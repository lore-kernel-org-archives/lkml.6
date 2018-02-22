Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBVVcg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:32:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:29958 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeBVVcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:32:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="177351547"
From: Wenkai Du <wenkai.du@intel.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        Archana Patni <archana.patni@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Wenkai Du <wenkai.du@intel.com>
Subject: [PATCH] Revert "mfd: cros_ec: Add ACPI GPE handler for LID0 devices"
Date: Thu, 22 Feb 2018 13:30:52 -0800
Message-Id: <20180222213052.126692-1-wenkai.du@intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e04653a9dcf4d98defe2149c885382e5cc72082f.

It is no longer needed to install Chrome EC GPE handler to have
GPE enabled in suspend to idle path. It is found that with this
handler installed, EC wake up doesn't work because default EC
event handler that can wake up system is not getting called.

Signed-off-by: Wenkai Du <wenkai.du@intel.com>
---
 drivers/mfd/Makefile           |   1 -
 drivers/mfd/cros_ec.c          |  15 ++----
 drivers/mfd/cros_ec_acpi_gpe.c | 103 -----------------------------------------
 include/linux/mfd/cros_ec.h    |  18 -------
 4 files changed, 3 insertions(+), 134 deletions(-)
 delete mode 100644 drivers/mfd/cros_ec_acpi_gpe.c

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9d2cf0d32ef..e9fd20dba18d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
 cros_ec_core-objs		:= cros_ec.o
-cros_ec_core-$(CONFIG_ACPI)	+= cros_ec_acpi_gpe.o
 obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
 obj-$(CONFIG_MFD_CROS_EC_I2C)	+= cros_ec_i2c.o
 obj-$(CONFIG_MFD_CROS_EC_SPI)	+= cros_ec_spi.o
diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index d61024141e2b..c221163d5b9e 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -173,8 +173,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	dev_info(dev, "Chrome EC device registered\n");
 
-	cros_ec_acpi_install_gpe_handler(dev);
-
 	return 0;
 
 fail_mfd:
@@ -188,8 +186,6 @@ int cros_ec_remove(struct cros_ec_device *ec_dev)
 {
 	mfd_remove_devices(ec_dev->dev);
 
-	cros_ec_acpi_remove_gpe_handler();
-
 	if (ec_dev->irq)
 		free_irq(ec_dev->irq, ec_dev);
 
@@ -204,14 +200,9 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 	int ret;
 	u8 sleep_event;
 
-	if (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) {
-		sleep_event = HOST_SLEEP_EVENT_S3_SUSPEND;
-	} else {
-		sleep_event = HOST_SLEEP_EVENT_S0IX_SUSPEND;
-
-		/* Clearing the GPE status for any pending event */
-		cros_ec_acpi_clear_gpe();
-	}
+	sleep_event = (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) ?
+		      HOST_SLEEP_EVENT_S3_SUSPEND :
+		      HOST_SLEEP_EVENT_S0IX_SUSPEND;
 
 	ret = cros_ec_sleep_event(ec_dev, sleep_event);
 	if (ret < 0)
diff --git a/drivers/mfd/cros_ec_acpi_gpe.c b/drivers/mfd/cros_ec_acpi_gpe.c
deleted file mode 100644
index 56d305dab2d4..000000000000
--- a/drivers/mfd/cros_ec_acpi_gpe.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * ChromeOS EC multi-function device
- *
- * Copyright (C) 2017 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * The ChromeOS EC multi function device is used to mux all the requests
- * to the EC device for its multiple features: keyboard controller,
- * battery charging and regulator control, firmware update.
- */
-#include <linux/acpi.h>
-
-#define ACPI_LID_DEVICE      "LID0"
-
-static int ec_wake_gpe = -EINVAL;
-
-/*
- * This handler indicates to ACPI core that this GPE should stay enabled for
- * lid to work in suspend to idle path.
- */
-static u32 cros_ec_gpe_handler(acpi_handle gpe_device, u32 gpe_number,
-			       void *data)
-{
-	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
-}
-
-/*
- * Get ACPI GPE for LID0 device.
- */
-static int cros_ec_get_ec_wake_gpe(struct device *dev)
-{
-	struct acpi_device *cros_acpi_dev;
-	struct acpi_device *adev;
-	acpi_handle handle;
-	acpi_status status;
-	int ret;
-
-	cros_acpi_dev = ACPI_COMPANION(dev);
-
-	if (!cros_acpi_dev || !cros_acpi_dev->parent ||
-	   !cros_acpi_dev->parent->handle)
-		return -EINVAL;
-
-	status = acpi_get_handle(cros_acpi_dev->parent->handle, ACPI_LID_DEVICE,
-				 &handle);
-	if (ACPI_FAILURE(status))
-		return -EINVAL;
-
-	ret = acpi_bus_get_device(handle, &adev);
-	if (ret)
-		return ret;
-
-	return adev->wakeup.gpe_number;
-}
-
-int cros_ec_acpi_install_gpe_handler(struct device *dev)
-{
-	acpi_status status;
-
-	ec_wake_gpe = cros_ec_get_ec_wake_gpe(dev);
-
-	if (ec_wake_gpe < 0)
-		return ec_wake_gpe;
-
-	status = acpi_install_gpe_handler(NULL, ec_wake_gpe,
-					  ACPI_GPE_EDGE_TRIGGERED,
-					  &cros_ec_gpe_handler, NULL);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	dev_info(dev, "Initialized, GPE = 0x%x\n", ec_wake_gpe);
-
-	return 0;
-}
-
-void cros_ec_acpi_remove_gpe_handler(void)
-{
-	acpi_status status;
-
-	if (ec_wake_gpe < 0)
-		return;
-
-	status = acpi_remove_gpe_handler(NULL, ec_wake_gpe,
-						 &cros_ec_gpe_handler);
-	if (ACPI_FAILURE(status))
-		pr_err("failed to remove gpe handler\n");
-}
-
-void cros_ec_acpi_clear_gpe(void)
-{
-	if (ec_wake_gpe < 0)
-		return;
-
-	acpi_clear_gpe(NULL, ec_wake_gpe);
-}
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index c61535979b8f..23af6806bc07 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -326,22 +326,4 @@ extern struct attribute_group cros_ec_vbc_attr_group;
 int cros_ec_debugfs_init(struct cros_ec_dev *ec);
 void cros_ec_debugfs_remove(struct cros_ec_dev *ec);
 
-/* ACPI GPE handler */
-#ifdef CONFIG_ACPI
-
-int cros_ec_acpi_install_gpe_handler(struct device *dev);
-void cros_ec_acpi_remove_gpe_handler(void);
-void cros_ec_acpi_clear_gpe(void);
-
-#else /* CONFIG_ACPI */
-
-static inline int cros_ec_acpi_install_gpe_handler(struct device *dev)
-{
-	return -ENODEV;
-}
-static inline void cros_ec_acpi_remove_gpe_handler(void) {}
-static inline void cros_ec_acpi_clear_gpe(void) {}
-
-#endif /* CONFIG_ACPI */
-
 #endif /* __LINUX_MFD_CROS_EC_H */
-- 
2.16.1
