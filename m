Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7B3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5646027469
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5646027469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeF2OkD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:40:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35318 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932131AbeF2OkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:40:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C34C80D;
        Fri, 29 Jun 2018 07:40:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8923F5C0;
        Fri, 29 Jun 2018 07:40:00 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:39:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com
Subject: Re: [PATCH v3 7/7] arm64: perf: Add support for chaining event
 counters
Message-ID: <20180629143958.sryambvgsbd7czdu@lakrids.cambridge.arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-8-git-send-email-suzuki.poulose@arm.com>
 <20180629140129.i4oh4oov3jaecnt5@lakrids.cambridge.arm.com>
 <f3c293f6-226f-2d16-8e45-6a4ab08c595f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c293f6-226f-2d16-8e45-6a4ab08c595f@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:29:12PM +0100, Suzuki K Poulose wrote:
> On 29/06/18 15:01, Mark Rutland wrote:
> > On Tue, Jun 19, 2018 at 11:15:42AM +0100, Suzuki K Poulose wrote:
> > > Add support for 64bit event by using chained event counters
> > > and 64bit cycle counters.
> > > 
> > > PMUv3 allows chaining a pair of adjacent 32-bit counters, effectively
> > > forming a 64-bit counter. The low/even counter is programmed to count
> > > the event of interest, and the high/odd counter is programmed to count
> > > the CHAIN event, taken when the low/even counter overflows.
> > > 
> > > For CPU cycles, when 64bit mode is requested, the cycle counter
> > > is used in 64bit mode. If the cycle counter is not available,
> > > falls back to chaining.
> > > 
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > > Changes sinec v2:
> > >   - Drop special allocation algorithm for chain indices
> > >   - Since we access the counters when the PMU is stopped,
> > >     get rid of the unncessary barriers.
> > >   - Ensure a counter is allocated when checking for chained event
> > > ---
> > >   arch/arm64/kernel/perf_event.c | 184 ++++++++++++++++++++++++++++++++++++-----
> > >   drivers/perf/arm_pmu.c         |  13 ++-
> > >   2 files changed, 169 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > > index eebc635..a03def7 100644
> > > --- a/arch/arm64/kernel/perf_event.c
> > > +++ b/arch/arm64/kernel/perf_event.c
> > > @@ -446,9 +446,16 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {
> > >   };
> > >   PMU_FORMAT_ATTR(event, "config:0-15");
> > > +PMU_FORMAT_ATTR(bits64, "config1:0");
> > 
> > I'm not too keen on the "bits64" name here -- it's a little unusual.
> > Perhaps "long"?
> 
> I wasn't either. The other option was _64bit, but it is easier to misspell.
> The only reason for not sticking to "long" is, that gives a perception that
> the user always get "double" the normal counter width, which may break
> if we ever get 64bit PMU counters by default without chaining.

I'm happy to take that risk with "long".

We can probably document that under Documentation/perf if we're
particularly worried.

[...]

> > > @@ -466,6 +473,20 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
> > >   	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
> > >   /*
> > > + * Use chained counter for a 64bit event, if we could not allocate
> > > + * the 64bit cycle counter. This must be called after a counter
> > > + * was allocated.
> > > + */
> > > +static inline bool armv8pmu_event_is_chained(struct perf_event *event)
> > > +{
> > > +	int idx = event->hw.idx;
> > > +
> > > +	return !WARN_ON(idx < 0) &&
> > > +	       armv8pmu_event_is_64bit(event) &&
> > > +	       (event->hw.idx != ARMV8_IDX_CYCLE_COUNTER);
> > > +}
> > 
> > It took me a moment to parse this. Perhaps:
> 
> Yes, it does look a bit weird.
> 
> > 
> > 	/*
> > 	 * The dedicated cycle counter doesn't requrie chaining, but
> > 	 * when this is already in use, we must chain two programmable
> > 	 * counters to form a 64-bit cycle counter.
> > 	 */
> 
> That sounds like, we check only for cycle events, which is not true, how
> about :
> 
> 	/*
> 	 * We must chain two programmable counters for 64 bit events,
> 	 * except when we have allocated the 64bit cycle counter (for CPU
> 	 *cycles event).
> 	 */

That sounds much better, yes please!

> > > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > > index 6e10e8c..a4675e4 100644
> > > --- a/drivers/perf/arm_pmu.c
> > > +++ b/drivers/perf/arm_pmu.c
> > > @@ -674,14 +674,13 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
> > >   	int idx;
> > >   	for (idx = 0; idx < armpmu->num_events; idx++) {
> > > -		/*
> > > -		 * If the counter is not used skip it, there is no
> > > -		 * need of stopping/restarting it.
> > > -		 */
> > > -		if (!test_bit(idx, hw_events->used_mask))
> > > -			continue;
> > > -
> > >   		event = hw_events->events[idx];
> > > +		/*
> > > +		 * If there is no event at this idx (e.g, an idx used
> > > +		 * by a chained event in Arm v8 PMUv3), skip it.
> > > +		 */
> > > +		if (!event)
> > > +			continue;
> > >   		switch (cmd) {
> > >   		case CPU_PM_ENTER:
> > 
> > Please make this change an individual patch earlier in the series. It's
> 
> I can do that. But I don't think the krait needs this, as explained in the
> other patch.

No need. I'm fine with it as-is; sorry for the noise!

Thanks,
Mark.
