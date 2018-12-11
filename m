Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509FAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1117420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1117420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeLKSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:00:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48800 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeLKR7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:59:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 662CA27D898
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v4 2/7] mfd / platform: cros_ec: move lightbar attributes to its own driver
Date:   Tue, 11 Dec 2018 18:59:29 +0100
Message-Id: <20181211175934.10238-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211175934.10238-1-enric.balletbo@collabora.com>
References: <20181211175934.10238-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entire way how cros sysfs attibutes are created is broken.
cros_ec_lightbar should be its own driver and its attributes should be
associated with a lightbar driver not the mfd driver. In order to retain
the path, the lightbar attributes are attached to the cros_class.

The patch also adds the sysfs documentation.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v4:
- Use <ec-device-name> instead <cros-ec> in documentation.

Changes in v3:
- Removed unneded check for ec_dev.

Changes in v2:
- Removed the two exported functions to attach/detach to the cros_class.
- Use dev_warn instead of dev_err when adding the lightbar.

 ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
 drivers/mfd/cros_ec_dev.c                     | 24 ++---
 drivers/mfd/cros_ec_dev.h                     |  6 --
 drivers/platform/chrome/Kconfig               | 11 +++
 drivers/platform/chrome/Makefile              |  3 +-
 drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
 include/linux/mfd/cros_ec.h                   |  1 -
 7 files changed, 173 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
new file mode 100644
index 000000000000..57a037791403
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
@@ -0,0 +1,74 @@
+What:		/sys/class/chromeos/<ec-device-name>/lightbar/brightness
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		Writing to this file adjusts the overall brightness of
+		the lightbar, separate from any color intensity. The
+		valid range is 0 (off) to 255 (maximum brightness).
+
+What:		/sys/class/chromeos/<ec-device-name>/lightbar/interval_msec
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		The lightbar is controlled by an embedded controller (EC),
+		which also manages the keyboard, battery charging, fans,
+		and other system hardware. To prevent unprivileged users
+		from interfering with the other EC functions, the rate at
+		which the lightbar control files can be read or written is
+		limited.
+
+		Reading this file will return the number of milliseconds
+		that must elapse between accessing any of the lightbar
+		functions through this interface. Going faster will simply
+		block until the necessary interval has lapsed. The interval
+		applies uniformly to all accesses of any kind by any user.
+
+What:		/sys/class/chromeos/<ec-device-name>/lightbar/led_rgb
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		This allows you to control each LED segment. If the
+		lightbar is already running one of the automatic
+		sequences, you probably won’t see anything change because
+		your color setting will be almost immediately replaced.
+		To get useful results, you should stop the lightbar
+		sequence first.
+
+		The values written to this file are sets of four integers,
+		indicating LED, RED, GREEN, BLUE. The LED number is 0 to 3
+		to select a single segment, or 4 to set all four segments
+		to the same value at once. The RED, GREEN, and BLUE
+		numbers should be in the range 0 (off) to 255 (maximum).
+		You can update more than one segment at a time by writing
+		more than one set of four integers.
+
+What:		/sys/class/chromeos/<ec-device-name>/lightbar/program
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		This allows you to upload and run custom lightbar sequences.
+
+What:		/sys/class/chromeos/<ec-device-name>/lightbar/sequence
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		The Pixel lightbar has a number of built-in sequences
+		that it displays under various conditions, such as at
+		power on, shut down, or while running. Reading from this
+		file displays the current sequence that the lightbar is
+		displaying. Writing to this file allows you to change the
+		sequence.
+
+What:		/sys/class/chromeos/<ec-device-name>/lightbar/userspace_control
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		This allows you to take the control of the lightbar. This
+		prevents the kernel from going through its normal
+		sequences.
+
+What:		/sys/class/chromeos/<ec-device-name>/lightbar/version
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		Show the information about the lightbar version.
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 2d0fee488c5a..b227718e0ec2 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -36,7 +36,6 @@ static int ec_major;
 
 static const struct attribute_group *cros_ec_groups[] = {
 	&cros_ec_attr_group,
-	&cros_ec_lightbar_attr_group,
 	&cros_ec_vbc_attr_group,
 	NULL,
 };
