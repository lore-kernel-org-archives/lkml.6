Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80357C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5975320879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfAURHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:07:48 -0500
Received: from muru.com ([72.249.23.125]:34414 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfAURHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:07:48 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5AAB180C0;
        Mon, 21 Jan 2019 17:07:54 +0000 (UTC)
Date:   Mon, 21 Jan 2019 09:07:43 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcousson@baylibre.com, paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Message-ID: <20190121170743.GB5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com>
 <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com>
 <20190118203832.3be7975e@aktux>
 <20190118194536.GY5544@atomide.com>
 <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0928fc-add1-1f37-c907-89bf5133fc00@ti.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [190121 07:13]:
> On 18/01/2019 21:45, Tony Lindgren wrote:
> > * Andreas Kemnade <andreas@kemnade.info> [190118 19:39]:
> > > Hi,
> > > 
> > > On Fri, 18 Jan 2019 10:36:30 -0800
> > > Tony Lindgren <tony@atomide.com> wrote:
> > > 
> > > [...]
> > > > til the next workaround.
> > > > 
> > > > > That flags also causes the iclk being enabled/disabled
> > > > > manually.
> > > > 
> > > > Yes but SWSUP_IDLE for the interface clock to me currently
> > > > just means:
> > > > 
> > > > "manually enable and disable ocp interface clock"
> > > > 
> > > well, if we want to manually disable it and not automatically,
> > > we have to disable autoidle or it will be automatically disabled.
> > > 
> > > Disabling it manually when it is already auto-disabled (by autoidle) is
> > > just practically a no-op towards the clock.
> > 
> > OK I buy that :) It should be probably added to the patch
> > description to make it clear what it changes.
> > 
> > Tero, any comments on this change?
> 
> Well, seeing the flag is pretty much only used for a handful of hwmods
> nowadays, it should be fine. OMAP3 PM should be tested with this change
> though, as there are couple of hwmods impacted on that platform. I wonder
> what happens to cpuidle when display is active...

OK so that's a good test case. AFAIK, we should have DSS idle
and have the SoC hit at least core retention with DSI command mode
displays. I don't know if this patch would block DSS autoidle then
or not.. I'm guessing 80% chance that we still need DSS hit runtime
suspend to enter SoC idle states meaning this patch would not
affect it :)

> > > > and with your changes it becomes:
> > > > 
> > > > "manually enable and disable ocp interface clock and block
> > > >   autoidle while in use".
> > > > 
> > > > So aren't we now changing the way things behave in general
> > > > for SWSUP_IDLE?
> > > > 
> > > Yes, we are, so proper testing is needed. But If I read those comments
> > > it was always intended this way but not fully implemented because it
> > > appeared to be more work like needing a usecounter (which my patchset
> > > also adds) for that autoidle flag.
> > 
> > OK yeah the use count seems necessary. I'll test here
> > with my PM use cases.

Regards,

Tony
