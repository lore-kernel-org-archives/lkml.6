Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeDORuR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 13:50:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDORuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 13:50:14 -0400
Date: Sun, 15 Apr 2018 19:50:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86/pti updates for 4.17
Message-ID: <alpine.DEB.2.21.1804151944040.17929@nanos.tec.linutronix.de>
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

Another series of PTI related changes:

 - Remove the manual stack switch for user entries from the idtentry code.
   This debloats entry by 5k+ bytes of text.

 - Use the proper types for the asm/bootparam.h defines to prevent user
   space compile errors.

 - Use PAGE_GLOBAL for !PCID systems to gain back performance

 - Prevent setting of huge PUD/PMD entries when the entries are not leaf
   entries otherwise the entries to which the PUD/PMD points to and are
   populated get lost.

Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/entry/64: Drop idtentry's manual stack switch for user entries

Dave Hansen (11):
      x86/mm: Factor out pageattr _PAGE_GLOBAL setting
      x86/mm: Undo double _PAGE_PSE clearing
      x86/mm: Introduce "default" kernel PTE mask
      x86/espfix: Document use of _PAGE_GLOBAL
      x86/mm: Do not auto-massage page protections
      x86/mm: Remove extra filtering in pageattr code
      x86/mm: Comment _PAGE_GLOBAL mystery
      x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init
      x86/pti: Enable global pages for shared areas
      x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image
      x86/pti: Leave kernel text global for !PCID

Dmitry V. Levin (1):
      x86/uapi: Fix asm/bootparam.h userspace compilation errors

Joerg Roedel (1):
      x86/pgtable: Don't set huge PUD/PMD on non-leaf entries


 arch/x86/boot/compressed/kaslr.c      |   3 +
 arch/x86/entry/entry_64.S             |   4 +-
 arch/x86/include/asm/pgtable.h        |  27 ++++++--
 arch/x86/include/asm/pgtable_types.h  |  29 ++++----
 arch/x86/include/asm/pti.h            |   2 +
 arch/x86/include/uapi/asm/bootparam.h |  18 ++---
 arch/x86/kernel/espfix_64.c           |   4 ++
 arch/x86/kernel/head64.c              |   2 +
 arch/x86/kernel/head_64.S             |  11 ++-
 arch/x86/kernel/ldt.c                 |   6 +-
 arch/x86/mm/cpu_entry_area.c          |  14 +++-
 arch/x86/mm/ident_map.c               |   3 +
 arch/x86/mm/init.c                    |  14 ++--
 arch/x86/mm/init_32.c                 |   8 ++-
 arch/x86/mm/init_64.c                 |  11 +++
 arch/x86/mm/iomap_32.c                |   6 ++
 arch/x86/mm/ioremap.c                 |   3 +
 arch/x86/mm/kasan_init_64.c           |  14 +++-
 arch/x86/mm/pageattr.c                |  97 ++++++++++++--------------
 arch/x86/mm/pgtable.c                 |  12 ++++
 arch/x86/mm/pti.c                     | 126 ++++++++++++++++++++++++++++++++--
 arch/x86/power/hibernate_64.c         |  20 ++++--
 22 files changed, 329 insertions(+), 105 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 66e42a098d70..a0a50b91ecef 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -54,6 +54,9 @@ unsigned int ptrs_per_p4d __ro_after_init = 1;
 
 extern unsigned long get_cmd_line_ptr(void);
 
+/* Used by PAGE_KERN* macros: */
+pteval_t __default_kernel_pte_mask __read_mostly = ~0;
+
 /* Simplified build-specific string for starting entropy. */
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 936e19642eab..cb1d8a3b870b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -913,7 +913,7 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	.if \paranoid < 2
+	.if \paranoid == 1
 	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
 	jnz	.Lfrom_usermode_switch_stack_\@
 	.endif
@@ -960,7 +960,7 @@ ENTRY(\sym)
 	jmp	error_exit
 	.endif
 
-	.if \paranoid < 2
+	.if \paranoid == 1
 	/*
 	 * Entry from userspace.  Switch stacks and treat it
 	 * as a normal entry.  This means that paranoid handlers
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 89d5c8886c85..5f49b4ff0c24 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -526,22 +526,39 @@ static inline pgprotval_t massage_pgprot(pgprot_t pgprot)
 	return protval;
 }
 
+static inline pgprotval_t check_pgprot(pgprot_t pgprot)
+{
+	pgprotval_t massaged_val = massage_pgprot(pgprot);
+
+	/* mmdebug.h can not be included here because of dependencies */
+#ifdef CONFIG_DEBUG_VM
+	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
+		  "attempted to set unsupported pgprot: %016llx "
+		  "bits: %016llx supported: %016llx\n",
+		  (u64)pgprot_val(pgprot),
+		  (u64)pgprot_val(pgprot) ^ massaged_val,
+		  (u64)__supported_pte_mask);
+#endif
+
+	return massaged_val;
+}
+
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pte(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+		     check_pgprot(pgprot));
 }
 
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pmd(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+		     check_pgprot(pgprot));
 }
 
 static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pud(((phys_addr_t)page_nr << PAGE_SHIFT) |
-		     massage_pgprot(pgprot));
+		     check_pgprot(pgprot));
 }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
