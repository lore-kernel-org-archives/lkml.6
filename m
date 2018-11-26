Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0073C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46882086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46882086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeK0ANE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:13:04 -0500
Received: from foss.arm.com ([217.140.101.70]:37256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeK0ANE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:13:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8841C339A;
        Mon, 26 Nov 2018 05:18:57 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31ACA3F5A0;
        Mon, 26 Nov 2018 05:18:55 -0800 (PST)
Subject: Re: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, joro@8bytes.org,
        Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
 <bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com>
 <20181123213448.GW3065@bombadil.infradead.org>
 <CAFqt6zYmy5SdZY6_1BXFbY2pBQaNd+Z8R71wHEs6nKmxjht07A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7a3e53dc-9949-5b33-1282-54ae8ac1c62f@arm.com>
Date:   Mon, 26 Nov 2018 13:18:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYmy5SdZY6_1BXFbY2pBQaNd+Z8R71wHEs6nKmxjht07A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 06:44, Souptick Joarder wrote:
> On Sat, Nov 24, 2018 at 3:04 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Nov 23, 2018 at 05:23:06PM +0000, Robin Murphy wrote:
>>> On 15/11/2018 15:49, Souptick Joarder wrote:
>>>> Convert to use vm_insert_range() to map range of kernel
>>>> memory to user vma.
>>>>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>> Reviewed-by: Matthew Wilcox <willy@infradead.org>
>>>> ---
>>>>    drivers/iommu/dma-iommu.c | 12 ++----------
>>>>    1 file changed, 2 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>> index d1b0475..69c66b1 100644
>>>> --- a/drivers/iommu/dma-iommu.c
>>>> +++ b/drivers/iommu/dma-iommu.c
>>>> @@ -622,17 +622,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>>>>    int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>>>>    {
>>>> -   unsigned long uaddr = vma->vm_start;
>>>> -   unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>> -   int ret = -ENXIO;
>>>> +   unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>> -   for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
>>>> -           ret = vm_insert_page(vma, uaddr, pages[i]);
>>>> -           if (ret)
>>>> -                   break;
>>>> -           uaddr += PAGE_SIZE;
>>>> -   }
>>>> -   return ret;
>>>> +   return vm_insert_range(vma, vma->vm_start, pages, count);
>>>
>>> AFIACS, vm_insert_range() doesn't respect vma->vm_pgoff, so doesn't this
>>> break partial mmap()s of a large buffer? (which I believe can be a thing)
>>
>> Whoops.  That should have been:
>>
>> return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff, count);
> 
> I am unable to trace back where vma->vm_pgoff is set for this driver ? if any ?

This isn't a driver - it's a DMA API backend, so any caller of 
dma_mmap_*() could potentially end up here (similarly for patch 2/9).

Robin.

> If default value set to 0 then I think existing code is correct.
> 
>>
>> I suppose.
>>
> 
>> Although arguably we should respect vm_pgoff inside vm_insert_region()
>> and then callers automatically get support for vm_pgoff without having
>> to think about it ...
> 
> I assume, vm_insert_region() means vm_insert_range(). If we respect vm_pgoff
> inside vm_insert_range, for any uninitialized/ error value set for vm_pgoff from
> drivers will introduce a bug inside core mm which might be difficult
> to trace back.
> But when vm_pgoff set and passed from caller (drivers) it might be
> easy to figure out.
> 
>> although we should then also pass in the length
>> of the pages array to avoid pages being mapped in which aren't part of
>> the allocated array.
> 
> Mostly Partial mapping is done by starting from an index and mapped it till
> end of pages array. Calculating length of the pages array will have a small
> overhead for each drivers.
> 
> Please correct me if I am wrong.
> 
