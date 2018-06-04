Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeFDUWu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:22:50 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:50653 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFDUWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:22:40 -0400
X-Google-Smtp-Source: ADUXVKIL/MtigoEYXw0SmwXAX3sNSGoHp8aqvHVyLa5KoBr/bz708cE31tCKQOXSWq2KRYiatA+tp1uI2VRSIQ==
MIME-Version: 1.0
Date: Mon,  4 Jun 2018 13:22:35 -0700
Message-Id: <20180604202235.73679-1-egranata@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH] Cleanup dependency chain for cros_ec modules
From: Enrico Granata <egranata@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: gwendal@google.com, Enrico Granata <egranata@chromium.org>,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

If one builds the Chrome EC support as modules, there is no explicit
dependency chain amongst the several modules (LPC, CHARDEV, CORE, ...)

This makes it possible - for instance - to rmmod cros_ec_core, even though
cros_ec_dev actively uses it for data transport to the EC chip.

This commit makes two changes in an attempt to address this:
a) moves cros_ec_proto.c as part of the CORE module; this removes the
   possibility of unloading cros_ec_core while cros_ec_dev is using it;
b) enables cros_ec_core to explicitly register a runtime dependency on
   the kernel module that is using its cmd and pkt transfer functions

Signed-off-by: Enrico Granata <egranata@chromium.org>
---

 drivers/mfd/Kconfig                             |  1 -
 drivers/mfd/Makefile                            |  2 +-
 drivers/mfd/cros_ec.c                           | 17 ++++++++++++++++-
 .../{platform/chrome => mfd}/cros_ec_proto.c    |  0
 drivers/platform/chrome/Kconfig                 |  5 -----
 drivers/platform/chrome/Makefile                |  1 -
 drivers/platform/chrome/cros_ec_lpc.c           |  1 +
 include/linux/mfd/cros_ec.h                     |  2 ++
 8 files changed, 20 insertions(+), 9 deletions(-)
 rename drivers/{platform/chrome => mfd}/cros_ec_proto.c (100%)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..a8daa2072ae6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -194,7 +194,6 @@ config MFD_CROS_EC
 	tristate "ChromeOS Embedded Controller"
 	select MFD_CORE
 	select CHROME_PLATFORMS
-	select CROS_EC_PROTO
 	depends on X86 || ARM || ARM64 || COMPILE_TEST
 	help
 	  If you say Y here you get support for the ChromeOS Embedded
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9d2cf0d32ef..20537bd27695 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
-cros_ec_core-objs		:= cros_ec.o
+cros_ec_core-objs		:= cros_ec.o cros_ec_proto.o
 cros_ec_core-$(CONFIG_ACPI)	+= cros_ec_acpi_gpe.o
 obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
 obj-$(CONFIG_MFD_CROS_EC_I2C)	+= cros_ec_i2c.o
diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index d61024141e2b..109e9cb1e289 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -168,9 +168,21 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	 */
 	err = cros_ec_sleep_event(ec_dev, 0);
 	if (err < 0)
-		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
+		dev_dbg(dev, "Error %d clearing sleep event to ec",
 			err);
 
+	if (ec_dev->xfer_fcn_owner != NULL) {
+		err = try_module_get(ec_dev->xfer_fcn_owner);
+		if (err < 0) {
+			dev_err(dev, "Error %d acquiring transfer module", err);
+			return err;
+		}
+		dev_info(dev, "Transfer module %p get successfully",
+			 ec_dev->xfer_fcn_owner);
+	} else {
+		dev_warn(dev, "No transfer module registered");
+	}
+
 	dev_info(dev, "Chrome EC device registered\n");
 
 	cros_ec_acpi_install_gpe_handler(dev);
@@ -193,6 +205,9 @@ int cros_ec_remove(struct cros_ec_device *ec_dev)
 	if (ec_dev->irq)
 		free_irq(ec_dev->irq, ec_dev);
 
+	if (ec_dev->xfer_fcn_owner != NULL)
+		module_put(ec_dev->xfer_fcn_owner);
+
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_remove);
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/mfd/cros_ec_proto.c
similarity index 100%
rename from drivers/platform/chrome/cros_ec_proto.c
rename to drivers/mfd/cros_ec_proto.c
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index e728a96cabfd..a050c9e8b506 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -65,11 +65,6 @@ config CROS_EC_LPC_MEC
 	  If you have a ChromeOS Embedded Controller Microchip EC variant
 	  choose Y here.
 
-config CROS_EC_PROTO
-        bool
-        help
-          ChromeOS EC communication protocol helpers.
-
 config CROS_KBD_LED_BACKLIGHT
 	tristate "Backlight LED support for Chrome OS keyboards"
 	depends on LEDS_CLASS && ACPI
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index ff3b369911f0..0b5e26ca9c96 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
 cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
-obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 3682e1539251..8f02b188bd3f 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -282,6 +282,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	ec_dev->phys_name = dev_name(dev);
 	ec_dev->cmd_xfer = cros_ec_cmd_xfer_lpc;
 	ec_dev->pkt_xfer = cros_ec_pkt_xfer_lpc;
+	ec_dev->xfer_fcn_owner = THIS_MODULE;
 	ec_dev->cmd_readmem = cros_ec_lpc_readmem;
 	ec_dev->din_size = sizeof(struct ec_host_response) +
 			   sizeof(struct ec_response_get_protocol_info);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 2d4e23c9ea0a..5239107e5091 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -18,6 +18,7 @@
 
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/mutex.h>
@@ -139,6 +140,7 @@ struct cros_ec_device {
 	int dout_size;
 	bool wake_enabled;
 	bool suspended;
+	struct module *xfer_fcn_owner;
 	int (*cmd_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
 	int (*pkt_xfer)(struct cros_ec_device *ec,
-- 
2.17.1.1185.g55be947832-goog
