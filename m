Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424226AbeE1LiR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423908AbeE1LMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 193/272] perf/x86/intel: Fix event update for auto-reload
Date: Mon, 28 May 2018 12:03:46 +0200
Message-Id: <20180528100256.842288791@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit d31fc13fdcb20e1c317f9a7dd6273c18fbd58308 ]

There is a bug when reading event->count with large PEBS enabled.

Here is an example:

  # ./read_count
  0x71f0
  0x122c0
  0x1000000001c54
  0x100000001257d
  0x200000000bdc5

In fixed period mode, the auto-reload mechanism could be enabled for
PEBS events, but the calculation of event->count does not take the
auto-reload values into account.

Anyone who reads event->count will get the wrong result, e.g x86_pmu_read().

This bug was introduced with the auto-reload mechanism enabled since
commit:

  851559e35fd5 ("perf/x86/intel: Use the PEBS auto reload mechanism when possible")

Introduce intel_pmu_save_and_restart_reload() to calculate the
event->count only for auto-reload.

Since the counter increments a negative counter value and overflows on
the sign switch, giving the interval:

        [-period, 0]

the difference between two consequtive reads is:

 A) value2 - value1;
    when no overflows have happened in between,
 B) (0 - value1) + (value2 - (-period));
    when one overflow happened in between,
 C) (0 - value1) + (n - 1) * (period) + (value2 - (-period));
    when @n overflows happened in between.

Here A) is the obvious difference, B) is the extension to the discrete
interval, where the first term is to the top of the interval and the
second term is from the bottom of the next interval and C) the extension
to multiple intervals, where the middle term is the whole intervals
covered.

The equation for all cases is:

    value2 - value1 + n * period

Previously the event->count is updated right before the sample output.
But for case A, there is no PEBS record ready. It needs to be specially
handled.

Remove the auto-reload code from x86_perf_event_set_period() since
we'll not longer call that function in this case.

Based-on-code-from: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Fixes: 851559e35fd5 ("perf/x86/intel: Use the PEBS auto reload mechanism when possible")
Link: http://lkml.kernel.org/r/1518474035-21006-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/core.c     |   15 ++-----
 arch/x86/events/intel/ds.c |   92 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 13 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1162,16 +1162,13 @@ int x86_perf_event_set_period(struct per
 
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
@@ -1315,17 +1315,84 @@ get_next_pebs_record_by_bit(void *base,
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
+	s64 new, old;
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
+	local64_set(&hwc->prev_count, new_raw_count);
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
+	 * Here A) is the obvious difference, B) is the extension to the
+	 * discrete interval, where the first term is to the top of the
+	 * interval and the second term is from the bottom of the next
+	 * interval and C) the extension to multiple intervals, where the
+	 * middle term is the whole intervals covered.
+	 *
+	 * An equivalent of C, by reduction, is:
+	 *
+	 *   value2 - value1 + n * period
+	 */
+	new = ((s64)(new_raw_count << shift) >> shift);
+	old = ((s64)(prev_raw_count << shift) >> shift);
+	local64_add(new - old + count * period, &event->count);
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
@@ -1377,8 +1444,11 @@ static void intel_pmu_drain_pebs_core(st
 		return;
 
 	n = top - at;
-	if (n <= 0)
+	if (n <= 0) {
+		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+			intel_pmu_save_and_restart_reload(event, 0);
 		return;
+	}
 
 	__intel_pmu_pebs_event(event, iregs, at, top, 0, n);
 }
@@ -1401,8 +1471,22 @@ static void intel_pmu_drain_pebs_nhm(str
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	if (unlikely(base >= top))
+	if (unlikely(base >= top)) {
+		/*
+		 * The drain_pebs() could be called twice in a short period
+		 * for auto-reload event in pmu::read(). There are no
+		 * overflows have happened in between.
+		 * It needs to call intel_pmu_save_and_restart_reload() to
+		 * update the event->count for this case.
+		 */
+		for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled,
+				 x86_pmu.max_pebs_events) {
+			event = cpuc->events[bit];
+			if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+				intel_pmu_save_and_restart_reload(event, 0);
+		}
 		return;
+	}
 
 	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
 		struct pebs_record_nhm *p = at;
