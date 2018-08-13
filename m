Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD04C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0679217DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0679217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeHMKcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:32:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbeHMKcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:32:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 11A4AC34D1281;
        Mon, 13 Aug 2018 15:50:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 15:50:51 +0800
Subject: Re: [PATCH v4 5/5] iommu/arm-smmu-v3: add bootup option "arm_iommu"
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-6-git-send-email-thunder.leizhen@huawei.com>
 <c46fa263-2dfa-b8fc-b2c1-0b1bf6029748@arm.com>
CC:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B713839.1010609@huawei.com>
Date:   Mon, 13 Aug 2018 15:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <c46fa263-2dfa-b8fc-b2c1-0b1bf6029748@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/9 19:08, Robin Murphy wrote:
> On 06/08/18 13:27, Zhen Lei wrote:
>> Add a bootup option to make the system manager can choose which mode to
>> be used. The default mode is strict.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>>   drivers/iommu/arm-smmu-v3.c                     | 17 ++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 533ff5c..426e989 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1720,6 +1720,15 @@
>>           nobypass    [PPC/POWERNV]
>>               Disable IOMMU bypass, using IOMMU for PCI devices.
>>
>> +    arm_iommu=    [ARM64]
>> +        non-strict    [Default Off]
> 
> Again, I'd much rather have "iommu.non_strict= { "0" | "1" }" in line with the passthrough option.

OK，I will change it in the next version.

> 
> Robin.
> 
>> +            Put off TLBs invalidation and release memory first.
>> +            It's good for scatter-gather performance but lacks full
>> +            isolation, an untrusted device can access the reused
>> +            memory because the TLBs may still valid. Please take
>> +            full consideration before choosing this mode.
>> +            Note that, VFIO will always use strict mode.
>> +
>>       iommu.passthrough=
>>               [ARM64] Configure DMA to bypass the IOMMU by default.
>>               Format: { "0" | "1" }
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 904bc1e..9a30892 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -631,6 +631,21 @@ struct arm_smmu_option_prop {
>>       { 0, NULL},
>>   };
>>
>> +static u32 smmu_non_strict __read_mostly;
>> +
>> +static int __init arm_smmu_setup(char *str)
>> +{
>> +    if (!strncmp(str, "non-strict", 10)) {
>> +        smmu_non_strict = 1;
>> +        pr_warn("WARNING: iommu non-strict mode is chosen.\n"
>> +            "It's good for scatter-gather performance but lacks full isolation\n");
>> +        add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>> +    }
>> +
>> +    return 0;
>> +}
>> +early_param("arm_iommu", arm_smmu_setup);
>> +
>>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>>                            struct arm_smmu_device *smmu)
>>   {
>> @@ -1622,7 +1637,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>>       if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>>           pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>>
>> -    if (domain->type == IOMMU_DOMAIN_DMA) {
>> +    if ((domain->type == IOMMU_DOMAIN_DMA) && smmu_non_strict) {
>>           domain->non_strict = 1;
>>           pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>>       }
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

