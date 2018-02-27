Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeB0HpI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:45:08 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42486 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752098AbeB0HpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:45:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=jason.cai@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SyZwmsH_1519717488;
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [RFC] vfio iommu type1: improve memory pinning process for raw
 PFN mapping
From: "Jason Cai (Xiang Feng)" <jason.cai@linux.alibaba.com>
In-Reply-To: <20180226121930.5e1f6300@w520.home>
Date: Tue, 27 Feb 2018 15:44:48 +0800
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gnehzuil@linux.alibaba.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8112174E-E15E-4E77-986C-FE3AF4C23EC3@linux.alibaba.com>
References: <7090CB2E-8D63-44B1-A739-932FFA649BC9@linux.alibaba.com>
 <20180226121930.5e1f6300@w520.home>
To: Alex Williamson <alex.williamson@redhat.com>
X-Mailer: Apple Mail (2.3259)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 2018, at 3:19 AM, Alex Williamson <alex.williamson@redhat.com> wrote:

> On Sat, 24 Feb 2018 13:44:07 +0800
> jason <jason.cai@linux.alibaba.com> wrote:
> 
>> When using vfio to pass through a PCIe device (e.g. a GPU card) that
>> has a huge BAR (e.g. 16GB), a lot of cycles are wasted on memory
>> pinning because PFNs of PCI BAR are not backed by struct page, and
>> the corresponding VMA has flags VM_IO|VM_PFNMAP.
>> 
>> With this change, memory pinning process will firstly try to figure
>> out whether the corresponding region is a raw PFN mapping, and if so
>> it can skip unnecessary user memory pinning process.
>> 
>> Even though it commes with a little overhead, finding vma and testing
>> flags, on each call, it can significantly improve VM's boot up time
>> when passing through devices via VFIO.
> 
> Needs a Sign-off, see Documentation/process/submitting-patches.rst
> 
>> ---
>> drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>> 
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index e30e29ae4819..1a471ece3f9c 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -374,6 +374,24 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>>        return ret;
>> }
>> 
>> +static int try_io_pfnmap(struct mm_struct *mm, unsigned long vaddr, long npage,
>> +                        unsigned long *pfn)
>> +{
>> +       struct vm_area_struct *vma;
>> +       int pinned = 0;
>> +
>> +       down_read(&mm->mmap_sem);
>> +       vma = find_vma_intersection(mm, vaddr, vaddr + 1);
>> +       if (vma && vma->vm_flags & (VM_IO | VM_PFNMAP)) {
>> +               *pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
>> +               if (is_invalid_reserved_pfn(*pfn))
>> +                       pinned = min(npage, (long)vma_pages(vma));
>> +       }
>> +       up_read(&mm->mmap_sem);
>> +
>> +       return pinned;
>> +}
>> +
>> /*
>>  * Attempt to pin pages.  We really don't want to track all the pfns and
>>  * the iommu can only map chunks of consecutive pfns anyway, so get the
>> @@ -392,6 +410,10 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
>>        if (!current->mm)
>>                return -ENODEV;
>> 
>> +       ret = try_io_pfnmap(current->mm, vaddr, npage, pfn_base);
>> +       if (ret)
>> +               return ret;
>> +
>>        ret = vaddr_get_pfn(current->mm, vaddr, dma->prot, pfn_base);
>>        if (ret)
>>                return ret;
> 
> I like the idea, but couldn't we integrated it better?  For instance,
> does it really make sense to test for this first, the majority of users
> are going to have more regular mappings than PFNMAP mappings.  If we
> were to do the above optimization, doesn't the rsvd bits in the
> remainder of the code become cruft?  What if we optimized from the point
> where we test the return of vaddr_get_pfn() for a reserved/invalid page?
> Perhaps something like the below (untested, uncompiled) patch.  Also
> curious why the above tests VM_IO|VM_PFNMAP while vaddr_get_pfn() only
> tests VM_PFNMAP, we should at least be consistent, but also correct the
> existing function if it's missing a case. Thanks,
> 
> Alex
> 

Good points! The patch has been updated according to these points.
And I’ve also tested with it. Please see it at the end. Thanks.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e113b2c43be2..425922393316 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -399,7 +399,6 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> {
> 	unsigned long pfn = 0;
> 	long ret, pinned = 0, lock_acct = 0;
> -	bool rsvd;
> 	dma_addr_t iova = vaddr - dma->vaddr + dma->iova;
> 
> 	/* This code path is only user initiated */
> @@ -410,14 +409,23 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> 	if (ret)
> 		return ret;
> 
> +	if (is_invalid_reserved_pfn(*pfn_base)) {
> +		struct vm_area_struct *vma;
> +
> +		down_read(&mm->mmap_sem);
> +		vma = find_vma_intersection(mm, vaddr, vaddr + 1);
> +		pinned = min(npage, (long)vma_pages(vma));
> +		up_read(&mm->mmap_sem);
> +		return pinned;
> +	}
> +
> 	pinned++;
> -	rsvd = is_invalid_reserved_pfn(*pfn_base);
> 
> 	/*
> 	 * Reserved pages aren't counted against the user, externally pinned
> 	 * pages are already counted against the user.
> 	 */
> -	if (!rsvd && !vfio_find_vpfn(dma, iova)) {
> +	if (!vfio_find_vpfn(dma, iova)) {
> 		if (!lock_cap && current->mm->locked_vm + 1 > limit) {
> 			put_pfn(*pfn_base, dma->prot);
> 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
> @@ -437,13 +445,12 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> 		if (ret)
> 			break;
> 
> -		if (pfn != *pfn_base + pinned ||
> -		    rsvd != is_invalid_reserved_pfn(pfn)) {
> +		if (pfn != *pfn_base + pinned) {
> 			put_pfn(pfn, dma->prot);
> 			break;
> 		}
> 
> -		if (!rsvd && !vfio_find_vpfn(dma, iova)) {
> +		if (!vfio_find_vpfn(dma, iova)) {
> 			if (!lock_cap &&
> 			    current->mm->locked_vm + lock_acct + 1 > limit) {
> 				put_pfn(pfn, dma->prot);
> @@ -461,10 +468,8 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
> 
> unpin_out:
> 	if (ret) {
> -		if (!rsvd) {
> -			for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
> -				put_pfn(pfn, dma->prot);
> -		}
> +		for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
> +			put_pfn(pfn, dma->prot);
> 
> 		return ret;
> 	}


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
