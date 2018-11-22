Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14078C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC7C204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC7C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394823AbeKVWNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:13:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54058 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390848AbeKVWNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:13:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ED79327DFD1
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 3/7] mfd / platform: cros_ec: move vbc attributes to its own driver.
Date:   Thu, 22 Nov 2018 12:33:52 +0100
Message-Id: <20181122113356.23610-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122113356.23610-1-enric.balletbo@collabora.com>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entire way how cros sysfs attibutes are created is broken.
cros_ec_vbc should be its own driver and its attributes should be
associated with a vbc driver not the mfd driver. In order to retain
the path, the vbc attributes are attached to the cros_class.

The patch also adds the sysfs documentation.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../sysfs-class-chromeos-driver-cros-ec-vbc   |  6 +++
 drivers/mfd/cros_ec_dev.c                     |  2 +-
 drivers/platform/chrome/Kconfig               | 10 ++++
 drivers/platform/chrome/Makefile              |  3 +-
 drivers/platform/chrome/cros_ec_vbc.c         | 46 ++++++++++++++++++-
 include/linux/mfd/cros_ec.h                   |  1 -
 6 files changed, 64 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc
new file mode 100644
index 000000000000..c256a2febf37
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc
@@ -0,0 +1,6 @@
+What:		/sys/class/chromeos/<cros-ec>/vbc/vboot_context
+Date:		October 2015
+KernelVersion:	4.4
+Description:
+		Read/write the verified boot context data included on a
+		small nvram space on some EC implementations.
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 9bdd42561701..790dc28b93f0 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -36,7 +36,6 @@ static int ec_major;
 
 static const struct attribute_group *cros_ec_groups[] = {
 	&cros_ec_attr_group,
-	&cros_ec_vbc_attr_group,
 	NULL,
 };
 
@@ -405,6 +404,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-lightbar" },
+	{ .name = "cros-ec-vbc" },
 };
 
 static int ec_device_probe(struct platform_device *pdev)
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 05bcefbe1926..29bd9837d520 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -121,4 +121,14 @@ config CROS_EC_LIGHTBAR
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_lightbar.
 
+config CROS_EC_VBC
+	tristate "ChromeOS EC vboot context support"
+	depends on MFD_CROS_EC_CHARDEV && OF
+	help
+	  This option exposes the ChromeOS EC vboot context nvram to
+	  userspace.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_vbc.
+
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 3c29a4b405d5..4081b7179df7 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
 cros_ec_ctl-objs			:= cros_ec_sysfs.o \
-					   cros_ec_vbc.o cros_ec_debugfs.o
+					   cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
@@ -14,3 +14,4 @@ obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
+obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 5356f26bc022..374153e3dc13 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -22,8 +22,11 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
+#define DRV_NAME "cros-ec-vbc"
+
 static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
 				  struct bin_attribute *att, char *buf,
 				  loff_t pos, size_t count)
@@ -132,4 +135,45 @@ struct attribute_group cros_ec_vbc_attr_group = {
 	.bin_attrs = cros_ec_vbc_bin_attrs,
 	.is_bin_visible = cros_ec_vbc_is_visible,
 };
-EXPORT_SYMBOL(cros_ec_vbc_attr_group);
+
+static int cros_ec_vbc_probe(struct platform_device *pd)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+	struct device *dev = &pd->dev;
+	int ret;
+
+	if (!ec_dev) {
+		dev_err(dev, "No EC dev found\n");
+		return -EINVAL;
+	}
+
+	ret = cros_ec_attach_attribute_group(ec_dev, &cros_ec_vbc_attr_group);
+	if (ret < 0)
+		dev_err(dev, "failed to create %s attributes. err=%d\n",
+			cros_ec_vbc_attr_group.name, ret);
+
+	return ret;
+}
+
+static int cros_ec_vbc_remove(struct platform_device *pd)
+{
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
+
+	cros_ec_detach_attribute_group(ec_dev, &cros_ec_vbc_attr_group);
+
+	return 0;
+}
+
+static struct platform_driver cros_ec_vbc_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_ec_vbc_probe,
+	.remove = cros_ec_vbc_remove,
+};
+
+module_platform_driver(cros_ec_vbc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Expose the vboot context nvram to userspace");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 4431e46c5875..ddbb7e18a530 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -335,7 +335,6 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
-extern struct attribute_group cros_ec_vbc_attr_group;
 
 /* debugfs stuff */
 int cros_ec_debugfs_init(struct cros_ec_dev *ec);
-- 
2.19.1

