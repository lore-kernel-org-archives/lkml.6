Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeCCMLC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 07:11:02 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58586 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751721AbeCCMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 07:11:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=jason.cai@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Syr2ub4_1520079035;
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [RFC v2] vfio iommu type1: improve memory pinning process for raw PFN
 mapping
From: "Jason Cai (Xiang Feng)" <jason.cai@linux.alibaba.com>
In-Reply-To: <20180226121930.5e1f6300@w520.home>
Date: Sat, 3 Mar 2018 20:10:33 +0800
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gnehzuil@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <25959294-E232-43EB-9CE2-E558A8D62F57@linux.alibaba.com>
References: <7090CB2E-8D63-44B1-A739-932FFA649BC9@linux.alibaba.com>
 <20180226121930.5e1f6300@w520.home>
To: Alex Williamson <alex.williamson@redhat.com>
X-Mailer: Apple Mail (2.3259)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using vfio to pass through a PCIe device (e.g. a GPU card) that
has a huge BAR (e.g. 16GB), a lot of cycles are wasted on memory
pinning because PFNs of PCI BAR are not backed by struct page, and
the corresponding VMA has flag VM_PFNMAP.

With this change, when pinning a region which is a raw PFN mapping,
it can skip unnecessary user memory pinning process. Thus, it can
significantly improve VM's boot up time when passing through devices
via VFIO.

Signed-off-by: Jason Cai (Xiang Feng) <jason.cai@linux.alibaba.com>
---
 drivers/vfio/vfio_iommu_type1.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e30e29ae4819..82ccfa350315 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -385,7 +385,6 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 {
        unsigned long pfn = 0;
        long ret, pinned = 0, lock_acct = 0;
-       bool rsvd;
        dma_addr_t iova = vaddr - dma->vaddr + dma->iova;

        /* This code path is only user initiated */
@@ -396,14 +395,22 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
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
@@ -423,13 +430,12 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
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
@@ -447,10 +453,8 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,

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
