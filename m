Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15564C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801CD2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801CD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeKTWGy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:06:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbeKTWGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:06:54 -0500
Received: from beast.luon.net (unknown [IPv6:2001:470:78b1:0:40e2:7ff:fef4:3122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 00A56263AA7;
        Tue, 20 Nov 2018 11:38:08 +0000 (GMT)
Received: by beast.luon.net (Postfix, from userid 1000)
        id 4EDC63E238F; Tue, 20 Nov 2018 12:38:05 +0100 (CET)
Message-ID: <aa26f5dc9e595feb3772495a6d0542c007948f48.camel@collabora.co.uk>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
From:   Sjoerd Simons <sjoerd.simons@collabora.co.uk>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Faiz Abbas <faiz_abbas@ti.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Bastian Stender <bst@pengutronix.de>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>
Date:   Tue, 20 Nov 2018 12:38:05 +0100
In-Reply-To: <20181120102300.GA1056@kunai>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
         <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
         <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
         <20181107084741.GA31092@kunai>
         <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
         <20181120102300.GA1056@kunai>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-20 at 11:23 +0100, Wolfram Sang wrote:
> > > > That also happens to be one of the cards we deploy; However i
> > > > did
> > > > wonder about adding a quirk but decided against it as it was
> > > > not clear
> > > > to me from the specification that CACHE ON really is meant to
> > > > complete
> > > > within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in
> > > > hit-a-
> > > > mole games as the failure is really quite tedious (boot
> > > > failure).
> > > 
> > > I agree that we should use the more defensive variant as a
> > > default. I
> > > mean there should be no performance regression since most cards
> > > will
> > > respond just faster, or? The only downside I could see is that we
> > > might
> > > miss a real timeout with no bounds set and might get stuck?
> > 
> > Well, you have a point, but still it's kind of nice to know which
> > cards are behaving well and which ones that doesn't. Hence I think
> > I
> > prefer to stick using a quirk, unless you have a strong opinion.

Not an incredibly strong opinion either; I just wonder if it's the
right trade-off. 

If the quirk/work-around is not there while it should be, the impact is
that you get an unusable card (which for eMMC is likely to mean a
failure to boot the system). Which is somewhat unfortunate.

If the work-around is there while it's not needed then there doesn't
seem to be much of an impact at all; Apart from it not being reported
to the user/developer/kernel community? 

In which case it might make more to put in a warning iff the card takes
too long with a list of cards for which this is known?

> No strong opinion. Especially not if you say it is in the spec
> (although
> "must be sufficient" would be better than "should be" ;)). Also, I
> assume this failure is reproducible and should turn up during
> development? Compared to "happens once in a while randomly"?

For the card in question it happens only on hard power off; The time it
takes seems correlated to the state of the cache at hard power off (It
takes substantially longer if there was a lot of I/O activity at 
 the time of hard power off). With light I/O activity the current
timeout is sometimes enough.

So if you know the pattern, or just happen to hit it often in e.g.
automated testing, it does show up during development. Otherwise it can
appear to "happen once in a while randomly".

Unfortunately for me, it was really a case of getting reports of some
boards started failing at some point which took a while to track back.
Especially since it's a battery powered device (thus hard poweroffs are
rather rare) and we allow the board manufactorer to select from various
different eMMCs depending on price/available at build time...

> Yet, if we add a quirk for that, then we should probably mention it
> in
> an error message when we hit -ETIMEDOUT for cache on ("does your card
> need this quirk?")? It can be pretty time consuming to track this
> down
> otherwise, I'd think.

Yes please. It would be nice if someone happens to have the right
contacts with Micron to see if it's a known issue for their cards in
general or just this one.

Also would be good to have a timeout higher then 1 seconds (or for
these cards not have one?); On our testing thusfar we've seen timeouts
up to 850ms, but it's impossible to ensure that that's the true upper
bound.

-- 
Sjoerd Simons
Collabora Ltd.