@@ -553,7 +570,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * the newprot (if present):
 	 */
 	val &= _PAGE_CHG_MASK;
-	val |= massage_pgprot(newprot) & ~_PAGE_CHG_MASK;
+	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
 
 	return __pte(val);
 }
@@ -563,7 +580,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	pmdval_t val = pmd_val(pmd);
 
 	val &= _HPAGE_CHG_MASK;
-	val |= massage_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
 
 	return __pmd(val);
 }
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index acfe755562a6..1e5a40673953 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -196,19 +196,21 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_NOENC	(__PAGE_KERNEL)
 #define __PAGE_KERNEL_NOENC_WP	(__PAGE_KERNEL_WP)
 
-#define PAGE_KERNEL		__pgprot(__PAGE_KERNEL | _PAGE_ENC)
-#define PAGE_KERNEL_NOENC	__pgprot(__PAGE_KERNEL)
-#define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO | _PAGE_ENC)
-#define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_EXEC_NOENC	__pgprot(__PAGE_KERNEL_EXEC)
-#define PAGE_KERNEL_RX		__pgprot(__PAGE_KERNEL_RX | _PAGE_ENC)
-#define PAGE_KERNEL_NOCACHE	__pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
-#define PAGE_KERNEL_LARGE	__pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
-#define PAGE_KERNEL_LARGE_EXEC	__pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
-#define PAGE_KERNEL_VVAR	__pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
-
-#define PAGE_KERNEL_IO		__pgprot(__PAGE_KERNEL_IO)
-#define PAGE_KERNEL_IO_NOCACHE	__pgprot(__PAGE_KERNEL_IO_NOCACHE)
+#define default_pgprot(x)	__pgprot((x) & __default_kernel_pte_mask)
+
+#define PAGE_KERNEL		default_pgprot(__PAGE_KERNEL | _PAGE_ENC)
+#define PAGE_KERNEL_NOENC	default_pgprot(__PAGE_KERNEL)
+#define PAGE_KERNEL_RO		default_pgprot(__PAGE_KERNEL_RO | _PAGE_ENC)
+#define PAGE_KERNEL_EXEC	default_pgprot(__PAGE_KERNEL_EXEC | _PAGE_ENC)
+#define PAGE_KERNEL_EXEC_NOENC	default_pgprot(__PAGE_KERNEL_EXEC)
+#define PAGE_KERNEL_RX		default_pgprot(__PAGE_KERNEL_RX | _PAGE_ENC)
+#define PAGE_KERNEL_NOCACHE	default_pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
+#define PAGE_KERNEL_LARGE	default_pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
+#define PAGE_KERNEL_LARGE_EXEC	default_pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
+#define PAGE_KERNEL_VVAR	default_pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
+
+#define PAGE_KERNEL_IO		default_pgprot(__PAGE_KERNEL_IO)
+#define PAGE_KERNEL_IO_NOCACHE	default_pgprot(__PAGE_KERNEL_IO_NOCACHE)
 
 #endif	/* __ASSEMBLY__ */
 
@@ -483,6 +485,7 @@ static inline pgprot_t pgprot_large_2_4k(pgprot_t pgprot)
 typedef struct page *pgtable_t;
 
 extern pteval_t __supported_pte_mask;
+extern pteval_t __default_kernel_pte_mask;
 extern void set_nx(void);
 extern int nx_enabled;
 
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 0b5ef05b2d2d..38a17f1d5c9d 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -6,8 +6,10 @@
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
+extern void pti_clone_kernel_text(void);
 #else
 static inline void pti_check_boottime_disable(void) { }
