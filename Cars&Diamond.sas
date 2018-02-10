/* Question- 1 */

/* Read Data from 93cars.dat */

libname cc "H:\SAS\hw2\";
data cc.cars1993;
data A1;
infile "H:\SAS\hw2\93cars.dat" dlm='';
input Manufacturer $ 1-14 Model $ 15-29 Type $ 30-36 Min_Price 38-41 Mid_Price 43-46
		Max_Price 48-51 City_MPG 53-54 Highway_MPG 56-57 Air_Bags_standard 59 Drive_Train_type 61
		No_of_cylinders 63 Engine_size 65-67 Horse_power 69-71 RPM 73-76 Engine_revolutions_per_mile
		Manual_transmission_available  Fuel_tank_capacity Passenger_capacity Length Wheelbase
		Width Uturn_space Rear_seat_room Luggage_capacity Weight Domestic;
run;

/* Looking at first 10 observations */
proc print data=a1(obs=10);
run;

/* Checking Variable Details */ 
proc contents data =a1;
run;

/* Looking at Data Characteristics */
proc means;
proc print;
run;

/*Looking at Frequency of Categorical Variables */
proc freq;
table type;
table air_bags_standard;
table drive_train_type;
table manual_transmission_available;
table domestic;
run;

/* Overall Correlation */

proc corr;
run;

/* Correlation between horsepower and midrange price */

proc corr;
var horse_power mid_price;
proc print;
run;

/* Plotting Scatter Diagram of horsepower and midrange price */
proc sgplot data=a1;
scatter x=horse_power y=mid_price;
reg x=horse_power y=mid_price;
run;

/* Regression Model*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic;
run;

/* Regression with Standardised Coefficents */
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic/ stb;
run;

proc sgplot data=a1;
reg x=city_mpg y=mid_price/ degree=2;
run;

/* Generate Quadratic Variables */
data a3;
set a1;
horsepower2= horse_power*horse_power;
citympg2= city_mpg*city_mpg;
run;

/* Scatter between citympg and mid price */
proc sgplot data=a1;
scatter x=city_mpg y=mid_price;
run;

/* Regression with non-linear term city_mpg square */
proc reg data=a3;
model mid_price=horse_power city_mpg citympg2 air_bags_standard manual_transmission_available domestic;
run;

/* Scatter between horsepower and mid price */
proc sgplot data=a1;
scatter x=horse_power y=mid_price;
run;

/* Regression with non-linear term Horse_power square */
proc reg data=a3;
model mid_price=horse_power horsepower2 city_mpg air_bags_standard manual_transmission_available domestic;
run;

/*Alternate Regression Models*/ 

/* Regression Modelby adding drive_train_type*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic drive_train_type;
run;

/* Regression Model by adding drive_train_type, engine_size*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic drive_train_type
				engine_size;
run;

/* Regression Model by adding drive_train_type, no of cylinders*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic drive_train_type
				no_of_cylinders;
run;

/* Regression Model by adding drive_train_type,RPM*/  
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic drive_train_type RPM;
run;

/* Regression Model by adding drive_train_type, Fuel_tank Capacity*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type fuel_tank_capacity;
run;

/* Regression Model by adding drive_train_type, Passenger Capacity*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type passenger_capacity;
run;

/* Regression Model by adding drive_train_type, luggage_capacity */
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type luggage_capacity;
run;

/* Regression Model by adding drive_train_type, weight */
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type weight;
run;

/* Regression Model by adding drive_train_type and Engine_revolutions_per_mile*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Engine_revolutions_per_mile;
run;

/* Regression Model by adding drive_train_type, Engine_revolutions_per_mile and rear_seat_room*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Engine_revolutions_per_mile rear_seat_room;
run;

/* Regression Model by adding drive_train_type, U-turn space and Engine_revolutions_per_mile*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Engine_revolutions_per_mile Uturn_space;
run;

/* Regression Model by adding drive_train_type, U-turn space*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space;
run;

/* Regression Model by adding drive_train_type, U-turn space and Length*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space Length;
run;

/* Regression Model by adding drive_train_type, U-turn space, wheelbase and Engine_revolutions_per_mile*/
proc reg data=a1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space wheelbase Engine_revolutions_per_mile;
run;

/* Creating Dummy Variables for type*/

DATA D1 ;
  SET A1 ;
  IF Type = "Small" THEN type_small = 1; 
    ELSE type_small = 0;
  IF Type = "Midsize" THEN type_midsize = 1; 
    ELSE type_midsize = 0;
  IF Type = "Compact" THEN type_compact = 1; 
    ELSE type_compact = 0;
  IF Type = "Large" THEN type_large = 1; 
    ELSE type_large = 0;
   IF Type = "Sporty" THEN type_sporty = 1; 
    ELSE type_sporty = 0;
   IF Type = "Van" THEN type_van = 1; 
    ELSE type_van = 0;
  RUN;


