Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeC2V2e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 17:28:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeC2V2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 17:28:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B17A610D5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v4 12/14] cpufreq: Add Kryo CPU scaling driver
Date: Fri, 30 Mar 2018 00:26:45 +0300
Message-Id: <1522358807-10413-13-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
the CPU ferequencies subset and voltage value of each OPP varies
based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
defines the voltage and frequency value based on the msm-id in SMEM
and speedbin blown in the efuse combination.
The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
to provide the OPP framework with required information.
This is used to determine the voltage and frequency value for each OPP of
operating-points-v2 table when it is parsed by the OPP framework.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/cpufreq/Kconfig.arm          |  11 +++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
 drivers/cpufreq/qcom-cpufreq-kryo.c  | 147 +++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 7f56fe5..71350e2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -134,6 +134,17 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 
+config ARM_QCOM_CPUFREQ_KRYO
+	tristate "Qualcomm Technologies, Inc. Kryo based"
+	depends on QCOM_QFPROM
+	depends on QCOM_SMEM
+	select PM_OPP
+	help
+	  This adds the CPUFreq driver for
+	  Qualcomm Technologies, Inc. Kryo SoC based boards.
+
+	  If in doubt, say N.
+
 config ARM_S3C_CPUFREQ
 	bool
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d24ade..fb4a2ec 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
 obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3b585e4..88e8a6e 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -127,6 +127,9 @@
 	{ .compatible = "ti,am43", },
 	{ .compatible = "ti,dra7", },
 
+	{ .compatible = "qcom,msm8996", },
+	{ .compatible = "qcom,apq8096", },
+
 	{ }
 };
 
diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
new file mode 100644
index 0000000..3cb51f8
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -0,0 +1,147 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+
+#define MSM_ID_SMEM	137
+#define SILVER_LEAD	0
+#define GOLD_LEAD	2
+
+enum _msm_id {
+	MSM8996V3 = 0xF6ul,
+	APQ8096V3 = 0x123ul,
+	MSM8996SG = 0x131ul,
+	APQ8096SG = 0x138ul,
+};
+
+enum _msm8996_version {
+	MSM8996_V3,
+	MSM8996_SG,
+	NUM_OF_MSM8996_VERSIONS,
+};
+
+static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
+{
+	size_t len;
+	u32 *msm_id;
+	enum _msm8996_version version;
+
+	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
+	/* The first 4 bytes are format, next to them is the actual msm-id */
+	msm_id++;
+
+	switch ((enum _msm_id)*msm_id) {
+	case MSM8996V3:
+	case APQ8096V3:
+		version = MSM8996_V3;
+		break;
+	case MSM8996SG:
+	case APQ8096SG:
+		version = MSM8996_SG;
+		break;
+	default:
+		version = NUM_OF_MSM8996_VERSIONS;
+	}
+
+	return version;
+}
+
+static int __init qcom_cpufreq_kryo_driver_init(void)
+{
+	struct platform_device *pdev;
+	struct device *cpu_dev;
+	struct device_node *np;
+	struct nvmem_cell *speedbin_nvmem;
+	enum _msm8996_version msm8996_version;
+	u8 *speedbin;
+	size_t len;
+	int ret;
+	u32 versions;
+
+	cpu_dev = get_cpu_device(SILVER_LEAD);
+	if (IS_ERR_OR_NULL(cpu_dev))
+		return PTR_ERR(cpu_dev);
+
+	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
+	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
+		dev_err(cpu_dev, "Not Snapdragon 820/821!");
+		return -ENODEV;
+        }
+
+	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	if (IS_ERR_OR_NULL(np))
+		return PTR_ERR(np);
+
+	if (!of_device_is_compatible(np, "operating-points-v2-kryo-cpu")) {
+		ret = -ENOENT;
+		goto free_np;
+	}
+
+	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+	if (IS_ERR(speedbin_nvmem)) {
+		ret = PTR_ERR(speedbin_nvmem);
+		dev_err(cpu_dev, "Could not get nvmem cell: %d\n", ret);
+		goto free_np;
+	}
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+
+	switch (msm8996_version) {
+	case MSM8996_V3:
+		versions = 1 << (unsigned int)(*speedbin);
+		break;
+	case MSM8996_SG:
+		versions = 1 << ((unsigned int)(*speedbin) + 4);
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
+	if (0 > ret)
+		goto free_np;
+
+	cpu_dev = get_cpu_device(GOLD_LEAD);
+	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
+
+	of_node_put(np);
+
+	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+
+free_np:
+	of_node_put(np);
+
+	return ret;
+}
+late_initcall(qcom_cpufreq_kryo_driver_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
