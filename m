Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeEOEJa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:09:30 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39159 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeEOEJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:09:26 -0400
X-Google-Smtp-Source: AB8JxZq94oLRvE7BCJxpl3IJsZfB2RrXRIVlgrQ0U/BwlhQafW2lRRvNyIPa7fUxxp1rMJtde9h3/g==
Date: Tue, 15 May 2018 09:39:22 +0530
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
Subject: Re: [PATCH v6 12/14] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180515040922.hbk4xqdweel2hvsr@vireshk-i7>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
 <1526303520-5843-13-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526303520-5843-13-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-18, 16:11, Ilia Lin wrote:
> +static int __init qcom_cpufreq_kryo_driver_init(void)
> +{
> +	size_t len;
> +	int ret;
> +	u32 versions;
> +	enum _msm8996_version msm8996_version;
> +	u8 *speedbin;
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	struct nvmem_cell *speedbin_nvmem;
> +	struct opp_table *opp_temp = NULL;
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
> +	ret = PTR_ERR_OR_ZERO(opp_temp = \

Why back slash here ?

> +			      dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> +	if (0 > ret)
> +		goto free_np;
> +
> +	dev_pm_opp_put_supported_hw(opp_temp);
> +
> +	cpu_dev = get_cpu_device(GOLD_LEAD);
> +	ret = PTR_ERR_OR_ZERO(opp_temp = \

And here.

> +			      dev_pm_opp_set_supported_hw(cpu_dev,&versions,1));
> +	if (0 > ret)
> +		goto free_np;
> +
> +	ret = PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt", \

and here.

> +							      -1, NULL, 0));
> +
> +	dev_pm_opp_put_supported_hw(opp_temp);

And this is wrong. You don't need to call this in success case here.
It may have worked for you as cpufreq-dt driver would have already
been initialized, but that's not the case always. For example try
inserting cpufreq-dt module after kernel boots and it will fail.

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
