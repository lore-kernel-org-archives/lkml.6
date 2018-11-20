Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8E9C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA312146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA312146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeKTTXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:23:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:57263 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeKTTXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:23:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 00:55:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,256,1539673200"; 
   d="scan'208";a="106105867"
Received: from yhuang-mobile.sh.intel.com ([10.239.197.245])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2018 00:55:29 -0800
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
Subject: [PATCH -V7 RESEND 13/21] swap: Support PMD swap mapping in madvise_free()
Date:   Tue, 20 Nov 2018 16:54:41 +0800
Message-Id: <20181120085449.5542-14-ying.huang@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181120085449.5542-1-ying.huang@intel.com>
References: <20181120085449.5542-1-ying.huang@intel.com>
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
 mm/huge_memory.c | 52 ++++++++++++++++++++++++++++++++++--------------
 mm/madvise.c     |  2 +-
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 079592b9f4a5..89aa93d586ec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1900,6 +1900,15 @@ int do_huge_pmd_swap_page(struct vm_fault *vmf, pmd_t orig_pmd)
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
@@ -1920,15 +1929,37 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
+				__split_huge_swap_pmd(vma, addr, pmd);
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
@@ -1974,15 +2005,6 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
index cbb3d7e38e51..0c1f96c605f8 100644
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
2.18.1

