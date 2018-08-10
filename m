Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42678C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A7422414
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A7422414
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeHJOWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727738AbeHJOWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:22:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72203AEDB;
        Fri, 10 Aug 2018 11:52:59 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 10/10] x86/paravirt: move the Xen-only pv_mmu_ops under the PARAVIRT_XXL umbrella
Date:   Fri, 10 Aug 2018 13:52:52 +0200
Message-Id: <20180810115252.18213-11-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180810115252.18213-1-jgross@suse.com>
References: <20180810115252.18213-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the paravirt ops defined in pv_mmu_ops are for Xen PV guests
only. Define them only if CONFIG_PARAVIRT_XXL is set.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/fixmap.h         |   2 +-
 arch/x86/include/asm/mmu_context.h    |   4 +-
 arch/x86/include/asm/paravirt.h       | 115 +++++++++++++++++-----------------
 arch/x86/include/asm/paravirt_types.h |  29 ++++-----
 arch/x86/include/asm/pgalloc.h        |   2 +-
 arch/x86/include/asm/pgtable.h        |   7 +--
 arch/x86/include/asm/special_insns.h  |  11 +---
 arch/x86/kernel/asm-offsets.c         |   2 +-
 arch/x86/kernel/head_64.S             |   4 +-
 arch/x86/kernel/paravirt.c            |  15 +++--
 arch/x86/kernel/paravirt_patch_32.c   |   4 +-
 arch/x86/kernel/paravirt_patch_64.c   |   4 +-
 12 files changed, 97 insertions(+), 102 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index e203169931c7..ac80e7eadc3a 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -152,7 +152,7 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
 void native_set_fixmap(enum fixed_addresses idx,
 		       phys_addr_t phys, pgprot_t flags);
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 static inline void __set_fixmap(enum fixed_addresses idx,
 				phys_addr_t phys, pgprot_t flags)
 {
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index bbc796eb0a3b..ffae17a8db36 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -16,12 +16,12 @@
 
 extern atomic64_t last_mm_ctx_id;
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
 }
