Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELso/BuhlDagwqOIGRj+9isSwHHijCZGHORmZnqXG9/f7MFswHTrfWkPHDaaLYB1IaYX8joI
ARC-Seal: i=1; a=rsa-sha256; t=1520295976; cv=none;
        d=google.com; s=arc-20160816;
        b=dMySU6AO69uOfZsxjPkDHFPgRlb4sPb/KCd0hJ2r3AvgQ1IqYAnrkLqgbtTc877j9X
         SdlKRQepIISrlK5c+mVNiMjCPTG4u+Q9aJrHJwOam/UnikjSYSmdW3P3IRdlMA0BkNDe
         ptM2MGKDEyWuolQg56ZMVvInG6+wUgLB4F4mG3j05yOTKnlN/0vqAP0FuAqO+0zdvzzF
         ZYDHEFFgrPGFYLjLJai13G/v1g/rxgRUiG86DY/9o+ZsTbvx6hhIPfkAC2v8OBoLRbFy
         k9Mvq8wBpk5BV0qCtEHHj8WMa32JdoIfk7Ue9QGJVi1dBiMluYdvJuSqfQQLnovvZE3P
         WM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=teXhoEtwiZXsRWfzbmoQfyZzk1VDqIrNlsOf1zDDjOo=;
        b=zrjZOAayotOME649C7ZsWrtZL7GM3Ao+5Tz7KiTunPS0ovNnLuubmU3tY9psrsrMpe
         y0OtEhrZScchMQownPcpKkl/WKt3hW+CQt6wkoxrYdWNIhPLrAiJQSuS9/MfGw960BHh
         qUejABHBqrTEBKt34/kE4s/cWqMDdjGVvmai15AanIouezKVZqxKQvyjf7QYe6Wkkn+Q
         vl4OqWJBZ2SsAH9bF581huU0OfDA1ufABuSsEzWUaYoXeEXO5rW111vFZFQOqOvEVn3p
         VqKFE+6R4LstNgvNdjTINgbcX06ScOUwUyv0uwdjW0xKrSM57uBMGwtYTnDQMigxmQ+9
         JzgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aE4kLNMA;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aE4kLNMA;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 17/65] x86/mm: Remove the UP asm/tlbflush.h code, always use the (formerly) SMP code
Date: Mon,  5 Mar 2018 19:24:50 -0500
Message-Id: <20180306002538.1761-18-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145873277992691?=
X-GMAIL-MSGID: =?utf-8?q?1594145873277992691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit ce4a4e565f5264909a18c733b864c3f74467f69e upstream.

The UP asm/tlbflush.h generates somewhat nicer code than the SMP version.
Aside from that, it's fallen quite a bit behind the SMP code:

 - flush_tlb_mm_range() didn't flush individual pages if the range
   was small.

 - The lazy TLB code was much weaker.  This usually wouldn't matter,
   but, if a kernel thread flushed its lazy "active_mm" more than
   once (due to reclaim or similar), it wouldn't be unlazied and
   would instead pointlessly flush repeatedly.

 - Tracepoints were missing.

Aside from that, simply having the UP code around was a maintanence
burden, since it means that any change to the TLB flush code had to
make sure not to break it.

Simplify everything by deleting the UP code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

