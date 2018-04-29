Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeD2PIU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 11:08:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753392AbeD2PIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 11:08:18 -0400
Date: Sun, 29 Apr 2018 17:08:16 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86/pti updates for 4.17
Message-ID: <alpine.DEB.2.21.1804291659220.1595@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

A set of updates for the x86/pti related code:

 - Preserve r8-r11 in int $0x80. r8-r11 need to be preserved, but the
   $int80 entry code removed that quite some time ago. Make it correct
   again.

 - A set of fixes for the Global Bit work which went into 4.17 and caused a
   bunch of interesting regressions:
   
    - Triggering a BUG in the page attribute code due to a missing check
      for early boot stage

    - Warnings in the page attribute code about holes in the kernel text
      mapping which are caused by the freeing of the init code. Handle
      such holes gracefully.

    - Reduce the amount of kernel memory which is set global to the actual
      text and do not incidentally overlap with data.

    - Disable the global bit when RANDSTRUCT is enabled as it partially
      defeats the hardening.

    - Make the page protection setup correct for vma->page_prot population
      again. The adjustment of the protections fell through the crack during
      the Global bit rework and triggers warnings on machines which do not
      support certain features, e.g. NX

Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/entry/64/compat: Preserve r8-r11 in int $0x80

Dave Hansen (5):
      x86/pti: Fix boot problems from Global-bit setting
      x86/pti: Fix boot warning from Global-bit setting
      x86/pti: Reduce amount of kernel text allowed to be Global
      x86/pti: Disallow global kernel text with RANDSTRUCT
      x86/pti: Filter at vma->vm_page_prot population


 arch/x86/Kconfig                                |  4 +++
 arch/x86/entry/entry_64_compat.S                |  8 ++---
 arch/x86/include/asm/pgtable.h                  |  5 +++
 arch/x86/mm/pageattr.c                          | 44 ++++++++++++++++++-------
 arch/x86/mm/pti.c                               | 26 +++++++++++++--
 mm/mmap.c                                       | 11 ++++++-
 tools/testing/selftests/x86/test_syscall_vdso.c | 35 ++++++++++++--------
 7 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 00fcf81f2c56..c07f492b871a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -52,6 +52,7 @@ config X86
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
+	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
@@ -273,6 +274,9 @@ config ARCH_HAS_CPU_RELAX
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_HAS_FILTER_PGPROT
+	def_bool y
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 9af927e59d49..9de7f1e1dede 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -84,13 +84,13 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	%rdx			/* pt_regs->dx */
 	pushq	%rcx			/* pt_regs->cx */
 	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
+	pushq   %r8			/* pt_regs->r8 */
 	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
+	pushq   %r9			/* pt_regs->r9 */
 	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
+	pushq   %r10			/* pt_regs->r10 */
 	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
+	pushq   %r11			/* pt_regs->r11 */
 	xorl	%r11d, %r11d		/* nospec   r11 */
 	pushq   %rbx                    /* pt_regs->rbx */
 	xorl	%ebx, %ebx		/* nospec   rbx */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5f49b4ff0c24..f1633de5a675 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -601,6 +601,11 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 
 #define canon_pgprot(p) __pgprot(massage_pgprot(p))
 
+static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
+{
+	return canon_pgprot(prot);
+}
+
 static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 					 enum page_cache_mode pcm,
 					 enum page_cache_mode new_pcm)
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 0f3d50f4c48c..3bded76e8d5c 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -93,6 +93,18 @@ void arch_report_meminfo(struct seq_file *m)
 static inline void split_page_count(int level) { }
 #endif
 
+static inline int
+within(unsigned long addr, unsigned long start, unsigned long end)
+{
+	return addr >= start && addr < end;
+}
+
+static inline int
+within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
+{
+	return addr >= start && addr <= end;
+}
+
 #ifdef CONFIG_X86_64
 
 static inline unsigned long highmap_start_pfn(void)
@@ -106,20 +118,25 @@ static inline unsigned long highmap_end_pfn(void)
 	return __pa_symbol(roundup(_brk_end, PMD_SIZE) - 1) >> PAGE_SHIFT;
 }
 
-#endif
-
-static inline int
-within(unsigned long addr, unsigned long start, unsigned long end)
+static bool __cpa_pfn_in_highmap(unsigned long pfn)
 {
-	return addr >= start && addr < end;
+	/*
+	 * Kernel text has an alias mapping at a high address, known
+	 * here as "highmap".
+	 */
+	return within_inclusive(pfn, highmap_start_pfn(), highmap_end_pfn());
 }
 
-static inline int
-within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
+#else
+
+static bool __cpa_pfn_in_highmap(unsigned long pfn)
 {
-	return addr >= start && addr <= end;
+	/* There is no highmap on 32-bit */
+	return false;
 }
 
+#endif
+
 /*
  * Flushing functions
  */
