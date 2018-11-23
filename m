Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C03C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C03C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440832AbeKXEIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:08:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49672 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391344AbeKXEIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:08:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 563F236BA;
        Fri, 23 Nov 2018 09:23:09 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F27203F5CF;
        Fri, 23 Nov 2018 09:23:07 -0800 (PST)
Subject: Re: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        willy@infradead.org, mhocko@suse.com, joro@8bytes.org
Cc:     linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bbad42cb-4a76-a7e7-c385-db77f1cc588b@arm.com>
Date:   Fri, 23 Nov 2018 17:23:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2018 15:49, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>   drivers/iommu/dma-iommu.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..69c66b1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -622,17 +622,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   
>   int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>   {
> -	unsigned long uaddr = vma->vm_start;
> -	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	int ret = -ENXIO;
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   
> -	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -		ret = vm_insert_page(vma, uaddr, pages[i]);
> -		if (ret)
> -			break;
> -		uaddr += PAGE_SIZE;
> -	}
> -	return ret;
> +	return vm_insert_range(vma, vma->vm_start, pages, count);

AFIACS, vm_insert_range() doesn't respect vma->vm_pgoff, so doesn't this 
break partial mmap()s of a large buffer? (which I believe can be a thing)

Robin.

>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> 
