Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6792054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfAQJsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:48:06 -0500
Received: from shell.v3.sk ([90.176.6.54]:60842 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfAQJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:48:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 21B205AB44;
        Thu, 17 Jan 2019 10:48:01 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PUQX9U1ttL0m; Thu, 17 Jan 2019 10:47:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C77265AB57;
        Thu, 17 Jan 2019 10:47:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rUZfttvU1wnp; Thu, 17 Jan 2019 10:47:57 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0D7F75AB44;
        Thu, 17 Jan 2019 10:47:56 +0100 (CET)
Message-ID: <bec06415e980f18d5d3407d498cad372dc3abd1b.camel@v3.sk>
Subject: Re: [PATCH] clk: mmp2: avoid disabling the SP clock when unused
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 17 Jan 2019 10:47:55 +0100
In-Reply-To: <154768138798.169631.18317264971847478148@swboyd.mtv.corp.google.com>
References: <20190116093505.1920945-1-lkundrak@v3.sk>
         <154765664632.169631.9344557684702266461@swboyd.mtv.corp.google.com>
         <73b20a5caef100d5768679cc395168976e86ed04.camel@v3.sk>
         <154768138798.169631.18317264971847478148@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 15:29 -0800, Stephen Boyd wrote:
> Quoting Lubomir Rintel (2019-01-16 09:26:31)
> > On Wed, 2019-01-16 at 08:37 -0800, Stephen Boyd wrote:
> > > Quoting Lubomir Rintel (2019-01-16 01:35:05)
> > > > There could be vital functionality running on the SP PJ1 core it can not be
> > > > restarted just by turning the clock back on.
> > > > 
> > > > On the OLPC laptop, the keyboard controller code runs there. It
> > > > wouldn't be possible to load the driver for it as a module if the clock
> > > > is disabled on boot.
> > > > 
> > > > Cc: stable@vger.kernel.org # v4.18+
> > > > Fixes: commit fc27c2394d96 ("clk: mmp2: add SP clock")
> > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > ---
> > > >  drivers/clk/mmp/clk-of-mmp2.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
> > > > index f2a1c9bbaa63..3e33f1295f59 100644
> > > > --- a/drivers/clk/mmp/clk-of-mmp2.c
> > > > +++ b/drivers/clk/mmp/clk-of-mmp2.c
> > > > @@ -246,7 +246,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[] = {
> > > >         {MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
> > > >         {MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
> > > >         {MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
> > > > -       {MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0x1b, 0x1b, 0x0, 0, &sp_lock},
> > > > +       {MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, APMU_SP, 0x1b, 0x1b, 0x0, 0, &sp_lock},
> > > 
> > > Is it a critical clk that should never be turned off?
> > 
> > I don't think it is. It is entirely plausible to have no use for the
> > "security processor", and in that case it's just okay to keep the clock
> > disabled.
> 
> So does the firmware/bootloader leave the clk enabled out of boot and we
> shouldn't really touch the on/off bits of the clk hardware from the
> kernel?

I think so.

> Or do we want to actively manage this clk from a driver
> somewhere in the kernel?

The olpc_apsp driver actually manages this clock, but that might turn
out to be the wrong thing to do. It currently only works if the driver
is built-in and thus the clock is always kept enabled.

I'm now somewhat more confused that I believed myself to be when
sending the patch. Perhaps you could help me understand things a bit
more:

1.) What's the principal difference between CLK_IGNORE_UNUSED and
CLK_IS_CRITICAL? Is it that the CLK_IGNORE_UNUSED clocks are permitted 
to be disabled by a driver, but an attempt to disable CLK_IS_CRITICAL
is a bug?

2.) Perhaps it makes sense to disable the SP on the machines that don't
utilize it even if firmware keeps it enabled? Would it make sense to
make the clk driver use the  "protected-clocks" DT property for this?

----8<----

Here's some more context for the SP on the MMP2:

The SP is a small PJ1 core. It starts when the platform is powered on
and eventually brings up the large PJ4 core.

On the OLPC machine, the first stage firmware (cforth) starts running
on the SP, configures the DRAM, starts the boot firmware (openfirmware)
on the main PJ4 core and then enters a loop that bit-bangs the PS/2
protocol on the attached keyboard/touchpad.

It is entirely possible that on some boards the SP is not used for
anything but the bringup of the bootloader on the main core.

SP is sometimes referred to as WTM, "wireless trusted module", but it's
not clear to me why is it the case. There's no documentation.

Lubo

