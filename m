Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF67C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4272E21D19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4272E21D19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbeHINZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:25:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbeHINZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:25:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1663D8CBF579C;
        Thu,  9 Aug 2018 19:01:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Thu, 9 Aug 2018
 19:01:10 +0800
Subject: Re: [PATCH v4 2/5] iommu/dma: add support for non-strict mode
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-3-git-send-email-thunder.leizhen@huawei.com>
 <e57298b0-66ec-b97c-1b36-b35bb3e1f20a@arm.com>
CC:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B6C1EF5.2050602@huawei.com>
Date:   Thu, 9 Aug 2018 19:01:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <e57298b0-66ec-b97c-1b36-b35bb3e1f20a@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/9 18:46, Robin Murphy wrote:
> On 06/08/18 13:27, Zhen Lei wrote:
>> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>>     capable call domain->ops->flush_iotlb_all to flush TLB.
>> 2. During the iommu domain initialization phase, base on domain->non_strict
>>     field to check whether non-strict mode is supported or not. If so, call
>>     init_iova_flush_queue to register iovad->flush_cb callback.
>> 3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>>     -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>>     put off iova freeing.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 23 +++++++++++++++++++++++
>>   drivers/iommu/iommu.c     |  1 +
>>   include/linux/iommu.h     |  1 +
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index ddcbbdb..213e62a 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -55,6 +55,7 @@ struct iommu_dma_cookie {
>>       };
>>       struct list_head        msi_page_list;
>>       spinlock_t            msi_lock;
>> +    struct iommu_domain        *domain;
>>   };
>>
>>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>> @@ -257,6 +258,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>       return ret;
>>   }
>>
>> +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>> +{
>> +    struct iommu_dma_cookie *cookie;
>> +    struct iommu_domain *domain;
>> +
>> +    cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
>> +    domain = cookie->domain;
>> +
>> +    domain->ops->flush_iotlb_all(domain);
>> +}
>> +
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> @@ -308,6 +320,14 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>       }
>>
>>       init_iova_domain(iovad, 1UL << order, base_pfn);
>> +
>> +    if (domain->non_strict) {
>> +        BUG_ON(!domain->ops->flush_iotlb_all);
>> +
>> +        cookie->domain = domain;
> 
> cookie->domain will only be non-NULL if domain->non_strict is true...
> 
>> +        init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
>> +    }
>> +
>>       if (!dev)
>>           return 0;
>>
>> @@ -390,6 +410,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>>       /* The MSI case is only ever cleaning up its most recent allocation */
>>       if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>>           cookie->msi_iova -= size;
>> +    else if (cookie->domain && cookie->domain->non_strict)
> 
> ...so we don't need to re-check non_strict every time here.

OK, I will change it to a comment.

> 
>> +        queue_iova(iovad, iova_pfn(iovad, iova),
>> +                size >> iova_shift(iovad), 0);
>>       else
>>           free_iova_fast(iovad, iova_pfn(iovad, iova),
>>                   size >> iova_shift(iovad));
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 63b3756..7811fde 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1263,6 +1263,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>
>>       domain->ops  = bus->iommu_ops;
>>       domain->type = type;
>> +    domain->non_strict = 0;
>>       /* Assume all sizes by default; the driver may override this later */
>>       domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 19938ee..0a0fb48 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -88,6 +88,7 @@ struct iommu_domain_geometry {
>>
>>   struct iommu_domain {
>>       unsigned type;
>> +    int non_strict;
> 
> bool?

OK

> 
> Robin.
> 
>>       const struct iommu_ops *ops;
>>       unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>>       iommu_fault_handler_t handler;
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

-- 
Thanks!
BestRegards

