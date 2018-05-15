Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeEOA6v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:58:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:29968 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeEOA6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:58:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,402,1520924400";
   d="scan'208";a="228568524"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH -mm] mm, hugetlb: Pass fault address to no page handler
Date: Tue, 15 May 2018 08:57:56 +0800
Message-Id: <20180515005756.28942-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

This is to take better advantage of huge page clearing
optimization (c79b57e462b5d, "mm: hugetlb: clear target sub-page last
when clearing huge page").  Which will clear to access sub-page last
to avoid the cache lines of to access sub-page to be evicted when
clearing other sub-pages.  This needs to get the address of the
sub-page to access, that is, the fault address inside of the huge
page.  So the hugetlb no page fault handler is changed to pass that
information.  This will benefit workloads which don't access the begin
of the huge page after page fault.

With this patch, the throughput increases ~28.1% in vm-scalability
anon-w-seq test case with 88 processes on a 2 socket Xeon E5 2699 v4
system (44 cores, 88 threads).  The test case creates 88 processes,
each process mmap a big anonymous memory area and writes to it from
the end to the begin.  For each process, other processes could be seen
as other workload which generates heavy cache pressure.  At the same
time, the cache miss rate reduced from ~36.3% to ~25.6%, the
IPC (instruction per cycle) increased from 0.3 to 0.37, and the time
spent in user space is reduced ~19.3%

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Shaohua Li <shli@fb.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 mm/hugetlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 129088710510..3de6326abf39 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3677,7 +3677,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 
 static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			   struct address_space *mapping, pgoff_t idx,
-			   unsigned long address, pte_t *ptep, unsigned int flags)
+			   unsigned long faddress, pte_t *ptep, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	int ret = VM_FAULT_SIGBUS;
@@ -3686,6 +3686,7 @@ static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct page *page;
 	pte_t new_pte;
 	spinlock_t *ptl;
+	unsigned long address = faddress & huge_page_mask(h);
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -3749,7 +3750,7 @@ static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				ret = VM_FAULT_SIGBUS;
 			goto out;
 		}
-		clear_huge_page(page, address, pages_per_huge_page(h));
+		clear_huge_page(page, faddress, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		set_page_huge_active(page);
 
@@ -3871,7 +3872,7 @@ u32 hugetlb_fault_mutex_hash(struct hstate *h, struct mm_struct *mm,
 #endif
 
 int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+			unsigned long faddress, unsigned int flags)
 {
 	pte_t *ptep, entry;
 	spinlock_t *ptl;
@@ -3883,8 +3884,7 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
-
-	address &= huge_page_mask(h);
+	unsigned long address = faddress & huge_page_mask(h);
 
 	ptep = huge_pte_offset(mm, address, huge_page_size(h));
 	if (ptep) {
@@ -3914,7 +3914,7 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	entry = huge_ptep_get(ptep);
 	if (huge_pte_none(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
+		ret = hugetlb_no_page(mm, vma, mapping, idx, faddress, ptep, flags);
 		goto out_mutex;
 	}
 
-- 
2.16.1
