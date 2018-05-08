Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755624AbeEHRtQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:49:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755325AbeEHRtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:49:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 535E26022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@linaro.org, Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>
Subject: [PATCH RFC 1/4] drivers: of-thermal: abstract sensor related information
Date: Tue,  8 May 2018 11:48:56 -0600
Message-Id: <20180508174859.26539-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508174859.26539-1-ilina@codeaurora.org>
References: <20180508174859.26539-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sensor related information like the sensor callback ops and sensor data
live in the thermal zone data structure along with other parameters.
In preparation to use the same sensor across multiple thermal zones
separate out the sensor specific information into its own data
structure.

Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/thermal/of-thermal.c | 72 ++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index eea2fce82bf7..b402edd09ed1 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -35,6 +35,16 @@ struct __thermal_bind_params {
 	unsigned long max;
 };
 
+/**
+ * struct thermal_sensor - Holds individual sensor data
+ * @sensor_data: sensor driver private data passed as input argument
+ * @ops: sensor driver ops
+ */
+struct thermal_sensor {
+	void *sensor_data;
+	const struct thermal_zone_of_device_ops *ops;
+};
+
 /**
  * struct __thermal_zone - internal representation of a thermal zone
  * @mode: current thermal zone device mode (enabled/disabled)
@@ -46,8 +56,7 @@ struct __thermal_bind_params {
  * @trips: an array of trip points (0..ntrips - 1)
  * @num_tbps: number of thermal bind params
  * @tbps: an array of thermal bind params (0..num_tbps - 1)
- * @sensor_data: sensor private data used while reading temperature and trend
- * @ops: set of callbacks to handle the thermal zone based on DT
+ * @sensor: sensor related parameters
  */
 
 struct __thermal_zone {
@@ -66,8 +75,7 @@ struct __thermal_zone {
 	struct __thermal_bind_params *tbps;
 
 	/* sensor interface */
-	void *sensor_data;
-	const struct thermal_zone_of_device_ops *ops;
+	struct thermal_sensor *sensor;
 };
 
 /***   DT thermal zone device callbacks   ***/
@@ -76,22 +84,24 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 			       int *temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct thermal_sensor *sensor = data->sensor;
 
-	if (!data->ops->get_temp)
+	if (!sensor || !sensor->ops->get_temp)
 		return -EINVAL;
 
-	return data->ops->get_temp(data->sensor_data, temp);
+	return sensor->ops->get_temp(sensor->sensor_data, temp);
 }
 
 static int of_thermal_set_trips(struct thermal_zone_device *tz,
 				int low, int high)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct thermal_sensor *sensor = data->sensor;
 
-	if (!data->ops || !data->ops->set_trips)
+	if (!sensor || !sensor->ops->set_trips)
 		return -EINVAL;
 
-	return data->ops->set_trips(data->sensor_data, low, high);
+	return sensor->ops->set_trips(sensor->sensor_data, low, high);
 }
 
 /**
@@ -173,19 +183,24 @@ static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct thermal_sensor *sensor = data->sensor;
+
+	if (!sensor || !sensor->ops->set_emul_temp)
+		return -EINVAL;
 
-	return data->ops->set_emul_temp(data->sensor_data, temp);
+	return sensor->ops->set_emul_temp(sensor->sensor_data, temp);
 }
 
 static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct thermal_sensor *sensor = data->sensor;
 
-	if (!data->ops->get_trend)
+	if (!sensor || !sensor->ops->get_trend)
 		return -EINVAL;
 
-	return data->ops->get_trend(data->sensor_data, trip, trend);
+	return sensor->ops->get_trend(sensor->sensor_data, trip, trend);
 }
 
 static int of_thermal_bind(struct thermal_zone_device *thermal,
@@ -303,14 +318,16 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct thermal_sensor *sensor = data->sensor;
 
 	if (trip >= data->ntrips || trip < 0)
 		return -EDOM;
 
-	if (data->ops->set_trip_temp) {
+	if (sensor && sensor->ops->set_trip_temp) {
 		int ret;
 
-		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
+		ret = sensor->ops->set_trip_temp(sensor->sensor_data,
+						trip, temp);
 		if (ret)
 			return ret;
 	}
@@ -382,8 +399,8 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 
 static struct thermal_zone_device *
 thermal_zone_of_add_sensor(struct device_node *zone,
-			   struct device_node *sensor, void *data,
-			   const struct thermal_zone_of_device_ops *ops)
+			   struct device_node *sensor_np,
+			   struct thermal_sensor *sensor)
 {
 	struct thermal_zone_device *tzd;
 	struct __thermal_zone *tz;
@@ -394,12 +411,11 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 
 	tz = tzd->devdata;
 
-	if (!ops)
+	if (!sensor->ops)
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&tzd->lock);
-	tz->ops = ops;
-	tz->sensor_data = data;
+	tz->sensor = sensor;
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
@@ -408,10 +424,10 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	 * The thermal zone core will calculate the window if they have set the
 	 * optional set_trips pointer.
 	 */
-	if (ops->set_trips)
+	if (sensor->ops->set_trips)
 		tzd->ops->set_trips = of_thermal_set_trips;
 
-	if (ops->set_emul_temp)
+	if (sensor->ops->set_emul_temp)
 		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 
 	mutex_unlock(&tzd->lock);
@@ -457,6 +473,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 {
 	struct device_node *np, *child, *sensor_np;
 	struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
+	struct thermal_sensor *sensor = NULL;
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np)
@@ -467,6 +484,13 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 		return ERR_PTR(-EINVAL);
 	}
 
+	sensor = kzalloc(sizeof(*sensor), GFP_KERNEL);
+	if (!sensor) {
+		of_node_put(np);
+		return ERR_PTR(-ENOMEM);
+	}
+	sensor->sensor_data = data;
+	sensor->ops = ops;
 	sensor_np = of_node_get(dev->of_node);
 
 	for_each_available_child_of_node(np, child) {
@@ -491,7 +515,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 
 		if (sensor_specs.np == sensor_np && id == sensor_id) {
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
-							 data, ops);
+							 sensor);
 			if (!IS_ERR(tzd))
 				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
 
@@ -505,6 +529,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 	of_node_put(sensor_np);
 	of_node_put(np);
 
+	if (tzd == ERR_PTR(-ENODEV))
+		kfree(sensor);
 	return tzd;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_register);
@@ -543,8 +569,8 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	tzd->ops->get_trend = NULL;
 	tzd->ops->set_emul_temp = NULL;
 
-	tz->ops = NULL;
-	tz->sensor_data = NULL;
+	kfree(tz->sensor);
+	tz->sensor = NULL;
 	mutex_unlock(&tzd->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_unregister);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
