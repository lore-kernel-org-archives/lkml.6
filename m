Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030239AbeBNNRY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:17:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030218AbeBNNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:17:23 -0500
Date: Wed, 14 Feb 2018 05:06:54 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-c65e774fb3f6af212641538694b9778ff9ab4300@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
        luto@amacapital.net, torvalds@linux-foundation.org, bp@suse.de
Reply-To: luto@amacapital.net, torvalds@linux-foundation.org, bp@suse.de,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        peterz@infradead.org
In-Reply-To: <20180214111656.88514-7-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-7-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Make PGDIR_SHIFT and PTRS_PER_P4D variable
Git-Commit-ID: c65e774fb3f6af212641538694b9778ff9ab4300
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

Commit-ID:  c65e774fb3f6af212641538694b9778ff9ab4300
Gitweb:     https://git.kernel.org/tip/c65e774fb3f6af212641538694b9778ff9ab4300
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:53 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:14 +0100

x86/mm: Make PGDIR_SHIFT and PTRS_PER_P4D variable

For boot-time switching between 4- and 5-level paging we need to be able
to fold p4d page table level at runtime. It requires variable
PGDIR_SHIFT and PTRS_PER_P4D.

The change doesn't affect the kernel image size much:

   text	   data	    bss	    dec	    hex	filename
8628091	4734304	1368064	14730459	 e0c4db	vmlinux.before
8628393	4734340	1368064	14730797	 e0c62d	vmlinux.after

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-7-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c        |  2 ++
 arch/x86/include/asm/pgtable_32.h       |  2 ++
 arch/x86/include/asm/pgtable_64_types.h | 19 ++++++++++++-------
 arch/x86/kernel/cpu/mcheck/mce.c        | 18 ++++++------------
 arch/x86/kernel/head64.c                |  6 +++++-
 arch/x86/mm/dump_pagetables.c           | 12 +++++-------
 arch/x86/mm/init_64.c                   |  2 +-
 arch/x86/mm/kasan_init_64.c             |  2 +-
 arch/x86/platform/efi/efi_64.c          |  4 ++--
 include/asm-generic/5level-fixup.h      |  1 +
 include/asm-generic/pgtable-nop4d.h     |  9 +++++----
 include/linux/kasan.h                   |  2 +-
 mm/kasan/kasan_init.c                   |  2 +-
 13 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index bd69e18..b18e8f9 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -48,6 +48,8 @@
 
 #ifdef CONFIG_X86_5LEVEL
 unsigned int pgtable_l5_enabled __ro_after_init = 1;
+unsigned int pgdir_shift __ro_after_init = 48;
+unsigned int ptrs_per_p4d __ro_after_init = 512;
 #endif
 
 extern unsigned long get_cmd_line_ptr(void);
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index e67c062..d829360 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -33,6 +33,8 @@ static inline void pgtable_cache_init(void) { }
 static inline void check_pgt_cache(void) { }
 void paging_init(void);
 
+static inline int pgd_large(pgd_t pgd) { return 0; }
+
 /*
  * Define this if things work differently on an i386 and an i486:
  * it will (on an i486) warn about kernel memory accesses that are
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 903e4d05..0c48d80 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -26,6 +26,9 @@ extern unsigned int pgtable_l5_enabled;
 #define pgtable_l5_enabled 0
 #endif
 
+extern unsigned int pgdir_shift;
+extern unsigned int ptrs_per_p4d;
+
 #endif	/* !__ASSEMBLY__ */
 
 #define SHARED_KERNEL_PMD	0
@@ -35,16 +38,17 @@ extern unsigned int pgtable_l5_enabled;
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
-#define PGDIR_SHIFT	48
+#define PGDIR_SHIFT	pgdir_shift
 #define PTRS_PER_PGD	512
 
 /*
  * 4th level page in 5-level paging case
  */
