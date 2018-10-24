Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860BECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E8B2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E8B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJYKAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:00:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:2331 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeJYKAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:00:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 18:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="268565519"
Received: from wtczc53028gn.jf.intel.com (HELO artvirt.jf.intel.com) ([10.23.229.173])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2018 18:29:52 -0700
Date:   Wed, 24 Oct 2018 13:32:48 -0400
From:   Christopher Hall <christopher.s.hall@intel.com>
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC to Mono-raw Drift
Message-ID: <20181024173248.GB6121@artvirt.jf.intel.com>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
 <20181024145113.GF12019@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024145113.GF12019@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:51:13PM +0200, Miroslav Lichvar wrote:
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

For this example, a i5-6600 CPU @ 3.30GHz I measured 90 ppb. That is the
largest I've seen since measuring this on a few platforms. 20-40 PPB seems
more typical.

> old days when the clock was updated 1000 times per second that would
> be hidden in the resolution of the clock, but now with tickless
> kernels those steps would be very noticeable.
> 
> If the multiplier was adjusted in the same way as the non-raw clock,
> there wouldn't be any steps in time, but there would be steps in
> frequency and the time error would be proportional to the update
> interval. For a clock updated once per second that's an error of up to
> a few hundreds of nanoseconds.
> 
> I agree with John. I think the raw monotonic clock should be stable.
> 
> It would help if we better understood the use case. If I needed a

There may be other future use cases, but the most immediate use is timed
GPIO. Current shipping hardware has a timed GPIO device that uses ART/TSC
directly to schedule output events and time-stamp input events. There isn't
a device clock like PHC, as an example.

An example application is synchronizing TGPIO across two networked devices
sync'd with PTP. It's possible to use existing the existing PHC interface to
compute the network time in terms of raw monotonic and vice versa.

Now we need to add a TSC to monotonic raw relation in order to interact
with the TGPIO hardware. To me this doesn't make sense because they use the
same hardware clock.

> clock that ticks in an exact proportion to the tsc, why wouldn't I use
> the tsc directly? Is this about having a fall back in case the tsc

I think this would work OK. This would need some additional API to expose the
relation between monotonic raw and TSC. In the kernel that would probably mean
plumbing ktime_get_snapshot() to the application. Or, another option:
add TSC as another clock to the get_device_system_crosststamp() interface.

The second option would be more precise, but for the proposed application
(or similar) would require changes to the supporting stacks like PTP.

> cannot be used (e.g. due to unsynchronized CPUs)?

No.
> 
> If the frequency error was exported, it could be compensated where
> necessary. Maybe that would work for the original poster?

This would be the same as plumbing ktime_get_snapshot() except that the
math would be done in the kernel.

> 
> A better fix might be to modify the calculation of time to use a
> second multiplier, effectively increasing its resolution. However,

I'm not sure, I'm understanding. Like cascading transforms? While this
would increase the precision, I think it would still drift over days. We
could probably fix up every second though.

> that would slow down all users of the clock.

Couldn't some clocksources specify an additional multiplier/precision and
others use lower precision?

> 
> -- 
> Miroslav Lichvar
