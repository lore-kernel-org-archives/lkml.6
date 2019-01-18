Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449DC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5291B21473
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfARSgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:36:35 -0500
Received: from muru.com ([72.249.23.125]:34240 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfARSge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:36:34 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8E7A98047;
        Fri, 18 Jan 2019 18:36:40 +0000 (UTC)
Date:   Fri, 18 Jan 2019 10:36:30 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Message-ID: <20190118183630.GX5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com>
 <20190118181827.7163bee4@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118181827.7163bee4@aktux>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190118 17:18]:
> On Fri, 18 Jan 2019 07:48:07 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190116 22:04]:
> > > Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> > > that makes hwmods working properly which cannot handle
> > > autoidle properly in lower power states.  
> > 
> > Sorry if I'm still missing something :)
> > 
> > But doesn't this now block autoidle for all modules
> > with OCPIF_SWSUP_IDLE even if they work just fine with
> > autoidle?
> 
> According to the code comments, it was just meant for that.
>              if (os->flags & OCPIF_SWSUP_IDLE) {
> -                       /* XXX omap_iclk_deny_idle(c); */
> +                       /*

Hmm..

> I guess there are workarounds for the other modules in place,
> or critical situations were not found yet. 
> The other affected module is e.g. DSS. And we had some trouble
> in initialisation order for omap3 in the past and did some
> quirks. Probably we also fixed issues in reality caused by
> having the autoidle bit set.

Yes this is rather confusing plus we can't do anything
from the interconnect or reset device drivers to block
autoidle for a clock currently.

So I'd like to have a generic interfaces for clk_deny_idle()
and clk_allow_idle() in place for a proper hardware based
solution instead of the hackish PM QoS DMA latency tinkering
and other workarounds. Anything else feels just like kicking
the can until the next workaround.

> That flags also causes the iclk being enabled/disabled
> manually.

Yes but SWSUP_IDLE for the interface clock to me currently
just means:

"manually enable and disable ocp interface clock"

and with your changes it becomes:

"manually enable and disable ocp interface clock and block
 autoidle while in use".

So aren't we now changing the way things behave in general
for SWSUP_IDLE?

> Did you see any regressions? The patch is now 3 month old
> and nobody complained. I checked module idlest bits and did
> not see any changes.

Sorry for all the delays. But I also need to consider how
this is going to make things easier for moving to use
drivers/reset for example. And it seems we're just now
piling up more dependencies and don't have a generic
interface that keeps preventing doing proper device
drivers. I don't see issue with your patches except for
the few open questions in this email.

> > I think what you want to do is keep clocks enabled
> > while in use?
> > 
> > If so, how about using HWMOD_CLKDM_NOAUTO:
> > 
> > "HWMOD_CLKDM_NOAUTO: Allows the hwmod's clockdomain to
> >  be prevented from entering HW_AUTO while hwmod is
> >  active."
> 
> That is about iclk. I think we should have clear wording here
> between all the idle things.

Do you mean HWMOD_CLKDM_NOAUTO is about the module clock
while your patches are about the ocp interface clock?
Yup that's confusing between ocp interface clock and the
module clock..

Then we also have SWSUP_IDLE vs SWSUP_SIDLE that can get
confused :)

BTW, is the ocp module interface clock also the module
clock in your case?

> > > Affected is e. g. the omap_hdq.  
> > 
> > Have you already tried what happens if you just tag
> > omap_hdq with HWMOD_CLKDM_NOAUTO?
> > 
> Well, I am just happy with having that single bit cleared.
> But having two flags for the same things makes no sense to me.

To me it seems there are at least the following case where we
need to block autoidle for clocks:

1. Modules that need to stay active and don't automatically
   block SoC idle states (mcbsp, hdq) where this should
   happen automatically when pm_runtime_get() is done.

2. Any drivers/reset driver while doing a reset

Regards,

Tony


