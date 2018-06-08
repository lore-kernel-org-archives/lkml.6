Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jmiTI6ufGltXYAAAmS7hNA
	; Fri, 08 Jun 2018 15:24:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7FAE6607DC; Fri,  8 Jun 2018 15:24:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E9FFE60590;
	Fri,  8 Jun 2018 15:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9FFE60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeFHPYY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:24:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeFHPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:24:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6AF1435;
        Fri,  8 Jun 2018 08:24:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 416A43F5A0;
        Fri,  8 Jun 2018 08:24:22 -0700 (PDT)
Date: Fri, 8 Jun 2018 16:24:19 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 5/5] arm64: perf: Add support for chaining event
 counters
Message-ID: <20180608152419.kamu7ptmgsoah5m3@lakrids.cambridge.arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
 <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
 <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a5b5e7f-fc0b-84e3-fc65-b9f860029207@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:46:57PM +0100, Suzuki K Poulose wrote:
> On 06/06/2018 07:01 PM, Mark Rutland wrote:
> > > Thus we need special allocation schemes
> > > to make the full use of available counters. So, we allocate the
> > > counters from either ends. i.e, chained counters are allocated
> > > from the lower end in pairs of two and the normal counters are
> > > allocated from the higher number. Also makes necessary changes to
> > > handle the chained events as a single event with 2 counters.
> > 
> > Why do we need to allocate in this way?
> > 
> > I can see this might make allocating a pair of counters more likely in
> > some cases, but there are still others where it wouldn't be possible
> > (and we'd rely on the rotation logic to repack the counters for us).
> 
> It makes the efficient use of the counters in all cases and allows
> counting maximum number of events with any given set, keeping the precedence
> on the order of their "inserts".
> e.g, if the number of counters happened to be "odd" (not sure if it is even
> possible).

Unfortunately, that doesn't always work.

Say you have a system with 8 counters, and you open 8 (32-bit) events.

Then you close the events in counters 0, 2, 4, and 6. The live events
aren't moved, and stay where they are, in counters 1, 3, 5, and 7.

Now, say you open a 64-bit event. When we try to add it, we try to
allocate an index for two consecutive counters, and find that we can't,
despite 4 counters being free.

We return -EAGAIN to the core perf code, whereupon it removes any other
events in that group (none in this case).

Then we wait for the rotation logic to pull all of the events out and
schedule them back in, re-packing them, which should (eventually) work
regardless of how we allocate counters.

... we might need to re-pack events to solve that. :/

[...]

> > > +static inline void armv8pmu_write_chain_counter(int idx, u64 value)
> > > +{
> > > +	armv8pmu_write_evcntr(idx, value >> 32);
> > > +	isb();
> > > +	armv8pmu_write_evcntr(idx - 1, value);
> > > +}
> > 
> > Can we use upper_32_bits() and lower_32_bits() here?
> > 
> > As a more general thing, I think we need to clean up the way we
> > read/write counters, because I don't think that it's right that we poke
> > them while they're running -- that means you get some arbitrary skew on
> > counter groups.
> > 
> > It looks like the only case we do that is the IRQ handler, so we should
> > be able to stop/start the PMU there.
> 
> Since we don't stop the "counting" of events usually when an IRQ is
> triggered, the skew will be finally balanced when the events are stopped
> in a the group. So, I think, stopping the PMU may not be really a good
> thing after all. Just my thought.

That's not quite right -- if one event in a group overflows, we'll
reprogram it *while* other events are counting, losing some events in
the process.

Stopping the PMU for the duration of the IRQ handler ensures that events
in a group are always in-sync with one another.

Thanks,
Mark.
