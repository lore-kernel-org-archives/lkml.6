Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeFBQ04 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 12:26:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeFBQ0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 12:26:55 -0400
Subject: [PATCH] Revert "vfio/type1: Improve memory pinning process for raw
 PFN mapping"
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: "Jason Cai \(Xiang Feng\)" <jason.cai@linux.alibaba.com>,
        Amadeusz =?utf-8?b?U8WCYXdpxYRza2k=?= <amade@asmblr.net>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 Jun 2018 10:26:49 -0600
Message-ID: <152795678646.18023.2344946004912261972.stgit@w520.home>
User-Agent: StGit/0.18-136-gffd7
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection by Amadeusz Sławiński implicates this commit leading to bad
page state issues after VM shutdown, likely due to unbalanced page
references.  The original commit was intended only as a performance
improvement, therefore revert for offline rework.

Link: https://lkml.org/lkml/2018/6/2/97
Fixes: 356e88ebe447 ("vfio/type1: Improve memory pinning process for raw PFN mapping")
Cc: Jason Cai (Xiang Feng) <jason.cai@linux.alibaba.com>
Reported-by: Amadeusz Sławiński <amade@asmblr.net>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c |   25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5c212bf29640..3c082451ab1a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -404,6 +404,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 {
 	unsigned long pfn = 0;
 	long ret, pinned = 0, lock_acct = 0;
+	bool rsvd;
 	dma_addr_t iova = vaddr - dma->vaddr + dma->iova;
 
 	/* This code path is only user initiated */
@@ -414,23 +415,14 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	if (ret)
 		return ret;
 
-	if (is_invalid_reserved_pfn(*pfn_base)) {
-		struct vm_area_struct *vma;
-
-		down_read(&current->mm->mmap_sem);
-		vma = find_vma_intersection(current->mm, vaddr, vaddr + 1);
-		pinned = min_t(long, npage, vma_pages(vma));
-		up_read(&current->mm->mmap_sem);
-		return pinned;
-	}
-
 	pinned++;
+	rsvd = is_invalid_reserved_pfn(*pfn_base);
 
 	/*
 	 * Reserved pages aren't counted against the user, externally pinned
 	 * pages are already counted against the user.
 	 */
-	if (!vfio_find_vpfn(dma, iova)) {
+	if (!rsvd && !vfio_find_vpfn(dma, iova)) {
 		if (!lock_cap && current->mm->locked_vm + 1 > limit) {
 			put_pfn(*pfn_base, dma->prot);
 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
@@ -450,12 +442,13 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 		if (ret)
 			break;
 
-		if (pfn != *pfn_base + pinned) {
+		if (pfn != *pfn_base + pinned ||
+		    rsvd != is_invalid_reserved_pfn(pfn)) {
 			put_pfn(pfn, dma->prot);
 			break;
 		}
 
-		if (!vfio_find_vpfn(dma, iova)) {
+		if (!rsvd && !vfio_find_vpfn(dma, iova)) {
 			if (!lock_cap &&
 			    current->mm->locked_vm + lock_acct + 1 > limit) {
 				put_pfn(pfn, dma->prot);
@@ -473,8 +466,10 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 
 unpin_out:
 	if (ret) {
-		for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
-			put_pfn(pfn, dma->prot);
+		if (!rsvd) {
+			for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
+				put_pfn(pfn, dma->prot);
+		}
 
 		return ret;
 	}
