Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBXFoR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 00:44:17 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54678 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751084AbeBXFoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 00:44:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=jason.cai@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0SyQ7cuJ_1519451048;
From: jason <jason.cai@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [RFC] vfio iommu type1: improve memory pinning process for raw PFN
 mapping
Message-Id: <7090CB2E-8D63-44B1-A739-932FFA649BC9@linux.alibaba.com>
Date: Sat, 24 Feb 2018 13:44:07 +0800
Cc: gnehzuil@linux.alibaba.com
To: jason <jason.cai@linux.alibaba.com>, alex.williamson@redhat.com,
        pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
X-Mailer: Apple Mail (2.3259)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using vfio to pass through a PCIe device (e.g. a GPU card) that
has a huge BAR (e.g. 16GB), a lot of cycles are wasted on memory
pinning because PFNs of PCI BAR are not backed by struct page, and
the corresponding VMA has flags VM_IO|VM_PFNMAP.

With this change, memory pinning process will firstly try to figure
out whether the corresponding region is a raw PFN mapping, and if so
it can skip unnecessary user memory pinning process.

Even though it commes with a little overhead, finding vma and testing
flags, on each call, it can significantly improve VM's boot up time
when passing through devices via VFIO.
---
 drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e30e29ae4819..1a471ece3f9c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -374,6 +374,24 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
        return ret;
 }

+static int try_io_pfnmap(struct mm_struct *mm, unsigned long vaddr, long npage,
+                        unsigned long *pfn)
+{
+       struct vm_area_struct *vma;
+       int pinned = 0;
+
+       down_read(&mm->mmap_sem);
+       vma = find_vma_intersection(mm, vaddr, vaddr + 1);
+       if (vma && vma->vm_flags & (VM_IO | VM_PFNMAP)) {
+               *pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+               if (is_invalid_reserved_pfn(*pfn))
+                       pinned = min(npage, (long)vma_pages(vma));
+       }
+       up_read(&mm->mmap_sem);
+
+       return pinned;
+}
+
 /*
  * Attempt to pin pages.  We really don't want to track all the pfns and
  * the iommu can only map chunks of consecutive pfns anyway, so get the
@@ -392,6 +410,10 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
        if (!current->mm)
                return -ENODEV;

+       ret = try_io_pfnmap(current->mm, vaddr, npage, pfn_base);
+       if (ret)
+               return ret;
+
        ret = vaddr_get_pfn(current->mm, vaddr, dma->prot, pfn_base);
        if (ret)
                return ret;
--
2.13.6
