Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062E9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE54020846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE54020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeFUGJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:09:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60450 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754065AbeFUGJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:09:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 76E7A29AFD2E0;
        Thu, 21 Jun 2018 14:09:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Thu, 21 Jun 2018
 14:09:51 +0800
Subject: Re: [PATCH 1/1] iommu/amd: make sure TLB to be flushed before IOVA
 freed
To:     Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1528251526-11408-1-git-send-email-thunder.leizhen@huawei.com>
CC:     Robin Murphy <robin.murphy@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B2B40F6.50309@huawei.com>
Date:   Thu, 21 Jun 2018 14:08:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1528251526-11408-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg:
  Can you take a look at it?


On 2018/6/6 10:18, Zhen Lei wrote:
> Although the mapping has already been removed in the page table, it maybe
> still exist in TLB. Suppose the freed IOVAs is reused by others before the
> flush operation completed, the new user can not correctly access to its
> meomory.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 8fb8c73..93aa389 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2402,9 +2402,9 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
>  	}
> 
>  	if (amd_iommu_unmap_flush) {
> -		dma_ops_free_iova(dma_dom, dma_addr, pages);
>  		domain_flush_tlb(&dma_dom->domain);
>  		domain_flush_complete(&dma_dom->domain);
> +		dma_ops_free_iova(dma_dom, dma_addr, pages);
>  	} else {
>  		pages = __roundup_pow_of_two(pages);
>  		queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
> --
> 1.8.3
> 
> 
> 
> .
> 

-- 
Thanks!
BestRegards