@@ -395,6 +394,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 	{ .name = "cros-usbpd-charger" }
 };
 
+static const struct mfd_cell cros_ec_platform_cells[] = {
+	{ .name = "cros-ec-lightbar" },
+};
+
 static int ec_device_probe(struct platform_device *pdev)
 {
 	int retval = -ENOMEM;
@@ -470,9 +473,6 @@ static int ec_device_probe(struct platform_device *pdev)
 				retval);
 	}
 
-	/* Take control of the lightbar from the EC. */
-	lb_manual_suspend_ctrl(ec, 1);
-
 	/* We can now add the sysfs class, we know which parameter to show */
 	retval = cdev_device_add(&ec->cdev, &ec->class_dev);
 	if (retval) {
@@ -480,6 +480,15 @@ static int ec_device_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
+	retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+				 cros_ec_platform_cells,
+				 ARRAY_SIZE(cros_ec_platform_cells),
+				 NULL, 0, NULL);
+	if (retval)
+		dev_warn(ec->dev,
+			 "failed to add cros-ec platform devices: %d\n",
+			 retval);
+
 	if (cros_ec_debugfs_init(ec))
 		dev_warn(dev, "failed to create debugfs directory\n");
 
@@ -494,9 +503,6 @@ static int ec_device_remove(struct platform_device *pdev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
 
-	/* Let the EC take over the lightbar again. */
-	lb_manual_suspend_ctrl(ec, 0);
-
 	cros_ec_debugfs_remove(ec);
 
 	mfd_remove_devices(ec->dev);
@@ -525,8 +531,6 @@ static __maybe_unused int ec_device_suspend(struct device *dev)
 
 	cros_ec_debugfs_suspend(ec);
 
-	lb_suspend(ec);
-
 	return 0;
 }
 
@@ -536,8 +540,6 @@ static __maybe_unused int ec_device_resume(struct device *dev)
 
 	cros_ec_debugfs_resume(ec);
 
-	lb_resume(ec);
-
 	return 0;
 }
 
diff --git a/drivers/mfd/cros_ec_dev.h b/drivers/mfd/cros_ec_dev.h
index 978d836a0248..ec750433455a 100644
--- a/drivers/mfd/cros_ec_dev.h
+++ b/drivers/mfd/cros_ec_dev.h
@@ -44,10 +44,4 @@ struct cros_ec_readmem {
 #define CROS_EC_DEV_IOCXCMD   _IOWR(CROS_EC_DEV_IOC, 0, struct cros_ec_command)
 #define CROS_EC_DEV_IOCRDMEM  _IOWR(CROS_EC_DEV_IOC, 1, struct cros_ec_readmem)
 
-/* Lightbar utilities */
-extern bool ec_has_lightbar(struct cros_ec_dev *ec);
-extern int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable);
-extern int lb_suspend(struct cros_ec_dev *ec);
-extern int lb_resume(struct cros_ec_dev *ec);
-
 #endif /* _CROS_EC_DEV_H_ */
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 16b1615958aa..6c05752a3334 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -111,4 +111,15 @@ config CROS_KBD_LED_BACKLIGHT
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_kbd_led_backlight.
 
+config CROS_EC_LIGHTBAR
+	tristate "Chromebook Pixel's lightbar support"
+	depends on MFD_CROS_EC_CHARDEV
+	default MFD_CROS_EC_CHARDEV
+	help
+	  This option exposes the Chromebook Pixel's lightbar to
+	  userspace.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_lightbar.
+
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index cd591bf872bb..3c29a4b405d5 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
-cros_ec_ctl-objs			:= cros_ec_sysfs.o cros_ec_lightbar.o \
+cros_ec_ctl-objs			:= cros_ec_sysfs.o \
 					   cros_ec_vbc.o cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
