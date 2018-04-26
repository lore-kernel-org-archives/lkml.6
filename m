Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755477AbeDZLjk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:39:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12122 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754149AbeDZLjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:39:35 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Apr 2018 04:39:35 -0700
Date: Thu, 26 Apr 2018 14:39:29 +0300
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Dmitry Osipenko <digetx@gmail.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "marvin24@gmx.de" <marvin24@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Message-ID: <20180426113929.GH6835@tbergstrom-lnx.Nvidia.com>
References: <20180219151252.29289-1-marcel@ziswiler.com>
 <6600596.BijQW1iq1K@ax5200p>
 <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
 <1524521136.4493.70.camel@toradex.com>
 <c0cb2620-91b5-8043-bb74-306dca0331eb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0cb2620-91b5-8043-bb74-306dca0331eb@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 05:38:41PM +0300, Dmitry Osipenko wrote:
> Hi Marcel,
> 
> On 24.04.2018 01:05, Marcel Ziswiler wrote:
> > Hi Dmitry
> > 
> > On Fri, 2018-04-20 at 13:50 +0300, Dmitry Osipenko wrote:
> >> ...
> >> I managed to find CDEV clocks in TRM this time.
> > 
> > And where exactly in which TRM? In all my attempts at finding anything
> > CDEV2 is just a pad group which includes the DAP_MCLK2 pad in question. 
> 
> That's the DEV2 clock you're talking about below.
> 
> >> Seems assigning CDEV2 clock to
> >> "ulpi-link" was correct
> > 
> > Sorry, but I do really not see how you can get to any such conclusion.
> > 
> > Whatever that CDEV2 clock exactly is. Its offset 93 points towards the
> > CLK_RST_CONTROLLER_CLK_OUT_ENB_U_0 register which has CLK_ENB_DEV2_OUT
> > at bit position 29 reading "Enable clock to DEV2 pad". While the TRM
> > misses further documenting what exactly that DEV2 pad should be I guess
> > it may point towards our suspected DAP_MCLK2. So for some reason
> > besides PLL_P_OUT4 which is what that pad is actually muxed to also
> > some additional DEV2 pad clock needs enabling. In addition there would
> > be a CLK_RST_CONTROLLER_MISC_CLK_ENB_0 register where one could also
> > specify a DEV2_OSC_DIV_SEL but I would assume that one only applies if
> > the pad in question being muxed to OSC which is not the case at least
> > in all device trees I have looked at.
> > 
> >> and both CDEV2 and PLL_P_OUT4 should be enabled,
> > 
> > Agreed, basically the DAP_MCLK2 pad seems gated by an additional enable
> > called CLK_ENB_DEV2_OUT.
> > 
> >> CDEV2
> >> should gate the PLL_P_OUT4 that feeds USB HW and PLL_P_OUT4 should be
> >> always-enabled because it is enabled by init_table, but apparently it
> >> is getting
> >> disabled erroneously.
> > 
> > At least that was the case back when I had trouble getting ULPI to work
> > on T20. Strangely latest -next right now does no longer seem to suffer
> > from that same issue even if my patch is reverted but as mentioned
> > before nobody stops the required PLL_P_OUT4 which is what is actually
> > driving DAP_MCLK2 to not be changed behind the scenes breaking the
> > whole thing again.
> > 
> >> Marcel, could you please revert your patch, add
> >> "trace_event=clk_enable,clk_disable,clk_set_parent tp_printk" to
> >> kernels cmdline
> >> and post the log?
> > 
> > Yes, the only difference in those traces is whether or not that non-
> > existent CDEV2 clock is enabled or not:
> > 
> > [    1.897521] clk_enable: cdev2_fixed
> > [    1.901008] clk_enable: cdev2
> > 
> > I also do have an explanation why it kept working in my case. Probably
> > the boot ROM or U-Boot is already setting that bit.
> > 
> >> It looks like there is some clk framework bug,
> > 
> > My conclusion is that there should be a DAP_MCLK2 clock which is gated
> > by that CLK_ENB_DEV2_OUT but really outputs a T20 internal clock
> > according to its pin muxing which if set to OSC may be further divided
> > down by DEV2_OSC_DIV_SEL.
> 
> Could be that DEV2_OSC_DIV_SEL is only relevant when DAP_MCLK2 is mux'ed to OSC.
> Maybe Peter could clarify everything.
> 

Yes. This looks likely. Problem here is that the source selection for cdev1
and cdev2 is done via pinmuxing rather than via a regular mux control in CAR.
So probably the "OSC" input is not really OSC but the output of the divider
configured in CLK_RST_CONTROLLER_MISC_CLK_ENB_0.

Possible solutions I see are:

1) make the tegra20 pinctrl driver a clock provider for the cdev1 and cdev2
   clocks. We would then need to introduce 2 new clocks cdev1_mux and
   cdev2_mux which represent pinmuxes. cdev1 and cdev2 would use those as
   a parent. cdev1_fixed and cdev2_fixed would need to be renamed to refelect
   the settings in CLK_RST_CONTROLLER_MISC_CLK_ENB_0 and can be inputs for
   cdev1_mux and cdev2_mux

2) read the pinmux configuration for cdev1 and cdev2 at boot. this would
   require mapping the apbmisc aperture in the clock driver, but we already
   map the PMC aperture, so there's a precedent for mappings outside CAR.
   Then define the cdev1 and cdev2 parent accordingly. Also cdev1_fixed and
   cdev2_fixed could be defined as the divided version of OSC according to
   the settings in CLK_RST_CONTROLLER_MISC_CLK_ENB_0. Limitation of this
   approach is that we assume these settings are never changed at runtime.
   This seems acceptable to me though. Or do we know of a use case where the
   setting is changed at runtime?

Solution 1 is nicer, but would require backwards-incompatible changes to the
DT bindings.

Peter.
