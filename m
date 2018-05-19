Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeESLzE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:55:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35626 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeESLzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:55:00 -0400
Date: Sat, 19 May 2018 12:54:41 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: ilialin@codeaurora.org
Cc: "'Viresh Kumar'" <viresh.kumar@linaro.org>, mark.rutland@arm.com,
        nm@ti.com, catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, tfinkel@codeaurora.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        nicolas.dechesne@linaro.org, linux-clk@vger.kernel.org,
        robh@kernel.org, andy.gross@linaro.org, celster@codeaurora.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, broonie@kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, sboyd@kernel.org, rjw@rjwysocki.net,
        lgirdwood@gmail.com, amit.kucheria@linaro.org
Subject: Re: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180519115441.GK17671@n2100.armlinux.org.uk>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org>
 <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <20180518014538.duphof6enscpm5vp@vireshk-i7>
 <018701d3ef61$dfd5e700$9f81b500$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018701d3ef61$dfd5e700$9f81b500$@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 02:09:24PM +0300, ilialin@codeaurora.org wrote:
> +static int __init qcom_cpufreq_kryo_driver_init(void)
> +{
> +       struct device *cpu_dev_silver, *cpu_dev_gold;
> +       struct opp_table *opp_silver, *opp_gold;
> +       enum _msm8996_version msm8996_version;
> +       struct nvmem_cell *speedbin_nvmem;
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +       u8 *speedbin;
> +       u32 versions;
> +       size_t len;
> +       int ret;
> +
> +       cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> +       if (IS_ERR_OR_NULL(cpu_dev_silver))
> +               return PTR_ERR(cpu_dev_silver);
> +
> +       cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> +       if (IS_ERR_OR_NULL(cpu_dev_gold))
> +               return PTR_ERR(cpu_dev_gold);
> +
> +       msm8996_version = qcom_cpufreq_kryo_get_msm_id();
> +       if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> +               dev_err(cpu_dev_silver, "Not Snapdragon 820/821!");
> +               return -ENODEV;
> +       }
> +
> +       np = dev_pm_opp_of_get_opp_desc_node(cpu_dev_silver);
> +       if (IS_ERR_OR_NULL(np))
> +               return PTR_ERR(np);

This function (qcom_cpufreq_kryo_driver_init) returns zero on success.
You are checking "np" here for being an error pointer, or NULL.
What value do you think PTR_ERR() returns in the case of PTR_ERR(NULL)?

IS_ERR_OR_NULL() is considered by some (me included) as being _very_
harmful because programmers generally fail to look at linux/err.h and
consider what it means when used as above.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
