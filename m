Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeE1FmA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:42:00 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33973 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbeE1Fl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:41:56 -0400
X-Google-Smtp-Source: ADUXVKIdnKkluW9dmUJwVq4rRMsMBYhKvhb1Uoas1B9KLwb74jcdrBKstd2TfJHt04bHf+6c8ep2qA==
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 3/3] thermal: broadcom: Add Stingray thermal driver
Date: Mon, 28 May 2018 11:11:24 +0530
Message-Id: <1527486084-4636-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

This commit adds stingray thermal driver to monitor six
thermal zones temperature and trips at critical temperature.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/thermal/Kconfig               |   3 +-
 drivers/thermal/broadcom/Kconfig      |   9 ++
 drivers/thermal/broadcom/Makefile     |   1 +
 drivers/thermal/broadcom/sr-thermal.c | 151 ++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 8297988..26d39d4 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -416,7 +416,8 @@ config MTK_THERMAL
 	  controller present in Mediatek SoCs
 
 menu "Broadcom thermal drivers"
-depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM_IPROC || \
+		COMPILE_TEST
 source "drivers/thermal/broadcom/Kconfig"
 endmenu
 
diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index c106a15..dc9a9bd 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -22,3 +22,12 @@ config BCM_NS_THERMAL
 	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
 	  Management Unit) block with a thermal sensor that allows checking CPU
 	  temperature.
+
+config BCM_SR_THERMAL
+	tristate "Stingray thermal driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	default ARCH_BCM_IPROC
+	help
+	  Support for the Stingray family of SoCs. Its different blocks like
+	  iHost, CRMU and NITRO has thermal sensor that allows checking its
+	  temperature.
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
index fae10ec..79df69e 100644
--- a/drivers/thermal/broadcom/Makefile
+++ b/drivers/thermal/broadcom/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_BCM2835_THERMAL)		+= bcm2835_thermal.o
 obj-$(CONFIG_BRCMSTB_THERMAL)		+= brcmstb_thermal.o
 obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
+obj-$(CONFIG_BCM_SR_THERMAL)		+= sr-thermal.o
diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
new file mode 100644
index 0000000..5baaa6e
--- /dev/null
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Broadcom
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define TMON_CRIT_TEMP 105000 /* temp in millidegree C */
+
+struct sr_thermal {
+	struct thermal_zone_device *tz;
+	struct device *dev;
+	void __iomem *regs;
+	unsigned int crit_temp;
+};
+
+static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	*temp = readl(sr_thermal->regs);
+
+	return 0;
+}
+
+static int sr_get_trip_type(struct thermal_zone_device *tz, int trip,
+					enum thermal_trip_type *type)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	switch (trip) {
+	case 0:
+		*type = THERMAL_TRIP_CRITICAL;
+		break;
+	default:
+		dev_dbg(sr_thermal->dev,
+			"Driver does not support more than 1 trip point\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sr_get_trip_temp(struct thermal_zone_device *tz, int trip, int *temp)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	switch (trip) {
+	case 0:
+		*temp = sr_thermal->crit_temp;
+		break;
+	default:
+		dev_dbg(sr_thermal->dev,
+			"Driver does not support more than 1 trip point\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sr_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	switch (trip) {
+	case 0:
+		/*
+		 * Allow the user to change critical temperature
+		 * as per their requirement, could be for debug
+		 * purpose, even if it's more than the recommended
+		 * critical temperature.
+		 */
+		sr_thermal->crit_temp = temp;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static struct thermal_zone_device_ops sr_thermal_ops = {
+	.get_temp = sr_get_temp,
+	.get_trip_type = sr_get_trip_type,
+	.get_trip_temp = sr_get_trip_temp,
+	.set_trip_temp = sr_set_trip_temp,
+};
+
+static int sr_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sr_thermal *sr_thermal;
+	struct resource *res;
+
+	sr_thermal = devm_kzalloc(dev, sizeof(*sr_thermal), GFP_KERNEL);
+	if (!sr_thermal)
+		return -ENOMEM;
+	sr_thermal->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sr_thermal->regs = devm_memremap(&pdev->dev, res->start,
+					 resource_size(res), MEMREMAP_WB);
+	if (IS_ERR(sr_thermal->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(sr_thermal->regs);
+	}
+
+	/* initialize tmon value to 0 */
+	writel(0, sr_thermal->regs);
+	sr_thermal->crit_temp = TMON_CRIT_TEMP;
+
+	sr_thermal->tz = thermal_zone_device_register(dev_name(dev), 1, 1,
+							 sr_thermal,
+							 &sr_thermal_ops,
+							 NULL, 1000, 1000);
+	if (IS_ERR(sr_thermal->tz))
+		return PTR_ERR(sr_thermal->tz);
+
+	platform_set_drvdata(pdev, sr_thermal);
+
+	return 0;
+}
+
+static int sr_thermal_remove(struct platform_device *pdev)
+{
+	struct sr_thermal *sr_thermal = platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(sr_thermal->tz);
+
+	return 0;
+}
+
+static const struct of_device_id sr_thermal_of_match[] = {
+	{ .compatible = "brcm,sr-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
+
+static struct platform_driver sr_thermal_driver = {
+	.probe		= sr_thermal_probe,
+	.remove		= sr_thermal_remove,
+	.driver = {
+		.name = "sr-thermal",
+		.of_match_table = sr_thermal_of_match,
+	},
+};
+module_platform_driver(sr_thermal_driver);
+
+MODULE_AUTHOR("Pramod Kumar <pramod.kumar@broadcom.com>");
+MODULE_DESCRIPTION("Stingray thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
