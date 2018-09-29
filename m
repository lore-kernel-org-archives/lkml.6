Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B6820879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B6820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeI2NaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:30:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeI2NaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:30:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8T72T8O726432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Sep 2018 00:02:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8T72T6Y726429;
        Sat, 29 Sep 2018 00:02:29 -0700
Date:   Sat, 29 Sep 2018 00:02:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-dd45407c0b2445bc2aa0ecfea744d5af3a146577@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
          hpa@zytor.com
In-Reply-To: <fc24e728b446404f42c78573c506e98cd0599873.1537468643.git.reinette.chatre@intel.com>
References: <fc24e728b446404f42c78573c506e98cd0599873.1537468643.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Use perf infrastructure for
 measurements
Git-Commit-ID: dd45407c0b2445bc2aa0ecfea744d5af3a146577
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dd45407c0b2445bc2aa0ecfea744d5af3a146577
Gitweb:     https://git.kernel.org/tip/dd45407c0b2445bc2aa0ecfea744d5af3a146577
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Thu, 20 Sep 2018 12:02:11 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Sep 2018 22:48:27 +0200

x86/intel_rdt: Use perf infrastructure for measurements

The success of a cache pseudo-locked region is measured using
performance monitoring events that are programmed directly at the time
the user requests a measurement.

Modifying the performance event registers directly is not appropriate
since it circumvents the in-kernel perf infrastructure that exists to
manage these resources and provide resource arbitration to the
performance monitoring hardware.

The cache pseudo-locking measurements are modified to use the in-kernel
perf infrastructure. Performance events are created and validated with
the appropriate perf API. The performance counters are still read as
directly as possible to avoid the additional cache hits. This is
done safely by first ensuring with the perf API that the counters have
been programmed correctly and only accessing the counters in an
interrupt disabled section where they are not able to be moved.

As part of the transition to the in-kernel perf infrastructure the L2
and L3 measurements are split into two separate measurements that can
be triggered independently. This separation prevents additional cache
misses incurred during the extra testing code used to decide if a
L2 and/or L3 measurement should be made.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: peterz@infradead.org
Cc: acme@kernel.org
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/fc24e728b446404f42c78573c506e98cd0599873.1537468643.git.reinette.chatre@intel.com

---
 Documentation/x86/intel_rdt_ui.txt          |  22 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 304 +++++++++++++++++-----------
 2 files changed, 203 insertions(+), 123 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index f662d3c530e5..52b10945ff75 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -520,18 +520,24 @@ the pseudo-locked region:
 2) Cache hit and miss measurements using model specific precision counters if
    available. Depending on the levels of cache on the system the pseudo_lock_l2
    and pseudo_lock_l3 tracepoints are available.
-   WARNING: triggering this  measurement uses from two (for just L2
-   measurements) to four (for L2 and L3 measurements) precision counters on
-   the system, if any other measurements are in progress the counters and
-   their corresponding event registers will be clobbered.
 
 When a pseudo-locked region is created a new debugfs directory is created for
 it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
 write-only file, pseudo_lock_measure, is present in this directory. The
-measurement on the pseudo-locked region depends on the number, 1 or 2,
-written to this debugfs file. Since the measurements are recorded with the
-tracing infrastructure the relevant tracepoints need to be enabled before the
-measurement is triggered.
+measurement of the pseudo-locked region depends on the number written to this
+debugfs file:
+1 -  writing "1" to the pseudo_lock_measure file will trigger the latency
+     measurement captured in the pseudo_lock_mem_latency tracepoint. See
+     example below.
+2 -  writing "2" to the pseudo_lock_measure file will trigger the L2 cache
+     residency (cache hits and misses) measurement captured in the
+     pseudo_lock_l2 tracepoint. See example below.
+3 -  writing "3" to the pseudo_lock_measure file will trigger the L3 cache
+     residency (cache hits and misses) measurement captured in the
+     pseudo_lock_l3 tracepoint.
+
+All measurements are recorded with the tracing infrastructure. This requires
+the relevant tracepoints to be enabled before the measurement is triggered.
 
 Example of latency debugging interface:
 In this example a pseudo-locked region named "newlock" was created. Here is
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 33d7968f152a..d68836139cf9 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -27,6 +27,7 @@
 #include <asm/intel_rdt_sched.h>
 #include <asm/perf_event.h>
 
+#include "../../events/perf_event.h" /* For X86_CONFIG() */
 #include "intel_rdt.h"
 
 #define CREATE_TRACE_POINTS
@@ -107,16 +108,6 @@ static u64 get_prefetch_disable_bits(void)
 	return 0;
 }
 
