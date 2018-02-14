Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967830AbeBNNPt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:15:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967717AbeBNNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:15:48 -0500
Date: Wed, 14 Feb 2018 05:05:23 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-eedb92abb9bb03ef21442614a6f5867eaac6e77f@git.kernel.org>
Cc: peterz@infradead.org, luto@amacapital.net, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bp@suse.de, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org, luto@amacapital.net,
        peterz@infradead.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, bp@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180214111656.88514-4-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-4-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Make virtual memory layout dynamic for
 CONFIG_X86_5LEVEL=y
Git-Commit-ID: eedb92abb9bb03ef21442614a6f5867eaac6e77f
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

Commit-ID:  eedb92abb9bb03ef21442614a6f5867eaac6e77f
Gitweb:     https://git.kernel.org/tip/eedb92abb9bb03ef21442614a6f5867eaac6e77f
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:50 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:13 +0100

x86/mm: Make virtual memory layout dynamic for CONFIG_X86_5LEVEL=y

We need to be able to adjust virtual memory layout at runtime to be able
to switch between 4- and 5-level paging at boot-time.

KASLR already has movable __VMALLOC_BASE, __VMEMMAP_BASE and __PAGE_OFFSET.
Let's re-use it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-4-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig                        | 8 ++++++++
 arch/x86/include/asm/kaslr.h            | 4 ----
 arch/x86/include/asm/page_64.h          | 4 ++++
 arch/x86/include/asm/page_64_types.h    | 4 ++--
 arch/x86/include/asm/pgtable_64_types.h | 4 ++--
 arch/x86/kernel/head64.c                | 9 +++++++++
 arch/x86/mm/kaslr.c                     | 8 --------
 7 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 63bf349..9225648 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1430,6 +1430,7 @@ config X86_PAE
 
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
+	select DYNAMIC_MEMORY_LAYOUT
 	depends on X86_64
 	---help---
 	  5-level paging enables access to larger address space:
@@ -2143,10 +2144,17 @@ config PHYSICAL_ALIGN
 
 	  Don't change this unless you know what you are doing.
 
+config DYNAMIC_MEMORY_LAYOUT
+	bool
+	---help---
+	  This option makes base addresses of vmalloc and vmemmap as well as
+	  __PAGE_OFFSET movable during boot.
+
 config RANDOMIZE_MEMORY
 	bool "Randomize the kernel memory sections"
 	depends on X86_64
 	depends on RANDOMIZE_BASE
+	select DYNAMIC_MEMORY_LAYOUT
 	default RANDOMIZE_BASE
 	---help---
 	   Randomizes the base virtual address of kernel memory sections
diff --git a/arch/x86/include/asm/kaslr.h b/arch/x86/include/asm/kaslr.h
index 460991e..db7ba2f 100644
--- a/arch/x86/include/asm/kaslr.h
+++ b/arch/x86/include/asm/kaslr.h
@@ -5,10 +5,6 @@
 unsigned long kaslr_get_random_long(const char *purpose);
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
-extern unsigned long page_offset_base;
-extern unsigned long vmalloc_base;
-extern unsigned long vmemmap_base;
-
 void kernel_randomize_memory(void);
 #else
 static inline void kernel_randomize_memory(void) { }
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4baa6bc..09637865 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -11,6 +11,10 @@
 extern unsigned long max_pfn;
 extern unsigned long phys_base;
 
+extern unsigned long page_offset_base;
+extern unsigned long vmalloc_base;
+extern unsigned long vmemmap_base;
+
 static inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
 	unsigned long y = x - __START_KERNEL_map;
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index f68e652..d54a3d5 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -43,11 +43,11 @@
 #define __PAGE_OFFSET_BASE      _AC(0xffff880000000000, UL)
 #endif
 
-#ifdef CONFIG_RANDOMIZE_MEMORY
+#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 #define __PAGE_OFFSET           page_offset_base
 #else
 #define __PAGE_OFFSET           __PAGE_OFFSET_BASE
-#endif /* CONFIG_RANDOMIZE_MEMORY */
+#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 7168de7..a0db91a 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -100,13 +100,13 @@ typedef struct { pteval_t pte; } pte_t;
 # define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 #endif
 
-#ifdef CONFIG_RANDOMIZE_MEMORY
+#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
 # define VMEMMAP_START		vmemmap_base
 #else
 # define VMALLOC_START		__VMALLOC_BASE
 # define VMEMMAP_START		__VMEMMAP_BASE
-#endif /* CONFIG_RANDOMIZE_MEMORY */
+#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define VMALLOC_END		(VMALLOC_START + _AC((VMALLOC_SIZE_TB << 40) - 1, UL))
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7ba5d81..bf5c9ba 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -39,6 +39,15 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
+#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
+unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE;
+EXPORT_SYMBOL(page_offset_base);
+unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE;
+EXPORT_SYMBOL(vmalloc_base);
+unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE;
+EXPORT_SYMBOL(vmemmap_base);
+#endif
+
 #define __head	__section(.head.text)
 
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index aedebd2..515b98a 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -43,14 +43,6 @@
 static const unsigned long vaddr_start = __PAGE_OFFSET_BASE;
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
-/* Default values */
-unsigned long page_offset_base = __PAGE_OFFSET_BASE;
-EXPORT_SYMBOL(page_offset_base);
-unsigned long vmalloc_base = __VMALLOC_BASE;
-EXPORT_SYMBOL(vmalloc_base);
-unsigned long vmemmap_base = __VMEMMAP_BASE;
-EXPORT_SYMBOL(vmemmap_base);
-
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
