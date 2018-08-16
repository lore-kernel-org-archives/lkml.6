Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F83C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59621480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F59621480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbeHPLSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:18:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389696AbeHPLSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:18:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 038C2B72D314B;
        Thu, 16 Aug 2018 16:21:27 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Thu, 16 Aug 2018
 16:21:18 +0800
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
CC:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B7533FD.20903@huawei.com>
Date:   Thu, 16 Aug 2018 16:21:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/15 20:26, Robin Murphy wrote:
> On 15/08/18 11:23, Zhen Lei wrote:
>> The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
>> __arm_smmu_sync_poll_msi requires that sync_idx must be increased
>> monotonously according to the sequence of the CMDs in the cmdq.
>>
>> But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
>> by spinlock, so the following scenarios may appear:
>> cpu0            cpu1
>> msidata=0
>>             msidata=1
>>             insert cmd1
>> insert cmd0
>>             smmu execute cmd1
>> smmu execute cmd0
>>             poll timeout, because msidata=1 is overridden by
>>             cmd0, that means VAL=0, sync_idx=1.
>>
>> This is not a functional problem, just make the caller wait for a long
>> time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
>> during the waiting period will break it.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 1d64710..3f5c236 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -566,7 +566,7 @@ struct arm_smmu_device {
>>
>>       int                gerr_irq;
>>       int                combined_irq;
>> -    atomic_t            sync_nr;
>> +    u32                sync_nr;
>>
>>       unsigned long            ias; /* IPA */
>>       unsigned long            oas; /* PA */
>> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>       return 0;
>>   }
>>
>> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
> 
> If we *are* going to go down this route then I think it would make sense to move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e. arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync command, then calling this guy would convert it to an MSI-based one. As-is, having bits of mutually-dependent data handled across two separate places just seems too messy and error-prone.

Yes, How about create a new function "arm_smmu_cmdq_build_sync_msi_cmd"?

static inline
void arm_smmu_cmdq_build_sync_msi_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
{
	cmd[0]  = FIELD_PREP(CMDQ_0_OP, ent->opcode);
	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
	cmd[1]  = ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
}


> 
> That said, I still don't think that just building the whole command under the lock is really all that bad - even when it doesn't get optimised into one of the assignments that memset you call out is only a single "stp xzr, xzr, ...", and a couple of extra branches doesn't seem a huge deal compared to the DSB and MMIO accesses (and potentially polling) that we're about to do anyway. I've tried hacking things up enough to convince GCC to inline a specialisation of the relevant switch case when ent->opcode is known, and that reduces the "overhead" down to just a handful of ALU instructions. I still need to try cleaning said hack up and double-check that it doesn't have any adverse impact on all the other SMMUv3 stuff in development, but watch this space...
> 
> Robin.
> 
>> +{
>> +    cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, msidata);
>> +}
>> +
>>   /* High-level queue accessors */
>>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>   {
>> @@ -836,7 +841,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>               cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>>           cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>>           cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>> -        cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
>>           cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>>           break;
>>       default:
>> @@ -947,7 +951,6 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>>       struct arm_smmu_cmdq_ent ent = {
>>           .opcode = CMDQ_OP_CMD_SYNC,
>>           .sync    = {
>> -            .msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
>>               .msiaddr = virt_to_phys(&smmu->sync_count),
>>           },
>>       };
>> @@ -955,6 +958,8 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>>       arm_smmu_cmdq_build_cmd(cmd, &ent);
>>
>>       spin_lock_irqsave(&smmu->cmdq.lock, flags);
>> +    ent.sync.msidata = ++smmu->sync_nr;
>> +    arm_smmu_cmdq_sync_set_msidata(cmd, ent.sync.msidata);
>>       arm_smmu_cmdq_insert_cmd(smmu, cmd);
>>       spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
>>
>> @@ -2179,7 +2184,6 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>>   {
>>       int ret;
>>
>> -    atomic_set(&smmu->sync_nr, 0);
>>       ret = arm_smmu_init_queues(smmu);
>>       if (ret)
>>           return ret;
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

