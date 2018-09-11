Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E0C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7C62086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7C62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeIKWPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:31120 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeIKWPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="79642211"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2018 10:14:58 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 3/6] x86/intel_rdt: Remove local register variables
Date:   Tue, 11 Sep 2018 10:14:34 -0700
Message-Id: <715bd9e15454c7a5bf8f39ed6d1687ff6249b3ec.1536685533.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local register variables were used in an effort to improve the
accuracy of the measurement of cache residency of a pseudo-locked
region. This was done to ensure that only the cache residency of
the memory is measured and not the cache residency of the variables
used to perform the measurement.

While local register variables do accomplish the goal they do require
significant care since different architectures have different registers
available. Local register variables also cannot be used with valuable
developer tools like KASAN.

Significant testing has shown that similar accuracy in measurement
results can be obtained by replacing local register variables with
regular local variables.

Make use of local variables in the critical code but do so with
READ_ONCE() to prevent the compiler from merging or refetching reads.
Ensure these variables are initialized before the measurement starts,
and ensure it is only the local variables that are accessed during
the measurement.

With the removal of the local register variables and using READ_ONCE()
there is no longer a motivation for using a direct wrmsr call (that
avoids the additional tracing code that may clobber the local register
variables).

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 53 ++++-----------------
 1 file changed, 9 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 40f3903ae5d9..8ad83eb3fc89 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -886,31 +886,14 @@ static int measure_cycles_lat_fn(void *_plr)
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long i;
 	u64 start, end;
-#ifdef CONFIG_KASAN
-	/*
-	 * The registers used for local register variables are also used
-	 * when KASAN is active. When KASAN is active we use a regular
-	 * variable to ensure we always use a valid pointer to access memory.
-	 * The cost is that accessing this pointer, which could be in
-	 * cache, will be included in the measurement of memory read latency.
-	 */
 	void *mem_r;
-#else
-#ifdef CONFIG_X86_64
-	register void *mem_r asm("rbx");
-#else
-	register void *mem_r asm("ebx");
-#endif /* CONFIG_X86_64 */
-#endif /* CONFIG_KASAN */
 
 	local_irq_disable();
 	/*
-	 * The wrmsr call may be reordered with the assignment below it.
-	 * Call wrmsr as directly as possible to avoid tracing clobbering
-	 * local register variable used for memory pointer.
+	 * Disable hardware prefetchers.
 	 */
-	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
-	mem_r = plr->kmem;
+	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	mem_r = READ_ONCE(plr->kmem);
 	/*
 	 * Dummy execute of the time measurement to load the needed
 	 * instructions into the L1 instruction cache.
@@ -939,26 +922,10 @@ static int measure_cycles_perf_fn(void *_plr)
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long long l2_hits, l2_miss;
 	u64 l2_hit_bits, l2_miss_bits;
-	unsigned long i;
-#ifdef CONFIG_KASAN
-	/*
-	 * The registers used for local register variables are also used
-	 * when KASAN is active. When KASAN is active we use regular variables
-	 * at the cost of including cache access latency to these variables
-	 * in the measurements.
-	 */
 	unsigned int line_size;
 	unsigned int size;
+	unsigned long i;
 	void *mem_r;
-#else
-	register unsigned int line_size asm("esi");
-	register unsigned int size asm("edi");
-#ifdef CONFIG_X86_64
-	register void *mem_r asm("rbx");
-#else
-	register void *mem_r asm("ebx");
-#endif /* CONFIG_X86_64 */
-#endif /* CONFIG_KASAN */
 
 	/*
 	 * Non-architectural event for the Goldmont Microarchitecture
@@ -1011,11 +978,9 @@ static int measure_cycles_perf_fn(void *_plr)
 
 	local_irq_disable();
 	/*
-	 * Call wrmsr direcly to avoid the local register variables from
-	 * being overwritten due to reordering of their assignment with
-	 * the wrmsr calls.
+	 * Disable hardware prefetchers.
 	 */
-	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
 	/* Disable events and reset counters */
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0, 0x0);
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, 0x0);
@@ -1028,6 +993,9 @@ static int measure_cycles_perf_fn(void *_plr)
 		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_PERFCTR0 + 3, 0x0);
 	}
 	/* Set and enable the L2 counters */
+	mem_r = READ_ONCE(plr->kmem);
+	size = READ_ONCE(plr->size);
+	line_size = READ_ONCE(plr->line_size);
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0, l2_hit_bits);
 	pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 1, l2_miss_bits);
 	if (l3_hit_bits > 0) {
@@ -1036,9 +1004,6 @@ static int measure_cycles_perf_fn(void *_plr)
 		pseudo_wrmsrl_notrace(MSR_ARCH_PERFMON_EVENTSEL0 + 3,
 				      l3_miss_bits);
 	}
-	mem_r = plr->kmem;
-	size = plr->size;
-	line_size = plr->line_size;
 	for (i = 0; i < size; i += line_size) {
 		asm volatile("mov (%0,%1,1), %%eax\n\t"
 			     :
-- 
2.17.0