+static inline void pti_clone_kernel_text(void) { }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index aebf60357758..a06cbf019744 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -137,15 +137,15 @@ struct boot_e820_entry {
  * setup data structure.
  */
 struct jailhouse_setup_data {
-	u16	version;
-	u16	compatible_version;
-	u16	pm_timer_address;
-	u16	num_cpus;
-	u64	pci_mmconfig_base;
-	u32	tsc_khz;
-	u32	apic_khz;
-	u8	standard_ioapic;
-	u8	cpu_ids[255];
+	__u16	version;
+	__u16	compatible_version;
+	__u16	pm_timer_address;
+	__u16	num_cpus;
+	__u64	pci_mmconfig_base;
+	__u32	tsc_khz;
+	__u32	apic_khz;
+	__u8	standard_ioapic;
+	__u8	cpu_ids[255];
 } __attribute__((packed));
 
 /* The so-called "zeropage" */
diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index e5ec3cafa72e..aebd0d5bc086 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -195,6 +195,10 @@ void init_espfix_ap(int cpu)
 
 	pte_p = pte_offset_kernel(&pmd, addr);
 	stack_page = page_address(alloc_pages_node(node, GFP_KERNEL, 0));
+	/*
+	 * __PAGE_KERNEL_* includes _PAGE_GLOBAL, which we want since
+	 * this is mapped to userspace.
+	 */
 	pte = __pte(__pa(stack_page) | ((__PAGE_KERNEL_RO | _PAGE_ENC) & ptemask));
 	for (n = 0; n < ESPFIX_PTE_CLONES; n++)
 		set_pte(&pte_p[n*PTE_STRIDE], pte);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c855deee165..0c408f8c4ed4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -195,6 +195,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pud[i + 1] = (pudval_t)pmd + pgtable_flags;
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
+	/* Filter out unsupported __PAGE_KERNEL_* bits: */
+	pmd_entry &= __supported_pte_mask;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 48385c1074a5..8344dd2f310a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -399,8 +399,13 @@ NEXT_PAGE(level3_ident_pgt)
 	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.fill	511, 8, 0
 NEXT_PAGE(level2_ident_pgt)
-	/* Since I easily can, map the first 1G.
+	/*
+	 * Since I easily can, map the first 1G.
 	 * Don't set NX because code runs from these pages.
+	 *
+	 * Note: This sets _PAGE_GLOBAL despite whether
+	 * the CPU supports it or it is enabled.  But,
+	 * the CPU should ignore the bit.
 	 */
 	PMDS(0, __PAGE_KERNEL_IDENT_LARGE_EXEC, PTRS_PER_PMD)
 #else
@@ -431,6 +436,10 @@ NEXT_PAGE(level2_kernel_pgt)
 	 * (NOTE: at +512MB starts the module area, see MODULES_VADDR.
 	 *  If you want to increase this then increase MODULES_VADDR
 	 *  too.)
+	 *
+	 *  This table is eventually used by the kernel during normal
+	 *  runtime.  Care must be taken to clear out undesired bits
+	 *  later, like _PAGE_RW or _PAGE_GLOBAL in some cases.
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 26d713ecad34..d41d896481b8 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -145,6 +145,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		unsigned long offset = i << PAGE_SHIFT;
 		const void *src = (char *)ldt->entries + offset;
 		unsigned long pfn;
+		pgprot_t pte_prot;
 		pte_t pte, *ptep;
 
 		va = (unsigned long)ldt_slot_va(slot) + offset;
@@ -163,7 +164,10 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		 * target via some kernel interface which misses a
 		 * permission check.
 		 */
-		pte = pfn_pte(pfn, __pgprot(__PAGE_KERNEL_RO & ~_PAGE_GLOBAL));
+		pte_prot = __pgprot(__PAGE_KERNEL_RO & ~_PAGE_GLOBAL);
+		/* Filter out unsuppored __PAGE_KERNEL* bits: */
+		pgprot_val(pte_prot) |= __supported_pte_mask;
+		pte = pfn_pte(pfn, pte_prot);
 		set_pte_at(mm, va, ptep, pte);
 		pte_unmap_unlock(ptep, ptl);
 	}
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 476d810639a8..b45f5aaefd74 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -27,8 +27,20 @@ EXPORT_SYMBOL(get_cpu_entry_area);
 void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 {
 	unsigned long va = (unsigned long) cea_vaddr;
+	pte_t pte = pfn_pte(pa >> PAGE_SHIFT, flags);
 
-	set_pte_vaddr(va, pfn_pte(pa >> PAGE_SHIFT, flags));
+	/*
+	 * The cpu_entry_area is shared between the user and kernel
+	 * page tables.  All of its ptes can safely be global.
+	 * _PAGE_GLOBAL gets reused to help indicate PROT_NONE for
+	 * non-present PTEs, so be careful not to set it in that
+	 * case to avoid confusion.
+	 */
+	if (boot_cpu_has(X86_FEATURE_PGE) &&
+	    (pgprot_val(flags) & _PAGE_PRESENT))
+		pte = pte_set_flags(pte, _PAGE_GLOBAL);
+
+	set_pte_vaddr(va, pte);
 }
 
 static void __init
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 9aa22be8331e..a2f0c7e20fb0 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -98,6 +98,9 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 	if (!info->kernpg_flag)
 		info->kernpg_flag = _KERNPG_TABLE;
 