@@ -172,7 +189,7 @@ static void __cpa_flush_all(void *arg)
 
 static void cpa_flush_all(unsigned long cache)
 {
-	BUG_ON(irqs_disabled());
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
@@ -236,7 +253,7 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
 	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
 #endif
 
-	BUG_ON(irqs_disabled());
+	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
 
 	on_each_cpu(__cpa_flush_all, (void *) do_wbinvd, 1);
 
@@ -1183,6 +1200,10 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 		cpa->numpages = 1;
 		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
 		return 0;
+
+	} else if (__cpa_pfn_in_highmap(cpa->pfn)) {
+		/* Faults in the highmap are OK, so do not warn: */
+		return -EFAULT;
 	} else {
 		WARN(1, KERN_WARNING "CPA: called for zero pte. "
 			"vaddr = %lx cpa->vaddr = %lx\n", vaddr,
@@ -1335,8 +1356,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 	 * to touch the high mapped kernel as well:
 	 */
 	if (!within(vaddr, (unsigned long)_text, _brk_end) &&
-	    within_inclusive(cpa->pfn, highmap_start_pfn(),
-			     highmap_end_pfn())) {
+	    __cpa_pfn_in_highmap(cpa->pfn)) {
 		unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
 					       __START_KERNEL_map - phys_base;
 		alias_cpa = *cpa;
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index f1fd52f449e0..4d418e705878 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -421,6 +421,16 @@ static inline bool pti_kernel_image_global_ok(void)
 	if (boot_cpu_has(X86_FEATURE_K8))
 		return false;
 
+	/*
+	 * RANDSTRUCT derives its hardening benefits from the
+	 * attacker's lack of knowledge about the layout of kernel
+	 * data structures.  Keep the kernel image non-global in
+	 * cases where RANDSTRUCT is in use to help keep the layout a
+	 * secret.
+	 */
+	if (IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT))
+		return false;
+
 	return true;
 }
 
@@ -430,12 +440,24 @@ static inline bool pti_kernel_image_global_ok(void)
  */
 void pti_clone_kernel_text(void)
 {
+	/*
+	 * rodata is part of the kernel image and is normally
+	 * readable on the filesystem or on the web.  But, do not
+	 * clone the areas past rodata, they might contain secrets.
+	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+	unsigned long end = (unsigned long)__end_rodata_hpage_align;
 
 	if (!pti_kernel_image_global_ok())
 		return;
 
+	pr_debug("mapping partial kernel image into user address space\n");
+
+	/*
+	 * Note that this will undo _some_ of the work that
+	 * pti_set_kernel_image_nonglobal() did to clear the
+	 * global bit.
+	 */
 	pti_clone_pmds(start, end, _PAGE_RW);
 }
 
@@ -458,8 +480,6 @@ void pti_set_kernel_image_nonglobal(void)
 	if (pti_kernel_image_global_ok())
 		return;
 
-	pr_debug("set kernel image non-global\n");
-
 	set_memory_nonglobal(start, (end - start) >> PAGE_SHIFT);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 188f195883b9..9d5968d1e8e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -100,11 +100,20 @@ pgprot_t protection_map[16] __ro_after_init = {
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
+#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
+static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
+{
+	return prot;
+}
+#endif
+
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	return __pgprot(pgprot_val(protection_map[vm_flags &
+	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
 				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
+
+	return arch_filter_pgprot(ret);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 
diff --git a/tools/testing/selftests/x86/test_syscall_vdso.c b/tools/testing/selftests/x86/test_syscall_vdso.c
index 40370354d4c1..c9c3281077bc 100644
--- a/tools/testing/selftests/x86/test_syscall_vdso.c
+++ b/tools/testing/selftests/x86/test_syscall_vdso.c
@@ -100,12 +100,19 @@ asm (
 	"	shl	$32, %r8\n"
 	"	orq	$0x7f7f7f7f, %r8\n"
 	"	movq	%r8, %r9\n"
-	"	movq	%r8, %r10\n"
-	"	movq	%r8, %r11\n"
-	"	movq	%r8, %r12\n"
-	"	movq	%r8, %r13\n"
-	"	movq	%r8, %r14\n"
-	"	movq	%r8, %r15\n"
+	"	incq	%r9\n"
+	"	movq	%r9, %r10\n"
+	"	incq	%r10\n"
+	"	movq	%r10, %r11\n"
+	"	incq	%r11\n"
+	"	movq	%r11, %r12\n"
+	"	incq	%r12\n"
+	"	movq	%r12, %r13\n"
+	"	incq	%r13\n"
+	"	movq	%r13, %r14\n"
+	"	incq	%r14\n"
+	"	movq	%r14, %r15\n"
+	"	incq	%r15\n"
 	"	ret\n"
 	"	.code32\n"
 	"	.popsection\n"
@@ -128,12 +135,13 @@ int check_regs64(void)
 	int err = 0;
 	int num = 8;
 	uint64_t *r64 = &regs64.r8;
+	uint64_t expected = 0x7f7f7f7f7f7f7f7fULL;
 
 	if (!kernel_is_64bit)
 		return 0;
 
 	do {
-		if (*r64 == 0x7f7f7f7f7f7f7f7fULL)
+		if (*r64 == expected++)
 			continue; /* register did not change */
 		if (syscall_addr != (long)&int80) {
 			/*
@@ -147,18 +155,17 @@ int check_regs64(void)
 				continue;
 			}
 		} else {
-			/* INT80 syscall entrypoint can be used by
+			/*
+			 * INT80 syscall entrypoint can be used by
 			 * 64-bit programs too, unlike SYSCALL/SYSENTER.
 			 * Therefore it must preserve R12+
 			 * (they are callee-saved registers in 64-bit C ABI).
 			 *
-			 * This was probably historically not intended,
-			 * but R8..11 are clobbered (cleared to 0).
-			 * IOW: they are the only registers which aren't
-			 * preserved across INT80 syscall.
+			 * Starting in Linux 4.17 (and any kernel that
+			 * backports the change), R8..11 are preserved.
+			 * Historically (and probably unintentionally), they
+			 * were clobbered or zeroed.
 			 */
-			if (*r64 == 0 && num <= 11)
-				continue;
 		}
 		printf("[FAIL]\tR%d has changed:%016llx\n", num, *r64);
 		err++;
