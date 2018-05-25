Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968306AbeEYUQt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:16:49 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35437 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967879AbeEYUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:16:47 -0400
X-Google-Smtp-Source: AB8JxZrkwSz8GAv9nwNTVtuSWiNMcze/SABymRwWnN8f+VHDh0wg2+LWOdH1n/ebkL9Vv/jGq2cuUw==
Date: Fri, 25 May 2018 13:16:45 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch] mm, hugetlb_cgroup: suppress SIGBUS when hugetlb_cgroup
 charge fails
Message-ID: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When charging to a hugetlb_cgroup fails, alloc_huge_page() returns
ERR_PTR(-ENOSPC) which will cause VM_FAULT_SIGBUS to be returned to the
page fault handler.

Instead, return the proper error code, ERR_PTR(-ENOMEM), so VM_FAULT_OOM
is handled correctly.  This is consistent with failing mem cgroup charges
in the non-hugetlb fault path.

At the same time, restructure the return paths of alloc_huge_page() so it
is consistent.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2006,8 +2006,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * code of zero indicates a reservation exists (no change).
 	 */
 	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
-	if (map_chg < 0)
-		return ERR_PTR(-ENOMEM);
+	if (map_chg < 0) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	/*
 	 * Processes that did not create the mapping will have no
@@ -2019,8 +2021,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (map_chg || avoid_reserve) {
 		gbl_chg = hugepage_subpool_get_pages(spool, 1);
 		if (gbl_chg < 0) {
-			vma_end_reservation(h, vma, addr);
-			return ERR_PTR(-ENOSPC);
+			ret = -ENOSPC;
+			goto out_reservation;
 		}
 
 		/*
@@ -2049,8 +2051,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	if (!page) {
 		spin_unlock(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
-		if (!page)
+		if (!page) {
+			ret = -ENOSPC;
 			goto out_uncharge_cgroup;
+		}
 		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
 			SetPagePrivate(page);
 			h->resv_huge_pages--;
@@ -2087,8 +2091,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
+out_reservation:
 	vma_end_reservation(h, vma, addr);
-	return ERR_PTR(-ENOSPC);
+out:
+	return ERR_PTR(ret);
 }
 
 int alloc_bootmem_huge_page(struct hstate *h)
