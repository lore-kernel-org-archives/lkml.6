Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeBZOll (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:41:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeBZOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:41:29 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: rui.zhang@intel.com, rjw@rjwysocki.net
Cc: groeck@chromium.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, snanda@chromium.org, lenb@kernel.org,
        Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Subject: [RESEND PATCH v3 2/2] thermal: core: introduce thermal zone device mode control
Date: Mon, 26 Feb 2018 15:41:18 +0100
Message-Id: <20180226144118.24693-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180226144118.24693-1-enric.balletbo@collabora.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Thermal "mode" sysfs attribute is introduced to enable/disable a thermal
zone, and .get_mode()/.set_mode() callback is introduced for platform
thermal driver to enable/disable the hardware thermal control logic. And
thermal core takes no action upon thermal zone enable/disable.

Actually, this is not quite right because thermal core still pokes those
disabled thermal zones occasionally, e.g. upon system resume.

To fix this, a new flag 'mode' is introduced in struct thermal_zone_device
to represent the thermal zone mode, and several decisions have been made
based on this flag, including
1. check the thermal zone mode right after it's registered.
2. skip updating thermal zone if the zone is disabled
3. stop the polling timer when the thermal zone is disabled

Note: basically, this patch doesn't affect the existing always-enabled
thermal zones much, with just one exception -
thermal zone .get_mode() must be well prepared to reflect the real thermal
zone status upon the thermal zone registration.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
That's another attempt to land these to patches that were sent long time
ago but never got merged, although, apparently, there is no issue with
it. Latest discussion about these here:

 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1436081.html


Changes in v3:
- [2/2] Rework by Zhang Rui.

Changes in v2:
- [2/2] Implement in thermal subsystem instead of ACPI thermal driver (Zhang Rui)

 drivers/thermal/thermal_core.c  | 37 +++++++++++++++++++++++++++++++++++--
 drivers/thermal/thermal_sysfs.c | 24 +++++++-----------------
 include/linux/thermal.h         |  3 +++
 3 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2b1b0ba393a4..8716ba5b2761 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -306,9 +306,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
 	mutex_lock(&tz->lock);
 
-	if (tz->passive)
+	if (tz->mode == THERMAL_DEVICE_ENABLED && tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
-	else if (tz->polling_delay)
+	else if (tz->mode == THERMAL_DEVICE_ENABLED && tz->polling_delay)
 		thermal_zone_device_set_polling(tz, tz->polling_delay);
 	else
 		thermal_zone_device_set_polling(tz, 0);
@@ -464,11 +464,35 @@ static void thermal_zone_device_reset(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+				 enum thermal_device_mode mode)
+{
+	int result;
+
+	if (!tz->ops->set_mode)
+		return -EPERM;
+
+	result = tz->ops->set_mode(tz, mode);
+	if (result)
+		return result;
+
+	if (tz->mode != mode) {
+		tz->mode = mode;
+		monitor_thermal_zone(tz);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
+
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	int count;
 
+	/* Do nothing if the thermal zone is disabled */
+	if (tz->mode == THERMAL_DEVICE_DISABLED)
+		return;
+
 	if (atomic_read(&in_suspend))
 		return;
 
@@ -1278,6 +1302,15 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
 	thermal_zone_device_reset(tz);
+
+	if (tz->ops->get_mode) {
+		enum thermal_device_mode mode;
+
+		result = tz->ops->get_mode(tz, &mode);
+		tz->mode = result ? THERMAL_DEVICE_ENABLED : mode;
+	} else
+		tz->mode = THERMAL_DEVICE_ENABLED;
+
 	/* Update the new thermal zone and mark it as already updated. */
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ba81c9080f6e..2746540289c4 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -51,18 +51,9 @@ static ssize_t
 mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	enum thermal_device_mode mode;
-	int result;
-
-	if (!tz->ops->get_mode)
-		return -EPERM;
 
-	result = tz->ops->get_mode(tz, &mode);
-	if (result)
-		return result;
-
-	return sprintf(buf, "%s\n", mode == THERMAL_DEVICE_ENABLED ? "enabled"
-		       : "disabled");
+	return sprintf(buf, "%s\n", tz->mode == THERMAL_DEVICE_ENABLED ?
+		       "enabled" : "disabled");
 }
 
 static ssize_t
@@ -70,18 +61,17 @@ mode_store(struct device *dev, struct device_attribute *attr,
 	   const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	enum thermal_device_mode mode;
 	int result;
 
-	if (!tz->ops->set_mode)
-		return -EPERM;
-
 	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
+		mode = THERMAL_DEVICE_ENABLED;
 	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
+		mode = THERMAL_DEVICE_DISABLED;
 	else
-		result = -EINVAL;
+		return -EINVAL;
 
+	result = thermal_zone_set_mode(tz, mode);
 	if (result)
 		return result;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 8c5302374eaa..ff60977c91da 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -211,6 +211,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
 	void *devdata;
+	enum thermal_device_mode mode;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	int passive_delay;
@@ -466,6 +467,8 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+			  enum thermal_device_mode mode);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-- 
2.16.1