-#endif	/* !CONFIG_PARAVIRT */
+#endif	/* !CONFIG_PARAVIRT_XXL */
 
 #ifdef CONFIG_PERF_EVENTS
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 220c13d7e846..520c85b74c74 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,6 +17,57 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
+static inline unsigned long long paravirt_sched_clock(void)
+{
+	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
+}
+
+struct static_key;
+extern struct static_key paravirt_steal_enabled;
+extern struct static_key paravirt_steal_rq_enabled;
+
+static inline u64 paravirt_steal_clock(int cpu)
+{
+	return PVOP_CALL1(u64, pv_time_ops.steal_clock, cpu);
+}
+
+/* The paravirtualized I/O functions */
+static inline void slow_down_io(void)
+{
+	pv_ops.pv_cpu_ops.io_delay();
+#ifdef REALLY_SLOW_IO
+	pv_ops.pv_cpu_ops.io_delay();
+	pv_ops.pv_cpu_ops.io_delay();
+	pv_ops.pv_cpu_ops.io_delay();
+#endif
+}
+
+static inline void __flush_tlb(void)
+{
+	PVOP_VCALL0(pv_mmu_ops.flush_tlb_user);
+}
+
+static inline void __flush_tlb_global(void)
+{
+	PVOP_VCALL0(pv_mmu_ops.flush_tlb_kernel);
+}
+
+static inline void __flush_tlb_one_user(unsigned long addr)
+{
+	PVOP_VCALL1(pv_mmu_ops.flush_tlb_one_user, addr);
+}
+
+static inline void flush_tlb_others(const struct cpumask *cpumask,
+				    const struct flush_tlb_info *info)
+{
+	PVOP_VCALL2(pv_mmu_ops.flush_tlb_others, cpumask, info);
+}
+
+static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
+{
+	PVOP_VCALL1(pv_mmu_ops.exit_mmap, mm);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -52,7 +103,6 @@ static inline void write_cr0(unsigned long x)
 {
 	PVOP_VCALL1(pv_cpu_ops.write_cr0, x);
 }
-#endif
 
 static inline unsigned long read_cr2(void)
 {
@@ -74,7 +124,6 @@ static inline void write_cr3(unsigned long x)
 	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
 static inline void __write_cr4(unsigned long x)
 {
 	PVOP_VCALL1(pv_cpu_ops.write_cr4, x);
@@ -172,23 +221,7 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
 	*p = paravirt_read_msr_safe(msr, &err);
 	return err;
 }
-#endif
 
-static inline unsigned long long paravirt_sched_clock(void)
-{
-	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
-}
-
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return PVOP_CALL1(u64, pv_time_ops.steal_clock, cpu);
-}
-
-#ifdef CONFIG_PARAVIRT_XXL
 static inline unsigned long long paravirt_read_pmc(int counter)
 {
 	return PVOP_CALL1(u64, pv_cpu_ops.read_pmc, counter);
@@ -267,18 +300,6 @@ static inline void set_iopl_mask(unsigned mask)
 {
 	PVOP_VCALL1(pv_cpu_ops.set_iopl_mask, mask);
 }
-#endif
-
-/* The paravirtualized I/O functions */
-static inline void slow_down_io(void)
-{
-	pv_ops.pv_cpu_ops.io_delay();
-#ifdef REALLY_SLOW_IO
-	pv_ops.pv_cpu_ops.io_delay();
-	pv_ops.pv_cpu_ops.io_delay();
-	pv_ops.pv_cpu_ops.io_delay();
-#endif
-}
 
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
@@ -292,30 +313,6 @@ static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 	PVOP_VCALL2(pv_mmu_ops.dup_mmap, oldmm, mm);
 }
 
-static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
-{
-	PVOP_VCALL1(pv_mmu_ops.exit_mmap, mm);
-}
-
-static inline void __flush_tlb(void)
-{
-	PVOP_VCALL0(pv_mmu_ops.flush_tlb_user);
-}
-static inline void __flush_tlb_global(void)
-{
-	PVOP_VCALL0(pv_mmu_ops.flush_tlb_kernel);
-}
-static inline void __flush_tlb_one_user(unsigned long addr)
-{
-	PVOP_VCALL1(pv_mmu_ops.flush_tlb_one_user, addr);
-}
-
-static inline void flush_tlb_others(const struct cpumask *cpumask,
-				    const struct flush_tlb_info *info)
-{
-	PVOP_VCALL2(pv_mmu_ops.flush_tlb_others, cpumask, info);
-}
-
 static inline int paravirt_pgd_alloc(struct mm_struct *mm)
 {
 	return PVOP_CALL1(int, pv_mmu_ops.pgd_alloc, mm);
@@ -640,7 +637,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 }
 #endif	/* CONFIG_X86_PAE */
 
-#ifdef CONFIG_PARAVIRT_XXL
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
 static inline void arch_start_context_switch(struct task_struct *prev)
 {
@@ -651,7 +647,6 @@ static inline void arch_end_context_switch(struct task_struct *next)
 {
 	PVOP_VCALL1(pv_cpu_ops.end_context_switch, next);
 }
-#endif
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void)
@@ -674,6 +669,7 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 {
 	pv_ops.pv_mmu_ops.set_fixmap(idx, phys, flags);
 }
+#endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 
@@ -959,15 +955,20 @@ extern void default_banner(void);
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
+#endif /* !CONFIG_PARAVIRT */
+
 #ifndef __ASSEMBLY__
+#ifndef CONFIG_PARAVIRT_XXL
 static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 					  struct mm_struct *mm)
 {
 }
+#endif
 
+#ifndef CONFIG_PARAVIRT
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 }
+#endif
 #endif /* __ASSEMBLY__ */
-#endif /* !CONFIG_PARAVIRT */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 938ac2bece81..a9b72dae18b2 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -90,13 +90,14 @@ struct pv_init_ops {
 			  unsigned long addr, unsigned len);
 } __no_randomize_layout;
 
-
+#ifdef CONFIG_PARAVIRT_XXL
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
 	void (*enter)(void);
 	void (*leave)(void);
 	void (*flush)(void);
 } __no_randomize_layout;
