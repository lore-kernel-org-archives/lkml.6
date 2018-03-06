Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELscu7zLRGwYqNUafRDbvivHTGAijivR9Umg8MaXP977CDGzZDbHORvWitzlUzV19YRqTHbJ
ARC-Seal: i=1; a=rsa-sha256; t=1520295966; cv=none;
        d=google.com; s=arc-20160816;
        b=DaxI6YAmDU2txV9c3nn4WYeYiGTuItNL0SjVLQvEhzpdV6qev0mTDRUM9SXgBvEKOD
         TJvME1qEh+5mkKRWHQm1KW03bL/yQeIOey1rq9VoAAqtDNY7dOMSqX1Jso1UebVDc5WM
         mdV536/uGx3tp3C3iKYiNkW2U3EWs+v1z9MRPAjWqMpl/GzoT3v5c2lOtuvefORlb93e
         lCejTXoMPb9yHQ9iXY0uj5roCZszaD4Ix7O6avhieYqEU3kHlkwXKdaFWg0xpzPvIm/C
         CnRVoY6/H1gZSCmmZu0FEIAJwfCVakPNcJhZFDId8nVra3q6LAXob0YAeSzsxeXBSwul
         jnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=U6LekhF5L6zObDuRnj+gIYlRM+qljTVVkXWjggyHW6c=;
        b=RQBZYj0cXsK00s71FMV81rYGcf2zmP/2rSqusKbzuVBzFC4fprcD7wMWzXKobjFDo8
         esi3aErNbC+bdVvUNanBiSW8oY+pZ2KmHpV+HUdUZCwiG09y5fUTGJFK2UZ8vC+QRU+R
         XYe+GNrAO2O5zy96oPBVV81c6A57+DNe2Y7vAnr+2TnA3WcajUrYjxnUWYN0mT9CQ2vQ
         nO+AT7PZH19zR5NzRjLmDD6EltV9wLThSUg9s8m0r7hXz6Kj1hy0btiCN1Fr9vK+8WWa
         mdWmoXpSH/fwedOSafW6p4QBJK1G5g+2PjA191MBhDcp+utaewK0TdHT5Oyj9ZRrrOQX
         qPpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tI8h0M/3;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tI8h0M/3;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 08/65] x86/mm, sched/core: Uninline switch_mm()
Date: Mon,  5 Mar 2018 19:24:41 -0500
Message-Id: <20180306002538.1761-9-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=845
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145863637211403?=
X-GMAIL-MSGID: =?utf-8?q?1594145863637211403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 69c0319aabba45bcf33178916a2f06967b4adede upstream.

