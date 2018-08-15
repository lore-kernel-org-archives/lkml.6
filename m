Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E3FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E05A208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E05A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHOVCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:02:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11115 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbeHOVCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:02:13 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5E7B48DB2B;
        Thu, 16 Aug 2018 02:08:58 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Thu, 16 Aug 2018
 02:08:51 +0800
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
To:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
 <20180815130046.GA19402@arm.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5961191f-f913-9bbf-5d0d-81800bec36a1@huawei.com>
Date:   Wed, 15 Aug 2018 19:08:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180815130046.GA19402@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2018 14:00, Will Deacon wrote:
> On Wed, Aug 15, 2018 at 01:26:31PM +0100, Robin Murphy wrote:
>> On 15/08/18 11:23, Zhen Lei wrote:
>>> The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
>>> __arm_smmu_sync_poll_msi requires that sync_idx must be increased
>>> monotonously according to the sequence of the CMDs in the cmdq.
>>>
>>> But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
>>> by spinlock, so the following scenarios may appear:
>>> cpu0			cpu1
>>> msidata=0
>>> 			msidata=1
>>> 			insert cmd1
>>> insert cmd0
>>> 			smmu execute cmd1
>>> smmu execute cmd0
>>> 			poll timeout, because msidata=1 is overridden by
>>> 			cmd0, that means VAL=0, sync_idx=1.
>>>
>>> This is not a functional problem, just make the caller wait for a long
>>> time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
>>> during the waiting period will break it.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index 1d64710..3f5c236 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -566,7 +566,7 @@ struct arm_smmu_device {
>>>
>>>  	int				gerr_irq;
>>>  	int				combined_irq;
>>> -	atomic_t			sync_nr;
>>> +	u32				sync_nr;
>>>
>>>  	unsigned long			ias; /* IPA */
>>>  	unsigned long			oas; /* PA */
>>> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>>  	return 0;
>>>  }
>>>
>>> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
>>
>> If we *are* going to go down this route then I think it would make sense to
>> move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e.
>> arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync
>> command, then calling this guy would convert it to an MSI-based one. As-is,
>> having bits of mutually-dependent data handled across two separate places
>> just seems too messy and error-prone.
>
> Yeah, but I'd first like to see some number showing that doing all of this
> under the lock actually has an impact.

Update:

I tested this patch versus a modified version which builds the command 
under the queue spinlock (* below). From my testing there is a small 
difference:

Setup:
Testing Single NVME card
fio 15 processes
No process pinning

Average Results:
v3 patch read/r,w/write (IOPS): 301K/149K,149K/307K
Build under lock version read/r,w/write (IOPS): 304K/150K,150K/311K

I don't know why it's better to build under the lock. We can test more.

I suppose there is no justification to build the command outside the 
spinlock based on these results alone...

Cheers,
John

* Modified version:
static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
{
     u64 cmd[CMDQ_ENT_DWORDS];
     unsigned long flags;
     struct arm_smmu_cmdq_ent ent = {
         .opcode = CMDQ_OP_CMD_SYNC,
         .sync    = {
             .msiaddr = virt_to_phys(&smmu->sync_count),
         },
     };

     spin_lock_irqsave(&smmu->cmdq.lock, flags);
     ent.sync.msidata = ++smmu->sync_nr;
     arm_smmu_cmdq_build_cmd(cmd, &ent);
     arm_smmu_cmdq_insert_cmd(smmu, cmd);
     spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

     return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
}


> Will
>
> .
>


