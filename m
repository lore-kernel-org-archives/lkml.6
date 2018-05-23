Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeEWKDX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:03:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44786 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeEWKDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:03:19 -0400
X-Google-Smtp-Source: AB8JxZpPKmkFuepeDwRCOdGcmxhOOk3kPmDk5F9JWZnTmta5mmwYjls+pPXZfQtPW1ZdVkQDdMj4Xg==
Date: Wed, 23 May 2018 15:33:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180523100316.27m4epl7deitfrnt@vireshk-i7>
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org>
 <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 12:40, Ilia Lin wrote:
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

Well I gave you an Ack and you should have kept it here :(

> +static int __init qcom_cpufreq_kryo_driver_init(void)
> +{
> +	struct opp_table *opp_tables[NR_CPUS] = {0};
> +	enum _msm8996_version msm8996_version;
> +	struct nvmem_cell *speedbin_nvmem;
> +	struct platform_device *pdev;
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
> +		ret = -ENOENT;
> +		goto free_np;

As Russell pointed out, drop this goto here and write:

                of_node_put(np);
                return -ENOENT;
        }

> +	}
> +
> +	speedbin_nvmem = of_nvmem_cell_get(np, NULL);

And do the same here unconditionally as you don't need to use np
anymore, i.e.

        of_node_put(np);

> +	if (IS_ERR(speedbin_nvmem)) {
> +		ret = PTR_ERR(speedbin_nvmem);
> +		dev_err(cpu_dev, "Could not get nvmem cell: %d\n", ret);
> +		goto free_np;
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

And then you can remove the label and above statement.

> +
> +	return ret;
> +}
> +late_initcall(qcom_cpufreq_kryo_driver_init);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1

-- 
viresh
