Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68037C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC3A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfAUT4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:56:36 -0500
Received: from muru.com ([72.249.23.125]:34540 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbfAUT4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:56:36 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DEEDB80C0;
        Mon, 21 Jan 2019 19:56:41 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:56:31 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Tero Kristo <t-kristo@ti.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcousson@baylibre.com, paul@pwsan.com,
        letux-kernel@openphoenux.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Message-ID: <20190121195631.GG5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com>
 <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com>
 <20190118203832.3be7975e@aktux>
 <20190118194536.GY5544@atomide.com>
 <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
 <20190121170743.GB5544@atomide.com>
 <20190121185344.7cff9641@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121185344.7cff9641@aktux>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190121 17:54]:
> Hi,
> 
> On Mon, 21 Jan 2019 09:07:43 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Tero Kristo <t-kristo@ti.com> [190121 07:13]:
> > > On 18/01/2019 21:45, Tony Lindgren wrote:  
> > > > * Andreas Kemnade <andreas@kemnade.info> [190118 19:39]:  
> > > > > Hi,
> > > > > 
> > > > > On Fri, 18 Jan 2019 10:36:30 -0800
> > > > > Tony Lindgren <tony@atomide.com> wrote:
> > > > > 
> > > > > [...]  
> > > > > > til the next workaround.
> > > > > >   
> > > > > > > That flags also causes the iclk being enabled/disabled
> > > > > > > manually.  
> > > > > > 
> > > > > > Yes but SWSUP_IDLE for the interface clock to me currently
> > > > > > just means:
> > > > > > 
> > > > > > "manually enable and disable ocp interface clock"
> > > > > >   
> > > > > well, if we want to manually disable it and not automatically,
> > > > > we have to disable autoidle or it will be automatically disabled.
> > > > > 
> > > > > Disabling it manually when it is already auto-disabled (by autoidle) is
> > > > > just practically a no-op towards the clock.  
> > > > 
> > > > OK I buy that :) It should be probably added to the patch
> > > > description to make it clear what it changes.
> > > > 
> > > > Tero, any comments on this change?  
> > > 
> > > Well, seeing the flag is pretty much only used for a handful of hwmods
> > > nowadays, it should be fine. OMAP3 PM should be tested with this change
> > > though, as there are couple of hwmods impacted on that platform. I wonder
> > > what happens to cpuidle when display is active...  
> > 
> > OK so that's a good test case. AFAIK, we should have DSS idle
> > and have the SoC hit at least core retention with DSI command mode
> > displays. I don't know if this patch would block DSS autoidle then
> > or not.. I'm guessing 80% chance that we still need DSS hit runtime
> > suspend to enter SoC idle states meaning this patch would not
> > affect it :)
> > 
> So this is a call to Nokia N950 owners?

Well sort of.. But the LCD command mode patches are still pending.
I've added Aaro and Sebastian to Cc in case they have it testable.

> Unfortunately, I do not have one. I have seen on non-command-mode
> displays that dss goes to idle when display is blanked.

OK. And I did a brief test on droid4 with the pending DSI
command mode patches by sprinkling some OCPIF_SWSUP_IDLE
to DSS and DSI with the hack below (that is not needed for
normal use). Things idle just fine for me when LCD is on
and I can see the SoC hit core retention the same way as
without the test patch below.

So as far as I'm concerned, these patches are good to go
and I'll go ack the patches.

Thanks,

Tony

8< --------------------
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3424,6 +3424,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.slave		= &omap44xx_dss_hwmod,
 	.clk		= "l3_div_ck",
 	.user		= OCP_USER_SDMA,
+	.flags		= OCPIF_SWSUP_IDLE,
 };
 
 /* l4_per -> dss */
@@ -3472,6 +3473,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "l3_div_ck",
 	.user		= OCP_USER_SDMA,
+	.flags		= OCPIF_SWSUP_IDLE,
 };
 
 /* l4_per -> dss_dsi2 */
@@ -3480,6 +3482,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi2 = {
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "l4_div_ck",
 	.user		= OCP_USER_MPU,
+	.flags		= OCPIF_SWSUP_IDLE,
 };
 
 /* l3_main_2 -> dss_hdmi */
