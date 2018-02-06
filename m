Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeBFELu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:11:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeBFEKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:10:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA69261156
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
Cc: sricharan@codeaurora.org
Subject: [PATCH v6 14/15] cpufreq: Add module to register cpufreq on Krait CPUs
Date: Tue,  6 Feb 2018 09:38:27 +0530
Message-Id: <1517890108-8140-15-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Register a cpufreq-generic device whenever we detect that a
"qcom,krait" compatible CPU is present in DT.

Cc: <devicetree@vger.kernel.org>
[Sricharan: updated to use dev_pm_opp_set_prop_name, NVMEM apis,
	    new binding]
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/Kconfig.arm          |  10 +++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |   5 ++
 drivers/cpufreq/qcom-cpufreq.c       | 161 +++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)
 create mode 100644 drivers/cpufreq/qcom-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index bdce448..076d039 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -100,6 +100,16 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 
+config ARM_QCOM_CPUFREQ
+	bool "CPUfreq driver for the QCOM SoCs with KRAIT processors"
+	depends on ARCH_QCOM
+	select PM_OPP
+	help
+	  This enables the CPUFreq driver for Qualcomm SoCs with
+	  KRAIT processors.
+
+	  If in doubt, say N.
+
 config ARM_S3C_CPUFREQ
 	bool
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 812f9e0..1496464 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ)		+= qcom-cpufreq.o
 obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
 obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ecc56e2..8a55a85 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -119,6 +119,11 @@
 	{ .compatible = "ti,am43", },
 	{ .compatible = "ti,dra7", },
 
+	{ .compatible = "qcom,ipq8064", },
+	{ .compatible = "qcom,apq8064", },
+	{ .compatible = "qcom,msm8974", },
+	{ .compatible = "qcom,msm8960", },
+
 	{ }
 };
 
diff --git a/drivers/cpufreq/qcom-cpufreq.c b/drivers/cpufreq/qcom-cpufreq.c
new file mode 100644
index 0000000..5b988d4
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include "cpufreq-dt.h"
+#include <linux/nvmem-consumer.h>
+
+static void __init get_krait_bin_format_a(int *speed, int *pvs, int *pvs_ver,
+					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+{
+	u32 pte_efuse;
+
+	pte_efuse = *((u32 *)buf);
+
+	*speed = pte_efuse & 0xf;
+	if (*speed == 0xf)
+		*speed = (pte_efuse >> 4) & 0xf;
+
+	if (*speed == 0xf) {
+		*speed = 0;
+		pr_warn("Speed bin: Defaulting to %d\n", *speed);
+	} else {
+		pr_info("Speed bin: %d\n", *speed);
+	}
+
+	*pvs = (pte_efuse >> 10) & 0x7;
+	if (*pvs == 0x7)
+		*pvs = (pte_efuse >> 13) & 0x7;
+
+	if (*pvs == 0x7) {
+		*pvs = 0;
+		pr_warn("PVS bin: Defaulting to %d\n", *pvs);
+	} else {
+		pr_info("PVS bin: %d\n", *pvs);
+	}
+
+	kfree(buf);
+}
+
+static void __init get_krait_bin_format_b(int *speed, int *pvs, int *pvs_ver,
+					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+{
+	u32 pte_efuse, redundant_sel;
+
+	pte_efuse = *((u32 *)buf);
+	redundant_sel = (pte_efuse >> 24) & 0x7;
+	*speed = pte_efuse & 0x7;
+
+	/* 4 bits of PVS are in efuse register bits 31, 8-6. */
+	*pvs = ((pte_efuse >> 28) & 0x8) | ((pte_efuse >> 6) & 0x7);
+	*pvs_ver = (pte_efuse >> 4) & 0x3;
+
+	switch (redundant_sel) {
+	case 1:
+		*speed = (pte_efuse >> 27) & 0xf;
+		break;
+	case 2:
+		*pvs = (pte_efuse >> 27) & 0xf;
+		break;
+	}
+
+	/* Check SPEED_BIN_BLOW_STATUS */
+	if (pte_efuse & BIT(3)) {
+		pr_info("Speed bin: %d\n", *speed);
+	} else {
+		pr_warn("Speed bin not set. Defaulting to 0!\n");
+		*speed = 0;
+	}
+
+	/* Check PVS_BLOW_STATUS */
+	pte_efuse = *(((u32 *)buf) + 4);
+	if (pte_efuse) {
+		pr_info("PVS bin: %d\n", *pvs);
+	} else {
+		pr_warn("PVS bin not set. Defaulting to 0!\n");
+		*pvs = 0;
+	}
+
+	pr_info("PVS version: %d\n", *pvs_ver);
+	kfree(buf);
+}
+
+static int __init qcom_cpufreq_populate_opps(struct nvmem_cell *pvs_nvmem)
+{
+	int speed = 0, pvs = 0, pvs_ver = 0, cpu;
+	struct device *dev;
+	u8 *buf;
+	size_t len;
+	char pvs_name[] = "speedXX-pvsXX-vXX";
+
+	buf = nvmem_cell_read(pvs_nvmem, &len);
+	if (len == 4)
+		get_krait_bin_format_a(&speed, &pvs, &pvs_ver, pvs_nvmem, buf);
+	else if (len == 8)
+		get_krait_bin_format_b(&speed, &pvs, &pvs_ver, pvs_nvmem, buf);
+	else
+		pr_warn("Unable to read nvmem data. Defaulting to 0!\n");
+
+	snprintf(pvs_name, sizeof(pvs_name), "speed%d-pvs%d-v%d",
+		 speed, pvs, pvs_ver);
+
+	for (cpu = 0; cpu < num_possible_cpus(); cpu++) {
+		dev = get_cpu_device(cpu);
+		if (!dev)
+			return -ENODEV;
+
+		if (IS_ERR(dev_pm_opp_set_prop_name(dev, pvs_name)))
+			pr_warn("failed to add OPP name %s\n", pvs_name);
+	}
+
+	return 0;
+}
+
+static int __init qcom_cpufreq_driver_init(void)
+{
+	struct device *cpu_dev;
+	struct device_node *np;
+	struct nvmem_cell *pvs_nvmem;
+	int ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	if (!np)
+		return -ENOENT;
+
+	if (!of_device_is_compatible(np, "operating-points-v2-krait-cpu")) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	pvs_nvmem = of_nvmem_cell_get(np, NULL);
+	if (IS_ERR(pvs_nvmem)) {
+		dev_err(cpu_dev, "Could not get nvmem cell\n");
+		return PTR_ERR(pvs_nvmem);
+	}
+
+	of_node_put(np);
+
+	ret = qcom_cpufreq_populate_opps(pvs_nvmem);
+	if (ret)
+		return ret;
+
+	return PTR_ERR(platform_device_register_simple("cpufreq-dt",
+						       -1, NULL, 0));
+}
+module_init(qcom_cpufreq_driver_init);
+
+MODULE_DESCRIPTION("Qualcomm CPUfreq driver");
+MODULE_LICENSE("GPL v2");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
