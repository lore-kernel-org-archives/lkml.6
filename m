Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934561AbeEIJCa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:02:30 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37792 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934007AbeEIJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:02:27 -0400
Date: Wed, 9 May 2018 10:02:13 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
Message-ID: <20180509090213.GQ16141@n2100.armlinux.org.uk>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-3-o.rempel@pengutronix.de>
 <20180508124033.GL16141@n2100.armlinux.org.uk>
 <20180509050628.csbusplowpvmmiwa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509050628.csbusplowpvmmiwa@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 07:06:28AM +0200, Oleksij Rempel wrote:
> On Tue, May 08, 2018 at 01:40:33PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Mar 05, 2018 at 11:25:19AM +0100, Oleksij Rempel wrote:
> > > One of the Freescale recommended sequences for power off with external
> > > PMIC is the following:
> > > ...
> > > 3.  SoC is programming PMIC for power off when standby is asserted.
> > > 4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> > > 
> > > See:
> > > http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> > > page 5083
> > > 
> > > This patch implements step 4. of this sequence.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> > > index ecdf071653d4..24689260a2a5 100644
> > > --- a/arch/arm/mach-imx/pm-imx6.c
> > > +++ b/arch/arm/mach-imx/pm-imx6.c
> > > @@ -604,6 +604,28 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
> > >  				   IMX6Q_GPR1_GINT);
> > >  }
> > >  
> > > +static void imx6_pm_stby_poweroff(void)
> > > +{
> > > +	imx6_set_lpm(STOP_POWER_OFF);
> > > +	cpu_suspend(0, imx6q_suspend_finish);
> > 
> > Do you actually need to save the processor state etc here - the request
> > is after all to power down the system and not to suspend.  Would calling
> > imx6q_suspend_finish() directly work (and hence simplify the code) ?
> 
> yes you right. This will work as well.
> I'll send changed version after Rafaels feedback for kernel/reboot.c
> part.
> Russell, can I expect your Signed-off-by for changed patch?

No, please read Documentation/process/submitting-patches.rst section 12.
s-o-b does not apply in this case.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
