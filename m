Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCTPvt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:51:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeCTPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:51:38 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: lee.jones@linaro.org, bleung@chromium.org
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v3 6/6] platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wake lid angle
Date: Tue, 20 Mar 2018 16:51:25 +0100
Message-Id: <20180320155125.3046-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320155125.3046-1-enric.balletbo@collabora.com>
References: <20180320155125.3046-1-enric.balletbo@collabora.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3:
- [6/6] Add Reviewed-by Andy Shevchenko
- [6/6] Fix the code that has_kb_wake_angle in cros_ec_sensors_register().

Changes in v2:
- [6/6] Use DEVICE_ATTR_RW variant.
- [6/6] Use one line when fits in 80 characters.
- [6/6] Use the previous defined to_cros_ec_dev

 drivers/mfd/cros_ec_dev.c               | 29 +++++-------
 drivers/platform/chrome/cros_ec_sysfs.c | 81 +++++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |  2 +
 3 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index e4fafdd96e5e..ceaff1cf2f65 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -305,7 +305,7 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 
 	resp = (struct ec_response_motion_sense *)msg->data;
 	sensor_num = resp->dump.sensor_count;
-	/* Allocate 2 extra sensors in case lid angle or FIFO are needed */
+	/* Allocate 1 extra sensors in FIFO are needed */
 	sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
 			       GFP_KERNEL);
 	if (sensor_cells == NULL)
@@ -362,16 +362,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 		sensor_type[resp->info.type]++;
 		id++;
 	}
-	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
-		sensor_platforms[id].sensor_num = sensor_num;
 
-		sensor_cells[id].name = "cros-ec-angle";
-		sensor_cells[id].id = 0;
-		sensor_cells[id].platform_data = &sensor_platforms[id];
-		sensor_cells[id].pdata_size =
-			sizeof(struct cros_ec_sensor_platform);
-		id++;
-	}
+	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
+		ec->has_kb_wake_angle = true;
+
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
 		sensor_cells[id].name = "cros-ec-ring";
 		id++;
@@ -424,6 +418,14 @@ static int ec_device_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
+	/* check whether this EC is a sensor hub. */
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
+		cros_ec_sensors_register(ec);
+
+	/* Take control of the lightbar from the EC. */
+	lb_manual_suspend_ctrl(ec, 1);
+
+	/* We can now add the sysfs class, we know which parameter to show */
 	retval = cdev_device_add(&ec->cdev, &ec->class_dev);
 	if (retval) {
 		dev_err(dev, "cdev_device_add failed => %d\n", retval);
@@ -433,13 +435,6 @@ static int ec_device_probe(struct platform_device *pdev)
 	if (cros_ec_debugfs_init(ec))
 		dev_warn(dev, "failed to create debugfs directory\n");
 
-	/* check whether this EC is a sensor hub. */
-	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
-		cros_ec_sensors_register(ec);
-
-	/* Take control of the lightbar from the EC. */
-	lb_manual_suspend_ctrl(ec, 1);
-
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
index c61535979b8f..2d4e23c9ea0a 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -183,6 +183,7 @@ struct cros_ec_debugfs;
  * @ec_dev: cros_ec_device structure to talk to the physical device
  * @dev: pointer to the platform device
  * @debug_info: cros_ec_debugfs structure for debugging information
+ * @has_kb_wake_angle: true if at least 2 accelerometer are connected to the EC.
  * @cmd_offset: offset to apply for each command.
  */
 struct cros_ec_dev {
@@ -191,6 +192,7 @@ struct cros_ec_dev {
 	struct cros_ec_device *ec_dev;
 	struct device *dev;
 	struct cros_ec_debugfs *debug_info;
+	bool has_kb_wake_angle;
 	u16 cmd_offset;
 	u32 features[2];
 };
-- 
2.16.2
