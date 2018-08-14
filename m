Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D238EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449F216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2449F216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbeHNEeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:34:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbeHNEeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:34:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B09171645CFC2;
        Tue, 14 Aug 2018 09:49:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Tue, 14 Aug 2018
 09:49:12 +0800
Subject: Re: [PATCH v4 4/5] iommu/arm-smmu-v3: add support for non-strict mode
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-5-git-send-email-thunder.leizhen@huawei.com>
 <94c88d9e-818e-f893-9ee2-7a0cf425bd9a@arm.com>
CC:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B723517.3010603@huawei.com>
Date:   Tue, 14 Aug 2018 09:49:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <94c88d9e-818e-f893-9ee2-7a0cf425bd9a@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/9 19:06, Robin Murphy wrote:
> On 06/08/18 13:27, Zhen Lei wrote:
>> Dynamically choose strict or non-strict mode for page table config based
>> on the iommu domain type.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 2f1304b..904bc1e 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -1622,6 +1622,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>>       if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>>           pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>>
>> +    if (domain->type == IOMMU_DOMAIN_DMA) {
>> +        domain->non_strict = 1;
>> +        pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> +    }
>> +
>>       pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>>       if (!pgtbl_ops)
>>           return -ENOMEM;
>> @@ -1782,7 +1787,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>>   {
>>       struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
>>
>> -    if (smmu)
>> +    if (smmu && !domain->non_strict)
> 
> That doesn't smell right - even in non-strict domains we still need stuff like walk cache invalidations for non-leaf unmaps to be synchronous, so we can't just ignore all sync operations at the driver level. I think the right thing to do to elide the "normal" sync on unmap is to first convert __iommu_dma_unmap to use iommu_unmap_fast()/iommu_tlb_sync(), then make it not issue that sync at all for non-strict domains.

OK, I will try it.

> 
> Robin.
> 
>>           __arm_smmu_tlb_sync(smmu);
>>   }
>>
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

