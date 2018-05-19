Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeESLlu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:41:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeESLlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:41:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0943960385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <nm@ti.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rnayak@codeaurora.org>,
        <amit.kucheria@linaro.org>, <nicolas.dechesne@linaro.org>,
        <celster@codeaurora.org>, <tfinkel@codeaurora.org>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org> <1526555955-29960-11-git-send-email-ilialin@codeaurora.org> <20180518014538.duphof6enscpm5vp@vireshk-i7>
In-Reply-To: <20180518014538.duphof6enscpm5vp@vireshk-i7>
Subject: RE: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
Date: Sat, 19 May 2018 14:41:18 +0300
Message-ID: <018901d3ef66$53e474a0$fbad5de0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ4436NnLWh81Iiw1zG4GLOsqluSgF4oTaoAirQgjmiz+iW8A==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From c5804e1d17578a63ca87cc8fd839bf756cfe3567 Mon Sep 17 00:00:00 2001
In-Reply-To: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
From: Ilia Lin <ilialin@codeaurora.org>
Date: Thu, 17 May 2018 13:55:12 +0300
Subject: [PATCH] cpufreq: Add Kryo CPU scaling driver

In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
the CPU frequency subset and voltage value of each OPP varies
based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
defines the voltage and frequency value based on the msm-id in SMEM
and speedbin blown in the efuse combination.
The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
to provide the OPP framework with required information.
This is used to determine the voltage and frequency value for each OPP of
operating-points-v2 table when it is parsed by the OPP framework.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm          |  10 +++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
 drivers/cpufreq/qcom-cpufreq-kryo.c  | 164
+++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index de55c7d..0bfd40e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -124,6 +124,16 @@ config ARM_OMAP2PLUS_CPUFREQ
        depends on ARCH_OMAP2PLUS
        default ARCH_OMAP2PLUS

+config ARM_QCOM_CPUFREQ_KRYO
+       bool "Qualcomm Kryo based CPUFreq"
+       depends on QCOM_QFPROM
+       depends on QCOM_SMEM
+       select PM_OPP
+       help
+         This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
+
+         If in doubt, say N.
+
 config ARM_S3C_CPUFREQ
        bool
        help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d24ade..fb4a2ec 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)           += mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)    += omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)       += pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)                   += pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)    += qcom-cpufreq-kryo.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)      += s3c2410-cpufreq.o
 obj-$(CONFIG_ARM_S3C2412_CPUFREQ)      += s3c2412-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)      += s3c2416-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3b585e4..77d6ab8 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -118,6 +118,9 @@

        { .compatible = "nvidia,tegra124", },