It's fairly large and it has quite a few callers.  This may also
help untangle some headers down the road.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/54f3367803e7f80b2be62c8a21879aa74b1a5f57.1461688545.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 70a39c7fd167399fde76aeac314dce026a255b49)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/include/asm/mmu_context.h
---
 arch/x86/include/asm/mmu_context.h |  97 +----------------------------------
 arch/x86/mm/tlb.c                  | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 95 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 73e38f14ddeb..375fafccb32c 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -92,101 +92,8 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #endif
 }
 
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-			     struct task_struct *tsk)
-{
-	unsigned cpu = smp_processor_id();
-
-	if (likely(prev != next)) {
-#ifdef CONFIG_SMP
-		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
-		this_cpu_write(cpu_tlbstate.active_mm, next);
-#endif
-		cpumask_set_cpu(cpu, mm_cpumask(next));
-
-		/*
-		 * Re-load page tables.
-		 *
-		 * This logic has an ordering constraint:
-		 *
-		 *  CPU 0: Write to a PTE for 'next'
-		 *  CPU 0: load bit 1 in mm_cpumask.  if nonzero, send IPI.
-		 *  CPU 1: set bit 1 in next's mm_cpumask
-		 *  CPU 1: load from the PTE that CPU 0 writes (implicit)
-		 *
-		 * We need to prevent an outcome in which CPU 1 observes
-		 * the new PTE value and CPU 0 observes bit 1 clear in
-		 * mm_cpumask.  (If that occurs, then the IPI will never
-		 * be sent, and CPU 0's TLB will contain a stale entry.)
-		 *
-		 * The bad outcome can occur if either CPU's load is
-		 * reordered before that CPU's store, so both CPUs must
-		 * execute full barriers to prevent this from happening.
-		 *
-		 * Thus, switch_mm needs a full barrier between the
-		 * store to mm_cpumask and any operation that could load
-		 * from next->pgd.  TLB fills are special and can happen
-		 * due to instruction fetches or for no reason at all,
-		 * and neither LOCK nor MFENCE orders them.
-		 * Fortunately, load_cr3() is serializing and gives the
-		 * ordering guarantee we need.
-		 *
-		 */
-		load_cr3(next->pgd);
-
-		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
-
-		/* Stop flush ipis for the previous mm */
-		cpumask_clear_cpu(cpu, mm_cpumask(prev));
-
-		/* Load per-mm CR4 state */
-		load_mm_cr4(next);
-
-		/*
-		 * Load the LDT, if the LDT is different.
-		 *
-		 * It's possible that prev->context.ldt doesn't match
-		 * the LDT register.  This can happen if leave_mm(prev)
-		 * was called and then modify_ldt changed
-		 * prev->context.ldt but suppressed an IPI to this CPU.
-		 * In this case, prev->context.ldt != NULL, because we
-		 * never set context.ldt to NULL while the mm still
-		 * exists.  That means that next->context.ldt !=
-		 * prev->context.ldt, because mms never share an LDT.
-		 */
-		if (unlikely(prev->context.ldt != next->context.ldt))
-			load_mm_ldt(next);
-	}
-#ifdef CONFIG_SMP
-	  else {
-		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
-		BUG_ON(this_cpu_read(cpu_tlbstate.active_mm) != next);
-
-		if (!cpumask_test_cpu(cpu, mm_cpumask(next))) {
-			/*
-			 * On established mms, the mm_cpumask is only changed
-			 * from irq context, from ptep_clear_flush() while in
-			 * lazy tlb mode, and here. Irqs are blocked during
-			 * schedule, protecting us from simultaneous changes.
-			 */
-			cpumask_set_cpu(cpu, mm_cpumask(next));
-
-			/*
-			 * We were in lazy tlb mode and leave_mm disabled
-			 * tlb flush IPI delivery. We must reload CR3
-			 * to make sure to use no freed page tables.
-			 *
-			 * As above, load_cr3() is serializing and orders TLB
-			 * fills with respect to the mm_cpumask write.
-			 */
-			load_cr3(next->pgd);
-			trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
-			load_mm_cr4(next);
-			load_mm_ldt(next);
-		}
-	}
-#endif
-}
+extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+		      struct task_struct *tsk);
 
 #define activate_mm(prev, next)			\
 do {						\
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a1aa5f59e3ad..40c640980720 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -59,6 +59,106 @@ void leave_mm(int cpu)
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
+#endif /* CONFIG_SMP */
+
+void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+	       struct task_struct *tsk)
+{
+	unsigned cpu = smp_processor_id();
+
+	if (likely(prev != next)) {
+#ifdef CONFIG_SMP
+		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
+		this_cpu_write(cpu_tlbstate.active_mm, next);
+#endif
+		cpumask_set_cpu(cpu, mm_cpumask(next));
+
+		/*
+		 * Re-load page tables.
+		 *
+		 * This logic has an ordering constraint:
+		 *
+		 *  CPU 0: Write to a PTE for 'next'
+		 *  CPU 0: load bit 1 in mm_cpumask.  if nonzero, send IPI.
+		 *  CPU 1: set bit 1 in next's mm_cpumask
+		 *  CPU 1: load from the PTE that CPU 0 writes (implicit)
+		 *
+		 * We need to prevent an outcome in which CPU 1 observes
+		 * the new PTE value and CPU 0 observes bit 1 clear in
+		 * mm_cpumask.  (If that occurs, then the IPI will never
+		 * be sent, and CPU 0's TLB will contain a stale entry.)
+		 *
+		 * The bad outcome can occur if either CPU's load is
+		 * reordered before that CPU's store, so both CPUs must
+		 * execute full barriers to prevent this from happening.
+		 *
+		 * Thus, switch_mm needs a full barrier between the
+		 * store to mm_cpumask and any operation that could load
+		 * from next->pgd.  TLB fills are special and can happen
+		 * due to instruction fetches or for no reason at all,
+		 * and neither LOCK nor MFENCE orders them.
+		 * Fortunately, load_cr3() is serializing and gives the
+		 * ordering guarantee we need.
+		 *
+		 */
+		load_cr3(next->pgd);
+
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
+
+		/* Stop flush ipis for the previous mm */
+		cpumask_clear_cpu(cpu, mm_cpumask(prev));
+
+		/* Load per-mm CR4 state */
+		load_mm_cr4(next);
+
+		/*
+		 * Load the LDT, if the LDT is different.
+		 *
+		 * It's possible that prev->context.ldt doesn't match
+		 * the LDT register.  This can happen if leave_mm(prev)
+		 * was called and then modify_ldt changed
+		 * prev->context.ldt but suppressed an IPI to this CPU.
+		 * In this case, prev->context.ldt != NULL, because we
+		 * never set context.ldt to NULL while the mm still
+		 * exists.  That means that next->context.ldt !=
+		 * prev->context.ldt, because mms never share an LDT.
+		 */
+		if (unlikely(prev->context.ldt != next->context.ldt))
+			load_mm_ldt(next);
+	}
+#ifdef CONFIG_SMP
+	  else {
+		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
+		BUG_ON(this_cpu_read(cpu_tlbstate.active_mm) != next);
+
+		if (!cpumask_test_cpu(cpu, mm_cpumask(next))) {
+			/*
+			 * On established mms, the mm_cpumask is only changed
+			 * from irq context, from ptep_clear_flush() while in
+			 * lazy tlb mode, and here. Irqs are blocked during
+			 * schedule, protecting us from simultaneous changes.
+			 */
+			cpumask_set_cpu(cpu, mm_cpumask(next));
+
+			/*
+			 * We were in lazy tlb mode and leave_mm disabled
+			 * tlb flush IPI delivery. We must reload CR3
+			 * to make sure to use no freed page tables.
+			 *
+			 * As above, load_cr3() is serializing and orders TLB
+			 * fills with respect to the mm_cpumask write.
+			 */
+			load_cr3(next->pgd);
+			trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
+			load_mm_cr4(next);
+			load_mm_ldt(next);
+		}
+	}
+#endif
+}
+
+#ifdef CONFIG_SMP
+
 /*
  * The flush IPI assumes that a thread switch happens in this order:
  * [cpu0: the cpu that switches]
-- 
2.16.2
