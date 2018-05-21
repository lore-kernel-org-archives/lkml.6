Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEUMuP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:50:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbeEUMuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:50:08 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        linux-clk@vger.kernel.org
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
Date: Mon, 21 May 2018 13:50:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/05/18 12:35, Ilia Lin wrote:
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
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |  10 +++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c  | 164 +++++++++++++++++++++++++++++++++++
>  4 files changed, 178 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
> 

[..]

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
> +#define SILVER_LEAD	0
> +#define GOLD_LEAD	2
> +

So I gather form other emails, that these are physical cpu number(not
even unique identifier like MPIDR). Will this work on parts or platforms
that need to boot in GOLD LEAD cpus.

[...]

> +
> +static int __init qcom_cpufreq_kryo_driver_init(void)
> +{
> +	struct device *cpu_dev_silver, *cpu_dev_gold;
> +	struct opp_table *opp_silver, *opp_gold;
> +	enum _msm8996_version msm8996_version;
> +	struct nvmem_cell *speedbin_nvmem;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	u8 *speedbin;
> +	u32 versions;
> +	size_t len;
> +	int ret;
> +
> +	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> +	if (IS_ERR_OR_NULL(cpu_dev_silver))
> +		return PTR_ERR(cpu_dev_silver);
> +
> +	cpu_dev_gold = get_cpu_device(SILVER_LEAD);

s/SILVER/GOLD/ ?

-- 
Regards,
Sudeep
