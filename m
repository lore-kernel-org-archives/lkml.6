Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeESLfG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:35:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbeESLfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:35:04 -0400
Date: Sat, 19 May 2018 04:34:43 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-ed7588d5dc6f5e7202fb9bbeb14d94706ba225d7@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hughd@google.com
Reply-To: linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        hughd@google.com, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20180518103528.59260-4-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-4-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/mm: Stop pretending pgtable_l5_enabled is a
 variable
Git-Commit-ID: ed7588d5dc6f5e7202fb9bbeb14d94706ba225d7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ed7588d5dc6f5e7202fb9bbeb14d94706ba225d7
Gitweb:     https://git.kernel.org/tip/ed7588d5dc6f5e7202fb9bbeb14d94706ba225d7
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 18 May 2018 13:35:24 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 11:56:57 +0200

x86/mm: Stop pretending pgtable_l5_enabled is a variable

pgtable_l5_enabled is defined using cpu_feature_enabled() but we refer
to it as a variable. This is misleading.

Make pgtable_l5_enabled() a function.

We cannot literally define it as a function due to circular dependencies
between header files. Function-alike macros is close enough.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180518103528.59260-4-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_64_types.h    |  2 +-
 arch/x86/include/asm/paravirt.h         |  4 ++--
 arch/x86/include/asm/pgalloc.h          |  4 ++--
 arch/x86/include/asm/pgtable.h          | 10 +++++-----
 arch/x86/include/asm/pgtable_32_types.h |  2 +-
 arch/x86/include/asm/pgtable_64.h       |  2 +-
 arch/x86/include/asm/pgtable_64_types.h | 14 +++++++++-----
 arch/x86/include/asm/sparsemem.h        |  4 ++--
 arch/x86/kernel/head64.c                |  2 +-
 arch/x86/kernel/machine_kexec_64.c      |  3 ++-
 arch/x86/mm/dump_pagetables.c           |  6 +++---
 arch/x86/mm/fault.c                     |  4 ++--
 arch/x86/mm/ident_map.c                 |  2 +-
 arch/x86/mm/init_64.c                   |  8 ++++----
 arch/x86/mm/kasan_init_64.c             |  8 ++++----
 arch/x86/mm/kaslr.c                     |  8 ++++----
 arch/x86/mm/tlb.c                       |  2 +-
 arch/x86/platform/efi/efi_64.c          |  2 +-
 arch/x86/power/hibernate_64.c           |  2 +-
 19 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 2c5a966dc222..6afac386a434 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -53,7 +53,7 @@
 #define __PHYSICAL_MASK_SHIFT	52
 
 #ifdef CONFIG_X86_5LEVEL
-#define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled ? 56 : 47)
+#define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled() ? 56 : 47)
 #else
 #define __VIRTUAL_MASK_SHIFT	47
 #endif
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 9be2bf13825b..d49bbf4bb5c8 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -574,14 +574,14 @@ static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 }
 
 #define set_pgd(pgdp, pgdval) do {					\
-	if (pgtable_l5_enabled)						\
+	if (pgtable_l5_enabled())						\
 		__set_pgd(pgdp, pgdval);				\
 	else								\
 		set_p4d((p4d_t *)(pgdp), (p4d_t) { (pgdval).pgd });	\
 } while (0)
 
 #define pgd_clear(pgdp) do {						\
-	if (pgtable_l5_enabled)						\
+	if (pgtable_l5_enabled())						\
 		set_pgd(pgdp, __pgd(0));				\
 } while (0)
 
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 263c142a6a6c..ada6410fd2ec 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -167,7 +167,7 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #if CONFIG_PGTABLE_LEVELS > 4
 static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
 {
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		return;
 	paravirt_alloc_p4d(mm, __pa(p4d) >> PAGE_SHIFT);
 	set_pgd(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
@@ -193,7 +193,7 @@ extern void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d);
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long address)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled())
 		___p4d_free_tlb(tlb, p4d);
 }
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f1633de5a675..5715647fc4fe 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -65,7 +65,7 @@ extern pmdval_t early_pmd_flags;
 
 #ifndef __PAGETABLE_P4D_FOLDED
 #define set_pgd(pgdp, pgd)		native_set_pgd(pgdp, pgd)
