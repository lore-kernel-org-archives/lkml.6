Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeBLIxK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:53:10 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43182 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933125AbeBLIxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:53:06 -0500
X-Google-Smtp-Source: AH8x226WNAmPpAInsOVarvaaTitFOiAqcSAcBybPG1TP2kwlhD+/1K4A6YBzzEobSS0JSyKxmejQcA==
Date: Mon, 12 Feb 2018 14:23:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stefan Agner <stefan@agner.ch>
Cc: rjw@rjwysocki.net, fabio.estevam@nxp.com, octavian.purdila@nxp.com,
        shawnguo@kernel.org, max.oss.09@gmail.com, marcel.ziswiler@toradex.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
Message-ID: <20180212085302.GR28462@vireshk-i7>
References: <20180118235836.17393-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118235836.17393-1-stefan@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-18, 00:58, Stefan Agner wrote:
> Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
> Use PLL1 sys clock for all operating points higher than 528MHz.
> 
> Note: For higher operating points VDD_SOC_IN needs to be 125mV
> higher than the ARM set-point (see datasheet). Specifically, the
> i.MX6UL/ULL EVK boards have an external DC regulator which needs
> adjustment. The regulator adjustment is not covered with this
> change.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 628fe899cb48..840f6386c780 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  		 */
>  		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
>  		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> -		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> -			clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> -		else
> -			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> -		clk_set_parent(step_clk, secondary_sel_clk);
> -		clk_set_parent(pll1_sw_clk, step_clk);
> +		if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
> +			if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> +				clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> +			else
> +				clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> +			clk_set_parent(step_clk, secondary_sel_clk);
> +			clk_set_parent(pll1_sw_clk, step_clk);
> +		}
>  	} else {
>  		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>  		clk_set_parent(pll1_sw_clk, step_clk);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