-#define P4D_SHIFT	39
-#define PTRS_PER_P4D	512
-#define P4D_SIZE	(_AC(1, UL) << P4D_SHIFT)
-#define P4D_MASK	(~(P4D_SIZE - 1))
+#define P4D_SHIFT		39
+#define MAX_PTRS_PER_P4D	512
+#define PTRS_PER_P4D		ptrs_per_p4d
+#define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
+#define P4D_MASK		(~(P4D_SIZE - 1))
 
 #define MAX_POSSIBLE_PHYSMEM_BITS	52
 
@@ -53,8 +57,9 @@ extern unsigned int pgtable_l5_enabled;
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
-#define PGDIR_SHIFT	39
-#define PTRS_PER_PGD	512
+#define PGDIR_SHIFT		39
+#define PTRS_PER_PGD		512
+#define MAX_PTRS_PER_P4D	1
 
 #endif /* CONFIG_X86_5LEVEL */
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 3a8e88a..cbb3af7 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1082,19 +1082,7 @@ void arch_unmap_kpfn(unsigned long pfn)
 	 * a legal address.
 	 */
 
-/*
- * Build time check to see if we have a spare virtual bit. Don't want
- * to leave this until run time because most developers don't have a
- * system that can exercise this code path. This will only become a
- * problem if/when we move beyond 5-level page tables.
- *
- * Hard code "9" here because cpp doesn't grok ilog2(PTRS_PER_PGD)
- */
-#if PGDIR_SHIFT + 9 < 63
 	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
