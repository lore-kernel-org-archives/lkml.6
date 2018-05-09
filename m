Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934116AbeEIIjF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:39:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:40122 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933715AbeEIIjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:39:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="52769462"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Shaohua Li <shli@kernel.org>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: [PATCH -mm -V2 01/21] mm, THP, swap: Enable PMD swap operations for CONFIG_THP_SWAP
Date: Wed,  9 May 2018 16:38:26 +0800
Message-Id: <20180509083846.14823-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180509083846.14823-1-ying.huang@intel.com>
References: <20180509083846.14823-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

Previously, the PMD swap operations are only enabled for
CONFIG_ARCH_ENABLE_THP_MIGRATION.  Because they are only used by the
THP migration support.  We will support PMD swap mapping to the huge
swap cluster and swapin the THP as a whole.  That will be enabled via
CONFIG_THP_SWAP and needs these PMD swap operations.  So enable the
PMD swap operations for CONFIG_THP_SWAP too.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
---
 arch/x86/include/asm/pgtable.h |  2 +-
 include/asm-generic/pgtable.h  |  2 +-
 include/linux/swapops.h        | 44 ++++++++++++++++++++++--------------------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index f1633de5a675..0dff03085197 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1224,7 +1224,7 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 	return pte_clear_flags(pte, _PAGE_SWP_SOFT_DIRTY);
 }
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+#if defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) || defined(CONFIG_THP_SWAP)
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_SWP_SOFT_DIRTY);
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index f59639afaa39..bb8354981a36 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -675,7 +675,7 @@ static inline void ptep_modify_prot_commit(struct mm_struct *mm,
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-#ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
+#if !defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) && !defined(CONFIG_THP_SWAP)
 static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
 {
 	return pmd;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 1d3877c39a00..f1be5a52f5c8 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -258,17 +258,7 @@ static inline int is_write_migration_entry(swp_entry_t entry)
 
 #endif
 
-struct page_vma_mapped_walk;
-
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-extern void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
-		struct page *page);
-
-extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
-		struct page *new);
-
-extern void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd);
-
+#if defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) || defined(CONFIG_THP_SWAP)
 static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
 {
 	swp_entry_t arch_entry;
@@ -286,6 +276,28 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 	arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
 	return __swp_entry_to_pmd(arch_entry);
 }
+#else
+static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
+{
+	return swp_entry(0, 0);
+}
+
+static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
+{
+	return __pmd(0);
+}
+#endif
+
+struct page_vma_mapped_walk;
+
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+extern void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+		struct page *page);
+
+extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
+		struct page *new);
+
+extern void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd);
 
 static inline int is_pmd_migration_entry(pmd_t pmd)
 {
@@ -306,16 +318,6 @@ static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 
 static inline void pmd_migration_entry_wait(struct mm_struct *m, pmd_t *p) { }
 
-static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
-{
-	return swp_entry(0, 0);
-}
-
-static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
-{
-	return __pmd(0);
-}
-
 static inline int is_pmd_migration_entry(pmd_t pmd)
 {
 	return 0;
-- 
2.16.1
