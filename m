Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A137E22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A137E22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeKMD2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:28:00 -0500
Received: from muru.com ([72.249.23.125]:53812 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeKMD2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:28:00 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1CD4D80C0;
        Mon, 12 Nov 2018 17:33:47 +0000 (UTC)
Date:   Mon, 12 Nov 2018 09:33:39 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Olof Johansson <olof@lixom.net>, guillaume.tucker@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] ARM: SoC fixes
Message-ID: <20181112173339.GA53235@atomide.com>
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
 <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
 <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
 <20181108154926.GI56134@atomide.com>
 <CAOesGMje+-R4Qbtgtj2AvNK+=Q3Rqbo=n8Q2DV4SG9wOv3Kj_w@mail.gmail.com>
 <20181112061324.GA28680@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112061324.GA28680@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Corentin Labbe <clabbe.montjoie@gmail.com> [181112 06:13]:
> On Sat, Nov 10, 2018 at 10:09:19AM -0800, Olof Johansson wrote:
> > On Thu, Nov 8, 2018 at 7:49 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Olof Johansson <olof@lixom.net> [181107 09:28]:
> > > > On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> > > > > >
> > > > > > ARM: SoC fixes
> > > > >
> > > > > Pulled.
> > > > >
> > > > > > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > > > > > and it ended up regressing at least BeagleBone XM boards.
> > > > >
> > > > > Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> > > > > preempt being off? Otherwise I don't see how/why preempt should fail
> > > > > in a board-specific manner..
> > > >
> > > > The board hangs early during boot and the usual way of collecting
> > > > early console doesn't seem to work when attempted (I haven't tried
> > > > personally).
> > > >
> > > > It's one of the major non-SMP platforms covered by tests. I'd be
> > > > surprised if it turns out to be truly _board_ specific (and rather
> > > > specific to OMAP3), but we don't have enough data yet. Chances are it
> > > > either shuffles some timing around or indeed hits a may_sleep() test
> > > > somewhere.
> > > >
> > > > (I just realized I might have missed to attribute Guillaume in the
> > > > revert patch. Sorry about that).
> > >
> > > Looks like we're missing the stdout-path for earlycon, maybe try
> > > with the following patch? I can't find my Beagleboard-xm right now,
> > > time to clean-up a bit I guess.
> > >
> > > At least omap3-evm, logicpd-torpedo and n900 all boot with PREEMPT.
> > 
> > To follow up on this, it turned out to be an issue where the kernel
> > outgrew the location it was loaded to, and overwrite the device tree
> > on decompression. So, not a code issue.
> > 
> > It's a known fragile aspect on some of the u-boot setups, and
> > something I've been hit by myself on my farm a few times.
> > 
> > Still, for now we'll keep PREEMPT off until next merge window.
> > 
> 
> Hello
> 
> Note that CONFIG_PREEMPT cause some errors also on sun8i-a83t-bananapi-m3
> Already reported https://lkml.org/lkml/2017/12/29/139

Also thread "[PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
is reverting commit 58b116bce136 ("drivercore: deferral race condition fix")
which has CONFIG_PREEMPT mentioned in the log. So more testing is
probably needed in Linux next before enabling CONFIG_PREEMPT again.

Regards,

Tony
