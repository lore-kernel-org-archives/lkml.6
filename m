Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98201C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4D8204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4D8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeKBUeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:34:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKBUeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:34:23 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIXbh-000456-3Q; Fri, 02 Nov 2018 12:27:17 +0100
Date:   Fri, 2 Nov 2018 12:27:16 +0100 (CET)
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
In-Reply-To: <20181102102613.GL19434@localhost>
Message-ID: <alpine.DEB.2.21.1811021226000.1895@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de> <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de> <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com> <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com> <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de> <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com> <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
 <20181024145113.GF12019@localhost> <alpine.DEB.2.21.1811011813470.1642@nanos.tec.linutronix.de> <20181102102613.GL19434@localhost>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miroslav,

On Fri, 2 Nov 2018, Miroslav Lichvar wrote:
> On Thu, Nov 01, 2018 at 06:41:00PM +0100, Thomas Gleixner wrote:
> > On Wed, 24 Oct 2018, Miroslav Lichvar wrote:
> > > The error is too large to be corrected by stepping on clock updates.
> > > For a typical TSC frequency we have multiplier in the range of few
> > > millions, so that's a frequency error of up to few hundred ppb. In the
> > > old days when the clock was updated 1000 times per second that would
> > > be hidden in the resolution of the clock, but now with tickless
> > > kernels those steps would be very noticeable.
> 
> > That only happens when the system was completely idle for a second and in
> > that case it's a non issue because the clock is updated before it's
> > used. So nothing will be able to observe the time jumping forward by a few
> > or even a few hundreds of nanoseconds.
> 
> That's great news (to me). I think we should do the same with the
> mono/real clock. A periodic 4ns step would be better than a slew
> correcting tens or hundreds of nanoseconds. This would be a
> significant improvement in accuracy on idle systems, in theory
> identical to running with nohz=off.
> 
> Maybe I am missing some important detail, but I think we can just drop
> the +1 mult adjustment and step on each update by the (truncated)
> amount that has accumulated in the NTP error register. With the
> changes that have been made earlier this year the clock should never
> be ahead, so the step would always be forward.

That sounds reasonable.

> > For the regular case, where CPUs are
> > busy and the update happens 100/250/1000 times per second the jump forward
> > will not be noticable at all.
> 
> I think a 4ns jump at 100 Hz might be noticeable with a good reference
> clock and large number of measurements, but so would be the current +1
> mult adjustment.

Indeed.

Thanks,

	tglx
