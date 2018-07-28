Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7815FECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4B820893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4B820893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeG1XWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:22:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44186 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbeG1XWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:22:21 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjXA0-0000QZ-Mr; Sat, 28 Jul 2018 17:54:00 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, luto@kernel.org,
        x86@kernel.org, vkuznets@redhat.com, mingo@kernel.org,
        efault@gmx.de, dave.hansen@intel.com, will.daecon@arm.com,
        catalin.marinas@arm.com, benh@kernel.crashing.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 04/10] x86,mm: use on_each_cpu_cond for TLB flushes
Date:   Sat, 28 Jul 2018 17:53:51 -0400
Message-Id: <20180728215357.3249-5-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180728215357.3249-1-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding bitmap magic, use on_each_cpu_cond
to determine which CPUs to send TLB flush IPIs to.

This might be a little bit slower than examining the bitmaps,
but it should be a lot easier to maintain in the long run.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c | 75 +++++++++++--------------------------------------------
 1 file changed, 15 insertions(+), 60 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5321e02c4e09..671cc66df801 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -582,12 +582,19 @@ static void flush_tlb_func_remote(void *info)
 	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
 }
 
+static bool tlb_is_lazy(int cpu, void *data)
+{
+	return per_cpu(cpu_tlbstate.is_lazy, cpu);
+}
+
+static bool tlb_is_not_lazy(int cpu, void *data)
+{
+	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
+}
+
 void native_flush_tlb_others(const struct cpumask *cpumask,
 			     const struct flush_tlb_info *info)
 {
-	cpumask_var_t lazymask;
-	unsigned int cpu;
-
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	if (info->end == TLB_FLUSH_ALL)
 		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
@@ -596,6 +603,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 				(info->end - info->start) >> PAGE_SHIFT);
 
 	if (is_uv_system()) {
+		unsigned int cpu;
 		/*
 		 * This whole special case is confused.  UV has a "Broadcast
 		 * Assist Unit", which seems to be a fancy way to send IPIs.
@@ -619,28 +627,8 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		return;
 	}
 
-	/*
-	 * A temporary cpumask is used in order to skip sending IPIs
-	 * to CPUs in lazy TLB state, while keeping them in mm_cpumask(mm).
-	 * If the allocation fails, simply IPI every CPU in mm_cpumask.
-	 */
-	if (!alloc_cpumask_var(&lazymask, GFP_ATOMIC)) {
-		smp_call_function_many(cpumask, flush_tlb_func_remote,
-			       (void *)info, 1);
-		return;
-	}
-
-	cpumask_copy(lazymask, cpumask);
-
-	for_each_cpu(cpu, lazymask) {
-		if (per_cpu(cpu_tlbstate.is_lazy, cpu))
-			cpumask_clear_cpu(cpu, lazymask);
-	}
-
-	smp_call_function_many(lazymask, flush_tlb_func_remote,
-			       (void *)info, 1);
-
-	free_cpumask_var(lazymask);
+	on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
+			      (void *)info, 1, GFP_ATOMIC, cpumask);
 }
 
 /*
@@ -709,50 +697,17 @@ void tlb_flush_remove_tables_local(void *arg)
 	}
 }
 
-static void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm,
-				      struct cpumask *lazy_cpus)
-{
-	int cpu;
-
-	for_each_cpu(cpu, mm_cpumask(mm)) {
-		if (!per_cpu(cpu_tlbstate.is_lazy, cpu))
-			cpumask_set_cpu(cpu, lazy_cpus);
-	}
-}
-
 void tlb_flush_remove_tables(struct mm_struct *mm)
 {
 	int cpu = get_cpu();
-	cpumask_var_t lazy_cpus;
 
 	if (cpumask_any_but(mm_cpumask(mm), cpu) >= nr_cpu_ids) {
 		put_cpu();
 		return;
 	}
 
-	if (!zalloc_cpumask_var(&lazy_cpus, GFP_ATOMIC)) {
-		/*
-		 * If the cpumask allocation fails, do a brute force flush
-		 * on all the CPUs that have this mm loaded.
-		 */
-		smp_call_function_many(mm_cpumask(mm),
-				tlb_flush_remove_tables_local, (void *)mm, 1);
-		put_cpu();
-		return;
-	}
-
-	/*
-	 * CPUs with !is_lazy either received a TLB flush IPI while the user
-	 * pages in this address range were unmapped, or have context switched
-	 * and reloaded %CR3 since then.
-	 *
-	 * Shootdown IPIs at page table freeing time only need to be sent to
-	 * CPUs that may have out of date TLB contents.
-	 */
-	mm_fill_lazy_tlb_cpu_mask(mm, lazy_cpus);
-	smp_call_function_many(lazy_cpus,
-				tlb_flush_remove_tables_local, (void *)mm, 1);
-	free_cpumask_var(lazy_cpus);
+	on_each_cpu_cond_mask(tlb_is_lazy, tlb_flush_remove_tables_local,
+			      (void *)mm, 1, GFP_ATOMIC, mm_cpumask(mm));
 	put_cpu();
 }
 
-- 
2.14.4

