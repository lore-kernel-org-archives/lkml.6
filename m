Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbeEUFFA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 01:05:00 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44975 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEUFE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 01:04:56 -0400
X-Google-Smtp-Source: AB8JxZq6fCb8/TaTRgOUi4jHlPOajOD7cw1XBdmQM9RnA4fKxr8H75FR6MiHbTFciVK0MbeXS9kISA==
Date: Mon, 21 May 2018 10:34:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, nm@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180521050453.vls3fe6fyake4dhk@vireshk-i7>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More comments after Russell's reply.

On 19-05-18, 14:35, Ilia Lin wrote:
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

get_cpu_device() returns only NULL on error.

> +		return PTR_ERR(cpu_dev_silver);
> +
> +	cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> +	if (IS_ERR_OR_NULL(cpu_dev_gold))
> +		return PTR_ERR(cpu_dev_gold);
> +
> +	msm8996_version = qcom_cpufreq_kryo_get_msm_id();
> +	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> +		dev_err(cpu_dev_silver, "Not Snapdragon 820/821!");
> +		return -ENODEV;
> +	}
> +
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev_silver);
> +	if (IS_ERR_OR_NULL(np))

same here.

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
> +		dev_err(cpu_dev_silver, "Could not get nvmem cell: %d\n", ret);
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
> +	opp_silver = dev_pm_opp_set_supported_hw(cpu_dev_silver,&versions,1);
> +	if (IS_ERR(opp_silver)) {
> +		dev_err(cpu_dev_silver, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_silver);
> +		goto free_np;
> +	}
> +
> +	opp_gold = dev_pm_opp_set_supported_hw(cpu_dev_gold,&versions,1);
> +	if (IS_ERR(opp_gold)) {
> +		dev_err(cpu_dev_gold, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_gold);
> +		goto free_opp_silver;
> +	}
> +
> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);

and this only returns ERR_PTR() on error.

> +	if (!IS_ERR_OR_NULL(pdev))
> +		return 0;
> +
> +	ret = PTR_ERR(pdev);
> +	dev_err(cpu_dev_silver, "Failed to register platform device\n");
> +	dev_pm_opp_put_supported_hw(opp_gold);
> +
> +free_opp_silver:
> +	dev_pm_opp_put_supported_hw(opp_silver);
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
> -- 
> 1.9.1

-- 
viresh
