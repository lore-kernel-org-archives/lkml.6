Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeERBpr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:45:47 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43867 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbeERBpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:45:43 -0400
X-Google-Smtp-Source: AB8JxZq13B7y4z0MlOeD4AuZi9/zztGB2NAvMAy3bCSmE1Ajg9bt6MPP8IAP311uBUkjhKQz8udLng==
Date: Fri, 18 May 2018 07:15:38 +0530
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
Subject: Re: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180518014538.duphof6enscpm5vp@vireshk-i7>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org>
 <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 14:19, Ilia Lin wrote:
> +static int __init qcom_cpufreq_kryo_driver_init(void)
> +{
> +	size_t len;
> +	int ret = 0;
> +	u32 versions;
> +	enum _msm8996_version msm8996_version;
> +	u8 *speedbin;
> +	struct device *cpu_dev_silver, *cpu_dev_gold;
> +	struct device_node *np;
> +	struct nvmem_cell *speedbin_nvmem;
> +	struct platform_device *pdev;
> +	struct opp_table *opp_silver = NULL;
> +	struct opp_table *opp_gold = NULL;

No need to initialize them and you may want to arrange all above in
decreasing order of their length.

> +
> +	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> +	if (IS_ERR_OR_NULL(cpu_dev_silver))
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
> +	if (IS_ERR_OR_NULL(opp_silver)) {

This API doesn't return NULL and so IS_ERR() would be sufficient.

> +		dev_err(cpu_dev_silver, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_silver);
> +		goto free_np;
> +	}
> +
> +	opp_gold = dev_pm_opp_set_supported_hw(cpu_dev_gold,&versions,1);
> +	if (IS_ERR_OR_NULL(opp_gold)) {

same here.

> +		dev_err(cpu_dev_gold, "Failed to set supported hardware\n");
> +		ret = PTR_ERR(opp_gold);
> +		goto free_opp_silver;
> +	}
> +
> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	if (!IS_ERR_OR_NULL(pdev))
> +		goto out;

Simply return from here and remove the useless label out.

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
> +out:
> +	return ret;
> +}
> +late_initcall(qcom_cpufreq_kryo_driver_init);

Please resend only this patch now or just paste the new code in a mail
here so that I can review it quickly and then you can resend the final
version. Most of the patches aren't changing anyway.

-- 
viresh
