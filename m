Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B212A2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B212A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKBCpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:45:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57860 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKBCpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:45:18 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIGxp-0007mV-He; Thu, 01 Nov 2018 18:41:01 +0100
Date:   Thu, 1 Nov 2018 18:41:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     John Stultz <john.stultz@linaro.org>,
        Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC to Mono-raw Drift
In-Reply-To: <20181024145113.GF12019@localhost>
Message-ID: <alpine.DEB.2.21.1811011813470.1642@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com> <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de> <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com> <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de> <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com> <20181024145113.GF12019@localhost>
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

Miroslav,

On Wed, 24 Oct 2018, Miroslav Lichvar wrote:
> On Tue, Oct 23, 2018 at 11:31:00AM -0700, John Stultz wrote:
> > On Fri, Oct 19, 2018 at 3:36 PM, John Stultz <john.stultz@linaro.org> wrote:
> > > On Fri, Oct 19, 2018 at 1:50 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> On Fri, 19 Oct 2018, John Stultz wrote:
> > >>> We might be able to reduce the degree in this case, but I worry the
> > >>> extra complexity may only cause problems for others.
> > >>
> > >> Is it really that complex to add a fixed correction value periodically?
> 
> The error is too large to be corrected by stepping on clock updates.
> For a typical TSC frequency we have multiplier in the range of few
> millions, so that's a frequency error of up to few hundred ppb. In the
> old days when the clock was updated 1000 times per second that would
> be hidden in the resolution of the clock, but now with tickless
> kernels those steps would be very noticeable.
> 
> If the multiplier was adjusted in the same way as the non-raw clock,
> there wouldn't be any steps in time, but there would be steps in
> frequency and the time error would be proportional to the update
> interval. For a clock updated once per second that's an error of up to
> a few hundreds of nanoseconds.

That only happens when the system was completely idle for a second and in
that case it's a non issue because the clock is updated before it's
used. So nothing will be able to observe the time jumping forward by a few
or even a few hundreds of nanoseconds. For the regular case, where CPUs are
busy and the update happens 100/250/1000 times per second the jump forward
will not be noticable at all.

> I agree with John. I think the raw monotonic clock should be stable.

It is stable. It's still monotonically increasing.

> It would help if we better understood the use case. If I needed a
> clock that ticks in an exact proportion to the tsc, why wouldn't I use
> the tsc directly? Is this about having a fall back in case the tsc
> cannot be used (e.g. due to unsynchronized CPUs)?
> 
> If the frequency error was exported, it could be compensated where
> necessary. Maybe that would work for the original poster?

I'd rather not go there and have yet another magic knob to deal with and we
need to have the same thing in the kernel as well.

> A better fix might be to modify the calculation of time to use a
> second multiplier, effectively increasing its resolution. However,
> that would slow down all users of the clock.

Right, and we carefully try to avoid that.

I really would like to give the adjustment a try. It should solve the
problem Christopher cares about and not have any side effects on other
users of monotonic raw including NTP/PTP etc. Famous last words ....

Thanks,

	tglx