-#define pgd_clear(pgd)			(pgtable_l5_enabled ? native_pgd_clear(pgd) : 0)
+#define pgd_clear(pgd)			(pgtable_l5_enabled() ? native_pgd_clear(pgd) : 0)
 #endif
 
 #ifndef set_p4d
@@ -881,7 +881,7 @@ static inline unsigned long p4d_index(unsigned long address)
 #if CONFIG_PGTABLE_LEVELS > 4
 static inline int pgd_present(pgd_t pgd)
 {
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		return 1;
 	return pgd_flags(pgd) & _PAGE_PRESENT;
 }
@@ -900,7 +900,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 /* to find an entry in a page-table-directory. */
 static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		return (p4d_t *)pgd;
 	return (p4d_t *)pgd_page_vaddr(*pgd) + p4d_index(address);
 }
@@ -909,7 +909,7 @@ static inline int pgd_bad(pgd_t pgd)
 {
 	unsigned long ignore_flags = _PAGE_USER;
 
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		return 0;
 
 	if (IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
@@ -920,7 +920,7 @@ static inline int pgd_bad(pgd_t pgd)
 
 static inline int pgd_none(pgd_t pgd)
 {
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		return 0;
 	/*
 	 * There is no need to do a workaround for the KNL stray
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index e3225e83db7d..d9a001a4a872 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -15,7 +15,7 @@
 # include <asm/pgtable-2level_types.h>
 #endif
 
-#define pgtable_l5_enabled 0
+#define pgtable_l5_enabled() 0
 
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE - 1))
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 877bc27718ae..3c5385f9a88f 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -220,7 +220,7 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
-	if (pgtable_l5_enabled || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
+	if (pgtable_l5_enabled() || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
 		*p4dp = p4d;
 		return;
 	}
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index c14a4116a693..054765ab2da2 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -28,12 +28,16 @@ extern unsigned int __pgtable_l5_enabled;
  * cpu_feature_enabled() is not available in early boot code.
  * Use variable instead.
  */
-#define pgtable_l5_enabled __pgtable_l5_enabled
+static inline bool pgtable_l5_enabled(void)
+{
+	return __pgtable_l5_enabled;
+}
 #else
-#define pgtable_l5_enabled cpu_feature_enabled(X86_FEATURE_LA57)
+#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
+
 #else
-#define pgtable_l5_enabled 0
+#define pgtable_l5_enabled() 0
 #endif /* CONFIG_X86_5LEVEL */
 
 extern unsigned int pgdir_shift;
@@ -109,7 +113,7 @@ extern unsigned int ptrs_per_p4d;
 
 #define LDT_PGD_ENTRY_L4	-3UL
 #define LDT_PGD_ENTRY_L5	-112UL
-#define LDT_PGD_ENTRY		(pgtable_l5_enabled ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
+#define LDT_PGD_ENTRY		(pgtable_l5_enabled() ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 
 #define __VMALLOC_BASE_L4	0xffffc90000000000UL
@@ -123,7 +127,7 @@ extern unsigned int ptrs_per_p4d;
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
-# define VMALLOC_SIZE_TB	(pgtable_l5_enabled ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
+# define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
 # define VMEMMAP_START		vmemmap_base
 #else
 # define VMALLOC_START		__VMALLOC_BASE_L4
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 4617a2bf123c..199218719a86 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -27,8 +27,8 @@
 # endif
 #else /* CONFIG_X86_32 */
 # define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
-# define MAX_PHYSADDR_BITS	(pgtable_l5_enabled ? 52 : 44)
-# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled ? 52 : 46)
+# define MAX_PHYSADDR_BITS	(pgtable_l5_enabled() ? 52 : 44)
+# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)
 #endif
 
 #endif /* CONFIG_SPARSEMEM */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 494fea1dbd6e..8d372d1c266d 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -279,7 +279,7 @@ again:
 	 * critical -- __PAGE_OFFSET would point us back into the dynamic
 	 * range and we might end up looping forever...
 	 */
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		p4d_p = pgd_p;
 	else if (pgd)
 		p4d_p = (p4dval_t *)((pgd & PTE_PFN_MASK) + __START_KERNEL_map - phys_base);
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 6010449ca6d2..4c8acdfdc5a7 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -354,7 +354,8 @@ void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_top_pgt);
-	VMCOREINFO_NUMBER(pgtable_l5_enabled);
+	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
+			pgtable_l5_enabled());
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index cc7ff5957194..2f3c9196b834 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -360,7 +360,7 @@ static inline bool kasan_page_table(struct seq_file *m, struct pg_state *st,
 				void *pt)
 {
 	if (__pa(pt) == __pa(kasan_zero_pmd) ||
-	    (pgtable_l5_enabled && __pa(pt) == __pa(kasan_zero_p4d)) ||
+	    (pgtable_l5_enabled() && __pa(pt) == __pa(kasan_zero_p4d)) ||
 	    __pa(pt) == __pa(kasan_zero_pud)) {
 		pgprotval_t prot = pte_flags(kasan_zero_pte[0]);
 		note_page(m, st, __pgprot(prot), 0, 5);
@@ -476,8 +476,8 @@ static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
 	}
 }
 
-#define pgd_large(a) (pgtable_l5_enabled ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
-#define pgd_none(a)  (pgtable_l5_enabled ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
+#define pgd_large(a) (pgtable_l5_enabled() ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
+#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
 
 static inline bool is_hypervisor_range(int idx)
 {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 73bd8c95ac71..77ec014554e7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -439,7 +439,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (pgd_none(*pgd_k))
 		return -1;
 
-	if (pgtable_l5_enabled) {
+	if (pgtable_l5_enabled()) {
 		if (pgd_none(*pgd)) {
 			set_pgd(pgd, *pgd_k);
 			arch_flush_lazy_mmu_mode();
@@ -454,7 +454,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	if (p4d_none(*p4d_k))
 		return -1;
 
-	if (p4d_none(*p4d) && !pgtable_l5_enabled) {
+	if (p4d_none(*p4d) && !pgtable_l5_enabled()) {
 		set_p4d(p4d, *p4d_k);
 		arch_flush_lazy_mmu_mode();
 	} else {
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index a2f0c7e20fb0..fe7a12599d8e 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -123,7 +123,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		result = ident_p4d_init(info, p4d, addr, next);
 		if (result)
 			return result;
-		if (pgtable_l5_enabled) {
+		if (pgtable_l5_enabled()) {
 			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag));
 		} else {
 			/*
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0a400606dea0..17383f9677fa 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -180,7 +180,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
  */
 void sync_global_pgds(unsigned long start, unsigned long end)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled())
 		sync_global_pgds_l5(start, end);
 	else
 		sync_global_pgds_l4(start, end);
@@ -643,7 +643,7 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 	unsigned long vaddr = (unsigned long)__va(paddr);
 	int i = p4d_index(vaddr);
 
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end, page_size_mask);
 
 	for (; i < PTRS_PER_P4D; i++, paddr = paddr_next) {
@@ -723,7 +723,7 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 					   page_size_mask);
 
 		spin_lock(&init_mm.page_table_lock);
-		if (pgtable_l5_enabled)
+		if (pgtable_l5_enabled())
 			pgd_populate(&init_mm, pgd, p4d);
 		else
 			p4d_populate(&init_mm, p4d_offset(pgd, vaddr), (pud_t *) p4d);
@@ -1100,7 +1100,7 @@ remove_p4d_table(p4d_t *p4d_start, unsigned long addr, unsigned long end,
 		 * 5-level case we should free them. This code will have to change
 		 * to adapt for boot-time switching between 4 and 5 level page tables.
 		 */
-		if (pgtable_l5_enabled)
+		if (pgtable_l5_enabled())
 			free_pud_table(pud_base, p4d);
 	}
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 340bb9b32e01..e3e77527f8df 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -180,7 +180,7 @@ static void __init clear_pgds(unsigned long start,
 		 * With folded p4d, pgd_clear() is nop, use p4d_clear()
 		 * instead.
 		 */
-		if (pgtable_l5_enabled)
+		if (pgtable_l5_enabled())
 			pgd_clear(pgd);
 		else
 			p4d_clear(p4d_offset(pgd, start));
@@ -195,7 +195,7 @@ static inline p4d_t *early_p4d_offset(pgd_t *pgd, unsigned long addr)
 {
 	unsigned long p4d;
 
-	if (!pgtable_l5_enabled)
+	if (!pgtable_l5_enabled())
 		return (p4d_t *)pgd;
 
 	p4d = __pa_nodebug(pgd_val(*pgd)) & PTE_PFN_MASK;
@@ -282,7 +282,7 @@ void __init kasan_early_init(void)
 	for (i = 0; i < PTRS_PER_PUD; i++)
 		kasan_zero_pud[i] = __pud(pud_val);
 
-	for (i = 0; pgtable_l5_enabled && i < PTRS_PER_P4D; i++)
+	for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
 		kasan_zero_p4d[i] = __p4d(p4d_val);
 
 	kasan_map_early_shadow(early_top_pgt);
@@ -313,7 +313,7 @@ void __init kasan_init(void)
 	 * bunch of things like kernel code, modules, EFI mapping, etc.
 	 * We need to take extra steps to not overwrite them.
 	 */
-	if (pgtable_l5_enabled) {
+	if (pgtable_l5_enabled()) {
 		void *ptr;
 
 		ptr = (void *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_END));
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 615cc03ced84..61db77b0eda9 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -78,7 +78,7 @@ void __init kernel_randomize_memory(void)
 	struct rnd_state rand_state;
 	unsigned long remain_entropy;
 
-	vaddr_start = pgtable_l5_enabled ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
+	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
 	vaddr = vaddr_start;
 
 	/*
@@ -124,7 +124,7 @@ void __init kernel_randomize_memory(void)
 		 */
 		entropy = remain_entropy / (ARRAY_SIZE(kaslr_regions) - i);
 		prandom_bytes_state(&rand_state, &rand, sizeof(rand));
-		if (pgtable_l5_enabled)
+		if (pgtable_l5_enabled())
 			entropy = (rand % (entropy + 1)) & P4D_MASK;
 		else
 			entropy = (rand % (entropy + 1)) & PUD_MASK;
@@ -136,7 +136,7 @@ void __init kernel_randomize_memory(void)
 		 * randomization alignment.
 		 */
 		vaddr += get_padding(&kaslr_regions[i]);
-		if (pgtable_l5_enabled)
+		if (pgtable_l5_enabled())
 			vaddr = round_up(vaddr + 1, P4D_SIZE);
 		else
 			vaddr = round_up(vaddr + 1, PUD_SIZE);
@@ -212,7 +212,7 @@ void __meminit init_trampoline(void)
 		return;
 	}
 
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled())
 		init_trampoline_p4d();
 	else
 		init_trampoline_pud();
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e055d1a06699..6eb1f34c3c85 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -157,7 +157,7 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 	unsigned long sp = current_stack_pointer;
 	pgd_t *pgd = pgd_offset(mm, sp);
 
-	if (pgtable_l5_enabled) {
+	if (pgtable_l5_enabled()) {
 		if (unlikely(pgd_none(*pgd))) {
 			pgd_t *pgd_ref = pgd_offset_k(sp);
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index bed7e7f4e44c..e01f7ceb9e7a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -225,7 +225,7 @@ int __init efi_alloc_page_tables(void)
 
 	pud = pud_alloc(&init_mm, p4d, EFI_VA_END);
 	if (!pud) {
-		if (pgtable_l5_enabled)
+		if (pgtable_l5_enabled())
 			free_page((unsigned long) pgd_page_vaddr(*pgd));
 		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
 		return -ENOMEM;
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index ccf4a49bb065..67ccf64c8bd8 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -72,7 +72,7 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 	 * tables used by the image kernel.
 	 */
 
-	if (pgtable_l5_enabled) {
+	if (pgtable_l5_enabled()) {
 		p4d = (p4d_t *)get_safe_page(GFP_ATOMIC);
 		if (!p4d)
 			return -ENOMEM;
