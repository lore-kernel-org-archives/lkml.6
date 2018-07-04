Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663B5215F0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663B5215F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeGDTtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:49:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeGDTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:49:15 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fanm0-0005ED-6b; Wed, 04 Jul 2018 21:49:08 +0200
Date:   Wed, 4 Jul 2018 21:49:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <d87ce7ad-4f85-d7c1-11d1-fa6fb6c3481b@arm.com>
Message-ID: <alpine.DEB.2.21.1807042141440.28271@nanos.tec.linutronix.de>
References: <20180511022751.9096-1-samuel@sholland.org> <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com> <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org> <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com> <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com> <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de> <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com> <alpine.DEB.2.21.1807041628440.1752@nanos.tec.linutronix.de> <55fc9e48-6329-df75-3a12-60cc42d91a31@arm.com>
 <alpine.DEB.2.21.1807041704570.1752@nanos.tec.linutronix.de> <d87ce7ad-4f85-d7c1-11d1-fa6fb6c3481b@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andre Przywara wrote:
> On 04/07/18 16:14, Thomas Gleixner wrote:
> > On Wed, 4 Jul 2018, Andre Przywara wrote:
> >> On 04/07/18 15:31, Thomas Gleixner wrote:
> >>> If that's the case then you need to find a different functional timer for
> >>> time keeping. Having an erratic behaving timer for time keeping is not an
> >>> option at all.
> >>
> >> That's not an option on arm64. There are other usable time sources in
> >> the SoC, but the arch timer is somewhat mandatory for all practical
> >> purposes on arm64. We rely on it in some many places that it's not
> >> feasible to run without it. That's why we call it "architected" timer
> >> after all ;-)
> > 
> > The argument that it has to be used just because someone defined it as
> > 'architected' is bullshit and doesn't change the fact that it's broken and
> > not usable for timekeeping. There is no wiggle room. Either it works or
> > not, but works mostly is not an option.
> 
> The "architected" part of the arch timer is fine, it's just that
> eventually someone has to implement that at some point. And as you
> mention below, this is where Murphy's law is kicking in ;-) Especially
> for such seemingly simple tasks as connecting a counter in the "uncore"
> part of the chip (Allwinner SoC) to the counter register interface in
> the core (ARM Cortex-A53) [1]. Apparently the propagation is not really
> atomic for all bits here ...

I've immediately spotted the fail in that document:

  The Cortex-A53 processor does not include the system counter. This
  resides in the SoC.

> >> But I am quite confident that we can find a correct workaround. Maybe
> >> it's really the TVAL (the downcounter) write which is the culprit here,
> >> since the hardware actually writes "now() + TVAL" into the CVAL
> >> (upcounter) register. This internal counter access may be flawed as well.
> > 
> > If the write to the event device is wreckaging the counter which provides
> > time, then there is something seriously wrong either in the design or in
> > that particular piece of silicon.
> 
> Apologies, that was my lousy wording: There is one 64-bit comparison
> register (CVAL), which signals when the counter (an independent
> register) is greater or equal. TVAL is just a different *view* of that
> same relation. So this part is fine, it's really that the "strictly
> monotonic counter" nature of CNTPCT is not really observed by the chip.
> 
> > Yet another proof for the theory that timers are implemented by janitors
> > and that silicon/IP vendors have a competition running who can create the
> > most subtly broken timers. Intel surely had a head start with that, but ARM
> > is definitely catching up.
> 
> ARM is trying really hard to be actually better ;-)

Better in terms of subtle brokenness? I surely can do consulting for
that. I've seen most of it in all colours, but I surely can come up with
new even subtler ways to wreckage them. You know how to reach me.

Thanks,

	tglx
