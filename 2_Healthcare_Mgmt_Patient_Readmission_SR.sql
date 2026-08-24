-- Healthcare Management: Patient Readmission
-- 2. Data Loading
# 2.1 Create a schema named healthcare, set it as default schema and create tables 
# using diabetice_data.csv
# create schema
create schema healthcare;
# set default schema
use healthcare ;
# Making sure file has been imported
select *  from diabetic_data;

-- Tasks:
# 3.1 Calculate total no of patient encounters in the healthcare dataset
select count(*) as total_pat_encounters from diabetic_data;

#3.2 Identify the top 10 most frequent diagnosis in the dataset
select diag_1 as diagnosis1 , count(*) as frequency
from diabetic_data
group by diag_1
order by frequency desc
limit 10;
select diag_2 as diagnosis2 , count(*) as frequency
from diabetic_data
group by diag_2
order by frequency desc
limit 10;
select diag_3 as diagnosis3 , count(*) as frequency
from diabetic_data
group by diag_3
order by frequency desc
limit 10;

# 3.3 Calculate the average length of hospital stay for each admission type
select admission_type_id, avg(time_in_hospital) as avg_length
from diabetic_data
group by admission_type_id;

# 3.4 Determine the number of readmitted patients and the percentage of total encounters
# that they represent

select count(readmitted) as readmit_count,
       ROUND((count(readmitted) * 100.0)/(select count(*) from diabetic_data),2) as percentage
from diabetic_data
where readmitted <> 'NO';

# 3.5 Identify the age distribution of patients

select age, count(*) as patient_count
from diabetic_data
group by age
order by age;


# 3.6 Identify the most common procedures performed during patient encounters

select medical_specialty,  count(*) as freq_procedures
from diabetic_data
where medical_specialty <> '?'
group by medical_specialty
order by freq_procedures desc
limit 35;

# 3.7 Calculate the average number of medications prescribed for patients in each age group

select age , avg(num_medications) as avg_medications
from diabetic_data
group by age
order by age;

# 3.8 Identify the distribution of readmission rates across different payer codes

select payer_code, 
sum(case when readmitted != 'NO' then 1 else 0 end) as readmit_count,
count(*) as total_encounters,
round((sum(case when readmitted != 'NO' then 1 else 0 end) * 100.0)/count(*),2)
 as readmit_rate
 from diabetic_data
 where payer_code <> '?'
 group by payer_code
 order by readmit_rate desc;
 
 





