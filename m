Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162FAECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B518321508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B518321508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeISA0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:26:03 -0400
Received: from foss.arm.com ([217.140.101.70]:49500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbeISA0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:26:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CFDAED1;
        Tue, 18 Sep 2018 11:52:08 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 449FC3F703;
        Tue, 18 Sep 2018 11:52:05 -0700 (PDT)
Subject: Re: [PATCH v7 2/6] iommu/dma: Add support for non-strict mode
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1536935328.git.robin.murphy@arm.com>
 <0a891cec4bb164f8cf2f57c753791a7d1f5f1d81.1536935328.git.robin.murphy@arm.com>
 <20180918171007.GJ16498@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <60410578-64f3-9bb3-0b88-27cde93335d0@arm.com>
Date:   Tue, 18 Sep 2018 19:52:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918171007.GJ16498@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 6:10 PM, Will Deacon wrote:
> Hi Robin,
> 
> On Fri, Sep 14, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>>     capable call domain->ops->flush_iotlb_all to flush TLB.
>> 2. During the iommu domain initialization phase, base on domain->non_strict
>>     field to check whether non-strict mode is supported or not. If so, call
>>     init_iova_flush_queue to register iovad->flush_cb callback.
>> 3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>>     -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>>     put off iova freeing, and omit iommu_tlb_sync operation.
> 
> Hmm, this is basically just a commentary on the code. Please could you write
> it more in terms of the problem that's being solved?

Sure - I intentionally kept a light touch when it came to the 
documentation and commit messages in this rework (other than patch #1 
where I eventually remembered the original reasoning and that it wasn't 
a bug). If we're more-or-less happy with the shape of the technical side 
I'll make sure to take a final pass through v8 to tidy up all the prose.

>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> [rm: convert raw boolean to domain attribute]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++++-
>>   include/linux/iommu.h     |  1 +
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 511ff9a1d6d9..092e6926dc3c 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -55,6 +55,9 @@ struct iommu_dma_cookie {
>>   	};
>>   	struct list_head		msi_page_list;
>>   	spinlock_t			msi_lock;
>> +
>> +	/* Only be assigned in non-strict mode, otherwise it's NULL */
>> +	struct iommu_domain		*domain;
>>   };
>>   
>>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>> @@ -257,6 +260,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>   	return ret;
>>   }
>>   
>> +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>> +{
>> +	struct iommu_dma_cookie *cookie;
>> +	struct iommu_domain *domain;
>> +
>> +	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
>> +	domain = cookie->domain;
>> +
>> +	domain->ops->flush_iotlb_all(domain);
> 
> Can we rely on this function pointer being non-NULL? I think it would
> be better to call iommu_flush_tlb_all(cookie->domain) instead.

Yeah, that's deliberate - in fact got as far as writing that change, 
then undid it as I realised that although the attribute conversion got 
rid of the explicit ops->flush_iotlb_all check, it still makes zero 
sense for an IOMMU driver to claim to support the flush queue attribute 
without also providing the relevant callback, so I do actually want this 
to blow up rather than silently do nothing if that assumption isn't met.

>> +}
>> +
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> @@ -275,6 +289,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>   	struct iova_domain *iovad = &cookie->iovad;
>>   	unsigned long order, base_pfn, end_pfn;
>> +	int attr = 1;
> 
> Do we actually need to initialise this?

Oops, no, that's a left-over from the turned-out-messier-that-I-thought 
v6 implementation.

Thanks,
Robin.