+	/* Filter out unsupported __PAGE_KERNEL_* bits: */
+	info->kernpg_flag &= __default_kernel_pte_mask;
+
 	for (; addr < end; addr = next) {
 		pgd_t *pgd = pgd_page + pgd_index(addr);
 		p4d_t *p4d;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 82f5252c723a..fec82b577c18 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -161,12 +161,6 @@ struct map_range {
 
 static int page_size_mask;
 
-static void enable_global_pages(void)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		__supported_pte_mask |= _PAGE_GLOBAL;
-}
-
 static void __init probe_page_size_mask(void)
 {
 	/*
@@ -187,9 +181,15 @@ static void __init probe_page_size_mask(void)
 	__supported_pte_mask &= ~_PAGE_GLOBAL;
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		cr4_set_bits_and_update_boot(X86_CR4_PGE);
-		enable_global_pages();
+		__supported_pte_mask |= _PAGE_GLOBAL;
 	}
 
+	/* By the default is everything supported: */
+	__default_kernel_pte_mask = __supported_pte_mask;
+	/* Except when with PTI where the kernel is mostly non-Global: */
+	if (cpu_feature_enabled(X86_FEATURE_PTI))
+		__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
+
 	/* Enable 1 GB linear kernel mappings if available: */
 	if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
 		printk(KERN_INFO "Using GB pages for direct mapping\n");
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 396e1f0151ac..07cdc2ed4965 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -558,8 +558,14 @@ static void __init pagetable_init(void)
 	permanent_kmaps_init(pgd_base);
 }
 
-pteval_t __supported_pte_mask __read_mostly = ~(_PAGE_NX | _PAGE_GLOBAL);
+#define DEFAULT_PTE_MASK ~(_PAGE_NX | _PAGE_GLOBAL)
+/* Bits supported by the hardware: */
+pteval_t __supported_pte_mask __read_mostly = DEFAULT_PTE_MASK;
+/* Bits allowed in normal kernel mappings: */
+pteval_t __default_kernel_pte_mask __read_mostly = DEFAULT_PTE_MASK;
 EXPORT_SYMBOL_GPL(__supported_pte_mask);
+/* Used in PAGE_KERNEL_* macros which are reasonably used out-of-tree: */
+EXPORT_SYMBOL(__default_kernel_pte_mask);
 
 /* user-defined highmem size */
 static unsigned int highmem_pages = -1;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 45241de66785..6d1ff39c2438 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -65,8 +65,13 @@
  * around without checking the pgd every time.
  */
 
+/* Bits supported by the hardware: */
 pteval_t __supported_pte_mask __read_mostly = ~0;
+/* Bits allowed in normal kernel mappings: */
+pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 EXPORT_SYMBOL_GPL(__supported_pte_mask);
+/* Used in PAGE_KERNEL_* macros which are reasonably used out-of-tree: */
+EXPORT_SYMBOL(__default_kernel_pte_mask);
 
 int force_personality32;
 
@@ -1285,6 +1290,12 @@ void mark_rodata_ro(void)
 			(unsigned long) __va(__pa_symbol(_sdata)));
 
 	debug_checkwx();
+
+	/*
+	 * Do this after all of the manipulation of the
+	 * kernel text page tables are complete.
+	 */
+	pti_clone_kernel_text();
 }
 
 int kern_addr_valid(unsigned long addr)
diff --git a/arch/x86/mm/iomap_32.c b/arch/x86/mm/iomap_32.c
index ada98b39b8ad..b3294d36769d 100644
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,6 +44,9 @@ int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot)
 		return ret;
 
 	*prot = __pgprot(__PAGE_KERNEL | cachemode2protval(pcm));
+	/* Filter out unsupported __PAGE_KERNEL* bits: */
+	pgprot_val(*prot) &= __default_kernel_pte_mask;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_create_wc);
@@ -88,6 +91,9 @@ iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
 		prot = __pgprot(__PAGE_KERNEL |
 				cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS));
 
+	/* Filter out unsupported __PAGE_KERNEL* bits: */
+	pgprot_val(prot) &= __default_kernel_pte_mask;
+
 	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
 }
 EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index e2db83bebc3b..c63a545ec199 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -816,6 +816,9 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 	}
 	pte = early_ioremap_pte(addr);
 
