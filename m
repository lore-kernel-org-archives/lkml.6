Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755604AbeEHRtP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:49:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755452AbeEHRtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:49:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5354860881
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 3/4] drivers: of-thermal: aggregate sensor trips across thermal zones
Date: Tue,  8 May 2018 11:48:58 -0600
Message-Id: <20180508174859.26539-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508174859.26539-1-ilina@codeaurora.org>
References: <20180508174859.26539-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aggregate thermal trip based on the trip points of the thermal zones
that use this sensor as the source.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/thermal/of-thermal.c      | 28 ++++++++++++++++++++++-
 drivers/thermal/thermal_helpers.c | 37 ++++++++++++++++++-------------
 include/linux/thermal.h           |  4 ++++
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 06e581a37c67..6fb2eeb5b6cf 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -96,16 +96,42 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 	return sensor->ops->get_temp(sensor->sensor_data, temp);
 }
 
+static void __of_thermal_agg_trip(struct thermal_sensor *sensor,
+				 int *floor, int *ceil)
+{
+	int low, high;
+	int max_lo = INT_MIN;
+	int min_hi = INT_MAX;
+	struct thermal_zone_device *tz;
+
+	list_for_each_entry(tz, &sensor->tz_list, sensor_tzd) {
+		thermal_zone_get_trip(tz, &low, &high);
+		if (low > max_lo)
+			max_lo = low;
+		if (high < min_hi)
+			min_hi = high;
+	}
+
+	*floor = max_lo;
+	*ceil = min_hi;
+}
+
 static int of_thermal_set_trips(struct thermal_zone_device *tz,
 				int low, int high)
 {
 	struct __thermal_zone *data = tz->devdata;
 	struct thermal_sensor *sensor = data->sensor;
+	int ret;
 
 	if (!sensor || !sensor->ops->set_trips)
 		return -EINVAL;
 
-	return sensor->ops->set_trips(sensor->sensor_data, low, high);
+	mutex_lock(&sensor->lock);
+	__of_thermal_agg_trip(sensor, &low, &high);
+	ret = sensor->ops->set_trips(sensor->sensor_data, low, high);
+	mutex_unlock(&sensor->lock);
+
+	return ret;
 }
 
 /**
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index f550fdee0f9b..d4fa125f8799 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -113,32 +113,39 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
+
+void thermal_zone_get_trip(struct thermal_zone_device *tz, int *low, int *high)
 {
-	int low = -INT_MAX;
-	int high = INT_MAX;
-	int trip_temp, hysteresis;
-	int i, ret;
+	int i, trip_low, trip_temp, hysteresis;
 
-	mutex_lock(&tz->lock);
-
-	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
-		goto exit;
+	*low = -INT_MAX;
+	*high = INT_MAX;
 
 	for (i = 0; i < tz->trips; i++) {
-		int trip_low;
-
 		tz->ops->get_trip_temp(tz, i, &trip_temp);
 		tz->ops->get_trip_hyst(tz, i, &hysteresis);
 
 		trip_low = trip_temp - hysteresis;
 
-		if (trip_low < tz->temperature && trip_low > low)
-			low = trip_low;
+		if (trip_low < tz->temperature && trip_low > *low)
+			*low = trip_low;
 
-		if (trip_temp > tz->temperature && trip_temp < high)
-			high = trip_temp;
+		if (trip_temp > tz->temperature && trip_temp < *high)
+			*high = trip_temp;
 	}
+}
+
+void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	int low, high;
+	int ret;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
+		goto exit;
+
+	thermal_zone_get_trip(tz, &low, &high);
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 09e1669a4919..000ae6a97678 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -443,6 +443,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
+void thermal_zone_get_trip(struct thermal_zone_device *tz, int *low, int *high);
 void thermal_zone_set_trips(struct thermal_zone_device *);
 
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
@@ -496,6 +497,9 @@ static inline int thermal_zone_unbind_cooling_device(
 static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 					      enum thermal_notify_event event)
 { }
+static inline void thermal_zone_get_trip(struct thermal_zone_device *tz,
+					 int *low, int *high)
+{ }
 static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
 { }
 static inline struct thermal_cooling_device *
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
