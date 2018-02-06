Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeBFR6u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:58:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:32852 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752736AbeBFR62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:58:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,469,1511856000";
   d="scan'208";a="27802179"
Subject: Re: [PATCH V3 1/5] perf/x86/intel: fix event update for auto-reload
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <1517243373-355481-2-git-send-email-kan.liang@linux.intel.com>
 <20180206150648.GK2249@hirez.programming.kicks-ass.net>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ae4c7aff-da12-8cb3-4fac-4637ab001060@linux.intel.com>
Date: Tue, 6 Feb 2018 12:58:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206150648.GK2249@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> With the exception of handling 'empty' buffers, I ended up with the
> below. Please try again.
>

There are two small errors. After fixing them, the patch works well.

> ---
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1156,16 +1156,13 @@ int x86_perf_event_set_period(struct per
>   
>   	per_cpu(pmc_prev_left[idx], smp_processor_id()) = left;
>   
> -	if (!(hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) ||
> -	    local64_read(&hwc->prev_count) != (u64)-left) {
> -		/*
> -		 * The hw event starts counting from this event offset,
> -		 * mark it to be able to extra future deltas:
> -		 */
> -		local64_set(&hwc->prev_count, (u64)-left);
> +	/*
> +	 * The hw event starts counting from this event offset,
> +	 * mark it to be able to extra future deltas:
> +	 */
> +	local64_set(&hwc->prev_count, (u64)-left);
>   
> -		wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> -	}
> +	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
>   
>   	/*
>   	 * Due to erratum on certan cpu we need
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1306,17 +1306,89 @@ get_next_pebs_record_by_bit(void *base,
>   	return NULL;
>   }
>   
> +/*
> + * Special variant of intel_pmu_save_and_restart() for auto-reload.
> + */
> +static int
> +intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int shift = 64 - x86_pmu.cntval_bits;
> +	u64 period = hwc->sample_period;
> +	u64 prev_raw_count, new_raw_count;
> +	u64 delta;
> +
> +	WARN_ON(!period);
> +
> +	/*
> +	 * drain_pebs() only happens when the PMU is disabled.
> +	 */
> +	WARN_ON(this_cpu_read(cpu_hw_events.enabled));
> +
> +	prev_raw_count = local64_read(&hwc->prev_count);
> +	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> +	local64_set(&hwx->prev_count, new_raw_count);

Here is a typo. It should be &hwc->prev_count.

> +
> +	/*
> +	 * Careful, not all hw sign-extends above the physical width
> +	 * of the counter.
> +	 */
> +	delta = (new_raw_count << shift) - (prev_raw_count << shift);
> +	delta >>= shift;

new_raw_count could be smaller than prev_raw_count.
The sign bit will be set. The delta>> could be wrong.

I think we can add a period here to prevent it.
+       delta = (period << shift) + (new_raw_count << shift) -
+               (prev_raw_count << shift);
+       delta >>= shift;
......
+       local64_add(delta + period * (count - 1), &event->count);


Thanks,
Kan
> +
> +	/*
> +	 * Since the counter increments a negative counter value and
> +	 * overflows on the sign switch, giving the interval:
> +	 *
> +	 *   [-period, 0]
> +	 *
> +	 * the difference between two consequtive reads is:
> +	 *
> +	 *   A) value2 - value1;
> +	 *      when no overflows have happened in between,
> +	 *
> +	 *   B) (0 - value1) + (value2 - (-period));
> +	 *      when one overflow happened in between,
> +	 *
> +	 *   C) (0 - value1) + (n - 1) * (period) + (value2 - (-period));
> +	 *      when @n overflows happened in between.
> +	 *
> +	 * Here A) is the obvious difference, B) is the extention to the
> +	 * discrete interval, where the first term is to the top of the
> +	 * interval and the second term is from the bottom of the next
> +	 * interval and 3) the extention to multiple intervals, where the
> +	 * middle term is the whole intervals covered.
> +	 *
> +	 * An equivalent of C, by reduction, is:
> +	 *
> +	 *   value2 - value1 + n * period
> +	 */
> +	local64_add(delta + period * count, &event->count);
> +
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
>   static void __intel_pmu_pebs_event(struct perf_event *event,
>   				   struct pt_regs *iregs,
>   				   void *base, void *top,
>   				   int bit, int count)
>   {
> +	struct hw_perf_event *hwc = &event->hw;
>   	struct perf_sample_data data;
>   	struct pt_regs regs;
>   	void *at = get_next_pebs_record_by_bit(base, top, bit);
>   
> -	if (!intel_pmu_save_and_restart(event) &&
> -	    !(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD))
> +	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
> +		/*
> +		 * Now, auto-reload is only enabled in fixed period mode.
> +		 * The reload value is always hwc->sample_period.
> +		 * May need to change it, if auto-reload is enabled in
> +		 * freq mode later.
> +		 */
> +		intel_pmu_save_and_restart_reload(event, count);
> +	} else if (!intel_pmu_save_and_restart(event))
>   		return;
>   
>   	while (count > 1) {
> 
