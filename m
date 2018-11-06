Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F5AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A17F20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A17F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeKGDyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:54:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387704AbeKGDyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:54:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1771DA78;
        Tue,  6 Nov 2018 10:27:42 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F9413F5C0;
        Tue,  6 Nov 2018 10:27:41 -0800 (PST)
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d232ee7a-40de-5b32-39ab-222b773e9bb2@arm.com>
Date:   Tue, 6 Nov 2018 18:27:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 23:36, Nicolin Chen wrote:
> On Fri, Nov 02, 2018 at 04:54:07PM +0000, Robin Murphy wrote:
>> On 01/11/2018 21:35, Nicolin Chen wrote:
>>> The __GFP_ZERO will be passed down to the generic page allocation
>>> routine which zeros everything page by page. This is safe to be a
>>> generic way but not efficient for iommu allocation that organizes
>>> contiguous pages using scatterlist.
>>>
>>> So this changes drops __GFP_ZERO from the flag, and adds a manual
>>> memset after page/sg allocations, using the length of scatterlist.
>>>
>>> My test result of a 2.5MB size allocation shows iommu_dma_alloc()
>>> takes 46% less time, reduced from averagely 925 usec to 500 usec.
>>
>> Assuming this is for arm64, I'm somewhat surprised that memset() could be
>> that much faster than clear_page(), since they should effectively amount to
>> the same thing (a DC ZVA loop). What hardware is this on? Profiling to try
> 
> I am running with tegra186-p2771-0000.dtb so it's arm64 yes.
> 
>> and see exactly where the extra time goes would be interesting too.
> 
> I re-ran the test to get some accuracy within the function and got:
> 1) pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
>     // reduced from 422 usec to 56 usec == 366 usec less
> 2) if (!(prot & IOMMU_CACHE)) {...}	//flush routine
>     // reduced from 439 usec to 236 usec == 203 usec less
> Note: new memset takes about 164 usec, resulting in 400 usec diff
>        for the entire iommu_dma_alloc() function call.
> 
> It looks like this might be more than the diff between clear_page
> and memset, and might be related to mapping and cache. Any idea?

Hmm, I guess it might not be so much clear_page() itself as all the 
gubbins involved in getting there from prep_new_page(). I could perhaps 
make some vague guesses about how the A57 cores might get tickled by the 
different code patterns, but the Denver cores are well beyond my ability 
to reason about. Out of even further curiosity, how does the quick hack 
below compare?

>>> @@ -568,6 +571,15 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>>>    	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
>>>    		alloc_sizes = min_size;
>>> +	/*
>>> +	 * The generic zeroing in a length of one page size is slow,
>>> +	 * so do it manually in a length of scatterlist size instead
>>> +	 */
>>> +	if (gfp & __GFP_ZERO) {
>>> +		gfp &= ~__GFP_ZERO;
>>> +		gfp_zero = true;
>>> +	}
>>
>> Or just mask it out in __iommu_dma_alloc_pages()?
> 
> Yea, the change here would be neater then.
> 
>>> @@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>>>    	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
>>>    		goto out_free_iova;
>>> +	if (gfp_zero) {
>>> +		/* Now zero all the pages in the scatterlist */
>>> +		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
>>> +			memset(sg_virt(s), 0, s->length);
>>
>> What if the pages came from highmem? I know that doesn't happen on arm64
>> today, but the point of this code *is* to be generic, and other users will
>> arrive eventually.
> 
> Hmm, so it probably should use sg_miter_start/stop() too? Looking
> at the flush routine doing in PAGE_SIZE for each iteration, would
> be possible to map and memset contiguous pages together? Actually
> the flush routine might be also optimized if we can map contiguous
> pages.

I suppose the ideal point at which to do it would be after the remapping 
when we have the entire buffer contiguous in vmalloc space and can make 
best use of prefetchers etc. - DMA_ATTR_NO_KERNEL_MAPPING is a bit of a 
spanner in the works, but we could probably accommodate a special case 
for that. As Christoph points out, this isn't really the place to be 
looking for performance anyway (unless it's pathologically bad as per 
the DMA_ATTR_ALLOC_SINGLE_PAGES fun), but if we're looking at pulling 
the remapping out of the arch code, maybe we could aim to rework the 
zeroing completely as part of that.

Robin.

----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b04753b204..7d28db3bf4bf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -569,7 +569,7 @@ struct page **iommu_dma_alloc(struct device *dev, 
size_t size, gfp_t gfp,
  		alloc_sizes = min_size;

  	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
+	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp 
& ~__GFP_ZERO);
  	if (!pages)
  		return NULL;

@@ -581,15 +581,18 @@ struct page **iommu_dma_alloc(struct device *dev, 
size_t size, gfp_t gfp,
  	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
  		goto out_free_iova;

-	if (!(prot & IOMMU_CACHE)) {
+	{
  		struct sg_mapping_iter miter;
  		/*
  		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
  		 * sufficient here, so skip it by using the "wrong" direction.
  		 */
  		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
-		while (sg_miter_next(&miter))
+		while (sg_miter_next(&miter)) {
+			clear_page(miter.addr);
+			if (!(prot & IOMMU_CACHE))
  			flush_page(dev, miter.addr, page_to_phys(miter.page));
+		}
  		sg_miter_stop(&miter);
  	}

