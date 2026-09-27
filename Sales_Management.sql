CREATE DATABASE SalesManagement;
USE SalesManagement;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers VALUES
(1, 'Rahul', 'Hubballi', 'rahul@gmail.com'),
(2, 'Priya', 'Dharwad', 'priya@gmail.com'),
(3, 'Arjun', 'Bengaluru', 'arjun@gmail.com'),
(4, 'Sneha', 'Mysuru', 'sneha@gmail.com');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mouse', 'Accessories', 800),
(103, 'Keyboard', 'Accessories', 1500),
(104, 'Monitor', 'Electronics', 12000);

INSERT INTO Orders VALUES
(1001, 1, 101, 1, '2026-09-01'),
(1002, 2, 102, 2, '2026-09-02'),
(1003, 3, 104, 1, '2026-09-03'),
(1004, 1, 103, 2, '2026-09-04'),
(1005, 4, 101, 1, '2026-09-05');

-- 1. Display all customers
SELECT * FROM Customers;

-- 2. Display all products
SELECT * FROM Products;

-- 3. Display customer orders
SELECT
    c.CustomerName,
    p.ProductName,
    o.Quantity,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID;

-- 4. Calculate total sales
SELECT
    SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID;

-- 5. Sales by product
SELECT
    p.ProductName,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductName;

-- 6. Sales by customer
SELECT
    c.CustomerName,
    SUM(o.Quantity * p.Price) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;