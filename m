Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438DF2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438DF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbeIYAlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:41:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36356 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeIYAlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:41:47 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4VkD-0002qj-P8; Mon, 24 Sep 2018 14:38:05 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, songliubraving@fb.com,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, npiggin@gmail.com,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de
Subject: [PATCH 2/7] x86/mm/tlb: Restructure switch_mm_irqs_off()
Date:   Mon, 24 Sep 2018 14:37:54 -0400
Message-Id: <20180924183759.23955-3-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924183759.23955-1-riel@surriel.com>
References: <20180924183759.23955-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some code that will be needed for the lazy -> !lazy state
transition when a lazy TLB CPU has gotten out of date.

No functional changes, since the if (real_prev == next) branch
always returns.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: efault@gmx.de
Cc: kernel-team@fb.com
Link: http://lkml.kernel.org/r/20180716190337.26133-4-riel@surriel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
(cherry picked from commit 61d0beb5796ab11f7f3bf38cb2eccc6579aaa70b)
---
 arch/x86/mm/tlb.c | 87 +++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d19f424073d9..ac05d61cc90e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -158,6 +158,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
+	bool need_flush;
+	u16 new_asid;
 
 	/*
 	 * NB: The scheduler will call us with prev == next when switching
@@ -217,8 +219,27 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 		return;
 	} else {
-		u16 new_asid;
-		bool need_flush;
+		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
+
+		/*
+		 * Avoid user/user BTB poisoning by flushing the branch
+		 * predictor when switching between processes. This stops
+		 * one process from doing Spectre-v2 attacks on another.
+		 *
+		 * As an optimization, flush indirect branches only when
+		 * switching into processes that disable dumping. This
+		 * protects high value processes like gpg, without having
+		 * too high performance overhead. IBPB is *expensive*!
+		 *
+		 * This will not flush branches when switching into kernel
+		 * threads. It will also not flush if we switch to idle
+		 * thread and back to the same process. It will flush if we
+		 * switch to a different non-dumpable process.
+		 */
+		if (tsk && tsk->mm &&
+		    tsk->mm->context.ctx_id != last_ctx_id &&
+		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+			indirect_branch_prediction_barrier();
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
@@ -249,44 +270,44 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		/* Let nmi_uaccess_okay() know that we're changing CR3. */
 		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
+	}
 
-		if (need_flush) {
-			this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
-			this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
-			load_new_mm_cr3(next->pgd, new_asid, true);
-
-			/*
-			 * NB: This gets called via leave_mm() in the idle path
-			 * where RCU functions differently.  Tracing normally
-			 * uses RCU, so we need to use the _rcuidle variant.
-			 *
-			 * (There is no good reason for this.  The idle code should
-			 *  be rearranged to call this before rcu_idle_enter().)
-			 */
-			trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
-		} else {
-			/* The new ASID is already up to date. */
-			load_new_mm_cr3(next->pgd, new_asid, false);
-
-			/* See above wrt _rcuidle. */
-			trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
-		}
+	if (need_flush) {
+		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
+		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
+		load_new_mm_cr3(next->pgd, new_asid, true);
 
 		/*
-		 * Record last user mm's context id, so we can avoid
-		 * flushing branch buffer with IBPB if we switch back
-		 * to the same user.
+		 * NB: This gets called via leave_mm() in the idle path
+		 * where RCU functions differently.  Tracing normally
+		 * uses RCU, so we need to use the _rcuidle variant.
+		 *
+		 * (There is no good reason for this.  The idle code should
+		 *  be rearranged to call this before rcu_idle_enter().)
 		 */
-		if (next != &init_mm)
-			this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
-
-		/* Make sure we write CR3 before loaded_mm. */
-		barrier();
+		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
+	} else {
+		/* The new ASID is already up to date. */
+		load_new_mm_cr3(next->pgd, new_asid, false);
 
-		this_cpu_write(cpu_tlbstate.loaded_mm, next);
-		this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+		/* See above wrt _rcuidle. */
+		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
+	/*
+	 * Record last user mm's context id, so we can avoid
+	 * flushing branch buffer with IBPB if we switch back
+	 * to the same user.
+	 */
+	if (next != &init_mm)
+		this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
+
+	/* Make sure we write CR3 before loaded_mm. */
+	barrier();
+
+	this_cpu_write(cpu_tlbstate.loaded_mm, next);
+	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+
 	load_mm_cr4(next);
 	switch_ldt(real_prev, next);
 }
-- 
2.17.1