+	/* Sanitize 'prot' against any unsupported bits: */
+	pgprot_val(flags) &= __default_kernel_pte_mask;
+
 	if (pgprot_val(flags))
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
 	else
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index d8ff013ea9d0..980dbebd0ca7 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -269,6 +269,12 @@ void __init kasan_early_init(void)
 	pudval_t pud_val = __pa_nodebug(kasan_zero_pmd) | _KERNPG_TABLE;
 	p4dval_t p4d_val = __pa_nodebug(kasan_zero_pud) | _KERNPG_TABLE;
 
+	/* Mask out unsupported __PAGE_KERNEL bits: */
+	pte_val &= __default_kernel_pte_mask;
+	pmd_val &= __default_kernel_pte_mask;
+	pud_val &= __default_kernel_pte_mask;
+	p4d_val &= __default_kernel_pte_mask;
+
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		kasan_zero_pte[i] = __pte(pte_val);
 
@@ -371,7 +377,13 @@ void __init kasan_init(void)
 	 */
 	memset(kasan_zero_page, 0, PAGE_SIZE);
 	for (i = 0; i < PTRS_PER_PTE; i++) {
-		pte_t pte = __pte(__pa(kasan_zero_page) | __PAGE_KERNEL_RO | _PAGE_ENC);
+		pte_t pte;
+		pgprot_t prot;
+
+		prot = __pgprot(__PAGE_KERNEL_RO | _PAGE_ENC);
+		pgprot_val(prot) &= __default_kernel_pte_mask;
+
+		pte = __pte(__pa(kasan_zero_page) | pgprot_val(prot));
 		set_pte(&kasan_zero_pte[i], pte);
 	}
 	/* Flush TLBs again to be sure that write protection applied. */
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 85cf12219dea..0f3d50f4c48c 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -298,9 +298,11 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 
 	/*
 	 * The .rodata section needs to be read-only. Using the pfn
-	 * catches all aliases.
+	 * catches all aliases.  This also includes __ro_after_init,
+	 * so do not enforce until kernel_set_to_readonly is true.
 	 */
-	if (within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
+	if (kernel_set_to_readonly &&
+	    within(pfn, __pa_symbol(__start_rodata) >> PAGE_SHIFT,
 		   __pa_symbol(__end_rodata) >> PAGE_SHIFT))
 		pgprot_val(forbidden) |= _PAGE_RW;
 
@@ -512,6 +514,23 @@ static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
 #endif
 }
 
+static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
+{
+	/*
+	 * _PAGE_GLOBAL means "global page" for present PTEs.
+	 * But, it is also used to indicate _PAGE_PROTNONE
+	 * for non-present PTEs.
+	 *
+	 * This ensures that a _PAGE_GLOBAL PTE going from
+	 * present to non-present is not confused as
+	 * _PAGE_PROTNONE.
+	 */
+	if (!(pgprot_val(prot) & _PAGE_PRESENT))
+		pgprot_val(prot) &= ~_PAGE_GLOBAL;
+
+	return prot;
+}
+
 static int
 try_preserve_large_page(pte_t *kpte, unsigned long address,
 			struct cpa_data *cpa)
@@ -566,6 +585,7 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	 * up accordingly.
 	 */
 	old_pte = *kpte;
+	/* Clear PSE (aka _PAGE_PAT) and move PAT bit to correct position */
 	req_prot = pgprot_large_2_4k(old_prot);
 
 	pgprot_val(req_prot) &= ~pgprot_val(cpa->mask_clr);
@@ -577,19 +597,9 @@ try_preserve_large_page(pte_t *kpte, unsigned long address,
 	 * different bit positions in the two formats.
 	 */
 	req_prot = pgprot_4k_2_large(req_prot);
-
-	/*
-	 * Set the PSE and GLOBAL flags only if the PRESENT flag is
-	 * set otherwise pmd_present/pmd_huge will return true even on
-	 * a non present pmd. The canon_pgprot will clear _PAGE_GLOBAL
-	 * for the ancient hardware that doesn't support it.
-	 */
+	req_prot = pgprot_clear_protnone_bits(req_prot);
 	if (pgprot_val(req_prot) & _PAGE_PRESENT)
-		pgprot_val(req_prot) |= _PAGE_PSE | _PAGE_GLOBAL;
-	else
-		pgprot_val(req_prot) &= ~(_PAGE_PSE | _PAGE_GLOBAL);
-
-	req_prot = canon_pgprot(req_prot);
+		pgprot_val(req_prot) |= _PAGE_PSE;
 
 	/*
 	 * old_pfn points to the large page base pfn. So we need
@@ -674,8 +684,12 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	switch (level) {
 	case PG_LEVEL_2M:
 		ref_prot = pmd_pgprot(*(pmd_t *)kpte);
-		/* clear PSE and promote PAT bit to correct position */
+		/*
+		 * Clear PSE (aka _PAGE_PAT) and move
+		 * PAT bit to correct position.
+		 */
 		ref_prot = pgprot_large_2_4k(ref_prot);
+
 		ref_pfn = pmd_pfn(*(pmd_t *)kpte);
 		break;
 
@@ -698,23 +712,14 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		return 1;
 	}
 
