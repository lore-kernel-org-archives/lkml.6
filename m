Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68EBC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C32420820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C32420820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeKAXLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:11:05 -0400
Received: from foss.arm.com ([217.140.101.70]:56986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeKAXLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:11:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA22BA78;
        Thu,  1 Nov 2018 07:07:57 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF84B3F5D3;
        Thu,  1 Nov 2018 07:07:56 -0700 (PDT)
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
To:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
Date:   Thu, 1 Nov 2018 14:07:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031200355.19945-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2018 20:03, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to allocate one single page from CMA area. Since
> the CMA area has a limited predefined size of space, it might run
> out of space in some heavy use case, where there might be quite a
> lot CMA pages being allocated for single pages.
> 
> This patch tries to skip CMA allocations of single pages and lets
> them go through normal page allocations. This would save resource
> in the CMA area for further more CMA allocations.

In general, this seems to make sense to me. It does represent a 
theoretical change in behaviour for devices which have their own CMA 
area somewhere other than kernel memory, and only ever make non-atomic 
allocations, but I'm not sure whether that's a realistic or common 
enough case to really worry about.

Robin.

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   kernel/dma/direct.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 22a12ab5a5e9..14c5d49eded2 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -120,8 +120,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>   			&phys_mask);
>   again:
> -	/* CMA can be used only in the context which permits sleeping */
> -	if (gfpflags_allow_blocking(gfp)) {
> +	/*
> +	 * CMA can be used only in the context which permits sleeping.
> +	 * Since addresses within one PAGE are always contiguous, skip
> +	 * CMA allocation for a single page to save CMA reserved space
> +	 */
> +	if (gfpflags_allow_blocking(gfp) && count > 1) {
>   		page = dma_alloc_from_contiguous(dev, count, page_order,
>   						 gfp & __GFP_NOWARN);
>   		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> 
