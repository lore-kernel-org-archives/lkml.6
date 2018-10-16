Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B792083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B792083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJPRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:30:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeJPRa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:30:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E6C0F72EEB1F;
        Tue, 16 Oct 2018 17:41:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 17:41:15 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
To:     Will Deacon <will.deacon@arm.com>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
 <20181015172146.GD31305@brain-police>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5BC5B23A.5040003@huawei.com>
Date:   Tue, 16 Oct 2018 17:41:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181015172146.GD31305@brain-police>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/16 1:21, Will Deacon wrote:
> On Mon, Oct 15, 2018 at 04:36:16PM +0800, Zhen Lei wrote:
>> ITS translation register map:
>> 0x0000-0x003C	Reserved
>> 0x0040		GITS_TRANSLATER
>> 0x0044-0xFFFC	Reserved
>>
>> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
>> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
>> data will be written to MSIAddress each time.
>>
>> MSIAddr: |----4bytes----|----4bytes----|
>> 	 |    MSIData   |    IMPDEF    |
>>
>> There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
>> But it will overwrite the 4 bytes memory following "sync_count". It's very
>> luckly that the previous and the next neighbour of "sync_count" are both aligned
>> by 8 bytes, so no problem is met now.
>>
>> It's good to explicitly add a workaround:
>> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
>>    aligned by 8 bytes.
>> 2. Add a "u64" union member to make sure the 4 bytes padding is always exist.
>>
>> There is no functional change.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 5059d09..a07bc0d 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -586,7 +586,10 @@ struct arm_smmu_device {
>>  
>>  	struct arm_smmu_strtab_cfg	strtab_cfg;
>>  
>> +	union {
>> +	u64				padding; /* workaround for Hisilicon */
>>  	u32				sync_count;
>> +	} __attribute__((aligned(8)));
> 
> Won't this already be aligned by the ABI?
> 
> Anyway, you'll need to swizzle things for big-endian, I suspect. Maybe you
> can do something clever like making sync_count an array of two elements
> and determining the offset based on the endianness. Or just keep it simple
> like we do for things like struct qrwlock and struct qspinlock and use
> #ifdefs.

This workaround is a special case, the sync_count is only written by ITS hardware,
and is only read by software. Although Hisilicon ITS will write 8 bytes at
MSIAddress(required it aligned by 8 bytes), but it can sure that the value of
MSIdata will be written at the lower 4 bytes(the start address of sync_count).
Because the type of sync_count is u32, so that CPU is also read the 4 bytes at
the lower address.

> 
> Also -- you need a comment to explain this insanity :)
> 
> Will
> 
> .
> 

-- 
Thanks!
BestRegards