+#endif
 
 struct pv_time_ops {
 	unsigned long long (*sched_clock)(void);
@@ -205,29 +206,28 @@ struct pv_irq_ops {
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
+	/* TLB operations */
+	void (*flush_tlb_user)(void);
+	void (*flush_tlb_kernel)(void);
+	void (*flush_tlb_one_user)(unsigned long addr);
+	void (*flush_tlb_others)(const struct cpumask *cpus,
+				 const struct flush_tlb_info *info);
+
+	/* Hook for intercepting the destruction of an mm_struct. */
+	void (*exit_mmap)(struct mm_struct *mm);
+
+#ifdef CONFIG_PARAVIRT_XXL
 	unsigned long (*read_cr2)(void);
 	void (*write_cr2)(unsigned long);
 
 	unsigned long (*read_cr3)(void);
 	void (*write_cr3)(unsigned long);
 
-	/*
-	 * Hooks for intercepting the creation/use/destruction of an
-	 * mm_struct.
-	 */
+	/* Hooks for intercepting the creation/use of an mm_struct. */
 	void (*activate_mm)(struct mm_struct *prev,
 			    struct mm_struct *next);
 	void (*dup_mmap)(struct mm_struct *oldmm,
 			 struct mm_struct *mm);
-	void (*exit_mmap)(struct mm_struct *mm);
-
-
-	/* TLB operations */
-	void (*flush_tlb_user)(void);
-	void (*flush_tlb_kernel)(void);
-	void (*flush_tlb_one_user)(unsigned long addr);
-	void (*flush_tlb_others)(const struct cpumask *cpus,
-				 const struct flush_tlb_info *info);
 
 	/* Hooks for allocating and freeing a pagetable top-level */
 	int  (*pgd_alloc)(struct mm_struct *mm);
@@ -302,6 +302,7 @@ struct pv_mmu_ops {
 	   an mfn.  We can tell which is which from the index. */
 	void (*set_fixmap)(unsigned /* enum fixed_addresses */ idx,
 			   phys_addr_t phys, pgprot_t flags);
+#endif
 } __no_randomize_layout;
 
 struct arch_spinlock;
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index fbd578daa66e..ec7f43327033 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -8,7 +8,7 @@
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
 #define paravirt_pgd_alloc(mm)	__paravirt_pgd_alloc(mm)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9ea291fe7107..b9abc525ece3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -52,9 +52,9 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 
 extern pmdval_t early_pmd_flags;
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
-#else  /* !CONFIG_PARAVIRT */
+#else  /* !CONFIG_PARAVIRT_XXL */
 #define set_pte(ptep, pte)		native_set_pte(ptep, pte)
 #define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
 
@@ -108,9 +108,6 @@ extern pmdval_t early_pmd_flags;
 #define pte_val(x)	native_pte_val(x)
 #define __pte(x)	native_make_pte(x)
 
-#endif	/* CONFIG_PARAVIRT */
-
-#ifndef CONFIG_PARAVIRT_XXL
 #define arch_end_context_switch(prev)	do {} while(0)
 #endif	/* CONFIG_PARAVIRT_XXL */
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2aa6ce4bf159..43c029cdc3fe 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -141,11 +141,10 @@ static inline unsigned long __read_cr4(void)
 	return native_read_cr4();
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
-#endif
+#else
 
-#ifndef CONFIG_PARAVIRT_XXL
 static inline unsigned long read_cr0(void)
 {
 	return native_read_cr0();
@@ -155,9 +154,7 @@ static inline void write_cr0(unsigned long x)
 {
 	native_write_cr0(x);
 }
-#endif
 
-#ifndef CONFIG_PARAVIRT
 static inline unsigned long read_cr2(void)
 {
 	return native_read_cr2();
@@ -181,9 +178,7 @@ static inline void write_cr3(unsigned long x)
 {
 	native_write_cr3(x);
 }
-#endif
 
-#ifndef CONFIG_PARAVIRT_XXL
 static inline void __write_cr4(unsigned long x)
 {
 	native_write_cr4(x);
@@ -213,7 +208,7 @@ static inline void load_gs_index(unsigned selector)
 
 #endif
 
-#endif/* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_XXL */
 
 static inline void clflush(volatile void *__p)
 {
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 429db3c8a0cc..1871bb388bb0 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -72,9 +72,9 @@ void common(void) {
 	       pv_irq_ops.irq_enable);
 #ifdef CONFIG_PARAVIRT_XXL
 	OFFSET(PV_CPU_iret, paravirt_patch_template, pv_cpu_ops.iret);
-#endif
 	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, pv_mmu_ops.read_cr2);
 #endif
+#endif
 
 #ifdef CONFIG_XEN
 	BLANK();
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index e11b96b2dc6b..981fd802830f 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -25,14 +25,12 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
 #define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
 #else
 #define GET_CR2_INTO(reg) movq %cr2, reg
-#endif
-#ifndef CONFIG_PARAVIRT_XXL
 #define INTERRUPT_RETURN iretq
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 19bfb3d2083f..36c60fbf61fd 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -385,16 +385,19 @@ struct paravirt_patch_template pv_ops = {
 #endif
 
 	/* Mmu ops. */
-	.pv_mmu_ops.read_cr2 = native_read_cr2,
-	.pv_mmu_ops.write_cr2 = native_write_cr2,
-	.pv_mmu_ops.read_cr3 = __native_read_cr3,
-	.pv_mmu_ops.write_cr3 = native_write_cr3,
-
 	.pv_mmu_ops.flush_tlb_user = native_flush_tlb,
 	.pv_mmu_ops.flush_tlb_kernel = native_flush_tlb_global,
 	.pv_mmu_ops.flush_tlb_one_user = native_flush_tlb_one_user,
 	.pv_mmu_ops.flush_tlb_others = native_flush_tlb_others,
 
+	.pv_mmu_ops.exit_mmap = paravirt_nop,
+
+#ifdef CONFIG_PARAVIRT_XXL
+	.pv_mmu_ops.read_cr2 = native_read_cr2,
+	.pv_mmu_ops.write_cr2 = native_write_cr2,
+	.pv_mmu_ops.read_cr3 = __native_read_cr3,
+	.pv_mmu_ops.write_cr3 = native_write_cr3,
+
 	.pv_mmu_ops.pgd_alloc = __paravirt_pgd_alloc,
 	.pv_mmu_ops.pgd_free = paravirt_nop,
 
@@ -447,7 +450,6 @@ struct paravirt_patch_template pv_ops = {
 	.pv_mmu_ops.make_pgd = PTE_IDENT,
 
 	.pv_mmu_ops.dup_mmap = paravirt_nop,
-	.pv_mmu_ops.exit_mmap = paravirt_nop,
 	.pv_mmu_ops.activate_mm = paravirt_nop,
 
 	.pv_mmu_ops.lazy_mode = {
@@ -457,6 +459,7 @@ struct paravirt_patch_template pv_ops = {
 	},
 
 	.pv_mmu_ops.set_fixmap = native_set_fixmap,
+#endif
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 	/* Lock ops. */
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 704ed7718062..a4e66a912121 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -7,10 +7,10 @@ DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
 DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
 #ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(pv_cpu_ops, iret, "iret");
-#endif
 DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
+#endif
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
@@ -49,10 +49,10 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(pv_irq_ops, save_fl);
 #ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(pv_cpu_ops, iret);
-#endif
 		PATCH_SITE(pv_mmu_ops, read_cr2);
 		PATCH_SITE(pv_mmu_ops, read_cr3);
 		PATCH_SITE(pv_mmu_ops, write_cr3);
+#endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 131a7eb01a13..abc0c94b8caa 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -7,10 +7,10 @@ DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
 DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
 DEF_NATIVE(pv_irq_ops, restore_fl, "pushq %rdi; popfq");
 DEF_NATIVE(pv_irq_ops, save_fl, "pushfq; popq %rax");
+#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(pv_mmu_ops, read_cr2, "movq %cr2, %rax");
 DEF_NATIVE(pv_mmu_ops, read_cr3, "movq %cr3, %rax");
 DEF_NATIVE(pv_mmu_ops, write_cr3, "movq %rdi, %cr3");
-#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(pv_cpu_ops, wbinvd, "wbinvd");
 
 DEF_NATIVE(pv_cpu_ops, usergs_sysret64, "swapgs; sysretq");
@@ -59,10 +59,10 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(pv_cpu_ops, usergs_sysret64);
 		PATCH_SITE(pv_cpu_ops, swapgs);
 		PATCH_SITE(pv_cpu_ops, wbinvd);
-#endif
 		PATCH_SITE(pv_mmu_ops, read_cr2);
 		PATCH_SITE(pv_mmu_ops, read_cr3);
 		PATCH_SITE(pv_mmu_ops, write_cr3);
+#endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
-- 
2.13.7