-/*
- * Helper to write 64bit value to MSR without tracing. Used when
- * use of the cache should be restricted and use of registers used
- * for local variables avoided.
- */
-static inline void pseudo_wrmsrl_notrace(unsigned int msr, u64 val)
-{
-	__wrmsr(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
-}
-
 /**
  * pseudo_lock_minor_get - Obtain available minor number
  * @minor: Pointer to where new minor number will be stored
@@ -925,7 +916,7 @@ static int measure_cycles_lat_fn(void *_plr)
  * The actual configuration of the event is set right before use in order
  * to use the X86_CONFIG macro.
  */
-static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
+static struct perf_event_attr perf_miss_attr = {
 	.type		= PERF_TYPE_RAW,
 	.size		= sizeof(struct perf_event_attr),
 	.pinned		= 1,
@@ -933,7 +924,7 @@ static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
 	.exclude_user	= 1,
 };
 
-static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
+static struct perf_event_attr perf_hit_attr = {
 	.type		= PERF_TYPE_RAW,
 	.size		= sizeof(struct perf_event_attr),
 	.pinned		= 1,
@@ -941,139 +932,215 @@ static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
 	.exclude_user	= 1,
 };
 
-static int measure_cycles_perf_fn(void *_plr)
+struct residency_counts {
+	u64 miss_before, hits_before;
+	u64 miss_after,  hits_after;
+};
+
+static int measure_residency_fn(struct perf_event_attr *miss_attr,
+				struct perf_event_attr *hit_attr,
+				struct pseudo_lock_region *plr,
+				struct residency_counts *counts)
 {
-	unsigned long long l3_hits = 0, l3_miss = 0;
-	u64 l3_hit_bits = 0, l3_miss_bits = 0;
-	struct pseudo_lock_region *plr = _plr;
-	unsigned long long l2_hits, l2_miss;
-	u64 l2_hit_bits, l2_miss_bits;
+	u64 hits_before = 0, hits_after = 0, miss_before = 0, miss_after = 0;
+	struct perf_event *miss_event, *hit_event;
+	int hit_pmcnum, miss_pmcnum;
 	unsigned int line_size;
 	unsigned int size;
 	unsigned long i;
 	void *mem_r;
+	u64 tmp;
 
-	/*
-	 * Non-architectural event for the Goldmont Microarchitecture
-	 * from Intel x86 Architecture Software Developer Manual (SDM):
-	 * MEM_LOAD_UOPS_RETIRED D1H (event number)
-	 * Umask values:
-	 *     L1_HIT   01H
-	 *     L2_HIT   02H
-	 *     L1_MISS  08H
-	 *     L2_MISS  10H
-	 *
-	 * On Broadwell Microarchitecture the MEM_LOAD_UOPS_RETIRED event
-	 * has two "no fix" errata associated with it: BDM35 and BDM100. On
-	 * this platform we use the following events instead:
-	 *  L2_RQSTS 24H (Documented in https://download.01.org/perfmon/BDW/)
-	 *       REFERENCES FFH
-	 *       MISS       3FH
-	 *  LONGEST_LAT_CACHE 2EH (Documented in SDM)
-	 *       REFERENCE 4FH
-	 *       MISS      41H
-	 */
+	miss_event = perf_event_create_kernel_counter(miss_attr, plr->cpu,
+						      NULL, NULL, NULL);
+	if (IS_ERR(miss_event))
+		goto out;
 
+	hit_event = perf_event_create_kernel_counter(hit_attr, plr->cpu,
+						     NULL, NULL, NULL);
+	if (IS_ERR(hit_event))
+		goto out_miss;
+
+	local_irq_disable();
 	/*
-	 * Start by setting flags for IA32_PERFEVTSELx:
-	 *     OS  (Operating system mode)  0x2
-	 *     INT (APIC interrupt enable)  0x10
-	 *     EN  (Enable counter)         0x40
-	 *
-	 * Then add the Umask value and event number to select performance
-	 * event.
+	 * Check any possible error state of events used by performing
+	 * one local read.
 	 */
-
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
-		l2_hit_bits = (0x52ULL << 16) | (0x2 << 8) | 0xd1;
-		l2_miss_bits = (0x52ULL << 16) | (0x10 << 8) | 0xd1;
-		break;
-	case INTEL_FAM6_BROADWELL_X:
-		/* On BDW the l2_hit_bits count references, not hits */
-		l2_hit_bits = (0x52ULL << 16) | (0xff << 8) | 0x24;
-		l2_miss_bits = (0x52ULL << 16) | (0x3f << 8) | 0x24;
-		/* On BDW the l3_hit_bits count references, not hits */
-		l3_hit_bits = (0x52ULL << 16) | (0x4f << 8) | 0x2e;
-		l3_miss_bits = (0x52ULL << 16) | (0x41 << 8) | 0x2e;
-		break;
-	default:
-		goto out;
+	if (perf_event_read_local(miss_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_hit;
+	}
+	if (perf_event_read_local(hit_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_hit;
 	}
 
-	local_irq_disable();
 	/*
 	 * Disable hardware prefetchers.
 	 */
 	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
-	/* Disable events and reset counters */
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0, 0x0);
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, 0x0);
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0, 0x0);
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 1, 0x0);
-	if (l3_hit_bits > 0) {
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 2, 0x0);
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3, 0x0);
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 2, 0x0);
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 3, 0x0);
-	}
-	/* Set and enable the L2 counters */
+
+	/* Initialize rest of local variables */
+	/*
+	 * Performance event has been validated right before this with
+	 * interrupts disabled - it is thus safe to read the counter index.
+	 */
+	miss_pmcnum = x86_perf_rdpmc_index(miss_event);
+	hit_pmcnum = x86_perf_rdpmc_index(hit_event);
+	line_size = READ_ONCE(plr->line_size);
 	mem_r = READ_ONCE(plr->kmem);
 	size = READ_ONCE(plr->size);
