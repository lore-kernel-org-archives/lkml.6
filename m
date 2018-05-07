Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeEGRyW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:54:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49776 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEGRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:54:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB3A060767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] drivers: thermal: step_wise: add support for hysteresis
Date: Mon,  7 May 2018 11:54:08 -0600
Message-Id: <20180507175408.2154-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Chandrasekar <rkumbako@codeaurora.org>

From: Ram Chandrasekar <rkumbako@codeaurora.org>

Step wise governor increases the mitigation level when the temperature
goes above a threshold and will decrease the mitigation when the
temperature falls below the threshold. If it were a case, where the
temperature hovers around a threshold, the mitigation will be applied
and removed at every iteration. This reaction to the temperature is
inefficient for performance.

The use of hysteresis temperature could avoid this ping-pong of
mitigation by relaxing the mitigation to happen only when the
temperature goes below this lower hysteresis value.

Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/thermal/step_wise.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index ee047ca43084..cf07e2269291 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -36,7 +36,7 @@
  *       for this trip point
  *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
  *       for this trip point
- * If the temperature is lower than a trip point,
+ * If the temperature is lower than a hysteresis temperature,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
  *       state for this trip point, if the cooling state already
@@ -127,7 +127,7 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 {
-	int trip_temp;
+	int trip_temp, hyst_temp;
 	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
@@ -135,22 +135,23 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 	int old_target;
 
 	if (trip == THERMAL_TRIPS_NONE) {
-		trip_temp = tz->forced_passive;
+		hyst_temp = trip_temp = tz->forced_passive;
 		trip_type = THERMAL_TRIPS_NONE;
 	} else {
 		tz->ops->get_trip_temp(tz, trip, &trip_temp);
+		hyst_temp = trip_temp;
+		if (tz->ops->get_trip_hyst) {
+			tz->ops->get_trip_hyst(tz, trip, &hyst_temp);
+			hyst_temp = trip_temp - hyst_temp;
+		}
 		tz->ops->get_trip_type(tz, trip, &trip_type);
 	}
 
 	trend = get_tz_trend(tz, trip);
 
-	if (tz->temperature >= trip_temp) {
-		throttle = true;
-		trace_thermal_zone_trip(tz, trip, trip_type);
-	}
-
-	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-				trip, trip_type, trip_temp, trend, throttle);
+	dev_dbg(&tz->device,
+		"Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%d\n",
+		trip, trip_type, trip_temp, hyst_temp, trend, throttle);
 
 	mutex_lock(&tz->lock);
 
@@ -159,6 +160,18 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 			continue;
 
 		old_target = instance->target;
+		throttle = false;
+		/*
+		 * Lower the mitigation only if the temperature
+		 * goes below the hysteresis temperature.
+		 */
+		if (tz->temperature >= trip_temp ||
+		   (tz->temperature >= hyst_temp &&
+		   old_target != THERMAL_NO_TARGET)) {
+			throttle = true;
+			trace_thermal_zone_trip(tz, trip, trip_type);
+		}
+
 		instance->target = get_target_state(instance, trend, throttle);
 		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
 					old_target, (int)instance->target);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
