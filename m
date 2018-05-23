Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932444AbeEWKjr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:39:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53082 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932180AbeEWKjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:39:43 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org>
 <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com>
Date: Wed, 23 May 2018 11:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/05/18 10:40, Ilia Lin wrote:
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

[...]

> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	if (!IS_ERR(pdev))
> +		return 0;
> +
> +	ret = PTR_ERR(pdev);
> +	dev_err(cpu_dev, "Failed to register platform device\n");
> +
> +free_opp:
> +	for_each_possible_cpu(cpu) {
> +		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> +			break;
> +		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> +	}
> +free_np:
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +late_initcall(qcom_cpufreq_kryo_driver_init);

Any particular reason why this *has* to be late initcall ?
Please change it to module_initcall otherwise.
Also address the of_node comments from Viresh.

Otherwise, it looks good.
-- 
Regards,
Sudeep
