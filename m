Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A660221477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A660221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeHPXSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:18:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:43390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeHPXSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:18:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 13:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="225248291"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2018 13:16:34 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 5/6] x86/intel_rdt: Use perf infrastructure for measurements
Date:   Thu, 16 Aug 2018 13:16:08 -0700
Message-Id: <30b32ebd826023ab88f3ab3122e4c414ea532722.1534450299.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 Documentation/x86/intel_rdt_ui.txt          |  22 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 342 ++++++++++++++------
 2 files changed, 258 insertions(+), 106 deletions(-)

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
index 20b76024701d..aa27e8081bae 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -26,6 +26,7 @@
 #include <asm/intel_rdt_sched.h>
 #include <asm/perf_event.h>
 
+#include "../../events/perf_event.h" /* For X86_CONFIG() */
 #include "intel_rdt.h"
 
 #define CREATE_TRACE_POINTS
@@ -106,16 +107,6 @@ static u64 get_prefetch_disable_bits(void)
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
@@ -926,7 +917,7 @@ static int measure_cycles_lat_fn(void *_plr)
  * The actual configuration of the event is set right before use in order
  * to use the X86_CONFIG macro.
  */
-static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
+static struct perf_event_attr perf_miss_attr = {
 	.type		= PERF_TYPE_RAW,
 	.size		= sizeof(struct perf_event_attr),
 	.pinned		= 1,
@@ -934,7 +925,7 @@ static struct perf_event_attr __attribute__((unused)) perf_miss_attr = {
 	.exclude_user	= 1,
 };
 
-static struct perf_event_attr __attribute__((unused)) perf_hit_attr = {
+static struct perf_event_attr perf_hit_attr = {
 	.type		= PERF_TYPE_RAW,
 	.size		= sizeof(struct perf_event_attr),
 	.pinned		= 1,
@@ -963,141 +954,289 @@ static inline int x86_perf_rdpmc_ctr_get(struct perf_event *event)
 	return IS_ERR_OR_NULL(event) ? -1 : event->hw.event_base_rdpmc;
 }
 
-static int measure_cycles_perf_fn(void *_plr)
+static int measure_l2_residency_fn(void *_plr)
 {
-	unsigned long long l3_hits = 0, l3_miss = 0;
-	u64 l3_hit_bits = 0, l3_miss_bits = 0;
+	u64 l2_hits_before, l2_hits_after, l2_miss_before, l2_miss_after;
+	struct perf_event *l2_miss_event, *l2_hit_event;
 	struct pseudo_lock_region *plr = _plr;
-	unsigned long long l2_hits, l2_miss;
-	u64 l2_hit_bits, l2_miss_bits;
+	int l2_hit_pmcnum, l2_miss_pmcnum;
 	unsigned int line_size;
 	unsigned int size;
 	unsigned long i;
 	void *mem_r;
+	u64 tmp;
 
 	/*
 	 * Non-architectural event for the Goldmont Microarchitecture
 	 * from Intel x86 Architecture Software Developer Manual (SDM):
 	 * MEM_LOAD_UOPS_RETIRED D1H (event number)
 	 * Umask values:
-	 *     L1_HIT   01H
 	 *     L2_HIT   02H
-	 *     L1_MISS  08H
 	 *     L2_MISS  10H
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
+	l2_miss_event = perf_event_create_kernel_counter(&perf_miss_attr,
+							 plr->cpu,
+							 NULL, NULL, NULL);
+	if (IS_ERR(l2_miss_event))
+		goto out;
+
+	l2_hit_event = perf_event_create_kernel_counter(&perf_hit_attr,
+							plr->cpu,
+							NULL, NULL, NULL);
+	if (IS_ERR(l2_hit_event))
+		goto out_l2_miss;
+
+	local_irq_disable();
+	/*
+	 * Check any possible error state of events used by performing
+	 * one local read.
+	 */
+	if (perf_event_read_local(l2_miss_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_l2_hit;
+	}
+	if (perf_event_read_local(l2_hit_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_l2_hit;
+	}
+
+	/*
+	 * Disable hardware prefetchers.
 	 *
+	 * Call wrmsr direcly to avoid the local register variables from
+	 * being overwritten due to reordering of their assignment with
+	 * the wrmsr calls.
+	 */
+	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+
+	/* Initialize rest of local variables */
+	/*
+	 * Performance event has been validated right before this with
+	 * interrupts disabled - it is thus safe to read the counter index.
+	 */
+	l2_miss_pmcnum = x86_perf_rdpmc_ctr_get(l2_miss_event);
+	l2_hit_pmcnum = x86_perf_rdpmc_ctr_get(l2_hit_event);
+	line_size = plr->line_size;
+	mem_r = plr->kmem;
+	size = plr->size;
+
+	/*
+	 * Read counter variables twice - first to load the instructions
+	 * used in L1 cache, second to capture accurate value that does not
+	 * include cache misses incurred because of instruction loads.
+	 */
+	rdpmcl(l2_hit_pmcnum, l2_hits_before);
+	rdpmcl(l2_miss_pmcnum, l2_miss_before);
+	/*
+	 * From SDM: Performing back-to-back fast reads are not guaranteed
+	 * to be monotonic. To guarantee monotonicity on back-toback reads,
+	 * a serializing instruction must be placed between the two
+	 * RDPMC instructions
+	 */
+	rmb();
+	rdpmcl(l2_hit_pmcnum, l2_hits_before);
+	rdpmcl(l2_miss_pmcnum, l2_miss_before);
+	/*
+	 * rdpmc is not a serializing instruction. Add barrier to prevent
+	 * instructions that follow to begin executing before reading the
+	 * counter value.
+	 */
+	rmb();
+	for (i = 0; i < size; i += line_size) {
+		/*
+		 * Add a barrier to prevent speculative execution of this
+		 * loop reading beyond the end of the buffer.
+		 */
+		rmb();
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			     :
+			     : "r" (mem_r), "r" (i)
+			     : "%eax", "memory");
+	}
+	rdpmcl(l2_hit_pmcnum, l2_hits_after);
+	rdpmcl(l2_miss_pmcnum, l2_miss_after);
+	/*
+	 * rdpmc is not a serializing instruction. Add barrier to ensure
+	 * events measured have completed and prevent instructions that
+	 * follow to begin executing before reading the counter value.
+	 */
+	rmb();
+	/* Re-enable hardware prefetchers */
+	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	local_irq_enable();
+	trace_pseudo_lock_l2(l2_hits_after - l2_hits_before,
+			     l2_miss_after - l2_miss_before);
+
+out_l2_hit:
+	perf_event_release_kernel(l2_hit_event);
+out_l2_miss:
+	perf_event_release_kernel(l2_miss_event);
+out:
+	plr->thread_done = 1;
+	wake_up_interruptible(&plr->lock_thread_wq);
+	return 0;
+}
+
+static int measure_l3_residency_fn(void *_plr)
+{
+	u64 l3_hits_before, l3_hits_after, l3_miss_before, l3_miss_after;
+	struct perf_event *l3_miss_event, *l3_hit_event;
+	struct pseudo_lock_region *plr = _plr;
+	int l3_hit_pmcnum, l3_miss_pmcnum;
+	unsigned int line_size;
+	unsigned int size;
+	unsigned long i;
+	void *mem_r;
+	u64 tmp;
+
+	/*
 	 * On Broadwell Microarchitecture the MEM_LOAD_UOPS_RETIRED event
 	 * has two "no fix" errata associated with it: BDM35 and BDM100. On
-	 * this platform we use the following events instead:
-	 *  L2_RQSTS 24H (Documented in https://download.01.org/perfmon/BDW/)
-	 *       REFERENCES FFH
-	 *       MISS       3FH
-	 *  LONGEST_LAT_CACHE 2EH (Documented in SDM)
+	 * this platform the following events are used instead:
+	 * LONGEST_LAT_CACHE 2EH (Documented in SDM)
 	 *       REFERENCE 4FH
 	 *       MISS      41H
 	 */
 
-	/*
-	 * Start by setting flags for IA32_PERFEVTSELx:
-	 *     OS  (Operating system mode)  0x2
-	 *     INT (APIC interrupt enable)  0x10
-	 *     EN  (Enable counter)         0x40
-	 *
-	 * Then add the Umask value and event number to select performance
-	 * event.
-	 */
-
 	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_ATOM_GOLDMONT:
-	case INTEL_FAM6_ATOM_GEMINI_LAKE:
-		l2_hit_bits = (0x52ULL << 16) | (0x2 << 8) | 0xd1;
-		l2_miss_bits = (0x52ULL << 16) | (0x10 << 8) | 0xd1;
-		break;
 	case INTEL_FAM6_BROADWELL_X:
-		/* On BDW the l2_hit_bits count references, not hits */
-		l2_hit_bits = (0x52ULL << 16) | (0xff << 8) | 0x24;
-		l2_miss_bits = (0x52ULL << 16) | (0x3f << 8) | 0x24;
 		/* On BDW the l3_hit_bits count references, not hits */
-		l3_hit_bits = (0x52ULL << 16) | (0x4f << 8) | 0x2e;
-		l3_miss_bits = (0x52ULL << 16) | (0x41 << 8) | 0x2e;
+		perf_hit_attr.config = X86_CONFIG(.event = 0x2e,
+						  .umask = 0x4f);
+		perf_miss_attr.config = X86_CONFIG(.event = 0x2e,
+						   .umask = 0x41);
 		break;
 	default:
 		goto out;
 	}
 
+	l3_miss_event = perf_event_create_kernel_counter(&perf_miss_attr,
+							 plr->cpu,
+							 NULL, NULL,
+							 NULL);
+	if (IS_ERR(l3_miss_event))
+		goto out;
+
+	l3_hit_event = perf_event_create_kernel_counter(&perf_hit_attr,
+							plr->cpu,
+							NULL, NULL,
+							NULL);
+	if (IS_ERR(l3_hit_event))
+		goto out_l3_miss;
+
 	local_irq_disable();
 	/*
+	 * Check any possible error state of events used by performing
+	 * one local read.
+	 */
+	if (perf_event_read_local(l3_miss_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_l3_hit;
+	}
+	if (perf_event_read_local(l3_hit_event, &tmp, NULL, NULL)) {
+		local_irq_enable();
+		goto out_l3_hit;
+	}
+
+	/*
+	 * Disable hardware prefetchers.
+	 *
 	 * Call wrmsr direcly to avoid the local register variables from
 	 * being overwritten due to reordering of their assignment with
 	 * the wrmsr calls.
 	 */
 	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
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
+	l3_hit_pmcnum = x86_perf_rdpmc_ctr_get(l3_hit_event);
+	l3_miss_pmcnum = x86_perf_rdpmc_ctr_get(l3_miss_event);
+	line_size = plr->line_size;
 	mem_r = plr->kmem;
 	size = plr->size;
-	line_size = plr->line_size;
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
+	rdpmcl(l3_hit_pmcnum, l3_hits_before);
+	rdpmcl(l3_miss_pmcnum, l3_miss_before);
+	/*
+	 * From SDM: Performing back-to-back fast reads are not guaranteed
+	 * to be monotonic. To guarantee monotonicity on back-toback reads,
+	 * a serializing instruction must be placed between the two
+	 * RDPMC instructions
+	 */
+	rmb();
+	rdpmcl(l3_hit_pmcnum, l3_hits_before);
+	rdpmcl(l3_miss_pmcnum, l3_miss_before);
+	/*
+	 * rdpmc is not a serializing instruction. Add barrier to prevent
+	 * instructions that follow to begin executing before reading the
+	 * counter value.
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
+	rdpmcl(l3_hit_pmcnum, l3_hits_after);
+	rdpmcl(l3_miss_pmcnum, l3_miss_after);
 	/*
-	 * Call wrmsr directly (no tracing) to not influence
-	 * the cache access counters as they are disabled.
+	 * rdpmc is not a serializing instruction. Add barrier to ensure
+	 * events measured have completed and prevent instructions that
+	 * follow to begin executing before reading the counter value.
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
+	/* Re-enable hardware prefetchers */
 	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
 	local_irq_enable();
-	/*
-	 * On BDW we count references and misses, need to adjust. Sometimes
-	 * the "hits" counter is a bit more than the references, for
-	 * example, x references but x + 1 hits. To not report invalid
-	 * hit values in this case we treat that as misses eaqual to
-	 * references.
-	 */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X)
-		l2_hits -= (l2_miss > l2_hits ? l2_hits : l2_miss);
-	trace_pseudo_lock_l2(l2_hits, l2_miss);
-	if (l3_hit_bits > 0) {
-		if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X)
-			l3_hits -= (l3_miss > l3_hits ? l3_hits : l3_miss);
-		trace_pseudo_lock_l3(l3_hits, l3_miss);
+	l3_miss_after -= l3_miss_before;
+	if (boot_cpu_data.x86_model == INTEL_FAM6_BROADWELL_X) {
+		/*
+		 * On BDW references and misses are counted, need to adjust.
+		 * Sometimes the "hits" counter is a bit more than the
+		 * references, for example, x references but x + 1 hits.
+		 * To not report invalid hit values in this case we treat
+		 * that as misses equal to references.
+		 */
+		/* First compute the number of cache references measured */
+		l3_hits_after -= l3_hits_before;
+		/* Next convert references to cache hits */
+		l3_hits_after -= l3_miss_after > l3_hits_after ?
+					l3_hits_after : l3_miss_after;
+	} else {
+		l3_hits_after -= l3_hits_before;
 	}
+	trace_pseudo_lock_l3(l3_hits_after, l3_miss_after);
 
+out_l3_hit:
+	perf_event_release_kernel(l3_hit_event);
+out_l3_miss:
+	perf_event_release_kernel(l3_miss_event);
 out:
 	plr->thread_done = 1;
 	wake_up_interruptible(&plr->lock_thread_wq);
@@ -1136,13 +1275,20 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
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
+		thread = kthread_create_on_node(measure_l2_residency_fn, plr,
+						cpu_to_node(cpu),
+						"pseudo_lock_measure/%u",
+						cpu);
+	else if (sel == 3)
+		thread = kthread_create_on_node(measure_l3_residency_fn, plr,
 						cpu_to_node(cpu),
 						"pseudo_lock_measure/%u",
 						cpu);
-- 
2.17.0

