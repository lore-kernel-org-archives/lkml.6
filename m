Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeFDLmQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:42:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35392 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751482AbeFDLmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:42:14 -0400
Subject: Re: [PATCH 4/7] iommu/amd: make sure TLB to be flushed before IOVA
 freed
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <1527752569-18020-5-git-send-email-thunder.leizhen@huawei.com>
 <ccc47903-d946-13ed-3c68-b264bc44b216@arm.com>
CC: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        "Guozhu Li" <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B152573.2080905@huawei.com>
Date: Mon, 4 Jun 2018 19:41:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <ccc47903-d946-13ed-3c68-b264bc44b216@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/31 21:04, Robin Murphy wrote:
> On 31/05/18 08:42, Zhen Lei wrote:
>> Although the mapping has already been removed in the page table, it maybe
>> still exist in TLB. Suppose the freed IOVAs is reused by others before the
>> flush operation completed, the new user can not correctly access to its
>> meomory.
> 
> This change seems reasonable in isolation, but why is it right in the middle of a series which has nothing to do with x86?
Because I described more in the previous patch, which may help this patch to be understood well.

You're right, I will repost this patch separately.

> 
> Robin.
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/amd_iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index 8fb8c73..93aa389 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -2402,9 +2402,9 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
>>       }
>>         if (amd_iommu_unmap_flush) {
>> -        dma_ops_free_iova(dma_dom, dma_addr, pages);
>>           domain_flush_tlb(&dma_dom->domain);
>>           domain_flush_complete(&dma_dom->domain);
>> +        dma_ops_free_iova(dma_dom, dma_addr, pages);
>>       } else {
>>           pages = __roundup_pow_of_two(pages);
>>           queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
>>
> 
> .
> 

-- 
Thanks!
BestRegards
