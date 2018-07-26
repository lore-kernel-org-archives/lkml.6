Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F25C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09FD20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09FD20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeGZFaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:30:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeGZFa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:30:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8143728D738C5;
        Thu, 26 Jul 2018 12:15:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Thu, 26 Jul 2018
 12:15:30 +0800
Subject: Re: [PATCH v3 2/6] iommu/dma: add support for non-strict mode
To:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-3-git-send-email-thunder.leizhen@huawei.com>
 <4a668c7c-bce6-eef0-e11d-319333c60fcb@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B594AE0.2090701@huawei.com>
Date:   Thu, 26 Jul 2018 12:15:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <4a668c7c-bce6-eef0-e11d-319333c60fcb@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/25 6:01, Robin Murphy wrote:
> On 2018-07-12 7:18 AM, Zhen Lei wrote:
>> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>>     capable call domain->ops->flush_iotlb_all to flush TLB.
>> 2. Add a new iommu capability: IOMMU_CAP_NON_STRICT, which used to indicate
>>     that the iommu domain support non-strict mode.
>> 3. During the iommu domain initialization phase, call capable() to check
>>     whether it support non-strcit mode. If so, call init_iova_flush_queue
>>     to register iovad->flush_cb callback.
>> 4. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>>     -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>>     put off iova freeing.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 25 +++++++++++++++++++++++++
>>   include/linux/iommu.h     |  7 +++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index ddcbbdb..9f0c77a 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -55,6 +55,7 @@ struct iommu_dma_cookie {
>>       };
>>       struct list_head        msi_page_list;
>>       spinlock_t            msi_lock;
>> +    struct iommu_domain        *domain_non_strict;
>>   };
>>     static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>> @@ -257,6 +258,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>       return ret;
>>   }
>>   +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>> +{
>> +    struct iommu_dma_cookie *cookie;
>> +    struct iommu_domain *domain;
>> +
>> +    cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
>> +    domain = cookie->domain_non_strict;
>> +
>> +    domain->ops->flush_iotlb_all(domain);
>> +}
>> +
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> @@ -272,6 +284,7 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>   int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>           u64 size, struct device *dev)
>>   {
>> +    const struct iommu_ops *ops = domain->ops;
>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>       struct iova_domain *iovad = &cookie->iovad;
>>       unsigned long order, base_pfn, end_pfn;
>> @@ -308,6 +321,15 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>       }
>>         init_iova_domain(iovad, 1UL << order, base_pfn);
>> +
>> +    if ((ops->capable && ops->capable(IOMMU_CAP_NON_STRICT)) &&
>> +        (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_NON_STRICT)) {
>> +        BUG_ON(!ops->flush_iotlb_all);
>> +
>> +        cookie->domain_non_strict = domain;
>> +        init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
>> +    }
>> +
>>       if (!dev)
>>           return 0;
>>   @@ -390,6 +412,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>>       /* The MSI case is only ever cleaning up its most recent allocation */
>>       if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>>           cookie->msi_iova -= size;
>> +    else if (cookie->domain_non_strict)
>> +        queue_iova(iovad, iova_pfn(iovad, iova),
>> +                size >> iova_shift(iovad), 0);
>>       else
>>           free_iova_fast(iovad, iova_pfn(iovad, iova),
>>                   size >> iova_shift(iovad));
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 19938ee..82ed979 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -86,6 +86,12 @@ struct iommu_domain_geometry {
>>   #define IOMMU_DOMAIN_DMA    (__IOMMU_DOMAIN_PAGING |    \
>>                    __IOMMU_DOMAIN_DMA_API)
>>   +#define IOMMU_STRICT        0
>> +#define IOMMU_NON_STRICT    1
>> +#define IOMMU_STRICT_MODE_MASK    1UL
>> +#define IOMMU_DOMAIN_STRICT_MODE(domain)    \
>> +        (domain->type != IOMMU_DOMAIN_UNMANAGED)
>> +
>>   struct iommu_domain {
>>       unsigned type;
>>       const struct iommu_ops *ops;
>> @@ -101,6 +107,7 @@ enum iommu_cap {
>>                          transactions */
>>       IOMMU_CAP_INTR_REMAP,        /* IOMMU supports interrupt isolation */
>>       IOMMU_CAP_NOEXEC,        /* IOMMU_NOEXEC flag */
>> +    IOMMU_CAP_NON_STRICT,        /* IOMMU supports non-strict mode */
> 
> This still isn't a capability of the hardware. Non-strict mode is pure software policy; *every IOMMU ever* supports it.
> 
> If you want to have this kind of per-driver control, make it a domain attribute - that's not only more logical, but should also work out a lot cleaner overall.

OK, I will use quirk, so this capability will be removed in the next version.

> 
> Robin.
> 
>>   };
>>     /*
>>
> 
> .
> 

-- 
Thanks!
BestRegards

