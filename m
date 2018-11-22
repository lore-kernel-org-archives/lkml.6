Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55D4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853CF20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853CF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394839AbeKVWNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:13:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54074 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394785AbeKVWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:13:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 61D4A27DBE5
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 5/7] mfd / platform: cros_ec: move device sysfs attributes to its own driver.
Date:   Thu, 22 Nov 2018 12:33:54 +0100
Message-Id: <20181122113356.23610-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122113356.23610-1-enric.balletbo@collabora.com>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entire way how cros debugfs attibutes are created is broken.
cros_ec_sysfs should be its own driver and its attributes should be
associated with the sysfs driver not the mfd driver.

The patch also adds the sysfs documentation.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../ABI/testing/sysfs-class-chromeos          | 32 ++++++++++++++
 drivers/mfd/Kconfig                           |  1 -
 drivers/mfd/cros_ec_dev.c                     |  7 +--
 drivers/platform/chrome/Kconfig               | 14 ++++--
 drivers/platform/chrome/Makefile              |  3 +-
 drivers/platform/chrome/cros_ec_sysfs.c       | 43 ++++++++++++++++++-
 include/linux/mfd/cros_ec.h                   |  3 --
 7 files changed, 87 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
new file mode 100644
index 000000000000..a5399c4ca82d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-chromeos
@@ -0,0 +1,32 @@
+What:		/sys/class/chromeos/<cros-ec>/flashinfo
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		Show the EC flash information.
+
+What:		/sys/class/chromeos/<cros-ec>/kb_wake_angle
+Date:		March 2018
+KernelVersion:	4.17
+Description:
+		Control the keyboard wake lid angle. Values are between
+		0 and 360. This file will also show the keyboard wake lid
+		angle by querying the hardware.
+
+What:		/sys/class/chromeos/<cros-ec>/reboot
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		Tell the EC to reboot in various ways. Options are:
+		"cancel": Cancel a pending reboot.
+		"ro": Jump to RO without rebooting.
+		"rw": Jump to RW without rebooting.
+		"cold": Cold reboot.
+		"disable-jump": Disable jump until next reboot.
+		"hibernate": Hibernate the EC.
+		"at-shutdown": Reboot after an AP shutdown.
+
+What:		/sys/class/chromeos/<cros-ec>/version
+Date:		August 2015
+KernelVersion:	4.2
+Description:
+		Show the information about the EC software and hardware.
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdce4326..089ffb408918 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -214,7 +214,6 @@ config MFD_CROS_EC
 config MFD_CROS_EC_CHARDEV
         tristate "Chrome OS Embedded Controller userspace device interface"
         depends on MFD_CROS_EC
-        select CROS_EC_CTL
         ---help---
           This driver adds support to talk with the ChromeOS EC from userspace.
 
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 8c7ee2a0b50a..fc235af6da65 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -34,15 +34,9 @@
 #define CROS_MAX_DEV 128
 static int ec_major;
 
-static const struct attribute_group *cros_ec_groups[] = {
-	&cros_ec_attr_group,
-	NULL,
-};
-
 static struct class cros_class = {
 	.owner          = THIS_MODULE,
 	.name           = "chromeos",
-	.dev_groups     = cros_ec_groups,
 };
 
 int cros_ec_attach_attribute_group(struct cros_ec_dev *ec,
@@ -405,6 +399,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-debugfs" },
 	{ .name = "cros-ec-lightbar" },
+	{ .name = "cros-ec-sysfs" },
 	{ .name = "cros-ec-vbc" },
 };
 
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index a1239d48c46f..2ef51520766a 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -49,9 +49,6 @@ config CHROMEOS_TBMC
 	  To compile this driver as a module, choose M here: the
 	  module will be called chromeos_tbmc.
 
-config CROS_EC_CTL
-        tristate
-
 config CROS_EC_I2C
 	tristate "ChromeOS Embedded Controller (I2C)"
 	depends on MFD_CROS_EC && I2C
@@ -141,4 +138,15 @@ config CROS_EC_DEBUGFS
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_debugfs.
 
+config CROS_EC_SYSFS
+	tristate "ChromeOS EC control and information through sysfs"
+	depends on MFD_CROS_EC_CHARDEV && SYSFS
+	default y
+	help
+	  This option exposes some sysfs attributes to control and get
+	  information from ChromeOS EC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_sysfs.
+
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 12a5c4d18c17..fdbee501931b 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -3,8 +3,6 @@
 obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
-cros_ec_ctl-objs			:= cros_ec_sysfs.o
-obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
@@ -15,3 +13,4 @@ obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
+obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f34a50121064..47d08a8f0542 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -34,6 +34,8 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
+#define DRV_NAME "cros-ec-sysfs"
+
 /* Accessor functions */
 
 static ssize_t reboot_show(struct device *dev,
@@ -353,7 +355,46 @@ struct attribute_group cros_ec_attr_group = {
 	.attrs = __ec_attrs,
 	.is_visible = cros_ec_ctrl_visible,
 };
-EXPORT_SYMBOL(cros_ec_attr_group);
+
+static int cros_ec_sysfs_probe(struct platform_device *pd)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+	struct cros_ec_platform *ec_platform = dev_get_platdata(ec_dev->dev);
+	struct device *dev = &pd->dev;
+	int ret;
+
+	if (!ec_dev) {
+		dev_err(dev, "No EC dev found\n");
+		return -EINVAL;
+	}
+
+	ret = cros_ec_attach_attribute_group(ec_dev, &cros_ec_attr_group);
+	if (ret < 0)
+		dev_err(dev, "failed to create %s attributes. err=%d\n",
+			ec_platform->ec_name, ret);
+
+	return ret;
+}
+
+static int cros_ec_sysfs_remove(struct platform_device *pd)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+
+	cros_ec_detach_attribute_group(ec_dev, &cros_ec_attr_group);
+
+	return 0;
+}
+
+static struct platform_driver cros_ec_sysfs_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_ec_sysfs_probe,
+	.remove = cros_ec_sysfs_remove,
+};
+
+module_platform_driver(cros_ec_sysfs_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC control driver");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 1722c2c26143..6d8618894a45 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -333,9 +333,6 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
  */
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
-/* sysfs stuff */
-extern struct attribute_group cros_ec_attr_group;
-
 /* Attach/detach attributes to the cros_class */
 extern int cros_ec_attach_attribute_group(struct cros_ec_dev *ec,
 					  struct attribute_group *attrs);
-- 
2.19.1

