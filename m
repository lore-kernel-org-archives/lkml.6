Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED33ECDFC0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E34720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E34720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeILFqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:46:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:23407 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbeILFqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:46:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="69283926"
Received: from unknown (HELO yhuang-mobile.sh.intel.com) ([10.239.198.87])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2018 17:44:57 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH -V5 RESEND 13/21] swap: Support PMD swap mapping in madvise_free()
Date:   Wed, 12 Sep 2018 08:44:06 +0800
Message-Id: <20180912004414.22583-14-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180912004414.22583-1-ying.huang@intel.com>
References: <20180912004414.22583-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When madvise_free() found a PMD swap mapping, if only part of the huge
swap cluster is operated on, the PMD swap mapping will be split and
fallback to PTE swap mapping processing.  Otherwise, if all huge swap
cluster is operated on, free_swap_and_cache() will be called to
decrease the PMD swap mapping count and probably free the swap space
and the THP in swap cache too.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/huge_memory.c | 54 +++++++++++++++++++++++++++++++++++++++---------------
 mm/madvise.c     |  2 +-
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cd353f39bed9..05407832e793 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1849,6 +1849,15 @@ int do_huge_pmd_swap_page(struct vm_fault *vmf, pmd_t orig_pmd)
 }
 #endif
 
+static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
+{
+	pgtable_t pgtable;
+
+	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
+	pte_free(mm, pgtable);
+	mm_dec_nr_ptes(mm);
+}
+
 /*
  * Return true if we do MADV_FREE successfully on entire pmd page.
  * Otherwise, return false.
@@ -1869,15 +1878,39 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		goto out_unlocked;
 
 	orig_pmd = *pmd;
-	if (is_huge_zero_pmd(orig_pmd))
-		goto out;
-
 	if (unlikely(!pmd_present(orig_pmd))) {
-		VM_BUG_ON(thp_migration_supported() &&
-				  !is_pmd_migration_entry(orig_pmd));
-		goto out;
+		swp_entry_t entry = pmd_to_swp_entry(orig_pmd);
+
+		if (is_migration_entry(entry)) {
+			VM_BUG_ON(!thp_migration_supported());
+			goto out;
+		} else if (IS_ENABLED(CONFIG_THP_SWAP) &&
+			   !non_swap_entry(entry)) {
+			/*
+			 * If part of THP is discarded, split the PMD
+			 * swap mapping and operate on the PTEs
+			 */
+			if (next - addr != HPAGE_PMD_SIZE) {
+				unsigned long haddr = addr & HPAGE_PMD_MASK;
+
+				__split_huge_swap_pmd(vma, haddr, pmd);
+				goto out;
+			}
+			free_swap_and_cache(entry, HPAGE_PMD_NR);
+			pmd_clear(pmd);
+			zap_deposited_table(mm, pmd);
+			if (current->mm == mm)
+				sync_mm_rss(mm);
+			add_mm_counter(mm, MM_SWAPENTS, -HPAGE_PMD_NR);
+			ret = true;
+			goto out;
+		} else
+			VM_BUG_ON(1);
 	}
 
+	if (is_huge_zero_pmd(orig_pmd))
+		goto out;
+
 	page = pmd_page(orig_pmd);
 	/*
 	 * If other processes are mapping this page, we couldn't discard
@@ -1923,15 +1956,6 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return ret;
 }
 
-static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
-{
-	pgtable_t pgtable;
-
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pte_free(mm, pgtable);
-	mm_dec_nr_ptes(mm);
-}
-
 int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pmd_t *pmd, unsigned long addr)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 6fff1c1d2009..07ef599d4255 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,7 +321,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long next;
 
 	next = pmd_addr_end(addr, end);
-	if (pmd_trans_huge(*pmd))
+	if (pmd_trans_huge(*pmd) || is_swap_pmd(*pmd))
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
 
-- 
2.16.4

