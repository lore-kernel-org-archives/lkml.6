Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60299606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeFFSBb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:01:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbeFFSBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:01:30 -0400
Date: Wed, 6 Jun 2018 19:01:20 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 5/5] arm64: perf: Add support for chaining event
 counters
Message-ID: <20180606180119.4ofhges6codarbmk@lakrids.cambridge.arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
 <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:55:56AM +0100, Suzuki K Poulose wrote:
> Add support for 64bit event by using chained event counters
> and 64bit cycle counters.
> 
> Arm v8 PMUv3 allows chaining a pair of adjacent PMU counters
> (with the lower counter number being always "even"). The low
> counter is programmed to count the event of interest and the
> high counter(odd numbered) is programmed with a special event
> code (0x1e - Chain).

I found this a little difficult to read. How about:

PMUv3 allows chaining a pair of adjacent 32-bit counters, effectively
forming a 64-bit counter. The low/even counter is programmed to count
the event of interest, and the high/odd counter is programmed to count
the CHAIN event, taken when the low/even counter overflows.

> Thus we need special allocation schemes
> to make the full use of available counters. So, we allocate the
> counters from either ends. i.e, chained counters are allocated
> from the lower end in pairs of two and the normal counters are
> allocated from the higher number. Also makes necessary changes to
> handle the chained events as a single event with 2 counters.

Why do we need to allocate in this way? 

I can see this might make allocating a pair of counters more likely in
some cases, but there are still others where it wouldn't be possible
(and we'd rely on the rotation logic to repack the counters for us).

[...]

> +static inline u32 armv8pmu_read_evcntr(int idx)
> +{
> +	return (armv8pmu_select_counter(idx) == idx) ?
> +	       read_sysreg(pmxevcntr_el0) : 0;
> +}

Given armv8pmu_select_counter() always returns the idx passed to it, I
don't think we need to check anything here. We can clean that up to be
void, and remove the existing checks.

[...]

> +static inline u64 armv8pmu_read_chain_counter(int idx)
> +{
> +	u64 prev_hi, hi, lo;
> +
> +	hi = armv8pmu_read_evcntr(idx);
> +	do {
> +		prev_hi = hi;
> +		isb();
> +		lo = armv8pmu_read_evcntr(idx - 1);
> +		isb();
> +		hi = armv8pmu_read_evcntr(idx);
> +	} while (prev_hi != hi);
> +
> +	return (hi << 32) | lo;
> +}

> +static inline void armv8pmu_write_chain_counter(int idx, u64 value)
> +{
> +	armv8pmu_write_evcntr(idx, value >> 32);
> +	isb();
> +	armv8pmu_write_evcntr(idx - 1, value);
> +}

Can we use upper_32_bits() and lower_32_bits() here?

As a more general thing, I think we need to clean up the way we
read/write counters, because I don't think that it's right that we poke
them while they're running -- that means you get some arbitrary skew on
counter groups.

It looks like the only case we do that is the IRQ handler, so we should
be able to stop/start the PMU there.

With that, we can get rid of the ISB here, and likewise in
read_chain_counter, which wouldn't need to be a loop.

> +
> +static inline void armv8pmu_write_hw_counter(struct perf_event *event,
> +					     u64 value)
> +{
> +	int idx = event->hw.idx;
> +
> +	if (armv8pmu_event_is_chained(event))
> +		armv8pmu_write_chain_counter(idx, value);
> +	else
> +		armv8pmu_write_evcntr(idx, value);
> +}
> +
>  static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>  {
>  	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> @@ -541,14 +612,14 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
>  			smp_processor_id(), idx);
>  	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
>  		/*
> -		 * Set the upper 32bits as this is a 64bit counter but we only
> -		 * count using the lower 32bits and we want an interrupt when
> -		 * it overflows.
> +		 * Set the upper 32bits if we are counting this in
> +		 * 32bit mode, as this is a 64bit counter.
>  		 */

It would be good to keep the explaination as to why.

> -		value |= 0xffffffff00000000ULL;
> +		if (!armv8pmu_event_is_64bit(event))
> +			value |= 0xffffffff00000000ULL;
>  		write_sysreg(value, pmccntr_el0);
> -	} else if (armv8pmu_select_counter(idx) == idx)
> -		write_sysreg(value, pmxevcntr_el0);
> +	} else
> +		armv8pmu_write_hw_counter(event, value);
>  }

> +static inline void armv8pmu_write_event_type(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	/*
> +	 * For chained events, write the the low counter event type
> +	 * followed by the high counter. The high counter is programmed
> +	 * with CHAIN event code with filters set to count at all ELs.
> +	 */
> +	if (armv8pmu_event_is_chained(event)) {
> +		u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN |
> +				ARMV8_PMU_INCLUDE_EL2;
> +
> +		armv8pmu_write_evtype(idx - 1, hwc->config_base);
> +		isb();
> +		armv8pmu_write_evtype(idx, chain_evt);

The ISB isn't necessary here, AFAICT. We only do this while the PMU is
disabled; no?

> +	} else
> +		armv8pmu_write_evtype(idx, hwc->config_base);
> +}

[...]

> +static inline void armv8pmu_enable_event_counter(struct perf_event *event)
> +{
> +	int idx = event->hw.idx;
> +
> +	/*
> +	 * For chained events, we enable the high counter followed by
> +	 * the low counter.
> +	 */
> +	armv8pmu_enable_counter(idx);
> +	if (armv8pmu_event_is_chained(event)) {
> +		isb();
> +		armv8pmu_enable_counter(idx - 1);
> +	}
> +}

If we fix up the IRQ handler, this would only happen with the PMU as a
whole disabled, and we wouldn't care about ordering of enable/disable of
each event.

[...]

> +static inline void armv8pmu_disable_event_counter(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	/*
> +	 * Disable the low counter followed by the high counter
> +	 * for chained events.
> +	 */
> +	if (armv8pmu_event_is_chained(event)) {
> +		armv8pmu_disable_counter(idx - 1);
> +		isb();
> +	}
> +
> +	armv8pmu_disable_counter(idx);
> +}

... likewise.

> @@ -679,6 +679,12 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
>  			continue;
>  
>  		event = hw_events->events[idx];
> +		/*
> +		 * If there is no event at this idx (e.g, an idx used
> +		 * by a chained event in Arm v8 PMUv3), skip it.
> +		 */
> +		if (!event)
> +			continue;

We may as well lose the used_mask test if we're looking at the event
regardless.

Thanks,
Mark.