-	/*
-	 * Set the GLOBAL flags only if the PRESENT flag is set
-	 * otherwise pmd/pte_present will return true even on a non
-	 * present pmd/pte. The canon_pgprot will clear _PAGE_GLOBAL
-	 * for the ancient hardware that doesn't support it.
-	 */
-	if (pgprot_val(ref_prot) & _PAGE_PRESENT)
-		pgprot_val(ref_prot) |= _PAGE_GLOBAL;
-	else
-		pgprot_val(ref_prot) &= ~_PAGE_GLOBAL;
+	ref_prot = pgprot_clear_protnone_bits(ref_prot);
 
 	/*
 	 * Get the target pfn from the original entry:
 	 */
 	pfn = ref_pfn;
 	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc)
-		set_pte(&pbase[i], pfn_pte(pfn, canon_pgprot(ref_prot)));
+		set_pte(&pbase[i], pfn_pte(pfn, ref_prot));
 
 	if (virt_addr_valid(address)) {
 		unsigned long pfn = PFN_DOWN(__pa(address));
@@ -930,19 +935,7 @@ static void populate_pte(struct cpa_data *cpa,
 
 	pte = pte_offset_kernel(pmd, start);
 
-	/*
-	 * Set the GLOBAL flags only if the PRESENT flag is
-	 * set otherwise pte_present will return true even on
-	 * a non present pte. The canon_pgprot will clear
-	 * _PAGE_GLOBAL for the ancient hardware that doesn't
-	 * support it.
-	 */
-	if (pgprot_val(pgprot) & _PAGE_PRESENT)
-		pgprot_val(pgprot) |= _PAGE_GLOBAL;
-	else
-		pgprot_val(pgprot) &= ~_PAGE_GLOBAL;
-
-	pgprot = canon_pgprot(pgprot);
+	pgprot = pgprot_clear_protnone_bits(pgprot);
 
 	while (num_pages-- && start < end) {
 		set_pte(pte, pfn_pte(cpa->pfn, pgprot));
@@ -1234,24 +1227,14 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 
 		new_prot = static_protections(new_prot, address, pfn);
 
-		/*
-		 * Set the GLOBAL flags only if the PRESENT flag is
-		 * set otherwise pte_present will return true even on
-		 * a non present pte. The canon_pgprot will clear
-		 * _PAGE_GLOBAL for the ancient hardware that doesn't
-		 * support it.
-		 */
-		if (pgprot_val(new_prot) & _PAGE_PRESENT)
-			pgprot_val(new_prot) |= _PAGE_GLOBAL;
-		else
-			pgprot_val(new_prot) &= ~_PAGE_GLOBAL;
+		new_prot = pgprot_clear_protnone_bits(new_prot);
 
 		/*
 		 * We need to keep the pfn from the existing PTE,
 		 * after all we're only going to change it's attributes
 		 * not the memory it points to
 		 */
-		new_pte = pfn_pte(pfn, canon_pgprot(new_prot));
+		new_pte = pfn_pte(pfn, new_prot);
 		cpa->pfn = pfn;
 		/*
 		 * Do we really change anything ?
@@ -1428,11 +1411,11 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	memset(&cpa, 0, sizeof(cpa));
 
 	/*
-	 * Check, if we are requested to change a not supported
-	 * feature:
+	 * Check, if we are requested to set a not supported
+	 * feature.  Clearing non-supported features is OK.
 	 */
 	mask_set = canon_pgprot(mask_set);
-	mask_clr = canon_pgprot(mask_clr);
+
 	if (!pgprot_val(mask_set) && !pgprot_val(mask_clr) && !force_split)
 		return 0;
 
@@ -1775,6 +1758,12 @@ int set_memory_4k(unsigned long addr, int numpages)
 					__pgprot(0), 1, 0, NULL);
 }
 
+int set_memory_nonglobal(unsigned long addr, int numpages)
+{
+	return change_page_attr_clear(&addr, numpages,
+				      __pgprot(_PAGE_GLOBAL), 0);
+}
+
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
 	struct cpa_data cpa;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 34cda7e0551b..ffc8c13c50e4 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/gfp.h>
+#include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
@@ -583,6 +584,9 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 void native_set_fixmap(enum fixed_addresses idx, phys_addr_t phys,
 		       pgprot_t flags)
 {
+	/* Sanitize 'prot' against any unsupported bits: */
+	pgprot_val(flags) &= __default_kernel_pte_mask;
+
 	__native_set_fixmap(idx, pfn_pte(phys >> PAGE_SHIFT, flags));
 }
 
@@ -636,6 +640,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	    (mtrr != MTRR_TYPE_WRBACK))
 		return 0;
 
