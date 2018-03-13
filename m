Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbeCMJ2Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:28:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2905 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeCMJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:28:21 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 13 Mar 2018 02:28:18 -0700
Date: Tue, 13 Mar 2018 11:28:16 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] cpufreq: tegra124-cpufreq: extend to support
 Tegra210
Message-ID: <20180313092816.GW6190@tbergstrom-lnx.Nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
 <b7a25613-44b4-5e63-e8c7-91ce2b7cb56e@nvidia.com>
 <20180309081438.GO6190@tbergstrom-lnx.Nvidia.com>
 <50b05dda-4577-0c86-a8e5-eb7095ee1f59@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <50b05dda-4577-0c86-a8e5-eb7095ee1f59@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:14:17AM +0000, Jon Hunter wrote:
> 
> On 09/03/18 08:14, Peter De Schrijver wrote:
> > On Thu, Mar 08, 2018 at 11:25:04PM +0000, Jon Hunter wrote:
> >>
> >> On 06/02/18 16:34, Peter De Schrijver wrote:
> >>> Tegra210 has a very similar CPU clocking scheme than Tegra124. So add
> >>> support in this driver. Also allow for the case where the CPU voltage is
> >>> controlled directly by the DFLL rather than by a separate regulator object.
> >>>
> >>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>> ---
> >>>  drivers/cpufreq/tegra124-cpufreq.c | 15 ++++++++-------
> >>>  1 file changed, 8 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> >>> index 4353025..f8e01a8 100644
> >>> --- a/drivers/cpufreq/tegra124-cpufreq.c
> >>> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> >>> @@ -64,7 +64,8 @@ static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
> >>>  {
> >>>  	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
> >>>  	clk_disable_unprepare(priv->dfll_clk);
> >>> -	regulator_sync_voltage(priv->vdd_cpu_reg);
> >>> +	if (priv->vdd_cpu_reg)
> >>> +		regulator_sync_voltage(priv->vdd_cpu_reg);
> >>>  	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
> >>>  }
> >>>  
> >>> @@ -89,10 +90,10 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
> >>>  		return -ENODEV;
> >>>  
> >>>  	priv->vdd_cpu_reg = regulator_get(cpu_dev, "vdd-cpu");
> >>> -	if (IS_ERR(priv->vdd_cpu_reg)) {
> >>> -		ret = PTR_ERR(priv->vdd_cpu_reg);
> >>> -		goto out_put_np;
> >>> -	}
> >>> +	if (IS_ERR(priv->vdd_cpu_reg) != -EPROBE_DEFER)
> >>> +		priv->vdd_cpu_reg = NULL;
> >>> +	else
> >>> +		return -EPROBE_DEFER;
> >>
> >> I am still not sure that we should rely on the fact that the regulator
> >> is not present in DT to imply that we do not need it. I think that we
> >> should be checking if we are using I2C mode here.
> >>
> > 
> > The cpufreq driver doesn't know this however. Also the current approach of
> > setting the same voltage when switching to pll_x is incorrect. The CVB
> > tables when using pll_x include more margin than when using the DFLL.
> 
> Ah yes I see now. However, we are going to need to update the DT doc,
> because 'vdd-cpu-supply' is listed as required.
> 

Ok.

Peter.
