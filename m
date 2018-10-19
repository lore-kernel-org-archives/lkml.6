Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3764ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972022083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972022083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeJTE6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:58:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJTE6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:58:04 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gDbic-00065n-4e; Fri, 19 Oct 2018 22:50:02 +0200
Date:   Fri, 19 Oct 2018 22:50:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com, gavin.hindman@intel.com,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC to Mono-raw Drift
In-Reply-To: <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de> <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

On Fri, 19 Oct 2018, John Stultz wrote:
> On Fri, Oct 19, 2018 at 11:57 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > I don't think you need complex oscillation for that. The error is constant
> > and small enough that it is a fractional nanoseconds thing with an interval
> > <= 1s. So you can just add that in a regular interval. Due to it being
> > small you can't observe time jumping I think.
> 
> Well, from the examples the trouble is we seem to be a bit fast,
> rather then slow.
> So we'll have to reduce mult by one, and rework the calculations, but
> maybe something like this (correcting the raw_interval value) would
> work.

Shouldn't be rocket science. It's a one off calculation of adjustment value
and maybe the period at which the correction happens.

> But this also sort of breaks, fundamental argument that the raw clock
> is a simple mult/shift transformation of the underlying clocksource
> counter. Its not the accuracy of the clock but the consistency that
> was key.
> 
> The counter argument is that the raw clock is abstracting the
> underlying hardware so folks who would have used the TSC directly can
> now use the raw clock and have a generic abstracted hardware-counter
> interface. So userland shouldn't really be worried about the
> occasional injections made since they shouldn't be trying to
> re-generate the abstraction from the hardware themselves.  <--
> Remember this point as we move to the next comment:)
> 
> > The end-result is 'correct' as much correct it is in relation to real
> > nanoseconds. :)
> >
> >> I guess I'd want to understand more of the use here and the need to
> >> tie the raw clock back to the hardware counter it abstracts.
> >
> > The problem there is ART which is distributed to PCIe devices and ART time
> > stamps are exposed in various ways. ART has a fixed ratio vs. TSC so there
> > is a reasonable expectation that MONOTONIC_RAW is accurate.
> 
> Which is maybe sort of my issue here. The raw clock provided a
> abstraction away from the hardware for generic usage, but then its
> being re-used with other un-abstracted hardware references. So unless
> they use the same method of transformation, there will be problems (of
> varying degree).

OTOH. If people use the CPUID provided frequency information and the TSC
from userspace then they get different results which is contrary to the
goal of providing them an abstracted way of doing it.

> We might be able to reduce the degree in this case, but I worry the
> extra complexity may only cause problems for others.

Is it really that complex to add a fixed correction value periodically?

I don't think so and it should just work for any clocksource which is
exposed this way. Famous last words .....

Thanks,

	tglx