+	/* Bail out if we are we on a populated non-leaf entry: */
+	if (pud_present(*pud) && !pud_huge(*pud))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pud, pfn_pte(
@@ -664,6 +672,10 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 		return 0;
 	}
 
+	/* Bail out if we are we on a populated non-leaf entry: */
+	if (pmd_present(*pmd) && !pmd_huge(*pmd))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pmd, pfn_pte(
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 631507f0c198..f1fd52f449e0 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -66,12 +66,22 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
+enum pti_mode {
+	PTI_AUTO = 0,
+	PTI_FORCE_OFF,
+	PTI_FORCE_ON
+} pti_mode;
+
 void __init pti_check_boottime_disable(void)
 {
 	char arg[5];
 	int ret;
 
+	/* Assume mode is auto unless overridden. */
+	pti_mode = PTI_AUTO;
+
 	if (hypervisor_is_type(X86_HYPER_XEN_PV)) {
+		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on XEN PV.");
 		return;
 	}
@@ -79,18 +89,23 @@ void __init pti_check_boottime_disable(void)
 	ret = cmdline_find_option(boot_command_line, "pti", arg, sizeof(arg));
 	if (ret > 0)  {
 		if (ret == 3 && !strncmp(arg, "off", 3)) {
+			pti_mode = PTI_FORCE_OFF;
 			pti_print_if_insecure("disabled on command line.");
 			return;
 		}
 		if (ret == 2 && !strncmp(arg, "on", 2)) {
+			pti_mode = PTI_FORCE_ON;
 			pti_print_if_secure("force enabled on command line.");
 			goto enable;
 		}
-		if (ret == 4 && !strncmp(arg, "auto", 4))
+		if (ret == 4 && !strncmp(arg, "auto", 4)) {
+			pti_mode = PTI_AUTO;
 			goto autosel;
+		}
 	}
 
 	if (cmdline_find_option_bool(boot_command_line, "nopti")) {
+		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on command line.");
 		return;
 	}
@@ -149,7 +164,7 @@ pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
  *
  * Returns a pointer to a P4D on success, or NULL on failure.
  */
-static __init p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
+static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
 {
 	pgd_t *pgd = kernel_to_user_pgdp(pgd_offset_k(address));
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
@@ -177,7 +192,7 @@ static __init p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
  *
  * Returns a pointer to a PMD on success, or NULL on failure.
  */
-static __init pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
+static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	p4d_t *p4d = pti_user_pagetable_walk_p4d(address);
@@ -267,7 +282,7 @@ static void __init pti_setup_vsyscall(void)
 static void __init pti_setup_vsyscall(void) { }
 #endif
 
-static void __init
+static void
 pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 {
 	unsigned long addr;
@@ -299,6 +314,27 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 		if (WARN_ON(!target_pmd))
 			return;
 
+		/*
+		 * Only clone present PMDs.  This ensures only setting
+		 * _PAGE_GLOBAL on present PMDs.  This should only be
+		 * called on well-known addresses anyway, so a non-
+		 * present PMD would be a surprise.
+		 */
+		if (WARN_ON(!(pmd_flags(*pmd) & _PAGE_PRESENT)))
+			return;
+
+		/*
+		 * Setting 'target_pmd' below creates a mapping in both
+		 * the user and kernel page tables.  It is effectively
+		 * global, so set it as global in both copies.  Note:
+		 * the X86_FEATURE_PGE check is not _required_ because
+		 * the CPU ignores _PAGE_GLOBAL when PGE is not
+		 * supported.  The check keeps consistentency with
+		 * code that only set this bit when supported.
+		 */
+		if (boot_cpu_has(X86_FEATURE_PGE))
+			*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
+
 		/*
 		 * Copy the PMD.  That is, the kernelmode and usermode
 		 * tables will share the last-level page tables of this
@@ -348,7 +384,83 @@ static void __init pti_clone_entry_text(void)
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
 			(unsigned long) __irqentry_text_end,
-		       _PAGE_RW | _PAGE_GLOBAL);
+		       _PAGE_RW);
+}
+
+/*
+ * Global pages and PCIDs are both ways to make kernel TLB entries
+ * live longer, reduce TLB misses and improve kernel performance.
+ * But, leaving all kernel text Global makes it potentially accessible
+ * to Meltdown-style attacks which make it trivial to find gadgets or
+ * defeat KASLR.
+ *
+ * Only use global pages when it is really worth it.
+ */
+static inline bool pti_kernel_image_global_ok(void)
+{
+	/*
+	 * Systems with PCIDs get litlle benefit from global
+	 * kernel text and are not worth the downsides.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_PCID))
+		return false;
+
+	/*
+	 * Only do global kernel image for pti=auto.  Do the most
+	 * secure thing (not global) if pti=on specified.
+	 */
+	if (pti_mode != PTI_AUTO)
+		return false;
+
+	/*
+	 * K8 may not tolerate the cleared _PAGE_RW on the userspace
+	 * global kernel image pages.  Do the safe thing (disable
+	 * global kernel image).  This is unlikely to ever be
+	 * noticed because PTI is disabled by default on AMD CPUs.
+	 */
+	if (boot_cpu_has(X86_FEATURE_K8))
+		return false;
+
+	return true;
+}
+
+/*
+ * For some configurations, map all of kernel text into the user page
+ * tables.  This reduces TLB misses, especially on non-PCID systems.
+ */
+void pti_clone_kernel_text(void)
+{
+	unsigned long start = PFN_ALIGN(_text);
+	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+
+	if (!pti_kernel_image_global_ok())
+		return;
+
+	pti_clone_pmds(start, end, _PAGE_RW);
+}
+
+/*
+ * This is the only user for it and it is not arch-generic like
+ * the other set_memory.h functions.  Just extern it.
+ */
+extern int set_memory_nonglobal(unsigned long addr, int numpages);
+void pti_set_kernel_image_nonglobal(void)
+{
+	/*
+	 * The identity map is created with PMDs, regardless of the
+	 * actual length of the kernel.  We need to clear
+	 * _PAGE_GLOBAL up to a PMD boundary, not just to the end
+	 * of the image.
+	 */
+	unsigned long start = PFN_ALIGN(_text);
+	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+
+	if (pti_kernel_image_global_ok())
+		return;
+
+	pr_debug("set kernel image non-global\n");
+
+	set_memory_nonglobal(start, (end - start) >> PAGE_SHIFT);
 }
 
 /*
@@ -362,6 +474,10 @@ void __init pti_init(void)
 	pr_info("enabled\n");
 
 	pti_clone_user_shared();
+
+	/* Undo all global bits from the init pagetables in head_64.S: */
+	pti_set_kernel_image_nonglobal();
+	/* Replace some of the global bits just for shared entry text: */
 	pti_clone_entry_text();
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 74a532989308..48b14b534897 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -51,6 +51,12 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 	pmd_t *pmd;
 	pud_t *pud;
 	p4d_t *p4d = NULL;
+	pgprot_t pgtable_prot = __pgprot(_KERNPG_TABLE);
+	pgprot_t pmd_text_prot = __pgprot(__PAGE_KERNEL_LARGE_EXEC);
+
+	/* Filter out unsupported __PAGE_KERNEL* bits: */
+	pgprot_val(pmd_text_prot) &= __default_kernel_pte_mask;
+	pgprot_val(pgtable_prot)  &= __default_kernel_pte_mask;
 
 	/*
 	 * The new mapping only has to cover the page containing the image
@@ -81,15 +87,19 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 		return -ENOMEM;
 
 	set_pmd(pmd + pmd_index(restore_jump_address),
-		__pmd((jump_address_phys & PMD_MASK) | __PAGE_KERNEL_LARGE_EXEC));
+		__pmd((jump_address_phys & PMD_MASK) | pgprot_val(pmd_text_prot)));
 	set_pud(pud + pud_index(restore_jump_address),
-		__pud(__pa(pmd) | _KERNPG_TABLE));
+		__pud(__pa(pmd) | pgprot_val(pgtable_prot)));
 	if (p4d) {
-		set_p4d(p4d + p4d_index(restore_jump_address), __p4d(__pa(pud) | _KERNPG_TABLE));
-		set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(p4d) | _KERNPG_TABLE));
+		p4d_t new_p4d = __p4d(__pa(pud) | pgprot_val(pgtable_prot));
+		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
+
+		set_p4d(p4d + p4d_index(restore_jump_address), new_p4d);
+		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	} else {
 		/* No p4d for 4-level paging: point the pgd to the pud page table */
-		set_pgd(pgd + pgd_index(restore_jump_address), __pgd(__pa(pud) | _KERNPG_TABLE));
+		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
+		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	}
 
 	return 0;
