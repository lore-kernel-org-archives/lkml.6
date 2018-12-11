Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB5B20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB5B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeLKSAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:00:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48810 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLKR7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:59:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7F8F7260458
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v4 4/7] mfd / platform: cros_ec: move debugfs attributes to its own driver
Date:   Tue, 11 Dec 2018 18:59:31 +0100
Message-Id: <20181211175934.10238-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211175934.10238-1-enric.balletbo@collabora.com>
References: <20181211175934.10238-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entire way how cros debugfs attibutes are created is broken.
cros_ec_debugfs should be its own driver and its attributes should be
associated with a debugfs driver not the mfd driver.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Add a "default MFD_CROS_EC_CHARDEV" in Kconfig for this.
- Remove the checks for missing debug_info, are not needed now.
- Remove a comment that no longer applies.

 drivers/mfd/cros_ec_dev.c                 | 41 +--------------
 drivers/platform/chrome/Kconfig           | 11 ++++
 drivers/platform/chrome/Makefile          |  4 +-
 drivers/platform/chrome/cros_ec_debugfs.c | 62 +++++++++++++++--------
 include/linux/mfd/cros_ec.h               |  6 ---
 5 files changed, 56 insertions(+), 68 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 40c98808fa1c..9955937b821d 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -394,6 +394,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
+	{ .name = "cros-ec-debugfs" },
 	{ .name = "cros-ec-lightbar" },
 	{ .name = "cros-ec-vbc" },
 };
@@ -489,9 +490,6 @@ static int ec_device_probe(struct platform_device *pdev)
 			 "failed to add cros-ec platform devices: %d\n",
 			 retval);
 
-	if (cros_ec_debugfs_init(ec))
-		dev_warn(dev, "failed to create debugfs directory\n");
-
 	return 0;
 
 failed:
@@ -503,62 +501,25 @@ static int ec_device_remove(struct platform_device *pdev)
 {
 	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
 
-	cros_ec_debugfs_remove(ec);
-
 	mfd_remove_devices(ec->dev);
 	cdev_del(&ec->cdev);
 	device_unregister(&ec->class_dev);
 	return 0;
 }
 
-static void ec_device_shutdown(struct platform_device *pdev)
-{
-	struct cros_ec_dev *ec = dev_get_drvdata(&pdev->dev);
-
-	/* Be sure to clear up debugfs delayed works */
-	cros_ec_debugfs_remove(ec);
-}
-
 static const struct platform_device_id cros_ec_id[] = {
 	{ DRV_NAME, 0 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, cros_ec_id);
 
-static __maybe_unused int ec_device_suspend(struct device *dev)
-{
-	struct cros_ec_dev *ec = dev_get_drvdata(dev);
-
-	cros_ec_debugfs_suspend(ec);
-
-	return 0;
-}
-
-static __maybe_unused int ec_device_resume(struct device *dev)
-{
-	struct cros_ec_dev *ec = dev_get_drvdata(dev);
-
-	cros_ec_debugfs_resume(ec);
-
-	return 0;
-}
-
-static const struct dev_pm_ops cros_ec_dev_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.suspend = ec_device_suspend,
-	.resume = ec_device_resume,
-#endif
-};
-
 static struct platform_driver cros_ec_dev_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &cros_ec_dev_pm_ops,
 	},
 	.id_table = cros_ec_id,
 	.probe = ec_device_probe,
 	.remove = ec_device_remove,
-	.shutdown = ec_device_shutdown,
 };
 
 static int __init cros_ec_dev_init(void)
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 1e9dc9626e84..6cbf5b69d156 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -133,4 +133,15 @@ config CROS_EC_VBC
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_vbc.
 
+config CROS_EC_DEBUGFS
+	tristate "Export ChromeOS EC internals in DebugFS"
+	depends on MFD_CROS_EC_CHARDEV && DEBUG_FS
+	default MFD_CROS_EC_CHARDEV
+	help
+	  This option exposes the ChromeOS EC device internals to
+	  userspace.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_debugfs.
+
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 4081b7179df7..12a5c4d18c17 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -3,8 +3,7 @@
 obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
 obj-$(CONFIG_CHROMEOS_TBMC)		+= chromeos_tbmc.o