-#else
-#error "no unused virtual bit available"
-#endif
 
 	if (set_memory_np(decoy_addr, 1))
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
@@ -2328,6 +2316,12 @@ static __init int mcheck_init_device(void)
 {
 	int err;
 
+	/*
+	 * Check if we have a spare virtual bit. This will only become
+	 * a problem if/when we move beyond 5-level page tables.
+	 */
+	MAYBE_BUILD_BUG_ON(__VIRTUAL_MASK_SHIFT >= 63);
+
 	if (!mce_available(&boot_cpu_data)) {
 		err = -EIO;
 		goto err_out;
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 17d00d1..98b0ff4 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -42,6 +42,10 @@ pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 #ifdef CONFIG_X86_5LEVEL
 unsigned int pgtable_l5_enabled __ro_after_init = 1;
 EXPORT_SYMBOL(pgtable_l5_enabled);
+unsigned int pgdir_shift __ro_after_init = 48;
+EXPORT_SYMBOL(pgdir_shift);
+unsigned int ptrs_per_p4d __ro_after_init = 512;
+EXPORT_SYMBOL(ptrs_per_p4d);
 #endif
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
@@ -336,7 +340,7 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	BUILD_BUG_ON((__START_KERNEL_map & ~PMD_MASK) != 0);
 	BUILD_BUG_ON((MODULES_VADDR & ~PMD_MASK) != 0);
 	BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
-	BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
+	MAYBE_BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a89f2db..420058b 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -428,14 +428,15 @@ static void walk_pud_level(struct seq_file *m, struct pg_state *st, p4d_t addr,
 #define p4d_none(a)  pud_none(__pud(p4d_val(a)))
 #endif
 
-#if PTRS_PER_P4D > 1
-
 static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr, unsigned long P)
 {
 	int i;
 	p4d_t *start, *p4d_start;
 	pgprotval_t prot;
 
+	if (PTRS_PER_P4D == 1)
+		return walk_pud_level(m, st, __p4d(pgd_val(addr)), P);
+
 	p4d_start = start = (p4d_t *)pgd_page_vaddr(addr);
 
 	for (i = 0; i < PTRS_PER_P4D; i++) {
@@ -455,11 +456,8 @@ static void walk_p4d_level(struct seq_file *m, struct pg_state *st, pgd_t addr,
 	}
 }
 
-#else
-#define walk_p4d_level(m,s,a,p) walk_pud_level(m,s,__p4d(pgd_val(a)),p)
-#define pgd_large(a) p4d_large(__p4d(pgd_val(a)))
-#define pgd_none(a)  p4d_none(__p4d(pgd_val(a)))
-#endif
+#define pgd_large(a) (pgtable_l5_enabled ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
+#define pgd_none(a)  (pgtable_l5_enabled ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
 
 static inline bool is_hypervisor_range(int idx)
 {
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 1ab42c8..6a4b20b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -143,7 +143,7 @@ void sync_global_pgds(unsigned long start, unsigned long end)
 		 * With folded p4d, pgd_none() is always false, we need to
 		 * handle synchonization on p4d level.
 		 */
-		BUILD_BUG_ON(pgd_none(*pgd_ref));
+		MAYBE_BUILD_BUG_ON(pgd_none(*pgd_ref));
 		p4d_ref = p4d_offset(pgd_ref, addr);
 
 		if (p4d_none(*p4d_ref))
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index af6f2f9..12ec90f 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -19,7 +19,7 @@
 
 extern struct range pfn_mapped[E820_MAX_ENTRIES];
 
-static p4d_t tmp_p4d_table[PTRS_PER_P4D] __initdata __aligned(PAGE_SIZE);
+static p4d_t tmp_p4d_table[MAX_PTRS_PER_P4D] __initdata __aligned(PAGE_SIZE);
 
 static __init void *early_alloc(size_t size, int nid, bool panic)
 {
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 780460a..d52aaa7 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -257,8 +257,8 @@ void efi_sync_low_kernel_mappings(void)
 	 * only span a single PGD entry and that the entry also maps
 	 * other important kernel regions.
 	 */
-	BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
-	BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
+	MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
+	MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
 			(EFI_VA_END & PGDIR_MASK));
 
 	pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index dfbd9d9..9c2e070 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -8,6 +8,7 @@
 #define P4D_SHIFT			PGDIR_SHIFT
 #define P4D_SIZE			PGDIR_SIZE
 #define P4D_MASK			PGDIR_MASK
+#define MAX_PTRS_PER_P4D		1
 #define PTRS_PER_P4D			1
 
 #define p4d_t				pgd_t
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 8f22f55..1a29b2a 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -8,10 +8,11 @@
 
 typedef struct { pgd_t pgd; } p4d_t;
 
-#define P4D_SHIFT	PGDIR_SHIFT
-#define PTRS_PER_P4D	1
-#define P4D_SIZE	(1UL << P4D_SHIFT)
-#define P4D_MASK	(~(P4D_SIZE-1))
+#define P4D_SHIFT		PGDIR_SHIFT
+#define MAX_PTRS_PER_P4D	1
+#define PTRS_PER_P4D		1
+#define P4D_SIZE		(1UL << P4D_SHIFT)
+#define P4D_MASK		(~(P4D_SIZE-1))
 
 /*
  * The "pgd_xxx()" functions here are trivial for a folded two-level
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index adc1347..d6459bd 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -18,7 +18,7 @@ extern unsigned char kasan_zero_page[PAGE_SIZE];
 extern pte_t kasan_zero_pte[PTRS_PER_PTE];
 extern pmd_t kasan_zero_pmd[PTRS_PER_PMD];
 extern pud_t kasan_zero_pud[PTRS_PER_PUD];
-extern p4d_t kasan_zero_p4d[PTRS_PER_P4D];
+extern p4d_t kasan_zero_p4d[MAX_PTRS_PER_P4D];
 
 void kasan_populate_zero_shadow(const void *shadow_start,
 				const void *shadow_end);
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index 554e4c0..f436246 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -31,7 +31,7 @@
 unsigned char kasan_zero_page[PAGE_SIZE] __page_aligned_bss;
 
 #if CONFIG_PGTABLE_LEVELS > 4
-p4d_t kasan_zero_p4d[PTRS_PER_P4D] __page_aligned_bss;
+p4d_t kasan_zero_p4d[MAX_PTRS_PER_P4D] __page_aligned_bss;
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
 pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