/* Alternate Regressions with interaction terms*/
data i1;
set d1;
int1=horse_power*engine_revolutions_per_mile;
int2=horse_power*rpm;
int3=city_mpg*engine_revolutions_per_mile;
run;

proc reg data=i1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space wheelbase Engine_revolutions_per_mile int1;
run;

proc reg data=i1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space Engine_revolutions_per_mile int2;
run;

proc reg data=i1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space Engine_revolutions_per_mile int3;
run;

/* Checking all combinations possible based on SSE, AIC, BIC, ADJRsq, RMSe */
proc reg data=i1 outest=est;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space wheelbase Engine_revolutions_per_mile highway_mpg  
				/ selection=adjrsq sse aic bic sbc adjrsq cp rmse;
run; quit;

proc reg data=i1;
model mid_price=city_mpg air_bags_standard horse_power manual_transmission_available domestic 
				drive_train_type Uturn_space Engine_revolutions_per_mile rpm;
run;


/* Question- 2 */

/* Read Data from diamond data.dat */

libname cc "H:\SAS\hw2\";
data cc.diamond;
data B1;
infile "H:\SAS\hw2\diamond data.dat" dlm='' firstobs=2;
input cut $ color $ clarity $ carat price ;
run;

/* Looking at first 10 observations */
proc print data=b1(obs=10);
run;

/* Checking Variable Details */ 
proc contents data =b1;
run;

/* Looking at Data Characteristics */
proc means;
run;

/*Looking at Frequency of Categorical Variables */
proc freq;
table cut color clarity;
run;

/* Creating Dummy Variables for cut, color and clarity */

DATA B2 ;
  SET B1 ;
  IF Cut = "VeryGood" THEN cut_verygood = 1; 
    ELSE cut_verygood = 0;
  IF Cut = "Ideal" THEN cut_ideal = 1; 
    ELSE cut_ideal = 0;
  IF Cut = "Good" THEN cut_good = 1; 
    ELSE cut_good = 0;
  IF Cut = "Fair" THEN cut_fair = 1; 
    ELSE cut_fair = 0;
  IF Color = "D" THEN color_D = 1; 
    ELSE color_D = 0;
  IF Color = "E" THEN color_E = 1; 
    ELSE color_E = 0;
  IF Clarity = "VS1" THEN clarity_vs1 = 1; 
    ELSE clarity_vs1=0;
  IF Clarity = "VS2" THEN clarity_vs2 = 1; 
    ELSE clarity_vs2=0;
  IF Clarity = "VVS1" THEN clarity_vvs1 = 1; 
    ELSE clarity_vvs1=0;
  IF Clarity = "VVS2" THEN clarity_vvs2 = 1; 
    ELSE clarity_vvs2=0;
RUN;

/* Regression Model */

proc reg data=b2;
model price= cut_verygood cut_ideal cut_good color_D clarity_vvs1 clarity_vvs2 clarity_vs1 carat;
run;

/* T-test to find out if there is significant difference in prices between color "D" and "E" */
proc ttest data=b1;
var price;
class color;
run;

/* Model to find price comparison of ideal cut diamond over a good cut diamond */
proc reg data=b2;
model price= cut_verygood cut_ideal cut_fair color_D clarity_vvs1 clarity_vvs2 clarity_vs1 carat;
run;

/* Model to find price comparison of VVS2 diamond over a VS1 diamond */
proc reg data=b2;
model price= cut_verygood cut_ideal cut_fair color_D clarity_vvs1 clarity_vvs2 clarity_vs2 carat;
run;

/* Chi-Square test */

proc freq data=b1;
 tables color*clarity / chisq
 plots=(freqplot(twoway=groupvertical
 scale=percent));
run;

/* t-tests to check wether average price is different for different levels of clarity */

/*Checking if average price is different for VVS1 and VVS2 */
data t1;
set b1;
if clarity="VVS1" or clarity="VVS2";
run;

proc ttest data=t1;
class clarity;
var price;
run;

/*Checking if average price is different for VVS1 and VS1 */
data t2;
set b1;
if clarity="VVS1" or clarity="VS1";
run;

proc ttest data=t2;
class clarity;
var price;
run;

/*Checking if average price is different for VVS1 and VS2 */
data t3;
set b1;
if clarity="VVS1" or clarity="VS2";
run;

proc ttest data=t3;
class clarity;
var price;
run;

/*Checking if average price is different for VVS2 and VS1 */
data t4;
set b1;
if clarity="VVS2" or clarity="VS1";
run;

proc ttest data=t4;
class clarity;
var price;
run;

/*Checking if average price is different for VVS2 and VS2 */
data t5;
set b1;
if clarity="VVS2" or clarity="VS2";
run;

proc ttest data=t5;
class clarity;
var price;
run;

/*Checking if average price is different for VS1 and VS2 */
data t6;
set b1;
if clarity="VS1" or clarity="VS2";
run;

proc ttest data=t6;
class clarity;
var price;
run;
