Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754863AbeCSCan convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:30:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34669 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754218AbeCSCam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:30:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jason.cai@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0SzfHoYg_1521426624;
From: "Jason Cai (Xiang Feng)" <jason.cai@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [PATCH] vfio iommu type1: improve memory pinning process for raw PFN
 mapping
Message-Id: <7F93BB33-4ABF-468F-8814-78DE9D23FA08@linux.alibaba.com>
Date: Mon, 19 Mar 2018 10:30:24 +0800
Cc: gnehzuil@linux.alibaba.com,
        "Jason Cai (Xiang Feng)" <jason.cai@linux.alibaba.com>
To: Alex Williamson <alex.williamson@redhat.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: Apple Mail (2.3259)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using vfio to pass through a PCIe device (e.g. a GPU card) that
has a huge BAR (e.g. 16GB), a lot of cycles are wasted on memory
pinning because PFNs of PCI BAR are not backed by struct page, and
the corresponding VMA has flag VM_PFNMAP.

With this change, when pinning a region which is a raw PFN mapping,
it can skip unnecessary user memory pinning process, and thus, can
significantly improve VM's boot up time when passing through devices
via VFIO. In my test on a Xeon E5 2.6GHz, the time mapping a 16GB
BAR was reduced from about 0.4s to 1.5us.

Signed-off-by: Jason Cai (Xiang Feng) <jason.cai@linux.alibaba.com>
---
 drivers/vfio/vfio_iommu_type1.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 45657e2b1ff7..0658f35318b8 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -397,7 +397,6 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 {
        unsigned long pfn = 0;
        long ret, pinned = 0, lock_acct = 0;
-       bool rsvd;
        dma_addr_t iova = vaddr - dma->vaddr + dma->iova;

        /* This code path is only user initiated */
@@ -408,14 +407,22 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
        if (ret)
                return ret;

+       if (is_invalid_reserved_pfn(*pfn_base)) {
+               struct vm_area_struct *vma;
+               down_read(&current->mm->mmap_sem);
+               vma = find_vma_intersection(current->mm, vaddr, vaddr + 1);
+               pinned = min(npage, (long)vma_pages(vma));
+               up_read(&current->mm->mmap_sem);
+               return pinned;
+       }
+
        pinned++;
-       rsvd = is_invalid_reserved_pfn(*pfn_base);

        /*
         * Reserved pages aren't counted against the user, externally pinned
         * pages are already counted against the user.
         */
-       if (!rsvd && !vfio_find_vpfn(dma, iova)) {
+       if (!vfio_find_vpfn(dma, iova)) {
                if (!lock_cap && current->mm->locked_vm + 1 > limit) {
                        put_pfn(*pfn_base, dma->prot);
                        pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
@@ -435,13 +442,12 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
                if (ret)
                        break;

-               if (pfn != *pfn_base + pinned ||
-                   rsvd != is_invalid_reserved_pfn(pfn)) {
+               if (pfn != *pfn_base + pinned) {
                        put_pfn(pfn, dma->prot);
                        break;
                }

-               if (!rsvd && !vfio_find_vpfn(dma, iova)) {
+               if (!vfio_find_vpfn(dma, iova)) {
                        if (!lock_cap &&
                            current->mm->locked_vm + lock_acct + 1 > limit) {
                                put_pfn(pfn, dma->prot);
@@ -459,10 +465,8 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,

 unpin_out:
        if (ret) {
-               if (!rsvd) {
-                       for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
-                               put_pfn(pfn, dma->prot);
-               }
+               for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
+                       put_pfn(pfn, dma->prot);

                return ret;
        }
--
2.13.6
