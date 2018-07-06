Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E51C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A816622ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A816622ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeGFV6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:58:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35320 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932810AbeGFV5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:57:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbYir-0003ql-QJ; Fri, 06 Jul 2018 17:57:01 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com, hpa@zytor.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 3/7] x86,mm: restructure switch_mm_irqs_off
Date:   Fri,  6 Jul 2018 17:56:54 -0400
Message-Id: <20180706215658.18018-4-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706215658.18018-1-riel@surriel.com>
References: <20180706215658.18018-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some code that will be needed for the lazy -> !lazy state
transition when a lazy TLB CPU has gotten out of date.

No functional changes, since the if (real_prev == next) branch
always returns.

Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/tlb.c | 60 +++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9a893673c56b..4b73fe835c95 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -187,6 +187,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
+	bool need_flush;
+	u16 new_asid;
 
 	/*
 	 * NB: The scheduler will call us with prev == next when switching
@@ -252,8 +254,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 		return;
 	} else {
-		u16 new_asid;
-		bool need_flush;
 		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
 
 		/*
@@ -297,41 +297,41 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
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
+	this_cpu_write(cpu_tlbstate.loaded_mm, next);
+	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+
 	load_mm_cr4(next);
 	switch_ldt(real_prev, next);
 }
-- 
2.14.4

