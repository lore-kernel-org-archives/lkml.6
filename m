Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935402AbeEXBAp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:00:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:34349 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935386AbeEXBAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:00:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="42362576"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH -V2 -mm 4/4] mm, hugetlbfs: Pass fault address to cow handler
Date: Thu, 24 May 2018 08:58:51 +0800
Message-Id: <20180524005851.4079-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180524005851.4079-1-ying.huang@intel.com>
References: <20180524005851.4079-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

This is to take better advantage of the general huge page copying
optimization.  Where, the target subpage will be copied last to avoid
the cache lines of target subpage to be evicted when copying other
subpages.  This works better if the address of the target subpage is
available when copying huge page.  So hugetlbfs page fault handlers
are changed to pass that information to hugetlb_cow().  This will
benefit workloads which don't access the begin of the hugetlbfs huge
page after the page fault under heavy cache contention.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Shaohua Li <shli@fb.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 mm/hugetlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ad3bec2ed269..1df974af34c1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3500,7 +3500,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
  * Keep the pte_same checks anyway to make transition from the mutex easier.
  */
 static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
-		       unsigned long haddr, pte_t *ptep,
+		       unsigned long address, pte_t *ptep,
 		       struct page *pagecache_page, spinlock_t *ptl)
 {
 	pte_t pte;
@@ -3509,6 +3509,7 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 	int ret = 0, outside_reserve = 0;
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
+	unsigned long haddr = address & huge_page_mask(h);
 
 	pte = huge_ptep_get(ptep);
 	old_page = pte_page(pte);
@@ -3583,7 +3584,7 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	copy_user_huge_page(new_page, old_page, haddr, vma,
+	copy_user_huge_page(new_page, old_page, address, vma,
 			    pages_per_huge_page(h));
 	__SetPageUptodate(new_page);
 	set_page_huge_active(new_page);
@@ -3817,7 +3818,7 @@ static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
 		/* Optimization, do the COW without a second fault */
-		ret = hugetlb_cow(mm, vma, haddr, ptep, page, ptl);
+		ret = hugetlb_cow(mm, vma, address, ptep, page, ptl);
 	}
 
 	spin_unlock(ptl);
@@ -3971,7 +3972,7 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & FAULT_FLAG_WRITE) {
 		if (!huge_pte_write(entry)) {
-			ret = hugetlb_cow(mm, vma, haddr, ptep,
+			ret = hugetlb_cow(mm, vma, address, ptep,
 					  pagecache_page, ptl);
 			goto out_put_page;
 		}
-- 
2.16.1
