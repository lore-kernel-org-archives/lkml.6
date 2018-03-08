Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCHXZL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:25:11 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13689 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeCHXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:25:09 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Mar 2018 15:25:07 -0800
Subject: Re: [PATCH v3 09/11] cpufreq: tegra124-cpufreq: extend to support
 Tegra210
To: Peter De Schrijver <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b7a25613-44b4-5e63-e8c7-91ce2b7cb56e@nvidia.com>
Date: Thu, 8 Mar 2018 23:25:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
X-Originating-IP: [10.26.11.23]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/02/18 16:34, Peter De Schrijver wrote:
> Tegra210 has a very similar CPU clocking scheme than Tegra124. So add
> support in this driver. Also allow for the case where the CPU voltage is
> controlled directly by the DFLL rather than by a separate regulator object.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 4353025..f8e01a8 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -64,7 +64,8 @@ static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
>  {
>  	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
>  	clk_disable_unprepare(priv->dfll_clk);
> -	regulator_sync_voltage(priv->vdd_cpu_reg);
> +	if (priv->vdd_cpu_reg)
> +		regulator_sync_voltage(priv->vdd_cpu_reg);
>  	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
>  }
>  
> @@ -89,10 +90,10 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	priv->vdd_cpu_reg = regulator_get(cpu_dev, "vdd-cpu");
> -	if (IS_ERR(priv->vdd_cpu_reg)) {
> -		ret = PTR_ERR(priv->vdd_cpu_reg);
> -		goto out_put_np;
> -	}
> +	if (IS_ERR(priv->vdd_cpu_reg) != -EPROBE_DEFER)
> +		priv->vdd_cpu_reg = NULL;
> +	else
> +		return -EPROBE_DEFER;

I am still not sure that we should rely on the fact that the regulator
is not present in DT to imply that we do not need it. I think that we
should be checking if we are using I2C mode here.

Cheers
Jon

-- 
nvpublic
