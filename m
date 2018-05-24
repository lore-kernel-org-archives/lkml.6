Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967330AbeEXMwF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:52:05 -0400
Received: from foss.arm.com ([217.140.101.70]:44060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964863AbeEXMwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:52:01 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org>
 <1527152242-31281-2-git-send-email-ilialin@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <860be68b-cac0-9efc-b3c7-cc75b391a4c3@arm.com>
Date: Thu, 24 May 2018 13:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527152242-31281-2-git-send-email-ilialin@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilia,


On 24/05/18 09:57, Ilia Lin wrote:
> In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> the CPU frequency subset and voltage value of each OPP varies
> based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |  10 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c  | 194 +++++++++++++++++++++++++++++++++++
>  4 files changed, 208 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index de55c7d..0bfd40e 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -124,6 +124,16 @@ config ARM_OMAP2PLUS_CPUFREQ
>  	depends on ARCH_OMAP2PLUS
>  	default ARCH_OMAP2PLUS
>  
> +config ARM_QCOM_CPUFREQ_KRYO
> +	bool "Qualcomm Kryo based CPUFreq"
> +	depends on QCOM_QFPROM
> +	depends on QCOM_SMEM
> +	select PM_OPP
> +	help
> +	  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
> +
> +	  If in doubt, say N.
> +
>  config ARM_S3C_CPUFREQ
>  	bool
>  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d24ade..fb4a2ec 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 3b585e4..77d6ab8 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -118,6 +118,9 @@
>  
>  	{ .compatible = "nvidia,tegra124", },
>  
> +	{ .compatible = "qcom,apq8096", },
> +	{ .compatible = "qcom,msm8996", },
> +
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },
>  
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> new file mode 100644
> index 0000000..9fe379c
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +/*
> + * In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> + * the CPU frequency subset and voltage value of each OPP varies
> + * based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> + * defines the voltage and frequency value based on the msm-id in SMEM
> + * and speedbin blown in the efuse combination.
> + * The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> + * to provide the OPP framework with required information.
> + * This is used to determine the voltage and frequency value for each OPP of
> + * operating-points-v2 table when it is parsed by the OPP framework.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/smem.h>
> +
> +#define MSM_ID_SMEM	137
> +
> +enum _msm_id {
> +	MSM8996V3 = 0xF6ul,
> +	APQ8096V3 = 0x123ul,
> +	MSM8996SG = 0x131ul,
> +	APQ8096SG = 0x138ul,
> +};
> +
> +enum _msm8996_version {
> +	MSM8996_V3,
> +	MSM8996_SG,
> +	NUM_OF_MSM8996_VERSIONS,
> +};
> +
> +static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> +{
> +	size_t len;
> +	u32 *msm_id;
> +	enum _msm8996_version version;
> +
> +	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
> +	/* The first 4 bytes are format, next to them is the actual msm-id */
> +	msm_id++;
> +
> +	switch ((enum _msm_id)*msm_id) {
> +	case MSM8996V3:
> +	case APQ8096V3:
> +		version = MSM8996_V3;
> +		break;
> +	case MSM8996SG:
> +	case APQ8096SG:
> +		version = MSM8996_SG;
> +		break;
> +	default:
> +		version = NUM_OF_MSM8996_VERSIONS;
> +	}
> +
> +	return version;
> +}
> +
> +static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> +{
> +	struct opp_table *opp_tables[NR_CPUS] = {0};
> +	struct platform_device *cpufreq_dt_pdev;
> +	enum _msm8996_version msm8996_version;
> +	struct nvmem_cell *speedbin_nvmem;
> +	struct device_node *np;
> +	struct device *cpu_dev;
> +	unsigned cpu;
> +	u8 *speedbin;
> +	u32 versions;
> +	size_t len;
> +	int ret;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (NULL == cpu_dev)
> +		return -ENODEV;
> +
> +	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
> +	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> +		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> +		return -ENODEV;
> +	}
> +
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	if (IS_ERR(np))
> +		return PTR_ERR(np);
> +
> +	if (!of_device_is_compatible(np, "operating-points-v2-kryo-cpu")) {
> +		of_node_put(np);
> +		return -ENOENT;
> +	}
> +
> +	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> +	of_node_put(np);
> +	if (IS_ERR(speedbin_nvmem)) {
> +		dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> +			PTR_ERR(speedbin_nvmem));
> +		return PTR_ERR(speedbin_nvmem);
> +	}
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	nvmem_cell_put(speedbin_nvmem);
> +
> +	switch (msm8996_version) {
> +	case MSM8996_V3:
> +		versions = 1 << (unsigned int)(*speedbin);
> +		break;
> +	case MSM8996_SG:
> +		versions = 1 << ((unsigned int)(*speedbin) + 4);
> +		break;
> +	default:
> +		BUG();
> +		break;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (NULL == cpu_dev) {
> +			ret = -ENODEV;
> +			goto free_opp;
> +		}
> +
> +		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> +							      &versions, 1);
> +		if (IS_ERR(opp_tables[cpu])) {
> +			ret = PTR_ERR(opp_tables[cpu]);
> +			dev_err(cpu_dev, "Failed to set supported hardware\n");
> +			goto free_opp;
> +		}
> +	}
> +
> +	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> +							  NULL, 0);
> +	if (!IS_ERR(cpufreq_dt_pdev))
> +		return 0;
> +
> +	ret = PTR_ERR(cpufreq_dt_pdev);
> +	dev_err(cpu_dev, "Failed to register platform device\n");
> +
> +free_opp:
> +	for_each_possible_cpu(cpu) {
> +		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> +			break;
> +		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +	}
> +
> +	return ret;
> +}
> +
> +static struct platform_driver qcom_cpufreq_kryo_driver = {
> +	.probe = qcom_cpufreq_kryo_probe,
> +	.driver = {
> +		.name = "qcom-cpufreq-kryo",
> +	},
> +};
> +
> +/*
> + * Since the driver depends on smem and nvmem drivers, which may
> + * return EPROBE_DEFER, all the real activity is done in the probe,
> + * which may be defered as well. The init here is only registering
> + * the driver and the platform device.
> + */
> +static int __init qcom_cpufreq_kryo_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&qcom_cpufreq_kryo_driver);
> +	if (unlikely(ret < 0))
> +		return ret;
> +
> +	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
> +		"qcom-cpufreq-kryo", -1, NULL, 0));


You simply can't do this unconditionally here. This will blow up on
platforms where this driver is not supposed to work. The probe will be
called on non-QCOM or non-Kryo QCOM platforms and I reckon it will
crash trying to execute something in qcom_smem_get.

-- 
Regards,
Sudeep