-	line_size = READ_ONCE(plr->line_size);
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0, l2_hit_bits);
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, l2_miss_bits);
-	if (l3_hit_bits > 0) {
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 2,
-				      l3_hit_bits);
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3,
-				      l3_miss_bits);
-	}
+
+	/*
+	 * Read counter variables twice - first to load the instructions
+	 * used in L1 cache, second to capture accurate value that does not
+	 * include cache misses incurred because of instruction loads.
+	 */
+	rdpmcl(hit_pmcnum, hits_before);
+	rdpmcl(miss_pmcnum, miss_before);
+	/*
+	 * From SDM: Performing back-to-back fast reads are not guaranteed
+	 * to be monotonic.
+	 * Use LFENCE to ensure all previous instructions are retired
+	 * before proceeding.
+	 */
+	rmb();
+	rdpmcl(hit_pmcnum, hits_before);
+	rdpmcl(miss_pmcnum, miss_before);
+	/*
+	 * Use LFENCE to ensure all previous instructions are retired
+	 * before proceeding.
+	 */
+	rmb();
 	for (i = 0; i < size; i += line_size) {
+		/*
+		 * Add a barrier to prevent speculative execution of this
+		 * loop reading beyond the end of the buffer.
+		 */
+		rmb();
 		asm volatile("mov (%0,%1,1), %%eax\n\t"
 			     :
 			     : "r" (mem_r), "r" (i)
 			     : "%eax", "memory");
 	}
 	/*
-	 * Call wrmsr directly (no tracing) to not influence
-	 * the cache access counters as they are disabled.
+	 * Use LFENCE to ensure all previous instructions are retired
+	 * before proceeding.
 	 */
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0,
-			      l2_hit_bits & ~(0x40ULL << 16));
-	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1,
-			      l2_miss_bits & ~(0x40ULL << 16));
-	if (l3_hit_bits > 0) {
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 2,
-				      l3_hit_bits & ~(0x40ULL << 16));
-		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3,
-				      l3_miss_bits & ~(0x40ULL << 16));
-	}
-	l2_hits = native_read_pmc(0);
-	l2_miss = native_read_pmc(1);
-	if (l3_hit_bits > 0) {
-		l3_hits = native_read_pmc(2);
-		l3_miss = native_read_pmc(3);
-	}
+	rmb();
+	rdpmcl(hit_pmcnum, hits_after);
+	rdpmcl(miss_pmcnum, miss_after);
+	/*
+	 * Use LFENCE to ensure all previous instructions are retired
+	 * before proceeding.
+	 */
+	rmb();
+	/* Re-enable hardware prefetchers */
 	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
 	local_irq_enable();
