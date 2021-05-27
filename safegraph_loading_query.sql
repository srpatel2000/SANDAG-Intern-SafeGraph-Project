/****** Script for SelectTopNRows command from SSMS  ******/

/* Helps with debugging SG loading process */
/* Connects to sql2014a8 server */

SELECT 
MAX(LEN(safegraph_place_id)),
MAX(LEN(location_name)),
MAX(LEN([visits_by_each_hour])),
MAX(LEN(visitor_country_of_origin)),
MAX(LEN(related_same_day_brand)),
MAX(LEN(related_same_week_brand))
FROM [ws].[staging].[safegraph_v2_temp]

SELECT 
       MAX(LEN([ID]))
      ,MAX(LEN([safegraph_place_id])) 
      ,MAX(LEN([location_name]))
      ,MAX(LEN([street_address]))
      ,MAX(LEN([city]))
      ,MAX(LEN([region]))
      ,MAX(LEN([postal_code]))
      ,MAX(LEN([iso_country_code]))
      ,MAX(LEN([safegraph_brand_ids]))
      ,MAX(LEN([brands]))
      ,MAX(LEN([date_range_start]))
      ,MAX(LEN([date_range_end]))
      ,MAX(LEN([raw_visit_counts]))
      ,MAX(LEN([raw_visitor_counts]))
      ,MAX(LEN([visits_by_day]))
      ,MAX(LEN([visits_by_each_hour]))
      ,MAX(LEN([poi_cbg]))
      ,MAX(LEN([visitor_country_of_origin]))
      ,MAX(LEN([distance_from_home]))
      ,MAX(LEN([median_dwell]))
      ,MAX(LEN([bucketed_dwell_times]))
      ,MAX(LEN([related_same_day_brand]))
      ,MAX(LEN([related_same_week_brand]))
      ,MAX(LEN([device_type]))
  FROM [ws].[staging].[safegraph_v2_temp]

  SELECT TOP (1000) *
  FROM [ws].[staging].[safegraph_v2_temp]
  ORDER BY LEN(visits_by_each_hour)
  
--SELECT COL_LENGTH('ws.staging.safegraph_v2_temp', 'location_name') AS Result 

SELECT 
  OBJECT_NAME(object_id) AS [Table Name],
  name AS [Column Name],
  max_length,
  MAX(LEN(name)) AS [COL_LENGTH()]
FROM sys.columns
WHERE OBJECT_NAME(object_id) IN ('safegraph_v2_temp')

/* Run each time that temporary table is full */

INSERT INTO staging.safegraph_v2 WITH (TABLOCK) (
[safegraph_place_id], [location_name], [street_address], [city], [region], [postal_code], [iso_country_code], [safegraph_brand_ids], [brands], [date_range_start], [date_range_end], [raw_visit_counts], [raw_visitor_counts], [visits_by_day], [visits_by_each_hour], [poi_cbg], [visitor_country_of_origin], [distance_from_home], [median_dwell], [bucketed_dwell_times], [related_same_day_brand], [related_same_week_brand], [device_type]) 
 
SELECT [safegraph_place_id], [location_name], [street_address], [city], [region], [postal_code], [iso_country_code], [safegraph_brand_ids], [brands], [date_range_start], [date_range_end], [raw_visit_counts], [raw_visitor_counts], [visits_by_day], [visits_by_each_hour], [poi_cbg], [visitor_country_of_origin], [distance_from_home], [median_dwell], [bucketed_dwell_times], [related_same_day_brand], [related_same_week_brand], [device_type]
FROM staging.safegraph_v2_temp 
