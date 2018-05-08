Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbeEHRtM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:49:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeEHRtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:49:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DB5660B23
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        amit.kucheria@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RFC 2/4] drivers: of-thermal: allow multiple thermal zones for a sensor
Date: Tue,  8 May 2018 11:48:57 -0600
Message-Id: <20180508174859.26539-3-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508174859.26539-1-ilina@codeaurora.org>
References: <20180508174859.26539-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow different mitigative actions based on a sensor temperature, it
is desirable to have multiple thermal zones share the same source. The
thermal zones could have different thresholds, mitigative actions and
even different governors.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/thermal/of-thermal.c | 32 ++++++++++++++++++++++++++------
 include/linux/thermal.h      |  2 ++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index b402edd09ed1..06e581a37c67 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -39,10 +39,14 @@ struct __thermal_bind_params {
  * struct thermal_sensor - Holds individual sensor data
  * @sensor_data: sensor driver private data passed as input argument
  * @ops: sensor driver ops
+ * @tz_list: list of thermal zones for this sensor
+ * @lock: lock sensor during operations
  */
 struct thermal_sensor {
 	void *sensor_data;
 	const struct thermal_zone_of_device_ops *ops;
+	struct list_head tz_list;
+	struct mutex lock;
 };
 
 /**
@@ -430,11 +434,24 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	if (sensor->ops->set_emul_temp)
 		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 
+	mutex_lock(&sensor->lock);
+	list_add_tail(&tzd->sensor_tzd, &sensor->tz_list);
+	mutex_unlock(&sensor->lock);
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
 }
 
+static struct thermal_zone_device *
+thermal_zone_of_get_sensor_tzd(struct thermal_sensor *sensor)
+{
+	if (list_empty(&sensor->tz_list))
+		return ERR_PTR(-ENODEV);
+
+	return list_first_entry(&sensor->tz_list, struct thermal_zone_device,
+				sensor_tzd);
+}
+
 /**
  * thermal_zone_of_sensor_register - registers a sensor to a DT thermal zone
  * @dev: a valid struct device pointer of a sensor device. Must contain
@@ -460,12 +477,11 @@ thermal_zone_of_add_sensor(struct device_node *zone,
  * 01 - This function must enqueue the new sensor instead of using
  * it as the only source of temperature values.
  *
- * 02 - There must be a way to match the sensor with all thermal zones
- * that refer to it.
- *
  * Return: On success returns a valid struct thermal_zone_device,
  * otherwise, it returns a corresponding ERR_PTR(). Caller must
  * check the return value with help of IS_ERR() helper.
+ * The returned thermal_zone_device is one of the thermal zones that is
+ * using this sensor as the temeprature source.
  */
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
@@ -489,6 +505,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 		of_node_put(np);
 		return ERR_PTR(-ENOMEM);
 	}
+	INIT_LIST_HEAD(&sensor->tz_list);
+	mutex_init(&sensor->lock);
 	sensor->sensor_data = data;
 	sensor->ops = ops;
 	sensor_np = of_node_get(dev->of_node);
@@ -521,14 +539,14 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 
 			of_node_put(sensor_specs.np);
 			of_node_put(child);
-			goto exit;
 		}
 		of_node_put(sensor_specs.np);
 	}
-exit:
+
 	of_node_put(sensor_np);
 	of_node_put(np);
 
+	tzd = thermal_zone_of_get_sensor_tzd(sensor);
 	if (tzd == ERR_PTR(-ENODEV))
 		kfree(sensor);
 	return tzd;
@@ -569,7 +587,9 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	tzd->ops->get_trend = NULL;
 	tzd->ops->set_emul_temp = NULL;
 
-	kfree(tz->sensor);
+	list_del(&tzd->sensor_tzd);
+	if (list_empty(&tz->sensor->tz_list))
+		kfree(tz->sensor);
 	tz->sensor = NULL;
 	mutex_unlock(&tzd->lock);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7a133bd6ff86..09e1669a4919 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -188,6 +188,7 @@ struct thermal_attr {
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
+ * @sensor_tzd:		node in sensor's list of thermal zone devices
  */
 struct thermal_zone_device {
 	int id;
@@ -220,6 +221,7 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	struct list_head sensor_tzd;
 };
 
 /**
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
