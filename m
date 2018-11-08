Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F2ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937DC20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937DC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeKIBZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:25:36 -0500
Received: from muru.com ([72.249.23.125]:53458 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeKIBZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:25:36 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DA38D8047;
        Thu,  8 Nov 2018 15:49:29 +0000 (UTC)
Date:   Thu, 8 Nov 2018 07:49:26 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        guillaume.tucker@collabora.com,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Subject: Re: [GIT PULL] ARM: SoC fixes
Message-ID: <20181108154926.GI56134@atomide.com>
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
 <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
 <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Olof Johansson <olof@lixom.net> [181107 09:28]:
> On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > ARM: SoC fixes
> >
> > Pulled.
> >
> > > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > > and it ended up regressing at least BeagleBone XM boards.
> >
> > Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> > preempt being off? Otherwise I don't see how/why preempt should fail
> > in a board-specific manner..
> 
> The board hangs early during boot and the usual way of collecting
> early console doesn't seem to work when attempted (I haven't tried
> personally).
> 
> It's one of the major non-SMP platforms covered by tests. I'd be
> surprised if it turns out to be truly _board_ specific (and rather
> specific to OMAP3), but we don't have enough data yet. Chances are it
> either shuffles some timing around or indeed hits a may_sleep() test
> somewhere.
> 
> (I just realized I might have missed to attribute Guillaume in the
> revert patch. Sorry about that).

Looks like we're missing the stdout-path for earlycon, maybe try
with the following patch? I can't find my Beagleboard-xm right now,
time to clean-up a bit I guess.

At least omap3-evm, logicpd-torpedo and n900 all boot with PREEMPT.

Regards,

Tony

8< ----------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 8 Nov 2018 07:43:28 -0800
Subject: [PATCH] ARM: dts: Add missing earlycon UART for Beagleboard

We can get early boot messages if CONFIG_SERIAL_EARLYCON=y is set, and
kernel commandline has debug earlycon. But we're missing the related dts
entry for Beagleboard.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Note: Untested, I can't find my Beagleboard-XM right now..

---
 arch/arm/boot/dts/omap3-beagle.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -24,6 +24,10 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	aliases {
 		display0 = &dvi0;
 		display1 = &tv0;
-- 
2.19.1