+out_hit:
+	perf_event_release_kernel(hit_event);
+out_miss:
+	perf_event_release_kernel(miss_event);
+out:
+	/*
+	 * All counts will be zero on failure.
+	 */
+	counts->miss_before = miss_before;
+	counts->hits_before = hits_before;
+	counts->miss_after  = miss_after;
+	counts->hits_after  = hits_after;
+	return 0;
+}
+
+static int measure_l2_residency(void *_plr)
+{
+	struct pseudo_lock_region *plr = _plr;
+	struct residency_counts counts = {0};
+
+	/*
+	 * Non-architectural event for the Goldmont Microarchitecture
+	 * from Intel x86 Architecture Software Developer Manual (SDM):
+	 * MEM_LOAD_UOPS_RETIRED D1H (event number)
+	 * Umask values:
+	 *     L2_HIT   02H
+	 *     L2_MISS  10H
+	 */
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
+		perf_miss_attr.config = X86_CONFIG(.event = 0xd1,
+						   .umask = 0x10);
+		perf_hit_attr.config = X86_CONFIG(.event = 0xd1,
+						  .umask = 0x2);
+		break;
+	default:
+		goto out;
+	}
+
+	measure_residency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);
+	/*
+	 * If a failure prevented the measurements from succeeding
+	 * tracepoints will still be written and all counts will be zero.
+	 */
+	trace_pseudo_lock_l2(counts.hits_after - counts.hits_before,
+			     counts.miss_after - counts.miss_before);
+out:
+	plr->thread_done = 1;
+	wake_up_interruptible(&plr->lock_thread_wq);
+	return 0;
+}
+
+static int measure_l3_residency(void *_plr)
+{
+	struct pseudo_lock_region *plr = _plr;
+	struct residency_counts counts = {0};
+
 	/*
-	 * On BDW we count references and misses, need to adjust. Sometimes
-	 * the "hits" counter is a bit more than the references, for
-	 * example, x references but x + 1 hits. To not report invalid
-	 * hit values in this case we treat that as misses eaqual to
-	 * references.
+	 * On Broadwell Microarchitecture the MEM_LOAD_UOPS_RETIRED event
+	 * has two "no fix" errata associated with it: BDM35 and BDM100. On
+	 * this platform the following events are used instead:
+	 * LONGEST_LAT_CACHE 2EH (Documented in SDM)
+	 *       REFERENCE 4FH
+	 *       MISS      41H
 	 */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X)
-		l2_hits -= (l2_miss > l2_hits ? l2_hits : l2_miss);
-	trace_pseudo_lock_l2(l2_hits, l2_miss);
-	if (l3_hit_bits > 0) {
-		if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X)
-			l3_hits -= (l3_miss > l3_hits ? l3_hits : l3_miss);
-		trace_pseudo_lock_l3(l3_hits, l3_miss);
+
+	switch (boot_cpu_data.x86_model) {
+	case INTEL_FAM6_BROADWELL_X:
+		/* On BDW the hit event counts references, not hits */
+		perf_hit_attr.config = X86_CONFIG(.event = 0x2e,
+						  .umask = 0x4f);
+		perf_miss_attr.config = X86_CONFIG(.event = 0x2e,
+						   .umask = 0x41);
+		break;
+	default:
+		goto out;
+	}
+
+	measure_residency_fn(&perf_miss_attr, &perf_hit_attr, plr, &counts);
+	/*
+	 * If a failure prevented the measurements from succeeding
+	 * tracepoints will still be written and all counts will be zero.
+	 */
+
+	counts.miss_after -= counts.miss_before;
+	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X) {
+		/*
+		 * On BDW references and misses are counted, need to adjust.
+		 * Sometimes the "hits" counter is a bit more than the
+		 * references, for example, x references but x + 1 hits.
+		 * To not report invalid hit values in this case we treat
+		 * that as misses equal to references.
+		 */
+		/* First compute the number of cache references measured */
+		counts.hits_after -= counts.hits_before;
+		/* Next convert references to cache hits */
+		counts.hits_after -= min(counts.miss_after, counts.hits_after);
+	} else {
+		counts.hits_after -= counts.hits_before;
 	}
 
+	trace_pseudo_lock_l3(counts.hits_after, counts.miss_after);
 out:
 	plr->thread_done = 1;
 	wake_up_interruptible(&plr->lock_thread_wq);
@@ -1112,13 +1179,20 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 		goto out;
 	}
 
+	plr->cpu = cpu;
+
 	if (sel == 1)
 		thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
 						cpu_to_node(cpu),
 						"pseudo_lock_measure/%u",
 						cpu);
 	else if (sel == 2)
-		thread = kthread_create_on_node(measure_cycles_perf_fn, plr,
+		thread = kthread_create_on_node(measure_l2_residency, plr,
+						cpu_to_node(cpu),
+						"pseudo_lock_measure/%u",
+						cpu);
+	else if (sel == 3)
+		thread = kthread_create_on_node(measure_l3_residency, plr,
 						cpu_to_node(cpu),
 						"pseudo_lock_measure/%u",
 						cpu);
