Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeFDLGP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:06:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752062AbeFDLGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:06:13 -0400
Subject: Re: [PATCH 1/7] iommu/dma: fix trival coding style mistake
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <1527752569-18020-2-git-send-email-thunder.leizhen@huawei.com>
 <b473059d-fee6-1627-4749-192771038741@arm.com>
CC: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        "Guozhu Li" <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B151CFA.10808@huawei.com>
Date: Mon, 4 Jun 2018 19:05:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <b473059d-fee6-1627-4749-192771038741@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/31 21:03, Robin Murphy wrote:
> On 31/05/18 08:42, Zhen Lei wrote:
>> The static function iova_reserve_iommu_regions is only called by function
>> iommu_dma_init_domain, and the 'if (!dev)' check in iommu_dma_init_domain
>> affect it only, so we can safely move the check into it. I think it looks
>> more natural.
> 
> As before, I disagree - the logic of iommu_dma_init_domain() is "we expect to have a valid device, but stop here if we don't", and moving the check just needlessly obfuscates that. It is not a coincidence that the arguments of both functions are in effective order of importance.
OK

> 
>> In addition, the local variable 'ret' is only assigned in the branch of
>> 'if (region->type == IOMMU_RESV_MSI)', so the 'if (ret)' should also only
>> take effect in the branch, add a brace to enclose it.
> 
> 'ret' is clearly also assigned at its declaration, to cover the (very likely) case where we don't enter the loop at all. Thus testing it in the loop is harmless, and cluttering that up with extra tabs and braces is just noise.
OK, I will drop this patch in v2

> 
> Robin.
> 
>> No functional changes.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index ddcbbdb..4e885f7 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -231,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>       LIST_HEAD(resv_regions);
>>       int ret = 0;
>>   +    if (!dev)
>> +        return 0;
>> +
>>       if (dev_is_pci(dev))
>>           iova_reserve_pci_windows(to_pci_dev(dev), iovad);
>>   @@ -246,11 +249,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>           hi = iova_pfn(iovad, region->start + region->length - 1);
>>           reserve_iova(iovad, lo, hi);
>>   -        if (region->type == IOMMU_RESV_MSI)
>> +        if (region->type == IOMMU_RESV_MSI) {
>>               ret = cookie_init_hw_msi_region(cookie, region->start,
>>                       region->start + region->length);
>> -        if (ret)
>> -            break;
>> +            if (ret)
>> +                break;
>> +        }
>>       }
>>       iommu_put_resv_regions(dev, &resv_regions);
>>   @@ -308,8 +312,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>       }
>>         init_iova_domain(iovad, 1UL << order, base_pfn);
>> -    if (!dev)
>> -        return 0;
>>         return iova_reserve_iommu_regions(dev, domain);
>>   }
>>
> 
> .
> 

-- 
Thanks!
BestRegards