@@ -13,3 +13,4 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
+obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 68193bb53383..80eed6317570 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -33,6 +33,8 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+#define DRV_NAME "cros-ec-lightbar"
+
 /* Rate-limit the lightbar interface to prevent DoS. */
 static unsigned long lb_interval_jiffies = 50 * HZ / 1000;
 
@@ -373,7 +375,7 @@ static int lb_send_empty_cmd(struct cros_ec_dev *ec, uint8_t cmd)
 	return ret;
 }
 
-int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
+static int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
 {
 	struct ec_params_lightbar *param;
 	struct cros_ec_command *msg;
@@ -408,25 +410,6 @@ int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
 
 	return ret;
 }
-EXPORT_SYMBOL(lb_manual_suspend_ctrl);
-
-int lb_suspend(struct cros_ec_dev *ec)
-{
-	if (userspace_control || ec != ec_with_lightbar)
-		return 0;
-
-	return lb_send_empty_cmd(ec, LIGHTBAR_CMD_SUSPEND);
-}
-EXPORT_SYMBOL(lb_suspend);
-
-int lb_resume(struct cros_ec_dev *ec)
-{
-	if (userspace_control || ec != ec_with_lightbar)
-		return 0;
-
-	return lb_send_empty_cmd(ec, LIGHTBAR_CMD_RESUME);
-}
-EXPORT_SYMBOL(lb_resume);
 
 static ssize_t sequence_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
@@ -584,7 +567,7 @@ static struct attribute *__lb_cmds_attrs[] = {
 	NULL,
 };
 
-bool ec_has_lightbar(struct cros_ec_dev *ec)
+static bool ec_has_lightbar(struct cros_ec_dev *ec)
 {
 	return !!get_lightbar_version(ec, NULL, NULL);
 }
@@ -616,4 +599,72 @@ struct attribute_group cros_ec_lightbar_attr_group = {
 	.attrs = __lb_cmds_attrs,
 	.is_visible = cros_ec_lightbar_attrs_are_visible,
 };
-EXPORT_SYMBOL(cros_ec_lightbar_attr_group);
+
+static int cros_ec_lightbar_probe(struct platform_device *pd)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+	struct device *dev = &pd->dev;
+	int ret;
+
+	/* Take control of the lightbar from the EC. */
+	lb_manual_suspend_ctrl(ec_dev, 1);
+
+	ret = sysfs_create_group(&ec_dev->class_dev.kobj,
+				 &cros_ec_lightbar_attr_group);
+	if (ret < 0)
+		dev_err(dev, "failed to create %s attributes. err=%d\n",
+			cros_ec_lightbar_attr_group.name, ret);
+
+	return ret;
+}
+
+static int cros_ec_lightbar_remove(struct platform_device *pd)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+
+	sysfs_remove_group(&ec_dev->class_dev.kobj,
+			   &cros_ec_lightbar_attr_group);
+
+	/* Let the EC take over the lightbar again. */
+	lb_manual_suspend_ctrl(ec_dev, 0);
+
+	return 0;
+}
+
+static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
+
+	if (userspace_control || ec_dev != ec_with_lightbar)
+		return 0;
+
+	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
+}
+
+static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
+
+	if (userspace_control || ec_dev != ec_with_lightbar)
+		return 0;
+
+	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
+}
+
+static SIMPLE_DEV_PM_OPS(cros_ec_lightbar_pm_ops,
+			 cros_ec_lightbar_suspend, cros_ec_lightbar_resume);
+
+static struct platform_driver cros_ec_lightbar_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.pm = &cros_ec_lightbar_pm_ops,
+	},
+	.probe = cros_ec_lightbar_probe,
+	.remove = cros_ec_lightbar_remove,
+};
+
+module_platform_driver(cros_ec_lightbar_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Expose the Chromebook Pixel's lightbar to userspace");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 706dd724de52..b6beba3031ba 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -325,7 +325,6 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
-extern struct attribute_group cros_ec_lightbar_attr_group;
 extern struct attribute_group cros_ec_vbc_attr_group;
 
 /* debugfs stuff */
-- 
2.19.2

