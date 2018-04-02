Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeDBO4P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:56:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeDBO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:56:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FEB360FEA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v4 12/14] cpufreq: Add Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: rnayak@codeaurora.org, amit.kucheria@linaro.org,
        nicolas.dechesne@linaro.org, celster@codeaurora.org,
        tfinkel@codeaurora.org
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-13-git-send-email-ilialin@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <c17f3623-849f-cba8-8118-623e4e8261da@codeaurora.org>
Date: Mon, 2 Apr 2018 20:26:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522358807-10413-13-git-send-email-ilialin@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilia,

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 7f56fe5..71350e2 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -134,6 +134,17 @@ config ARM_OMAP2PLUS_CPUFREQ
>  	depends on ARCH_OMAP2PLUS
>  	default ARCH_OMAP2PLUS
>  
> +config ARM_QCOM_CPUFREQ_KRYO
> +	tristate "Qualcomm Technologies, Inc. Kryo based"

 Does this need to be 'tristate' ?. 'cpu-freq-dt' driver is already
 built as module.

<..>

> +
> +#include <linux/cpu.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>

 Is io.h required ?

Regards,
  Sricharan

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
> +#define SILVER_LEAD	0
> +#define GOLD_LEAD	2
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
> +static int __init qcom_cpufreq_kryo_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	struct nvmem_cell *speedbin_nvmem;
> +	enum _msm8996_version msm8996_version;
> +	u8 *speedbin;
> +	size_t len;
> +	int ret;
> +	u32 versions;
> +
> +	cpu_dev = get_cpu_device(SILVER_LEAD);
> +	if (IS_ERR_OR_NULL(cpu_dev))
> +		return PTR_ERR(cpu_dev);
> +
> +	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
> +	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> +		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> +		return -ENODEV;
> +        }
> +
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	if (IS_ERR_OR_NULL(np))
> +		return PTR_ERR(np);
> +
> +	if (!of_device_is_compatible(np, "operating-points-v2-kryo-cpu")) {
> +		ret = -ENOENT;
> +		goto free_np;
> +	}
> +
> +	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> +	if (IS_ERR(speedbin_nvmem)) {
> +		ret = PTR_ERR(speedbin_nvmem);
> +		dev_err(cpu_dev, "Could not get nvmem cell: %d\n", ret);
> +		goto free_np;
> +	}
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
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
> +	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> +	if (0 > ret)
> +		goto free_np;
> +
> +	cpu_dev = get_cpu_device(GOLD_LEAD);
> +	ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> +
> +	of_node_put(np);
> +
> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +
> +free_np:
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +late_initcall(qcom_cpufreq_kryo_driver_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
