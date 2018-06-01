Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeFAWNi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 18:13:38 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51636 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeFAWNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 18:13:36 -0400
Date: Fri, 1 Jun 2018 18:13:27 -0400
From: Rik van Riel <riel@surriel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        songliubraving@fb.com, kernel-team <kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
Message-ID: <20180601181327.367f0fe3@imladris.surriel.com>
In-Reply-To: <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
        <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
        <1527877328.7898.80.camel@surriel.com>
        <1527878882.4448.11.camel@gmx.de>
        <1527882207.7898.86.camel@surriel.com>
        <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
        <1527885324.7898.88.camel@surriel.com>
        <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2018 14:21:58 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> Hmm.  I wonder if there's a more clever data structure than a bitmap
> that we could be using here.  Each CPU only ever needs to be in one
> mm's cpumask, and each cpu only ever changes its own state in the
> bitmask.  And writes are much less common than reads for most
> workloads.

It would be easy enough to add an mm_struct pointer to the
per-cpu tlbstate struct, and iterate over those.

However, that would be an orthogonal change to optimizing
lazy TLB mode. 

Does the (untested) patch below make sense as a potential
improvement to the lazy TLB heuristic?

---8<---
Subject: x86,tlb: workload dependent per CPU lazy TLB switch

Lazy TLB mode is a tradeoff between flushing the TLB and touching
the mm_cpumask(&init_mm) at context switch time, versus potentially
incurring a remote TLB flush IPI while in lazy TLB mode.

Whether this pays off is likely to be workload dependent more than
anything else. However, the current heuristic keys off hardware type.

This patch changes the lazy TLB mode heuristic to a dynamic, per-CPU
decision, dependent on whether we recently received a remote TLB
shootdown while in lazy TLB mode.

This is a very simple heuristic. When a CPU receives a remote TLB
shootdown IPI while in lazy TLB mode, a counter in the same cache
line is set to 16. Every time we skip lazy TLB mode, the counter
is decremented.

While the counter is zero (no recent TLB flush IPIs), allow lazy TLB mode.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/tlbflush.h | 32 ++++++++++++++++----------------
 arch/x86/mm/tlb.c               |  4 ++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6690cd3fc8b1..f06a934e317d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -148,22 +148,6 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 #define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
 #endif
 
-static inline bool tlb_defer_switch_to_init_mm(void)
-{
-	/*
-	 * If we have PCID, then switching to init_mm is reasonably
-	 * fast.  If we don't have PCID, then switching to init_mm is
-	 * quite slow, so we try to defer it in the hopes that we can
-	 * avoid it entirely.  The latter approach runs the risk of
-	 * receiving otherwise unnecessary IPIs.
-	 *
-	 * This choice is just a heuristic.  The tlb code can handle this
-	 * function returning true or false regardless of whether we have
-	 * PCID.
-	 */
-	return !static_cpu_has(X86_FEATURE_PCID);
-}
-
 struct tlb_context {
 	u64 ctx_id;
 	u64 tlb_gen;
@@ -179,6 +163,7 @@ struct tlb_state {
 	struct mm_struct *loaded_mm;
 	u16 loaded_mm_asid;
 	u16 next_asid;
+	u16 flushed_while_lazy;
 	/* last user mm's ctx id */
 	u64 last_ctx_id;
 
@@ -246,6 +231,21 @@ struct tlb_state {
 };
 DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
 
+static inline bool tlb_defer_switch_to_init_mm(void)
+{
+	/*
+	 * If the CPU recently received a TLB flush IPI while in lazy
+	 * TLB mode, do a straight switch to the idle task, and skip
+	 * lazy TLB mode for now.
+	 */
+	if (this_cpu_read(cpu_tlbstate.flushed_while_lazy)) {
+		this_cpu_dec(cpu_tlbstate.flushed_while_lazy);
+		return false;
+	}
+
+	return true;
+}
+
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e055d1a06699..d8b0b7b236f3 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -454,7 +454,11 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * paging-structure cache to avoid speculatively reading
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
+		 *
+		 * Skip lazy TLB mode for the next 16 context switches,
+		 * in case more TLB flush IPIs are coming.
 		 */
+		this_cpu_write(cpu_tlbstate.flushed_while_lazy, 16);
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
 		return;
 	}
