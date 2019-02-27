Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C656C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FFE20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXSKKf++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfB0KQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:16:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfB0KQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I+6wGC8zVIq05ae93Q9chpbJ6fG/Vzq3uh70vDJ9/MU=; b=fXSKKf++FcI9Bp/7h1AX5fsMiw
        Z1UxLFldtVI/jTWNQV6GmR7ODue6WAByxVnRi9qD3ArnGUkxf2SX8oSeYaVsumBN3WmSCt0jk9Yvd
        Kr45w8fBb6wCakuy0myhVFU2P5sp8N7Vf/qZ0Yqu6415s+0cp1FlWViimDYl6sToGycH1nTOCh9O6
        kmc7TQsarN9ASCFs5ecVCrHDcFGJPpB/gih6wJQqYoneoQGtRL0wVa8sa0BhCUECvsjATEcIMKMDF
        cCKHCgOzaOYTyjVV8aHNg6lLuIhLsQlLQ6e8r0Xy9RtIPb43q3FDvunkKp69IqmuW1qKz2St3OfNi
        HoaM0OrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gywGO-0007nr-Je; Wed, 27 Feb 2019 10:16:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1180128524772; Wed, 27 Feb 2019 11:16:29 +0100 (CET)
Message-Id: <20190227101544.485731815@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 27 Feb 2019 11:12:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 4/5] x86/percpu, x86/tlb: Relax cpu_tlbstate accesses
References: <20190227101252.413192716@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all of this is ran with IRQs disabled and therefore doesn't
need the extra constraints on the this_cpu_*() ops, use __this_cpu_*()
to alleviate this.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/tlb.c |   62 +++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -58,15 +58,15 @@ static void clear_asid_other(void)
 
 	for (asid = 0; asid < TLB_NR_DYN_ASIDS; asid++) {
 		/* Do not need to flush the current asid */
-		if (asid == this_cpu_read(cpu_tlbstate.loaded_mm_asid))
+		if (asid == __this_cpu_read(cpu_tlbstate.loaded_mm_asid))
 			continue;
 		/*
 		 * Make sure the next time we go to switch to
 		 * this asid, we do a flush:
 		 */
-		this_cpu_write(cpu_tlbstate.ctxs[asid].ctx_id, 0);
+		__this_cpu_write(cpu_tlbstate.ctxs[asid].ctx_id, 0);
 	}
-	this_cpu_write(cpu_tlbstate.invalidate_other, false);
+	__this_cpu_write(cpu_tlbstate.invalidate_other, false);
 }
 
 atomic64_t last_mm_ctx_id = ATOMIC64_INIT(1);
@@ -83,16 +83,16 @@ static void choose_new_asid(struct mm_st
 		return;
 	}
 
