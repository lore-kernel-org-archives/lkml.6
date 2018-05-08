Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755678AbeEHRt4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:49:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755466AbeEHRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:49:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A7E06085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 4/4] drivers: of-thermal: notify framework when sensor is tripped
Date: Tue,  8 May 2018 11:48:59 -0600
Message-Id: <20180508174859.26539-5-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508174859.26539-1-ilina@codeaurora.org>
References: <20180508174859.26539-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify all related thermal zones when the sensor reports a thermal trip.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/thermal/of-thermal.c | 83 ++++++++++++++++++++++++++++++++++--
 include/linux/thermal.h      |  4 ++
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 6fb2eeb5b6cf..9b42bfed78bf 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -41,12 +41,18 @@ struct __thermal_bind_params {
  * @ops: sensor driver ops
  * @tz_list: list of thermal zones for this sensor
  * @lock: lock sensor during operations
+ * @low_trip: sensor's low trip temp
+ * @high_trip: sensor's high trip temp
+ * @low_tz: the thermal zone whose low trip is used as @low_trip
+ * @high_tz: the thermal zone whose high trip is used as @high_trip
  */
 struct thermal_sensor {
 	void *sensor_data;
 	const struct thermal_zone_of_device_ops *ops;
 	struct list_head tz_list;
 	struct mutex lock;
+	int low_trip, high_trip;
+	struct thermal_zone_device *low_tz, *high_tz;
 };
 
 /**
@@ -102,18 +108,26 @@ static void __of_thermal_agg_trip(struct thermal_sensor *sensor,
 	int low, high;
 	int max_lo = INT_MIN;
 	int min_hi = INT_MAX;
-	struct thermal_zone_device *tz;
+	struct thermal_zone_device *tz, *lo_tz = NULL, *hi_tz = NULL;
 
 	list_for_each_entry(tz, &sensor->tz_list, sensor_tzd) {
 		thermal_zone_get_trip(tz, &low, &high);
-		if (low > max_lo)
+		if (low > max_lo) {
 			max_lo = low;
-		if (high < min_hi)
+			lo_tz = tz;
+		}
+		if (high < min_hi) {
 			min_hi = high;
+			hi_tz = tz;
+		}
 	}
 
 	*floor = max_lo;
 	*ceil = min_hi;
+	sensor->low_trip = max_lo;
+	sensor->high_trip = min_hi;
+	sensor->low_tz = lo_tz;
+	sensor->high_tz = hi_tz;
 }
 
 static int of_thermal_set_trips(struct thermal_zone_device *tz,
@@ -427,6 +441,69 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 
 /***   sensor API   ***/
 
+static void thermal_zone_of_get_trip(struct thermal_zone_device *tz,
+				     int temp, int *low_trip, int *hi_trip)
+{
+	struct __thermal_zone *data = tz->devdata;
+	int low = INT_MIN;
+	int hi = INT_MAX;
+	int i;
+
+	for (i = 0; i < data->ntrips; i++) {
+		int trip_temp = data->trips[i].temperature;
+
+		if (trip_temp < temp && trip_temp > low)
+			*low_trip = i;
+		if (trip_temp > temp && trip_temp < hi)
+			*hi_trip = i;
+	}
+}
+
+/**
+ * thermal_zone_of_sensor_notify - notify framework of a trip
+ * @tzd: the thermal zone device
+ *
+ * Sensor drivers may use this API to notify the thermal framework that the
+ * temperature has crossed the trip threshold. This function is akin to
+ * thermal_notify_framework() call, but is expected to be called by a sensor
+ * that registered itself with the framework using the
+ * thermal_zone_of_add_sensor() function.
+ */
+void thermal_zone_of_sensor_notify(struct thermal_zone_device *tzd)
+{
+	struct __thermal_zone *tz = tzd->devdata;
+	struct thermal_sensor *sensor = tz->sensor;
+	int temp, low_trip, hi_trip, *trip;
+	struct thermal_zone_device *trip_tz = NULL;
+
+	if (!tz->sensor)
+		return;
+
+	if (of_thermal_get_temp(tzd, &temp))
+		return;
+
+	mutex_lock(&sensor->lock);
+	if (tzd->temperature < sensor->low_trip && sensor->low_tz) {
+		trip_tz = sensor->low_tz;
+		trip = &low_trip;
+	}
+	if (tzd->temperature > sensor->high_trip && sensor->high_tz) {
+		trip_tz = sensor->high_tz;
+		trip = &hi_trip;
+	}
+
+	if (trip_tz)
+		thermal_zone_of_get_trip(trip_tz, temp, &low_trip, &hi_trip);
+
+	mutex_unlock(&sensor->lock);
+
+	if (!trip_tz)
+		return;
+
+	thermal_notify_framework(trip_tz, *trip);
+}
+EXPORT_SYMBOL(thermal_zone_of_sensor_notify);
+
 static struct thermal_zone_device *
 thermal_zone_of_add_sensor(struct device_node *zone,
 			   struct device_node *sensor_np,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 000ae6a97678..603bf8065d7d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -388,6 +388,7 @@ struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
 		const struct thermal_zone_of_device_ops *ops);
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 					    struct thermal_zone_device *tz);
+void thermal_zone_of_sensor_notify(struct thermal_zone_device *tzd);
 #else
 static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
@@ -415,6 +416,9 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 {
 }
 
+static inline
+void thermal_zone_of_sensor_notify(struct thermal_zone_device *tzd)
+{ }
 #endif
 
 #if IS_ENABLED(CONFIG_THERMAL)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
