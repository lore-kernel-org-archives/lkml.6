Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9097C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9473320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9473320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeLJQbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:31:49 -0500
Received: from foss.arm.com ([217.140.101.70]:58168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeLJQbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:31:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33C071596;
        Mon, 10 Dec 2018 08:31:48 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D001C3F6A8;
        Mon, 10 Dec 2018 08:31:46 -0800 (PST)
Subject: Re: [PATCH v3 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, joro@8bytes.org,
        Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181206184343.GA30569@jordon-HP-15-Notebook-PC>
 <d02ad9d7-d0f6-c891-bb7e-fdf6661f651c@arm.com>
 <CAFqt6zYF5fFQuGFGss3D1q=jKJGPOD33XLmZiAkBFT9zx_55LA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <67137be3-c56f-fb01-5ebe-86e9ebf5714b@arm.com>
Date:   Mon, 10 Dec 2018 16:31:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYF5fFQuGFGss3D1q=jKJGPOD33XLmZiAkBFT9zx_55LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 20:41, Souptick Joarder wrote:
> On Fri, Dec 7, 2018 at 7:17 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 06/12/2018 18:43, Souptick Joarder wrote:
>>> Convert to use vm_insert_range() to map range of kernel
>>> memory to user vma.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Reviewed-by: Matthew Wilcox <willy@infradead.org>
>>> ---
>>>    drivers/iommu/dma-iommu.c | 13 +++----------
>>>    1 file changed, 3 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index d1b0475..a2c65e2 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -622,17 +622,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>>>
>>>    int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>>>    {
>>> -     unsigned long uaddr = vma->vm_start;
>>> -     unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>> -     int ret = -ENXIO;
>>> +     unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>
>>> -     for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
>>> -             ret = vm_insert_page(vma, uaddr, pages[i]);
>>> -             if (ret)
>>> -                     break;
>>> -             uaddr += PAGE_SIZE;
>>> -     }
>>> -     return ret;
>>> +     return vm_insert_range(vma, vma->vm_start,
>>> +                             pages + vma->vm_pgoff, count);
>>
>> You also need to adjust count to compensate for the pages skipped by
>> vm_pgoff, otherwise you've got an out-of-bounds dereference triggered
>> from userspace, which is pretty high up the "not good" scale (not to
>> mention the entire call would then propagate -EFAULT back from
>> vm_insert_page() and thus always appear to fail for nonzero offsets).
> 
> So this should something similar to ->
> 
>          return vm_insert_range(vma, vma->vm_start,
>                                  pages + vma->vm_pgoff, count - vma->vm_pgoff);
> 

Yup, I think that looks appropriate.

Robin.