-	if (this_cpu_read(cpu_tlbstate.invalidate_other))
+	if (__this_cpu_read(cpu_tlbstate.invalidate_other))
 		clear_asid_other();
 
 	for (asid = 0; asid < TLB_NR_DYN_ASIDS; asid++) {
-		if (this_cpu_read(cpu_tlbstate.ctxs[asid].ctx_id) !=
+		if (__this_cpu_read(cpu_tlbstate.ctxs[asid].ctx_id) !=
 		    next->context.ctx_id)
 			continue;
 
 		*new_asid = asid;
-		*need_flush = (this_cpu_read(cpu_tlbstate.ctxs[asid].tlb_gen) <
+		*need_flush = (__this_cpu_read(cpu_tlbstate.ctxs[asid].tlb_gen) <
 			       next_tlb_gen);
 		return;
 	}
@@ -101,10 +101,10 @@ static void choose_new_asid(struct mm_st
 	 * We don't currently own an ASID slot on this CPU.
 	 * Allocate a slot.
 	 */
-	*new_asid = this_cpu_add_return(cpu_tlbstate.next_asid, 1) - 1;
+	*new_asid = __this_cpu_add_return(cpu_tlbstate.next_asid, 1) - 1;
 	if (*new_asid >= TLB_NR_DYN_ASIDS) {
 		*new_asid = 0;
-		this_cpu_write(cpu_tlbstate.next_asid, 1);
+		__this_cpu_write(cpu_tlbstate.next_asid, 1);
 	}
 	*need_flush = true;
 }
@@ -245,7 +245,7 @@ static void cond_ibpb(struct task_struct
 		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
 		 */
 		next_mm = mm_mangle_tif_spec_ib(next);
-		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
+		prev_mm = __this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
 
 		/*
 		 * Issue IBPB only if the mm's are different and one or
@@ -255,7 +255,7 @@ static void cond_ibpb(struct task_struct
 		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
 
-		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
+		__this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
 
 	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
@@ -264,9 +264,9 @@ static void cond_ibpb(struct task_struct
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
+		if (__this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
 			indirect_branch_prediction_barrier();
-			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
+			__this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
 		}
 	}
 }
@@ -274,9 +274,9 @@ static void cond_ibpb(struct task_struct
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
-	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
-	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
+	struct mm_struct *real_prev = __this_cpu_read(cpu_tlbstate.loaded_mm);
+	u16 prev_asid = __this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	bool was_lazy = __this_cpu_read(cpu_tlbstate.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
 	bool need_flush;
@@ -321,7 +321,7 @@ void switch_mm_irqs_off(struct mm_struct
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate.is_lazy, false);
+	__this_cpu_write(cpu_tlbstate.is_lazy, false);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
@@ -330,7 +330,7 @@ void switch_mm_irqs_off(struct mm_struct
 	 * memory barrier and core serializing instruction.
 	 */
 	if (real_prev == next) {
-		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
+		VM_WARN_ON(__this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
 		/*
@@ -358,7 +358,7 @@ void switch_mm_irqs_off(struct mm_struct
 		 */
 		smp_mb();
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
-		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
+		if (__this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
 				next_tlb_gen)
 			return;
 
@@ -406,13 +406,13 @@ void switch_mm_irqs_off(struct mm_struct
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
 		/* Let nmi_uaccess_okay() know that we're changing CR3. */
-		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		__this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
 	}
 
 	if (need_flush) {
-		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
-		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
+		__this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
+		__this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, new_asid, true);
 
 		/*
@@ -435,8 +435,8 @@ void switch_mm_irqs_off(struct mm_struct
 	/* Make sure we write CR3 before loaded_mm. */
 	barrier();
 
-	this_cpu_write(cpu_tlbstate.loaded_mm, next);
-	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	__this_cpu_write(cpu_tlbstate.loaded_mm, next);
+	__this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 
 	if (next != real_prev) {
 		load_mm_cr4(next);
@@ -529,10 +529,10 @@ static void flush_tlb_func_common(const
 	 * - f->new_tlb_gen: the generation that the requester of the flush
 	 *                   wants us to catch up to.
 	 */
-	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	struct mm_struct *loaded_mm = __this_cpu_read(cpu_tlbstate.loaded_mm);
+	u32 loaded_mm_asid = __this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
-	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	u64 local_tlb_gen = __this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
 
 	/* This code cannot presently handle being reentered. */
 	VM_WARN_ON(!irqs_disabled());
@@ -540,10 +540,10 @@ static void flush_tlb_func_common(const
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
-	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
+	VM_WARN_ON(__this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
-	if (this_cpu_read(cpu_tlbstate.is_lazy)) {
+	if (__this_cpu_read(cpu_tlbstate.is_lazy)) {
 		/*
 		 * We're in lazy mode.  We need to at least flush our
 		 * paging-structure cache to avoid speculatively reading
@@ -631,7 +631,7 @@ static void flush_tlb_func_common(const
 	}
 
 	/* Both paths above update our state to mm_tlb_gen. */
-	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
+	__this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
 }
 
 static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
@@ -647,7 +647,7 @@ static void flush_tlb_func_remote(void *
 
 	inc_irq_stat(irq_tlb_count);
 
-	if (f->mm && f->mm != this_cpu_read(cpu_tlbstate.loaded_mm))
+	if (f->mm && f->mm != __this_cpu_read(cpu_tlbstate.loaded_mm))
 		return;
 
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
@@ -749,7 +749,7 @@ void flush_tlb_mm_range(struct mm_struct
 		info.end = TLB_FLUSH_ALL;
 	}
 
-	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
+	if (mm == __this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		VM_WARN_ON(irqs_disabled());
 		local_irq_disable();
 		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);


