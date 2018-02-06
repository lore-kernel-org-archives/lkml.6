Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBFPG6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:06:58 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:37267 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeBFPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:06:54 -0500
Date: Tue, 6 Feb 2018 16:06:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V3 1/5] perf/x86/intel: fix event update for auto-reload
Message-ID: <20180206150648.GK2249@hirez.programming.kicks-ass.net>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <1517243373-355481-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517243373-355481-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 08:29:29AM -0800, kan.liang@linux.intel.com wrote:
> +/*
> + * Specific intel_pmu_save_and_restart() for auto-reload.
> + * It only be called from drain_pebs().
> + */
> +static int intel_pmu_save_and_restart_reload(struct perf_event *event,
> +					     int reload_times)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int shift = 64 - x86_pmu.cntval_bits;
> +	u64 reload_val = hwc->sample_period;
> +	u64 prev_raw_count, new_raw_count;
> +	u64 delta;
> +
> +	WARN_ON((reload_times == 0) || (reload_val == 0));

I'm struggling to see why !count is a problem. You can call read() twice
without having extra PEBS samples, right?

Which also seems to suggest we have a problem in intel_pmu_drain_pebs*()
because those will simply not call us when there aren't any PEBS events
in the buffer, even though the count value can have changed. Your patch
doesn't appear to address that.

> +
> +	/*
> +	 * drain_pebs() only happens when the PMU is disabled.
> +	 * It doesnot need to specially handle the previous event value.
> +	 * The hwc->prev_count will be updated in x86_perf_event_set_period().

That's completely buggered. You shouldn't need to call
x86_perf_event_set_period() _at_all_.

> +	 */

	WARN_ON(this_cpu_read(cpu_hw_events.enabled));

> +	prev_raw_count = local64_read(&hwc->prev_count);
> +	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> +
> +	/*
> +	 * Now we have the new raw value and have updated the prev
> +	 * timestamp already. We can now calculate the elapsed delta
> +	 * (event-)time and add that to the generic event.
> +	 *
> +	 * Careful, not all hw sign-extends above the physical width
> +	 * of the count.
> +	 *
> +	 * There is a small gap between 'PEBS hardware is armed' and 'the NMI
> +	 * is handled'. Because of the gap, the first record also needs to be
> +	 * specially handled.

True, but not at all relevant.

> +	 * The formula to calculate the increments of event->count is as below.
> +	 * The increments = the period for first record +
> +	 *                  (reload_times - 1) * reload_val +
> +	 *                  the gap
> +	 * 'The period for first record' can be got from -prev_raw_count.
> +	 *
> +	 * 'The gap' = new_raw_count + reload_val. Because the start point of
> +	 * counting is always -reload_val for auto-reload.

That is still very much confused, what you seem to want is something
like:

	Since the counter increments a negative counter value and
	overflows on the sign switch, giving the interval:

		[-period, 0]

	the difference between two consequtive reads is:

	  A) value2 - value1;
	     when no overflows have happened in between,

	  B) (0 - value1) + (value2 - (-period));
	     when one overflow happened in between,

	  C) (0 - value1) + (n - 1) * (period) + (value2 - (-period));
	     when @n overflows happened in betwee.

	Here A) is the obvious difference, B) is the extention to the
	discrete interval, where the first term is to the top of the
	interval and the second term is from the bottom of the next
	interval and 3) the extention to multiple intervals, where the
	middle term is the whole intervals covered.

	An equivalent of C, by reduction, is:

	  value2 - value1 + n * period

> +	 *
> +	 * The period_left needs to do the same adjustment by adding
> +	 * reload_val.
> +	 */
> +	delta = (reload_val << shift) + (new_raw_count << shift) -
> +		(prev_raw_count << shift);
> +	delta >>= shift;
> +
> +	local64_add(reload_val * (reload_times - 1), &event->count);
> +	local64_add(delta, &event->count);
> +	local64_sub(delta, &hwc->period_left);

Nobody cares about period_left, since AUTO_RELOAD already limits the
periods to what the hardware supports, right?

> +
> +	return x86_perf_event_set_period(event);
> +}

With the exception of handling 'empty' buffers, I ended up with the
below. Please try again.

---
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1156,16 +1156,13 @@ int x86_perf_event_set_period(struct per
 
 	per_cpu(pmc_prev_left[idx], smp_processor_id()) = left;
 
-	if (!(hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) ||
-	    local64_read(&hwc->prev_count) != (u64)-left) {
-		/*
-		 * The hw event starts counting from this event offset,
-		 * mark it to be able to extra future deltas:
-		 */
-		local64_set(&hwc->prev_count, (u64)-left);
+	/*
+	 * The hw event starts counting from this event offset,
+	 * mark it to be able to extra future deltas:
+	 */
+	local64_set(&hwc->prev_count, (u64)-left);
 
-		wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
-	}
+	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 
 	/*
 	 * Due to erratum on certan cpu we need
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1306,17 +1306,89 @@ get_next_pebs_record_by_bit(void *base,
 	return NULL;
 }
 
+/*
+ * Special variant of intel_pmu_save_and_restart() for auto-reload.
+ */
+static int
+intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int shift = 64 - x86_pmu.cntval_bits;
+	u64 period = hwc->sample_period;
+	u64 prev_raw_count, new_raw_count;
+	u64 delta;
+
+	WARN_ON(!period);
+
+	/*
+	 * drain_pebs() only happens when the PMU is disabled.
+	 */
+	WARN_ON(this_cpu_read(cpu_hw_events.enabled));
+
+	prev_raw_count = local64_read(&hwc->prev_count);
+	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+	local64_set(&hwx->prev_count, new_raw_count);
+
+	/*
+	 * Careful, not all hw sign-extends above the physical width
+	 * of the counter.
+	 */
+	delta = (new_raw_count << shift) - (prev_raw_count << shift);
+	delta >>= shift;
+
+	/*
+	 * Since the counter increments a negative counter value and
+	 * overflows on the sign switch, giving the interval:
+	 *
+	 *   [-period, 0]
+	 *
+	 * the difference between two consequtive reads is:
+	 *
+	 *   A) value2 - value1;
+	 *      when no overflows have happened in between,
+	 *
+	 *   B) (0 - value1) + (value2 - (-period));
+	 *      when one overflow happened in between,
+	 *
+	 *   C) (0 - value1) + (n - 1) * (period) + (value2 - (-period));
+	 *      when @n overflows happened in between.
+	 *
+	 * Here A) is the obvious difference, B) is the extention to the
+	 * discrete interval, where the first term is to the top of the
+	 * interval and the second term is from the bottom of the next
+	 * interval and 3) the extention to multiple intervals, where the
+	 * middle term is the whole intervals covered.
+	 *
+	 * An equivalent of C, by reduction, is:
+	 *
+	 *   value2 - value1 + n * period
+	 */
+	local64_add(delta + period * count, &event->count);
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
 static void __intel_pmu_pebs_event(struct perf_event *event,
 				   struct pt_regs *iregs,
 				   void *base, void *top,
 				   int bit, int count)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	struct perf_sample_data data;
 	struct pt_regs regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 
-	if (!intel_pmu_save_and_restart(event) &&
-	    !(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD))
+	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
+		/*
+		 * Now, auto-reload is only enabled in fixed period mode.
+		 * The reload value is always hwc->sample_period.
+		 * May need to change it, if auto-reload is enabled in
+		 * freq mode later.
+		 */
+		intel_pmu_save_and_restart_reload(event, count);
+	} else if (!intel_pmu_save_and_restart(event))
 		return;
 
 	while (count > 1) {
