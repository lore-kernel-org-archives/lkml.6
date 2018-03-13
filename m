Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCMJvZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:51:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5513 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932292AbeCMJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:51:23 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 13 Mar 2018 02:51:22 -0700
Date: Tue, 13 Mar 2018 11:51:17 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] cpufreq: tegra124-cpufreq: extend to support
 Tegra210
Message-ID: <20180313095117.GX6190@tbergstrom-lnx.Nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-10-git-send-email-pdeschrijver@nvidia.com>
 <85edea04-6aaf-3609-1da9-0d542ac98e7d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85edea04-6aaf-3609-1da9-0d542ac98e7d@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:15:22PM +0000, Jon Hunter wrote:
> 
> On 06/02/18 16:34, Peter De Schrijver wrote:
> > Tegra210 has a very similar CPU clocking scheme than Tegra124. So add
> > support in this driver. Also allow for the case where the CPU voltage is
> > controlled directly by the DFLL rather than by a separate regulator object.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/cpufreq/tegra124-cpufreq.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> > index 4353025..f8e01a8 100644
> > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > @@ -64,7 +64,8 @@ static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
> >  {
> >  	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
> >  	clk_disable_unprepare(priv->dfll_clk);
> > -	regulator_sync_voltage(priv->vdd_cpu_reg);
> > +	if (priv->vdd_cpu_reg)
> > +		regulator_sync_voltage(priv->vdd_cpu_reg);
> >  	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
> >  }
> 
> OK, so this bit does not make sense to me. In the above we are switching
> from the DFLL to the PLL (ie. disabling the DFLL) and so to ensure we
> are operating at the correct voltage after disabling the DFLL we need to
> sync the voltage. Seems we would need to do this for all devices, no?
> How is the different between Tegra124 and Tegra210?

Yes. So in case of i2c the regulator framework will reapply the voltage it
knows which in our case is the boot voltage for VDD_CPU because noone else
from a regulator framework pov has ever changed the voltage. In case of PWM
putting the PWM output pad in tri state will cause the OVR regulator to output
a hardware defined voltage. This is done as part of the dfll_clk_disable()
function. To summarize:

switch from pll_x to DFLL for i2c regulator:

entry: voltage is boot voltage set bootloader
1) set dfll rate to pll_x rate
2) set parent to pll_p so we run at 408MHz which is below Fmax@Vmin when
   running from PLL
3) enable DFLL this will switch to closed loop mode and start controlling
   the voltage via i2c, however because we are below Fmax@Vmin there's no
   V/f curve violation.
4) change parent from pll_x to DFLL

switch from DFLL to pll_x for i2c regulator:

entry: voltage is whatever the DFLL has programmed but not lower than Vmin
1) set parent to pll_p so we run at 408MHz (below Fmax@Vmin)
2) disable DFLL, this will cause the voltage to be the last value programmed
   by the DFLL.
3) go back to the voltage as programmed by the boot loader using
   regulator_sync_voltage().
4) change parent from DFLL to pll_x. Because pll_x is still programmed at
   the bootloader frequency, we're within the V/f curve.

switch from pll_x to DFLL for PWM regulator:

entry: voltage is boot voltage set by hardware because PWM pin is in tristate
1) set dfll rate to pll_x rate
2) set parent to pll_p so we run at 408MHz which is below Fmax@Vmin when
   running from PLL
3) enable DFLL this will set the PWM pad to output, switch to closed loop mode
   and start controlling the voltage via PWM, however because we are below
   Fmax@Vmin there's no V/f curve violation.
4) change parent from pll_x to DFLL

switch from DFLL to pll_x for PWM regulator:

entry: voltage is whatever the DFLL has programmed but not lower than Vmin
1) set parent to pll_p so we run at 408MHz (below Fmax@Vmin)
2) disable DFLL, this will cause the PWM pad to be programmed to tristate
   and the voltage to change back to the hardware defined voltage.
3) change parent from DFLL to pll_x. Because pll_x is still programmed at
   the bootloader frequency, we're within the V/f curve.

Peter.
