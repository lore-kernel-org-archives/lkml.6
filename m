Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C64C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BF2208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BF2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbeHPHHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 03:07:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbeHPHHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 03:07:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 20527A0245C68;
        Thu, 16 Aug 2018 12:11:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Thu, 16 Aug 2018
 12:11:44 +0800
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
To:     John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
 <20180815130046.GA19402@arm.com>
 <5961191f-f913-9bbf-5d0d-81800bec36a1@huawei.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B74F97F.8010902@huawei.com>
Date:   Thu, 16 Aug 2018 12:11:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5961191f-f913-9bbf-5d0d-81800bec36a1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/16 2:08, John Garry wrote:
> On 15/08/2018 14:00, Will Deacon wrote:
>> On Wed, Aug 15, 2018 at 01:26:31PM +0100, Robin Murphy wrote:
>>> On 15/08/18 11:23, Zhen Lei wrote:
>>>> The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
>>>> __arm_smmu_sync_poll_msi requires that sync_idx must be increased
>>>> monotonously according to the sequence of the CMDs in the cmdq.
>>>>
>>>> But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
>>>> by spinlock, so the following scenarios may appear:
>>>> cpu0            cpu1
>>>> msidata=0
>>>>             msidata=1
>>>>             insert cmd1
>>>> insert cmd0
>>>>             smmu execute cmd1
>>>> smmu execute cmd0
>>>>             poll timeout, because msidata=1 is overridden by
>>>>             cmd0, that means VAL=0, sync_idx=1.
>>>>
>>>> This is not a functional problem, just make the caller wait for a long
>>>> time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
>>>> during the waiting period will break it.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  drivers/iommu/arm-smmu-v3.c | 12 ++++++++----
>>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>> index 1d64710..3f5c236 100644
>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>> @@ -566,7 +566,7 @@ struct arm_smmu_device {
>>>>
>>>>      int                gerr_irq;
>>>>      int                combined_irq;
>>>> -    atomic_t            sync_nr;
>>>> +    u32                sync_nr;
>>>>
>>>>      unsigned long            ias; /* IPA */
>>>>      unsigned long            oas; /* PA */
>>>> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>>>      return 0;
>>>>  }
>>>>
>>>> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
>>>
>>> If we *are* going to go down this route then I think it would make sense to
>>> move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e.
>>> arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync
>>> command, then calling this guy would convert it to an MSI-based one. As-is,
>>> having bits of mutually-dependent data handled across two separate places
>>> just seems too messy and error-prone.
>>
>> Yeah, but I'd first like to see some number showing that doing all of this
>> under the lock actually has an impact.
> 
> Update:
> 
> I tested this patch versus a modified version which builds the command under the queue spinlock (* below). From my testing there is a small difference:
> 
> Setup:
> Testing Single NVME card
> fio 15 processes
> No process pinning
> 
> Average Results:
> v3 patch read/r,w/write (IOPS): 301K/149K,149K/307K
> Build under lock version read/r,w/write (IOPS): 304K/150K,150K/311K
> 
> I don't know why it's better to build under the lock. We can test more.

I have analysed the assembly code, the memset will be optimized as Robin said to be "stp xzr, xzr, [x0]",
and the switch..case is as below:
ffff0000085e5744 <arm_smmu_cmdq_build_cmd>:
ffff0000085e5744:       a9007c1f        stp     xzr, xzr, [x0]			//memset
ffff0000085e5748:       39400023        ldrb    w3, [x1]
ffff0000085e574c:       f9400002        ldr     x2, [x0]
ffff0000085e5750:       aa020062        orr     x2, x3, x2
ffff0000085e5754:       f9000002        str     x2, [x0]
ffff0000085e5758:       39400023        ldrb    w3, [x1]			//ent->opcode
ffff0000085e575c:       51000463        sub     w3, w3, #0x1
ffff0000085e5760:       7101147f        cmp     w3, #0x45
ffff0000085e5764:       54000069        b.ls    ffff0000085e5770
ffff0000085e5768:       12800023        mov     w3, #0xfffffffe
ffff0000085e576c:       1400000e        b       ffff0000085e57a4
ffff0000085e5770:       b0003024        adrp    x4, ffff000008bea000
ffff0000085e5774:       91096084        add     x4, x4, #0x258			//static table in rodata
ffff0000085e5778:       38634883        ldrb    w3, [x4,w3,uxtw]		//use ent->opcode as index
ffff0000085e577c:       10000064        adr     x4, ffff0000085e5788
ffff0000085e5780:       8b238883        add     x3, x4, w3, sxtb #2
ffff0000085e5784:       d61f0060        br      x3				//jump to "case xxx:"