-cros_ec_ctl-objs			:= cros_ec_sysfs.o \
-					   cros_ec_debugfs.o
+cros_ec_ctl-objs			:= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
@@ -15,3 +14,4 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
+obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index c62ee8e610a0..6cacac53dfce 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -23,12 +23,16 @@
 #include <linux/fs.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 
+#define DRV_NAME "cros-ec-debugfs"
+
 #define LOG_SHIFT		14
 #define LOG_SIZE		(1 << LOG_SHIFT)
 #define LOG_POLL_SEC		10
@@ -423,8 +427,9 @@ static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
 	return 0;
 }
 
-int cros_ec_debugfs_init(struct cros_ec_dev *ec)
+static int cros_ec_debugfs_probe(struct platform_device *pd)
 {
+	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
 	struct cros_ec_platform *ec_platform = dev_get_platdata(ec->dev);
 	const char *name = ec_platform->ec_name;
 	struct cros_ec_debugfs *debug_info;
@@ -453,40 +458,57 @@ int cros_ec_debugfs_init(struct cros_ec_dev *ec)
 
 	ec->debug_info = debug_info;
 
+	dev_set_drvdata(&pd->dev, ec);
+
 	return 0;
 
 remove_debugfs:
 	debugfs_remove_recursive(debug_info->dir);
 	return ret;
 }
-EXPORT_SYMBOL(cros_ec_debugfs_init);
 
-void cros_ec_debugfs_remove(struct cros_ec_dev *ec)
+static int cros_ec_debugfs_remove(struct platform_device *pd)
 {
-	if (!ec->debug_info)
-		return;
+	struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
 
 	debugfs_remove_recursive(ec->debug_info->dir);
 	cros_ec_cleanup_console_log(ec->debug_info);
+
+	return 0;
 }
-EXPORT_SYMBOL(cros_ec_debugfs_remove);
 
-void cros_ec_debugfs_suspend(struct cros_ec_dev *ec)
+static int __maybe_unused cros_ec_debugfs_suspend(struct device *dev)
 {
-	/*
-	 * cros_ec_debugfs_init() failures are non-fatal; it's also possible
-	 * that we initted things but decided that console log wasn't supported.
-	 * We'll use the same set of checks that cros_ec_debugfs_remove() +
-	 * cros_ec_cleanup_console_log() end up using to handle those cases.
-	 */
-	if (ec->debug_info && ec->debug_info->log_buffer.buf)
-		cancel_delayed_work_sync(&ec->debug_info->log_poll_work);
+	struct cros_ec_dev *ec = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&ec->debug_info->log_poll_work);
+
+	return 0;
 }
-EXPORT_SYMBOL(cros_ec_debugfs_suspend);
 
-void cros_ec_debugfs_resume(struct cros_ec_dev *ec)
+static int __maybe_unused cros_ec_debugfs_resume(struct device *dev)
 {
-	if (ec->debug_info && ec->debug_info->log_buffer.buf)
-		schedule_delayed_work(&ec->debug_info->log_poll_work, 0);
+	struct cros_ec_dev *ec = dev_get_drvdata(dev);
+
+	schedule_delayed_work(&ec->debug_info->log_poll_work, 0);
+
+	return 0;
 }
-EXPORT_SYMBOL(cros_ec_debugfs_resume);
+
+static SIMPLE_DEV_PM_OPS(cros_ec_debugfs_pm_ops,
+			 cros_ec_debugfs_suspend, cros_ec_debugfs_resume);
+
+static struct platform_driver cros_ec_debugfs_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.pm = &cros_ec_debugfs_pm_ops,
+	},
+	.probe = cros_ec_debugfs_probe,
+	.remove = cros_ec_debugfs_remove,
+};
+
+module_platform_driver(cros_ec_debugfs_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Debug logs for ChromeOS EC");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index bbbe416fd573..3e4401e2ceea 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -326,10 +326,4 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
 
-/* debugfs stuff */
-int cros_ec_debugfs_init(struct cros_ec_dev *ec);
-void cros_ec_debugfs_remove(struct cros_ec_dev *ec);
-void cros_ec_debugfs_suspend(struct cros_ec_dev *ec);
-void cros_ec_debugfs_resume(struct cros_ec_dev *ec);
-
 #endif /* __LINUX_MFD_CROS_EC_H */
-- 
2.19.2

