Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934939AbeBPLDi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:03:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:03:34 -0500
Date: Fri, 16 Feb 2018 02:53:03 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-4fa5662b6b49611f11856db8be346710217473ef@git.kernel.org>
Cc: dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        jpoimboe@redhat.com, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, dwmw2@infradead.org, peterz@infradead.org,
        arjan@linux.intel.com, bp@suse.de, linux-kernel@vger.kernel.org
Reply-To: dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        torvalds@linux-foundation.org, jpoimboe@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, luto@kernel.org, peterz@infradead.org,
        arjan@linux.intel.com, bp@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180214182542.69302-4-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-4-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Initialize 'page_offset_base' at boot-time
Git-Commit-ID: 4fa5662b6b49611f11856db8be346710217473ef
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

Commit-ID:  4fa5662b6b49611f11856db8be346710217473ef
Gitweb:     https://git.kernel.org/tip/4fa5662b6b49611f11856db8be346710217473ef
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:36 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:47 +0100

x86/mm: Initialize 'page_offset_base' at boot-time

For 4- and 5-level paging we have different 'page_offset_base'.
Let's initialize it at boot-time accordingly to machine capability.

We also have to split __PAGE_OFFSET_BASE into two constants -- for 4-
and 5-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214182542.69302-4-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_64_types.h |  9 +++------
 arch/x86/kernel/head64.c             | 13 +++++++++----
 arch/x86/kernel/head_64.S            |  2 +-
 arch/x86/mm/kaslr.c                  |  8 ++++----
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index fa7dc7c..2c5a966 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -37,16 +37,13 @@
  * hypervisor to fit.  Choosing 16 slots here is arbitrary, but it's
  * what Xen requires.
  */
-#ifdef CONFIG_X86_5LEVEL
-#define __PAGE_OFFSET_BASE      _AC(0xff10000000000000, UL)
-#else
-#define __PAGE_OFFSET_BASE      _AC(0xffff880000000000, UL)
-#endif
+#define __PAGE_OFFSET_BASE_L5	_AC(0xff10000000000000, UL)
+#define __PAGE_OFFSET_BASE_L4	_AC(0xffff880000000000, UL)
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 #define __PAGE_OFFSET           page_offset_base
 #else
-#define __PAGE_OFFSET           __PAGE_OFFSET_BASE
+#define __PAGE_OFFSET           __PAGE_OFFSET_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8a0a485..876d3bf 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -49,7 +49,7 @@ EXPORT_SYMBOL(ptrs_per_p4d);
 #endif
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
-unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE;
+unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
 unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE;
 EXPORT_SYMBOL(vmalloc_base);
@@ -64,6 +64,11 @@ static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 	return ptr - (void *)_text + (void *)physaddr;
 }
 
+static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
+{
+	return fixup_pointer(ptr, physaddr);
+}
+
 #ifdef CONFIG_X86_5LEVEL
 static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 {
@@ -81,6 +86,7 @@ static void __head check_la57_support(unsigned long physaddr)
 	*fixup_int(&pgtable_l5_enabled, physaddr) = 1;
 	*fixup_int(&pgdir_shift, physaddr) = 48;
 	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
+	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
 }
 #else
 static void __head check_la57_support(unsigned long physaddr) {}
@@ -89,7 +95,7 @@ static void __head check_la57_support(unsigned long physaddr) {}
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long load_delta, *p;
+	unsigned long load_delta;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
@@ -196,8 +202,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Fixup phys_base - remove the memory encryption mask to obtain
 	 * the true physical address.
 	 */
-	p = fixup_pointer(&phys_base, physaddr);
-	*p += load_delta - sme_get_me_mask();
+	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
 
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04a625f..d3f8b43 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -41,7 +41,7 @@
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 
 #if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
-PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE)
+PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE_L4)
 PGD_START_KERNEL = pgd_index(__START_KERNEL_map)
 #endif
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index d079878..7828a7c 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -34,13 +34,10 @@
 #define TB_SHIFT 40
 
 /*
- * Virtual address start and end range for randomization.
- *
  * The end address could depend on more configuration options to make the
  * highest amount of space for randomization available, but that's too hard
  * to keep straight and caused issues already.
  */
-static const unsigned long vaddr_start = __PAGE_OFFSET_BASE;
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
 /*
@@ -76,11 +73,14 @@ static inline bool kaslr_memory_enabled(void)
 void __init kernel_randomize_memory(void)
 {
 	size_t i;
-	unsigned long vaddr = vaddr_start;
+	unsigned long vaddr_start, vaddr;
 	unsigned long rand, memory_tb;
 	struct rnd_state rand_state;
 	unsigned long remain_entropy;
 
+	vaddr_start = pgtable_l5_enabled ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
+	vaddr = vaddr_start;
+
 	/*
 	 * These BUILD_BUG_ON checks ensure the memory layout is consistent
 	 * with the vaddr_start/vaddr_end variables. These checks are very
