Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949FBC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672BC2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeJXXTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:19:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeJXXTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:19:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A62E03082AF0;
        Wed, 24 Oct 2018 14:51:17 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E24E60921;
        Wed, 24 Oct 2018 14:51:15 +0000 (UTC)
Date:   Wed, 24 Oct 2018 16:51:13 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC to Mono-raw Drift
Message-ID: <20181024145113.GF12019@localhost>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Oct 2018 14:51:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:31:00AM -0700, John Stultz wrote:
> On Fri, Oct 19, 2018 at 3:36 PM, John Stultz <john.stultz@linaro.org> wrote:
> > On Fri, Oct 19, 2018 at 1:50 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> On Fri, 19 Oct 2018, John Stultz wrote:
> >>> We might be able to reduce the degree in this case, but I worry the
> >>> extra complexity may only cause problems for others.
> >>
> >> Is it really that complex to add a fixed correction value periodically?

The error is too large to be corrected by stepping on clock updates.
For a typical TSC frequency we have multiplier in the range of few
millions, so that's a frequency error of up to few hundred ppb. In the
old days when the clock was updated 1000 times per second that would
be hidden in the resolution of the clock, but now with tickless
kernels those steps would be very noticeable.

If the multiplier was adjusted in the same way as the non-raw clock,
there wouldn't be any steps in time, but there would be steps in
frequency and the time error would be proportional to the update
interval. For a clock updated once per second that's an error of up to
a few hundreds of nanoseconds.

I agree with John. I think the raw monotonic clock should be stable.

It would help if we better understood the use case. If I needed a
clock that ticks in an exact proportion to the tsc, why wouldn't I use
the tsc directly? Is this about having a fall back in case the tsc
cannot be used (e.g. due to unsynchronized CPUs)?

If the frequency error was exported, it could be compensated where
necessary. Maybe that would work for the original poster?

A better fix might be to modify the calculation of time to use a
second multiplier, effectively increasing its resolution. However,
that would slow down all users of the clock.

-- 
Miroslav Lichvar