(cherry picked from commit b2e24274d50e0ecdf560ebe06dbed0cc648ad3f9)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/Kconfig
---
 arch/x86/include/asm/hardirq.h     |  2 +-
 arch/x86/include/asm/mmu.h         |  6 ---
 arch/x86/include/asm/mmu_context.h |  2 -
 arch/x86/include/asm/tlbflush.h    | 78 +-------------------------------------
 arch/x86/mm/init.c                 |  2 -
 arch/x86/mm/tlb.c                  | 17 +--------
 6 files changed, 4 insertions(+), 103 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index ebaf64d0a785..edd280d39a31 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -21,8 +21,8 @@ typedef struct {
 #ifdef CONFIG_SMP
 	unsigned int irq_resched_count;
 	unsigned int irq_call_count;
-	unsigned int irq_tlb_count;
 #endif
+	unsigned int irq_tlb_count;
 #ifdef CONFIG_X86_THERMAL_VECTOR
 	unsigned int irq_thermal_count;
 #endif
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 364d27481a52..652517e86e01 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -22,12 +22,6 @@ typedef struct {
 	atomic_t perf_rdpmc_allowed;	/* nonzero if rdpmc is allowed */
 } mm_context_t;
 
-#ifdef CONFIG_SMP
 void leave_mm(int cpu);
-#else
-static inline void leave_mm(int cpu)
-{
-}
-#endif
 
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 2bf4bae1c65e..29292b7aa370 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -86,10 +86,8 @@ void destroy_context(struct mm_struct *mm);
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
-#ifdef CONFIG_SMP
 	if (this_cpu_read(cpu_tlbstate.state) == TLBSTATE_OK)
 		this_cpu_write(cpu_tlbstate.state, TLBSTATE_LAZY);
-#endif
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f23ee750bb68..4f7017c9cae8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -6,6 +6,7 @@
 
 #include <asm/processor.h>
 #include <asm/special_insns.h>
+#include <asm/smp.h>
 
 static inline void __invpcid(unsigned long pcid, unsigned long addr,
 			     unsigned long type)
@@ -64,10 +65,8 @@ static inline void invpcid_flush_all_nonglobals(void)
 #endif
 
 struct tlb_state {
-#ifdef CONFIG_SMP
 	struct mm_struct *active_mm;
 	int state;
-#endif
 
 	/*
 	 * Access to this CR4 shadow and to H/W CR4 is protected by
@@ -208,79 +207,6 @@ static inline void __flush_tlb_one(unsigned long addr)
  * and page-granular flushes are available only on i486 and up.
  */
 
-#ifndef CONFIG_SMP
-
-/* "_up" is for UniProcessor.
- *
- * This is a helper for other header functions.  *Not* intended to be called
- * directly.  All global TLB flushes need to either call this, or to bump the
- * vm statistics themselves.
- */
-static inline void __flush_tlb_up(void)
-{
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	__flush_tlb();
-}
-
-static inline void flush_tlb_all(void)
-{
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	__flush_tlb_all();
-}
-
-static inline void local_flush_tlb(void)
-{
-	__flush_tlb_up();
-}
-
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-	if (mm == current->active_mm)
-		__flush_tlb_up();
-}
-
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long addr)
-{
-	if (vma->vm_mm == current->active_mm)
-		__flush_tlb_one(addr);
-}
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end)
-{
-	if (vma->vm_mm == current->active_mm)
-		__flush_tlb_up();
-}
-
-static inline void flush_tlb_mm_range(struct mm_struct *mm,
-	   unsigned long start, unsigned long end, unsigned long vmflag)
-{
-	if (mm == current->active_mm)
-		__flush_tlb_up();
-}
-
-static inline void native_flush_tlb_others(const struct cpumask *cpumask,
-					   struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-}
-
-static inline void reset_lazy_tlbstate(void)
-{
-}
-
-static inline void flush_tlb_kernel_range(unsigned long start,
-					  unsigned long end)
-{
-	flush_tlb_all();
-}
-
-#else  /* SMP */
-
-#include <asm/smp.h>
-
 #define local_flush_tlb() __flush_tlb()
 
 #define flush_tlb_mm(mm)	flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL)
@@ -311,8 +237,6 @@ static inline void reset_lazy_tlbstate(void)
 	this_cpu_write(cpu_tlbstate.active_mm, &init_mm);
 }
 
-#endif	/* SMP */
-
 #ifndef CONFIG_PARAVIRT
 #define flush_tlb_others(mask, mm, start, end)	\
 	native_flush_tlb_others(mask, mm, start, end)
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 3e1bb1c8daea..0a06e5a14278 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -752,10 +752,8 @@ void __init zone_sizes_init(void)
 }
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate) = {
-#ifdef CONFIG_SMP
 	.active_mm = &init_mm,
 	.state = 0,
-#endif
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
 };
 EXPORT_SYMBOL_GPL(cpu_tlbstate);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 77fdf801efde..95624d903c0e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -15,7 +15,7 @@
 #include <linux/debugfs.h>
 
 /*
- *	Smarter SMP flushing macros.
+ *	TLB flushing, formerly SMP-only
  *		c/o Linus Torvalds.
  *
  *	These mean you can really definitely utterly forget about
@@ -28,8 +28,6 @@
  *	Implement flush IPI by CALL_FUNCTION_VECTOR, Alex Shi
  */
 
-#ifdef CONFIG_SMP
-
 struct flush_tlb_info {
 	struct mm_struct *flush_mm;
 	unsigned long flush_start;
@@ -59,8 +57,6 @@ void leave_mm(int cpu)
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
-#endif /* CONFIG_SMP */
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -77,10 +73,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	unsigned cpu = smp_processor_id();
 
 	if (likely(prev != next)) {
-#ifdef CONFIG_SMP
 		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
 		this_cpu_write(cpu_tlbstate.active_mm, next);
-#endif
 		cpumask_set_cpu(cpu, mm_cpumask(next));
 
 		/*
@@ -135,9 +129,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 */
 		if (unlikely(prev->context.ldt != next->context.ldt))
 			load_mm_ldt(next);
-	}
-#ifdef CONFIG_SMP
-	  else {
+	} else {
 		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
 		BUG_ON(this_cpu_read(cpu_tlbstate.active_mm) != next);
 
@@ -164,11 +156,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			load_mm_ldt(next);
 		}
 	}
-#endif
 }
 
-#ifdef CONFIG_SMP
-
 /*
  * The flush IPI assumes that a thread switch happens in this order:
  * [cpu0: the cpu that switches]
@@ -416,5 +405,3 @@ static int __init create_tlb_single_page_flush_ceiling(void)
 	return 0;
 }
 late_initcall(create_tlb_single_page_flush_ceiling);
-
-#endif /* CONFIG_SMP */
-- 
2.16.2