Actually, after apply the patch "inline arm_smmu_cmdq_build_cmd" sent by Robin, the memset and static table will be removed:
ffff0000085e68a8:       94123207        bl      ffff000008a730c4 <_raw_spin_lock_irqsave>
ffff0000085e68ac:       b9410ad5        ldr     w21, [x22,#264]
ffff0000085e68b0:       aa0003fa        mov     x26, x0
ffff0000085e68b4:       110006b5        add     w21, w21, #0x1			//++smmu->sync_nr
ffff0000085e68b8:       b9010ad5        str     w21, [x22,#264]
ffff0000085e68bc:       b50005f3        cbnz    x19, ffff0000085e6978		//if (ent->sync.msiaddr)
ffff0000085e68c0:       d28408c2        mov     x2, #0x2046
ffff0000085e68c4:       f2a1f802        movk    x2, #0xfc0, lsl #16		//the constant part of CMD_SYNC
ffff0000085e68c8:       aa158042        orr     x2, x2, x21, lsl #32		//or msidata
ffff0000085e68cc:       aa1603e0        mov     x0, x22				//x0 = x22 = smmu
ffff0000085e68d0:       910163a1        add     x1, x29, #0x58			//x1 = the address of local variable "cmd"
ffff0000085e68d4:       f9002fa2        str     x2, [x29,#88]			//save cmd[0]
ffff0000085e68d8:       927ec673        and     x19, x19, #0xffffffffffffc
ffff0000085e68dc:       f90033b3        str     x19, [x29,#96]			//save cmd[1]
ffff0000085e68e0:       97fffd0d        bl      ffff0000085e5d14 <arm_smmu_cmdq_insert_cmd>

So that, my patch v2 plus Robin's "inline arm_smmu_cmdq_build_cmd()" is a good choice.

But the assembly code of my patch v3, it seems that is still shorter than above:
ffff0000085e695c:       9412320a        bl      ffff000008a73184 <_raw_spin_lock_irqsave>
ffff0000085e6960:       aa0003f6        mov     x22, x0
ffff0000085e6964:       b9410a62        ldr     w2, [x19,#264]
ffff0000085e6968:       aa1303e0        mov     x0, x19
ffff0000085e696c:       f94023a3        ldr     x3, [x29,#64]
ffff0000085e6970:       910103a1        add     x1, x29, #0x40
ffff0000085e6974:       11000442        add     w2, w2, #0x1			//++smmu->sync_nr
ffff0000085e6978:       b9010a62        str     w2, [x19,#264]
ffff0000085e697c:       b9005ba2        str     w2, [x29,#88]
ffff0000085e6980:       aa028062        orr     x2, x3, x2, lsl #32
ffff0000085e6984:       f90023a2        str     x2, [x29,#64]
ffff0000085e6988:       97fffd58        bl      ffff0000085e5ee8 <arm_smmu_cmdq_insert_cmd>

> 
> I suppose there is no justification to build the command outside the spinlock based on these results alone...
> 
> Cheers,
> John
> 
> * Modified version:
> static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
> {
>     u64 cmd[CMDQ_ENT_DWORDS];
>     unsigned long flags;
>     struct arm_smmu_cmdq_ent ent = {
>         .opcode = CMDQ_OP_CMD_SYNC,
>         .sync    = {
>             .msiaddr = virt_to_phys(&smmu->sync_count),
>         },
>     };
> 
>     spin_lock_irqsave(&smmu->cmdq.lock, flags);
>     ent.sync.msidata = ++smmu->sync_nr;
>     arm_smmu_cmdq_build_cmd(cmd, &ent);
>     arm_smmu_cmdq_insert_cmd(smmu, cmd);
>     spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
>     return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
> }
> 
> 
>> Will
>>
>> .
>>
> 
> 
> 
> .
> 

-- 
Thanks!
BestRegards

