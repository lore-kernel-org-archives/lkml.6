Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6D521735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6D521735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeH0KvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:51:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11607 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbeH0KvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:51:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 68A6A96DE6B37;
        Mon, 27 Aug 2018 15:05:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 27 Aug 2018
 15:05:29 +0800
Subject: Re: [PATCH v5 5/5] iommu/arm-smmu-v3: add bootup option
 "iommu.non_strict"
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
 <1534296510-12888-6-git-send-email-thunder.leizhen@huawei.com>
 <29330cf7-d269-c4db-2f5a-632509058987@arm.com>
CC:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B83A2B8.7030909@huawei.com>
Date:   Mon, 27 Aug 2018 15:05:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <29330cf7-d269-c4db-2f5a-632509058987@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/23 1:02, Robin Murphy wrote:
> On 15/08/18 02:28, Zhen Lei wrote:
>> Add a bootup option to make the system manager can choose which mode to
>> be used. The default mode is strict.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
>>   drivers/iommu/arm-smmu-v3.c                     | 22 +++++++++++++++++++++-
>>   2 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 5cde1ff..cb9d043e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1720,6 +1720,19 @@
>>           nobypass    [PPC/POWERNV]
>>               Disable IOMMU bypass, using IOMMU for PCI devices.
>>
>> +    iommu.non_strict=    [ARM64]
>> +            Format: { "0" | "1" }
>> +            0 - strict mode, default.
>> +                Release IOVAs after the related TLBs are invalid
>> +                completely.
>> +            1 - non-strict mode.
>> +                Put off TLBs invalidation and release memory first.
>> +                It's good for scatter-gather performance but lacks
>> +                full isolation, an untrusted device can access the
>> +                reused memory because the TLBs may still valid.
>> +                Please take    full consideration before choosing this
>> +                mode. Note that, VFIO will always use strict mode.
>> +
>>       iommu.passthrough=
>>               [ARM64] Configure DMA to bypass the IOMMU by default.
>>               Format: { "0" | "1" }
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 61eb7ec..0eda90e 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -631,6 +631,26 @@ struct arm_smmu_option_prop {
>>       { 0, NULL},
>>   };
>>
>> +static bool smmu_non_strict __read_mostly;
>> +
>> +static int __init arm_smmu_setup(char *str)
>> +{
>> +    int ret;
>> +
>> +    ret = kstrtobool(str, &smmu_non_strict);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (smmu_non_strict) {
>> +        pr_warn("WARNING: iommu non-strict mode is chosen.\n"
>> +            "It's good for scatter-gather performance but lacks full isolation\n");
>> +        add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>> +    }
>> +
>> +    return 0;
>> +}
>> +early_param("iommu.non_strict", arm_smmu_setup);
> 
> As I said on v3, the option should be parsed by iommu-dma, since that's where it takes effect, and I'm sure SMMUv2 users will be interested in trying it out too.

OK, I am so sorry that I have not understood your opinion correctly.

> 
> In other words, if iommu_dma_init_domain() does something like:
> 
>     if (iommu_dma_non_strict && domain->ops->flush_iotlb_all) {
>         domain->non_strict = true;
>         cookie->domain = domain;
>         init_iova_flush_queue(...);
>     }
> 
>> +
>>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>>                            struct arm_smmu_device *smmu)
>>   {
>> @@ -1622,7 +1642,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>>       if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>>           pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>>
>> -    if (domain->type == IOMMU_DOMAIN_DMA) {
>> +    if ((domain->type == IOMMU_DOMAIN_DMA) && smmu_non_strict) {
>>           domain->non_strict = true;
>>           pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>>       }
> 
> ...then all the driver should need to do is:
> 
>     if (domain->non_strict)
>         pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> 
> 
> Now, that would make it possible to request non-strict mode even with drivers which *don't* understand it, but I think that's not actually harmful, just means that some TLBIs will still get issued synchronously and the flush queue might not do much. If you wanted to avoid even that, you could replace domain->non_strict with an iommu_domain_set_attr() call, so iommu_dma could tell up-front whether the driver understands non-strict mode and it's worth setting the queue up or not.

OK, I will think seriously about it, thanks. I've been busy these days, I will reply to you as soon as possible.

> 
> Robin.
> 
> .
> 

-- 
Thanks!
BestRegards

