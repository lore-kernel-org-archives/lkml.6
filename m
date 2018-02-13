Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966129AbeBMXXy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:23:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:1101 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965783AbeBMXXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:23:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="203890700"
Subject: [PATCH 2/3] x86/mm: introduce __PAGE_KERNEL_GLOBAL
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 13 Feb 2018 15:19:30 -0800
References: <20180213231927.32581D84@viggo.jf.intel.com>
In-Reply-To: <20180213231927.32581D84@viggo.jf.intel.com>
Message-Id: <20180213231930.F91235EB@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Kernel mappings are historically _PAGE_GLOBAL.  But, with PTI, we do not
want them to be _PAGE_GLOBAL.  We currently accomplish this by simply
clearing _PAGE_GLOBAL from the suppotred mask which ensures it is
cleansed from many of our PTE construction sites:

        if (!static_cpu_has(X86_FEATURE_PTI))
	                __supported_pte_mask |= _PAGE_GLOBAL;

But, this also means that we now get *no* opportunity to use global
pages with PTI, even for data which is shared such as the cpu_entry_area
and entry/exit text.

This patch introduces a new mask: __PAGE_KERNEL_GLOBAL.  This mask
can be thought of as the default global bit value when creating kernel
mappings.  We make it _PAGE_GLOBAL when PTI=n, but 0 when PTI=y.  This
ensures that on PTI kernels, all of the __PAGE_KERNEL_* users will not
get _PAGE_GLOBAL.

This also restores _PAGE_GLOBAL to __supported_pte_mask, allowing it
to be set in the first place.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
---

 b/arch/x86/include/asm/pgtable_types.h |    9 ++++++++-
 b/arch/x86/mm/init.c                   |    8 +-------
 b/arch/x86/mm/pageattr.c               |    9 +++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff -puN arch/x86/include/asm/pgtable_types.h~kpti-no-global-for-kernel-mappings arch/x86/include/asm/pgtable_types.h
--- a/arch/x86/include/asm/pgtable_types.h~kpti-no-global-for-kernel-mappings	2018-02-13 15:17:56.144210060 -0800
+++ b/arch/x86/include/asm/pgtable_types.h	2018-02-13 15:17:56.152210060 -0800
@@ -180,8 +180,15 @@ enum page_cache_mode {
 #define PAGE_READONLY_EXEC	__pgprot(_PAGE_PRESENT | _PAGE_USER |	\
 					 _PAGE_ACCESSED)
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#define __PAGE_KERNEL_GLOBAL		0
+#else
+#define __PAGE_KERNEL_GLOBAL		_PAGE_GLOBAL
+#endif
+
 #define __PAGE_KERNEL_EXEC						\
-	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_GLOBAL)
+	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED | 	\
+	 __PAGE_KERNEL_GLOBAL)
 #define __PAGE_KERNEL		(__PAGE_KERNEL_EXEC | _PAGE_NX)
 
 #define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
diff -puN arch/x86/mm/init.c~kpti-no-global-for-kernel-mappings arch/x86/mm/init.c
--- a/arch/x86/mm/init.c~kpti-no-global-for-kernel-mappings	2018-02-13 15:17:56.146210060 -0800
+++ b/arch/x86/mm/init.c	2018-02-13 15:17:56.152210060 -0800
@@ -162,12 +162,6 @@ struct map_range {
 
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
@@ -189,7 +183,7 @@ static void __init probe_page_size_mask(
 	__supported_pte_mask &= ~_PAGE_GLOBAL;
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		cr4_set_bits_and_update_boot(X86_CR4_PGE);
-		enable_global_pages();
+		__supported_pte_mask |= _PAGE_GLOBAL;
 	}
 
 	/* Enable 1 GB linear kernel mappings if available: */
diff -puN arch/x86/mm/pageattr.c~kpti-no-global-for-kernel-mappings arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~kpti-no-global-for-kernel-mappings	2018-02-13 15:17:56.148210060 -0800
+++ b/arch/x86/mm/pageattr.c	2018-02-13 15:17:56.153210060 -0800
@@ -593,7 +593,8 @@ try_preserve_large_page(pte_t *kpte, uns
 	 * different bit positions in the two formats.
 	 */
 	req_prot = pgprot_4k_2_large(req_prot);
-	req_prot = pgprot_set_on_present(req_prot, _PAGE_GLOBAL | _PAGE_PSE);
+	req_prot = pgprot_set_on_present(req_prot,
+			__PAGE_KERNEL_GLOBAL | _PAGE_PSE);
 	req_prot = canon_pgprot(req_prot);
 
 	/*
@@ -703,7 +704,7 @@ __split_large_page(struct cpa_data *cpa,
 		return 1;
 	}
 
-	ref_prot = pgprot_set_on_present(ref_prot, _PAGE_GLOBAL);
+	ref_prot = pgprot_set_on_present(ref_prot, __PAGE_KERNEL_GLOBAL);
 
 	/*
 	 * Get the target pfn from the original entry:
@@ -926,7 +927,7 @@ static void populate_pte(struct cpa_data
 
 	pte = pte_offset_kernel(pmd, start);
 
-	pgprot = pgprot_set_on_present(pgprot, _PAGE_GLOBAL);
+	pgprot = pgprot_set_on_present(pgprot, __PAGE_KERNEL_GLOBAL);
 	pgprot = canon_pgprot(pgprot);
 
 	while (num_pages-- && start < end) {
@@ -1219,7 +1220,7 @@ repeat:
 
 		new_prot = static_protections(new_prot, address, pfn);
 
-		new_prot = pgprot_set_on_present(new_prot, _PAGE_GLOBAL);
+		new_prot = pgprot_set_on_present(new_prot, __PAGE_KERNEL_GLOBAL);
 
 		/*
 		 * We need to keep the pfn from the existing PTE,
_
