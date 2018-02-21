Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933718AbeBURIX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:08:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55654 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754169AbeBURIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:08:02 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 6/6] platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wake lid angle
Date: Wed, 21 Feb 2018 18:07:48 +0100
Message-Id: <20180221170748.27505-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221170748.27505-1-enric.balletbo@collabora.com>
References: <20180221170748.27505-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

This adds a sysfs attribute (/sys/class/chromeos/cros_ec/kb_wake_angle)
used to set and get the keyboard wake lid angle. This attribute is
present only if 2 accelerometers are controlled by the EC.

This patch also moves the cros_ec features check before the device is
added so the features map obtained from the EC is ready on time.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- Suggested by Andy Shevchenko:
  - Use the previous defined to_cros_ec_dev
  - Use one line when fits in 80 characters.
  - Use DEVICE_ATTR_RW variant.

 drivers/mfd/cros_ec_dev.c               | 19 ++++----
 drivers/platform/chrome/cros_ec_sysfs.c | 81 +++++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |  1 +
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 9d4b74404f49..48eac38a7d62 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -485,15 +485,6 @@ static int ec_device_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
-	retval = cdev_device_add(&ec->cdev, &ec->class_dev);
-	if (retval) {
-		dev_err(dev, "cdev_device_add failed => %d\n", retval);
-		goto failed;
-	}
-
-	if (cros_ec_debugfs_init(ec))
-		dev_warn(dev, "failed to create debugfs directory\n");
-
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
@@ -514,6 +505,16 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* Take control of the lightbar from the EC. */
 	lb_manual_suspend_ctrl(ec, 1);
 
+	/* We can now add the sysfs class, we know which parameter to show */
+	retval = cdev_device_add(&ec->cdev, &ec->class_dev);
+	if (retval) {
+		dev_err(dev, "cdev_device_add failed => %d\n", retval);
+		goto failed;
+	}
+
+	if (cros_ec_debugfs_init(ec))
+		dev_warn(dev, "failed to create debugfs directory\n");
+
 	return 0;
 
 failed:
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 78ae0d3760e4..5a6db3fe213a 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -258,21 +258,102 @@ static ssize_t flashinfo_show(struct device *dev,
 	return ret;
 }
 
+/* Keyboard wake angle control */
+static ssize_t kb_wake_angle_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+	struct ec_response_motion_sense *resp;
+	struct ec_params_motion_sense *param;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_motion_sense *)msg->data;
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+	msg->version = 2;
+	param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
+	param->kb_wake_angle.data = EC_MOTION_SENSE_NO_VALUE;
+	msg->outsize = sizeof(*param);
+	msg->insize = sizeof(*resp);
+
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0)
+		goto exit;
+
+	resp = (struct ec_response_motion_sense *)msg->data;
+	ret = scnprintf(buf, PAGE_SIZE, "%d\n", resp->kb_wake_angle.ret);
+exit:
+	kfree(msg);
+	return ret;
+}
+
+static ssize_t kb_wake_angle_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+	struct ec_params_motion_sense *param;
+	struct cros_ec_command *msg;
+	u16 angle;
+	int ret;
+
+	ret = kstrtou16(buf, 0, &angle);
+	if (ret)
+		return ret;
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_motion_sense *)msg->data;
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+	msg->version = 2;
+	param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
+	param->kb_wake_angle.data = angle;
+	msg->outsize = sizeof(*param);
+	msg->insize = sizeof(struct ec_response_motion_sense);
+
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	kfree(msg);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
 /* Module initialization */
 
 static DEVICE_ATTR_RW(reboot);
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(flashinfo);
+static DEVICE_ATTR_RW(kb_wake_angle);
 
 static struct attribute *__ec_attrs[] = {
+	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
 	&dev_attr_flashinfo.attr,
 	NULL,
 };
 
+static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
+				    struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+
+	if (a == &dev_attr_kb_wake_angle.attr && !ec->has_kb_wake_angle)
+		return 0;
+
+	return a->mode;
+}
+
 struct attribute_group cros_ec_attr_group = {
 	.attrs = __ec_attrs,
+	.is_visible = cros_ec_ctrl_visible,
 };
 EXPORT_SYMBOL(cros_ec_attr_group);
 
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 804b3ddbf819..951c27333d46 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -191,6 +191,7 @@ struct cros_ec_dev {
 	struct cros_ec_device *ec_dev;
 	struct device *dev;
 	struct cros_ec_debugfs *debug_info;
+	bool has_kb_wake_angle;
 	u16 cmd_offset;
 	u32 features[2];
 };
-- 
2.16.1
