Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755203AbeEaNEi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:04:38 -0400
Received: from foss.arm.com ([217.140.101.70]:41198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755025AbeEaNEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:04:37 -0400
Subject: Re: [PATCH 4/7] iommu/amd: make sure TLB to be flushed before IOVA
 freed
To: Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <1527752569-18020-5-git-send-email-thunder.leizhen@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ccc47903-d946-13ed-3c68-b264bc44b216@arm.com>
Date: Thu, 31 May 2018 14:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527752569-18020-5-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 08:42, Zhen Lei wrote:
> Although the mapping has already been removed in the page table, it maybe
> still exist in TLB. Suppose the freed IOVAs is reused by others before the
> flush operation completed, the new user can not correctly access to its
> meomory.

This change seems reasonable in isolation, but why is it right in the 
middle of a series which has nothing to do with x86?

Robin.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/amd_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 8fb8c73..93aa389 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2402,9 +2402,9 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
>   	}
>   
>   	if (amd_iommu_unmap_flush) {
> -		dma_ops_free_iova(dma_dom, dma_addr, pages);
>   		domain_flush_tlb(&dma_dom->domain);
>   		domain_flush_complete(&dma_dom->domain);
> +		dma_ops_free_iova(dma_dom, dma_addr, pages);
>   	} else {
>   		pages = __roundup_pow_of_two(pages);
>   		queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
> 
