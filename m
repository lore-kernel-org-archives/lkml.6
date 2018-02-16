Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbeBPLFK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:05:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50367 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935015AbeBPLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:04:59 -0500
Date: Fri, 16 Feb 2018 02:53:33 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-a7412546d8cb5ad578805060b4006f2a021b5868@git.kernel.org>
Cc: luto@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de, hpa@zytor.com, arjan@linux.intel.com, bp@suse.de,
        dwmw2@infradead.org, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        peterz@infradead.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, jpoimboe@redhat.com,
        peterz@infradead.org, mingo@kernel.org, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, dan.j.williams@intel.com, arjan@linux.intel.com,
        bp@suse.de
In-Reply-To: <20180214182542.69302-5-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-5-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Adjust vmalloc base and size at boot-time
Git-Commit-ID: a7412546d8cb5ad578805060b4006f2a021b5868
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

Commit-ID:  a7412546d8cb5ad578805060b4006f2a021b5868
Gitweb:     https://git.kernel.org/tip/a7412546d8cb5ad578805060b4006f2a021b5868
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:37 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:47 +0100

x86/mm: Adjust vmalloc base and size at boot-time

vmalloc area has different placement and size depending on paging mode.
Let's adjust it during early boot accodring to machine capability.

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
Link: http://lkml.kernel.org/r/20180214182542.69302-5-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_64_types.h | 16 ++++++++++------
 arch/x86/kernel/head64.c                |  3 ++-
 arch/x86/mm/kaslr.c                     |  3 ++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 59d971c..6863299 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -102,25 +102,29 @@ extern unsigned int ptrs_per_p4d;
 #define LDT_PGD_ENTRY		(pgtable_l5_enabled ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 
+#define __VMALLOC_BASE_L4	0xffffc90000000000
+#define __VMALLOC_BASE_L5 	0xffa0000000000000
+
+#define VMALLOC_SIZE_TB_L4	32UL
+#define VMALLOC_SIZE_TB_L5	12800UL
+
 #ifdef CONFIG_X86_5LEVEL
-# define VMALLOC_SIZE_TB	_AC(12800, UL)
-# define __VMALLOC_BASE		_AC(0xffa0000000000000, UL)
 # define __VMEMMAP_BASE		_AC(0xffd4000000000000, UL)
 #else
-# define VMALLOC_SIZE_TB	_AC(32, UL)
-# define __VMALLOC_BASE		_AC(0xffffc90000000000, UL)
 # define __VMEMMAP_BASE		_AC(0xffffea0000000000, UL)
 #endif
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
+# define VMALLOC_SIZE_TB	(pgtable_l5_enabled ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
 # define VMEMMAP_START		vmemmap_base
 #else
-# define VMALLOC_START		__VMALLOC_BASE
+# define VMALLOC_START		__VMALLOC_BASE_L4
+# define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
 # define VMEMMAP_START		__VMEMMAP_BASE
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
-#define VMALLOC_END		(VMALLOC_START + _AC((VMALLOC_SIZE_TB << 40) - 1, UL))
+#define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 876d3bf..22bf201 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL(ptrs_per_p4d);
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
-unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE;
+unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
 EXPORT_SYMBOL(vmalloc_base);
 unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE;
 EXPORT_SYMBOL(vmemmap_base);
@@ -87,6 +87,7 @@ static void __head check_la57_support(unsigned long physaddr)
 	*fixup_int(&pgdir_shift, physaddr) = 48;
 	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
 	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
+	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
 }
 #else
 static void __head check_la57_support(unsigned long physaddr) {}
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 7828a7c..641169d 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -50,7 +50,7 @@ static __initdata struct kaslr_memory_region {
 	unsigned long size_tb;
 } kaslr_regions[] = {
 	{ &page_offset_base, 0 },
-	{ &vmalloc_base, VMALLOC_SIZE_TB },
+	{ &vmalloc_base, 0 },
 	{ &vmemmap_base, 1 },
 };
 
@@ -94,6 +94,7 @@ void __init kernel_randomize_memory(void)
 		return;
 
 	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
 	/*
 	 * Update Physical memory mapping to available and
