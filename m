Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeCOBTU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:19:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:60023 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCOBTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:19:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,308,1517904000";
   d="scan'208";a="182872805"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@kernel.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
        jglisse@redhat.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH -mm] mm, madvise, THP: Use THP aligned address in madvise_free_huge_pmd()
Date: Thu, 15 Mar 2018 09:18:40 +0800
Message-Id: <20180315011840.27599-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

The address argument passed in madvise_free_huge_pmd() may be not THP
aligned.  But some THP operations like pmdp_invalidate(),
set_pmd_at(), and tlb_remove_pmd_tlb_entry() need the address to be
THP aligned.  Fix this via using THP aligned address for these
functions in madvise_free_huge_pmd().

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Shaohua Li <shli@kernel.org>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: jglisse@redhat.com
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/huge_memory.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0cc62405de9c..c5e1bfb08bd7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1617,6 +1617,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct page *page;
 	struct mm_struct *mm = tlb->mm;
 	bool ret = false;
+	unsigned long haddr = addr & HPAGE_PMD_MASK;
 
 	tlb_remove_check_page_size_change(tlb, HPAGE_PMD_SIZE);
 
@@ -1663,12 +1664,12 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	unlock_page(page);
 
 	if (pmd_young(orig_pmd) || pmd_dirty(orig_pmd)) {
-		pmdp_invalidate(vma, addr, pmd);
+		pmdp_invalidate(vma, haddr, pmd);
 		orig_pmd = pmd_mkold(orig_pmd);
 		orig_pmd = pmd_mkclean(orig_pmd);
 
-		set_pmd_at(mm, addr, pmd, orig_pmd);
-		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+		set_pmd_at(mm, haddr, pmd, orig_pmd);
+		tlb_remove_pmd_tlb_entry(tlb, pmd, haddr);
 	}
 
 	mark_page_lazyfree(page);
-- 
2.16.1
