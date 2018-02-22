Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBVUhJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:37:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:49853 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeBVUhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:37:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="32847369"
Subject: [RFC][PATCH 03/10] x86/mm: introduce "default" kernel PTE mask
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, aarcange@redhat.com,
        luto@kernel.org, torvalds@linux-foundation.org, keescook@google.com,
        hughd@google.com, jgross@suse.com, x86@kernel.org, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2018 12:36:56 -0800
References: <20180222203651.B776810C@viggo.jf.intel.com>
In-Reply-To: <20180222203651.B776810C@viggo.jf.intel.com>
Message-Id: <20180222203656.25C9B4EC@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The __PAGE_KERNEL_* page permissions are "raw".  They contain bits
that may or may not be supported on the current processor.  They
need to be filtered by a mask (currently __supported_pte_mask) to
turn them into a value that we can actually set in a PTE.

These __PAGE_KERNEL_* values all contain _PAGE_GLOBAL.  But, with
PTI, we want to be able to support _PAGE_GLOBAL (have the bit set
in __supported_pte_mask) but not have it appear in any of these
masks by default.

This patch creates a new mask, __default_kernel_pte_mask, and
applies it when creating all of the PAGE_KERNEL_* masks.  This
makes PAGE_KERNEL_* safe to use anywhere (they only contain
supported bits).  It also ensures that PAGE_KERNEL_* contains
_PAGE_GLOBAL on PTI=n kernels but clears _PAGE_GLOBAL when
PTI=y.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: Nadav Amit <namit@vmware.com>
---

 b/arch/x86/include/asm/pgtable_types.h |   29 ++++++++++++++++-------------
 b/arch/x86/mm/init.c                   |    6 ++++++
 b/arch/x86/mm/init_32.c                |    7 ++++++-
 b/arch/x86/mm/init_64.c                |    4 ++++
 4 files changed, 32 insertions(+), 14 deletions(-)

diff -puN arch/x86/include/asm/pgtable_types.h~KERN-pgprot-default arch/x86/include/asm/pgtable_types.h
--- a/arch/x86/include/asm/pgtable_types.h~KERN-pgprot-default	2018-02-22 12:36:18.608036554 -0800
+++ b/arch/x86/include/asm/pgtable_types.h	2018-02-22 12:36:18.617036554 -0800
@@ -145,6 +145,7 @@ enum page_cache_mode {
 	_PAGE_CACHE_MODE_WP = 5,
 	_PAGE_CACHE_MODE_NUM = 8
 };
+extern unsigned long __default_kernel_pte_mask;
 #endif
 
 #define _PAGE_CACHE_MASK	(_PAGE_PAT | _PAGE_PCD | _PAGE_PWT)
@@ -197,20 +198,22 @@ enum page_cache_mode {
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
-#define PAGE_KERNEL_VSYSCALL	__pgprot(__PAGE_KERNEL_VSYSCALL | _PAGE_ENC)
-#define PAGE_KERNEL_VVAR	__pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
+#define default_pgprot(x)	__pgprot((x) & __default_kernel_pte_mask)
 
-#define PAGE_KERNEL_IO		__pgprot(__PAGE_KERNEL_IO)
-#define PAGE_KERNEL_IO_NOCACHE	__pgprot(__PAGE_KERNEL_IO_NOCACHE)
+#define PAGE_KERNEL		default_pgprot(__PAGE_KERNEL | _PAGE_ENC)
+#define PAGE_KERNEL_NOENC	default_pgprot(__PAGE_KERNEL)
+#define PAGE_KERNEL_RO		default_pgprot(__PAGE_KERNEL_RO | _PAGE_ENC)
+#define PAGE_KERNEL_EXEC	default_pgprot(__PAGE_KERNEL_EXEC | _PAGE_ENC)
+#define PAGE_KERNEL_EXEC_NOENC	default_pgprot(__PAGE_KERNEL_EXEC)
+#define PAGE_KERNEL_RX		default_pgprot(__PAGE_KERNEL_RX | _PAGE_ENC)
+#define PAGE_KERNEL_NOCACHE	default_pgprot(__PAGE_KERNEL_NOCACHE | _PAGE_ENC)
+#define PAGE_KERNEL_LARGE	default_pgprot(__PAGE_KERNEL_LARGE | _PAGE_ENC)
+#define PAGE_KERNEL_LARGE_EXEC	default_pgprot(__PAGE_KERNEL_LARGE_EXEC | _PAGE_ENC)
+#define PAGE_KERNEL_VSYSCALL	default_pgprot(__PAGE_KERNEL_VSYSCALL | _PAGE_ENC)
+#define PAGE_KERNEL_VVAR	default_pgprot(__PAGE_KERNEL_VVAR | _PAGE_ENC)
+
+#define PAGE_KERNEL_IO		default_pgprot(__PAGE_KERNEL_IO)
+#define PAGE_KERNEL_IO_NOCACHE	default_pgprot(__PAGE_KERNEL_IO_NOCACHE)
 
 #endif	/* __ASSEMBLY__ */
 
diff -puN arch/x86/mm/init_32.c~KERN-pgprot-default arch/x86/mm/init_32.c
--- a/arch/x86/mm/init_32.c~KERN-pgprot-default	2018-02-22 12:36:18.610036554 -0800
+++ b/arch/x86/mm/init_32.c	2018-02-22 12:36:18.618036554 -0800
@@ -543,8 +543,13 @@ static void __init pagetable_init(void)
 	permanent_kmaps_init(pgd_base);
 }
 
-pteval_t __supported_pte_mask __read_mostly = ~(_PAGE_NX | _PAGE_GLOBAL);
+#define DEFAULT_PTE_MASK ~(_PAGE_NX | _PAGE_GLOBAL)
+/* Bits supported by the hardware: */
+pteval_t __supported_pte_mask __read_mostly = DEFAULT_PTE_MASK;
+/* Bits allowed in normal kernel mappings: */
+pteval_t __default_kernel_pte_mask __read_mostly = DEFAULT_PTE_MASK;
 EXPORT_SYMBOL_GPL(__supported_pte_mask);
+EXPORT_SYMBOL_GPL(__default_kernel_pte_mask);
 
 /* user-defined highmem size */
 static unsigned int highmem_pages = -1;
diff -puN arch/x86/mm/init_64.c~KERN-pgprot-default arch/x86/mm/init_64.c
--- a/arch/x86/mm/init_64.c~KERN-pgprot-default	2018-02-22 12:36:18.612036554 -0800
+++ b/arch/x86/mm/init_64.c	2018-02-22 12:36:18.618036554 -0800
@@ -65,8 +65,12 @@
  * around without checking the pgd every time.
  */
 
+/* Bits supported by the hardware: */
 pteval_t __supported_pte_mask __read_mostly = ~0;
+/* Bits allowed in normal kernel mappings: */
+pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 EXPORT_SYMBOL_GPL(__supported_pte_mask);
+EXPORT_SYMBOL_GPL(__default_kernel_pte_mask);
 
 int force_personality32;
 
diff -puN arch/x86/mm/init.c~KERN-pgprot-default arch/x86/mm/init.c
--- a/arch/x86/mm/init.c~KERN-pgprot-default	2018-02-22 12:36:18.614036554 -0800
+++ b/arch/x86/mm/init.c	2018-02-22 12:36:18.619036554 -0800
@@ -190,6 +190,12 @@ static void __init probe_page_size_mask(
 		enable_global_pages();
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
_