+       { .compatible = "qcom,apq8096", },
+       { .compatible = "qcom,msm8996", },
+
        { .compatible = "st,stih407", },
        { .compatible = "st,stih410", },

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c
b/drivers/cpufreq/qcom-cpufreq-kryo.c
new file mode 100644
index 0000000..ae2d1b9
--- /dev/null
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+/*
+ * In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
+ * the CPU frequency subset and voltage value of each OPP varies
+ * based on the silicon variant in use. Qualcomm Process Voltage Scaling
Tables
+ * defines the voltage and frequency value based on the msm-id in SMEM
+ * and speedbin blown in the efuse combination.
+ * The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the
SoC
+ * to provide the OPP framework with required information.
+ * This is used to determine the voltage and frequency value for each OPP
of
+ * operating-points-v2 table when it is parsed by the OPP framework.
+ */
+
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+
+#define MSM_ID_SMEM    137
+#define SILVER_LEAD    0
+#define GOLD_LEAD      2
+
+enum _msm_id {
+       MSM8996V3 = 0xF6ul,
+       APQ8096V3 = 0x123ul,
+       MSM8996SG = 0x131ul,
+       APQ8096SG = 0x138ul,
+};
+
+enum _msm8996_version {
+       MSM8996_V3,
+       MSM8996_SG,
+       NUM_OF_MSM8996_VERSIONS,
+};
+
+static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
+{
+       size_t len;
+       u32 *msm_id;
+       enum _msm8996_version version;
+
+       msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
+       /* The first 4 bytes are format, next to them is the actual msm-id
*/
+       msm_id++;
+
+       switch ((enum _msm_id)*msm_id) {
+       case MSM8996V3:
+       case APQ8096V3:
+               version = MSM8996_V3;
+               break;
+       case MSM8996SG:
+       case APQ8096SG:
+               version = MSM8996_SG;
+               break;
+       default:
+               version = NUM_OF_MSM8996_VERSIONS;
+       }
+
+       return version;
+}
+
+static int __init qcom_cpufreq_kryo_driver_init(void)
+{
+       struct device *cpu_dev_silver, *cpu_dev_gold;
+       struct opp_table *opp_silver, *opp_gold;
+       enum _msm8996_version msm8996_version;
+       struct nvmem_cell *speedbin_nvmem;
+       struct platform_device *pdev;
+       struct device_node *np;
+       u8 *speedbin;
+       u32 versions;
+       size_t len;
+       int ret;
+
+       cpu_dev_silver = get_cpu_device(SILVER_LEAD);
+       if (IS_ERR_OR_NULL(cpu_dev_silver))
+               return PTR_ERR(cpu_dev_silver);
+
+       cpu_dev_gold = get_cpu_device(SILVER_LEAD);
+       if (IS_ERR_OR_NULL(cpu_dev_gold))
+               return PTR_ERR(cpu_dev_gold);
+
+       msm8996_version = qcom_cpufreq_kryo_get_msm_id();
+       if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
+               dev_err(cpu_dev_silver, "Not Snapdragon 820/821!");
+               return -ENODEV;
+       }
+
+       np = dev_pm_opp_of_get_opp_desc_node(cpu_dev_silver);
+       if (IS_ERR_OR_NULL(np))
+               return PTR_ERR(np);
+
+       if (!of_device_is_compatible(np, "operating-points-v2-kryo-cpu")) {
+               ret = -ENOENT;
+               goto free_np;
+       }
+
+       speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+       if (IS_ERR(speedbin_nvmem)) {
+               ret = PTR_ERR(speedbin_nvmem);
+               dev_err(cpu_dev_silver, "Could not get nvmem cell: %d\n",
ret);
+               goto free_np;
+       }
+
+       speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+       nvmem_cell_put(speedbin_nvmem);
+
+       switch (msm8996_version) {
+       case MSM8996_V3:
+               versions = 1 << (unsigned int)(*speedbin);
+               break;
+       case MSM8996_SG:
+               versions = 1 << ((unsigned int)(*speedbin) + 4);
+               break;
+       default:
+               BUG();
+               break;
+       }
+
+       opp_silver =
dev_pm_opp_set_supported_hw(cpu_dev_silver,&versions,1);
+       if (IS_ERR(opp_silver)) {
+               dev_err(cpu_dev_silver, "Failed to set supported
hardware\n");
+               ret = PTR_ERR(opp_silver);
+               goto free_np;
+       }
+
+       opp_gold = dev_pm_opp_set_supported_hw(cpu_dev_gold,&versions,1);
+       if (IS_ERR(opp_gold)) {
+               dev_err(cpu_dev_gold, "Failed to set supported hardware\n");
+               ret = PTR_ERR(opp_gold);
+               goto free_opp_silver;
+       }
+
+       pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+       if (!IS_ERR_OR_NULL(pdev))
+               return 0;
+
+       ret = PTR_ERR(pdev);
+       dev_err(cpu_dev_silver, "Failed to register platform device\n");
+       dev_pm_opp_put_supported_hw(opp_gold);
+
+free_opp_silver:
+       dev_pm_opp_put_supported_hw(opp_silver);
+
+free_np:
+       of_node_put(np);
+
+       return ret;
+}
+late_initcall(qcom_cpufreq_kryo_driver_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
+MODULE_LICENSE("GPL v2");
--
1.9.1

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Friday, May 18, 2018 04:46
> To: Ilia Lin <ilialin@codeaurora.org>
> Cc: mturquette@baylibre.com; sboyd@kernel.org; robh@kernel.org;
> mark.rutland@arm.com; nm@ti.com; lgirdwood@gmail.com;
> broonie@kernel.org; andy.gross@linaro.org; david.brown@linaro.org;
> catalin.marinas@arm.com; will.deacon@arm.com; rjw@rjwysocki.net; linux-
> clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pm@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; linux-soc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; rnayak@codeaurora.org;
> amit.kucheria@linaro.org; nicolas.dechesne@linaro.org;
> celster@codeaurora.org; tfinkel@codeaurora.org
> Subject: Re: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
> 
> On 17-05-18, 14:19, Ilia Lin wrote:
> > +static int __init qcom_cpufreq_kryo_driver_init(void)
> > +{
> > +	size_t len;
> > +	int ret = 0;
> > +	u32 versions;
> > +	enum _msm8996_version msm8996_version;
> > +	u8 *speedbin;
> > +	struct device *cpu_dev_silver, *cpu_dev_gold;
> > +	struct device_node *np;
> > +	struct nvmem_cell *speedbin_nvmem;
> > +	struct platform_device *pdev;
> > +	struct opp_table *opp_silver = NULL;
> > +	struct opp_table *opp_gold = NULL;
> 
> No need to initialize them and you may want to arrange all above in
> decreasing order of their length.
> 
> > +
> > +	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> > +	if (IS_ERR_OR_NULL(cpu_dev_silver))
> > +		return PTR_ERR(cpu_dev_silver);
> > +
> > +	cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> > +	if (IS_ERR_OR_NULL(cpu_dev_gold))
> > +		return PTR_ERR(cpu_dev_gold);
> > +
> > +	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
> > +	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> > +		dev_err(cpu_dev_silver, "Not Snapdragon 820/821!");
> > +		return -ENODEV;
> > +	}
> > +
> > +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev_silver);
> > +	if (IS_ERR_OR_NULL(np))
> > +		return PTR_ERR(np);
> > +
> > +	if (!of_device_is_compatible(np, "operating-points-v2-kryo-cpu")) {
> > +		ret = -ENOENT;
> > +		goto free_np;
> > +	}
> > +
> > +	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> > +	if (IS_ERR(speedbin_nvmem)) {
> > +		ret = PTR_ERR(speedbin_nvmem);
> > +		dev_err(cpu_dev_silver, "Could not get nvmem cell: %d\n",
> ret);
> > +		goto free_np;
> > +	}
> > +
> > +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> > +	nvmem_cell_put(speedbin_nvmem);
> > +
> > +	switch (msm8996_version) {
> > +	case MSM8996_V3:
> > +		versions = 1 << (unsigned int)(*speedbin);
> > +		break;
> > +	case MSM8996_SG:
> > +		versions = 1 << ((unsigned int)(*speedbin) + 4);
> > +		break;
> > +	default:
> > +		BUG();
> > +		break;
> > +	}
> > +
> > +	opp_silver =
> dev_pm_opp_set_supported_hw(cpu_dev_silver,&versions,1);
> > +	if (IS_ERR_OR_NULL(opp_silver)) {
> 
> This API doesn't return NULL and so IS_ERR() would be sufficient.
> 
> > +		dev_err(cpu_dev_silver, "Failed to set supported
> hardware\n");
> > +		ret = PTR_ERR(opp_silver);
> > +		goto free_np;
> > +	}
> > +
> > +	opp_gold =
> dev_pm_opp_set_supported_hw(cpu_dev_gold,&versions,1);
> > +	if (IS_ERR_OR_NULL(opp_gold)) {
> 
> same here.
> 
> > +		dev_err(cpu_dev_gold, "Failed to set supported
> hardware\n");
> > +		ret = PTR_ERR(opp_gold);
> > +		goto free_opp_silver;
> > +	}
> > +
> > +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> > +	if (!IS_ERR_OR_NULL(pdev))
> > +		goto out;
> 
> Simply return from here and remove the useless label out.
> 
> > +
> > +	ret = PTR_ERR(pdev);
> > +	dev_err(cpu_dev_silver, "Failed to register platform device\n");
> > +	dev_pm_opp_put_supported_hw(opp_gold);
> > +
> > +free_opp_silver:
> > +	dev_pm_opp_put_supported_hw(opp_silver);
> > +
> > +free_np:
> > +	of_node_put(np);
> > +
> > +out:
> > +	return ret;
> > +}
> > +late_initcall(qcom_cpufreq_kryo_driver_init);
> 
> Please resend only this patch now or just paste the new code in a mail
here
> so that I can review it quickly and then you can resend the final version.
Most
> of the patches aren't changing anyway.
> 
> --
> viresh
