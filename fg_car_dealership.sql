CREATE TABLE "customer" (
  "customer_id" integer PRIMARY KEY,
  "last_name" varchar,
  "first_name" varchar,
  "email" varchar(50),
  "phone_number" int
);

CREATE TABLE "invoice" (
  "invoice_id" integer PRIMARY KEY,
  "customer_id" integer,
  "car_id" integer,
  "date" timestamp,
  "sales_id" int
);

CREATE TABLE "salesperson" (
  "salesperson_id" integer PRIMARY KEY,
  "last_name" varchar,
  "first_name" varchar,
  "email" varchar(50)
);

CREATE TABLE "service_ticket" (
  "service_ticket_id" integer PRIMARY KEY,
  "car_id" int,
  "customer_id" int,
  "name" varchar,
  "date" timestamp,
  "cost" float
);

CREATE TABLE "car" (
  "car_id" integer PRIMARY KEY,
  "year" int,
  "make" varchar,
  "model" varchar,
  "price" int,
  "pre_owned" bool
);

CREATE TABLE "mechanic" (
  "mechanic_id" integer PRIMARY KEY,
  "service_ticket_id" integer,
  "last_name" varchar,
  "first_name" varchar
);

CREATE TABLE "parts_needed" (
  "parts_needed_id" integer PRIMARY KEY,
  "parts_id" integer,
  "amount" int,
  "total" float,
  "service_ticket_id" int
);

CREATE TABLE "parts" (
  "parts_id" integer PRIMARY KEY,
  "name" varchar,
  "price" float
);

ALTER TABLE "invoice" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id");
ALTER TABLE "invoice" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");
ALTER TABLE "invoice" ADD FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("salesperson_id");

ALTER TABLE "service_ticket" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("customer_id");
ALTER TABLE "service_ticket" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "mechanic" ADD FOREIGN KEY ("service_ticket_id") REFERENCES "service_ticket" ("service_ticket_id");

ALTER TABLE "parts_needed" ADD FOREIGN KEY ("parts_id") REFERENCES "parts" ("parts_id");
ALTER TABLE "parts_needed" ADD FOREIGN KEY ("service_ticket_id") REFERENCES "service_ticket" ("service_ticket_id");


create or replace function add_parts(
	_parts_id integer,
	_name varchar,
	_price float
)

returns record as $main$

declare
	new_parts record;
begin
	insert into parts(parts_id, name, price)
	values(_parts_id, _name, _price)
	returning *
	into new_parts;

	return new_parts;
end;
$main$
language plpgsql;

select add_parts(1, 'Tire', 99.99);
select add_parts(2, 'Windshield', 299.95);


INSERT INTO customer VALUES(1,'Hawkins','Derek','dhawkins@codingtemple.com',8675309);
INSERT INTO customer VALUES(2,'Lang','Lucas','lucastle@codingtemple.com',8675309);

insert into car values(1, 2021, 'Ford', 'Mustang', 39995, false);
insert into car values(2, 2020, 'Chevy', 'Camaro', 36997, false);

INSERT INTO salesperson VALUES(1, 'Anderson', 'Russell', 'randerson@codingtemple.com');
INSERT INTO salesperson VALUES(2, 'Leon', 'David', 'dleon@codingtemple.com')

insert into invoice values(1, 1, 1, '2021-11-18', 1);
insert into invoice values(2, 2, 2, '2021-11-19', 2);

insert into service_ticket values(1, 1, 1, 'Oil Change', '2021-11-18', 29.99);
insert into service_ticket values(2, 2, 2, 'Tire Rotation', '2021-11-19', 19.99);

INSERT INTO mechanic VALUES(1, 1, 'Patel', 'Jay');
INSERT INTO mechanic VALUES(2, 2, 'Peterson', 'Ben');

insert into parts_needed values(1, 1, 1, 99.99, 1);
insert into parts_needed values(2, 2, 1, 299.95, 2);