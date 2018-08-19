Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113EFC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C296B215EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C296B215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeHSKNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 06:13:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbeHSKNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 06:13:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 229CAACF9269B;
        Sun, 19 Aug 2018 15:03:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Sun, 19 Aug 2018
 15:02:59 +0800
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com> <5B7533FD.20903@huawei.com>
 <20180816091805.GB31093@arm.com>
 <ad5bd6c0-20bd-9581-a12a-4464e5ec69f6@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
Message-ID: <5B791622.4040509@huawei.com>
Date:   Sun, 19 Aug 2018 15:02:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <ad5bd6c0-20bd-9581-a12a-4464e5ec69f6@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/16 17:27, Robin Murphy wrote:
> On 2018-08-16 10:18 AM, Will Deacon wrote:
>> On Thu, Aug 16, 2018 at 04:21:17PM +0800, Leizhen (ThunderTown) wrote:
>>> On 2018/8/15 20:26, Robin Murphy wrote:
>>>> On 15/08/18 11:23, Zhen Lei wrote:
>>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>>> index 1d64710..3f5c236 100644
>>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>>> @@ -566,7 +566,7 @@ struct arm_smmu_device {
>>>>>
>>>>>        int                gerr_irq;
>>>>>        int                combined_irq;
>>>>> -    atomic_t            sync_nr;
>>>>> +    u32                sync_nr;
>>>>>
>>>>>        unsigned long            ias; /* IPA */
>>>>>        unsigned long            oas; /* PA */
>>>>> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
>>>>
>>>> If we *are* going to go down this route then I think it would make sense
>>>> to move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e.
>>>> arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync
>>>> command, then calling this guy would convert it to an MSI-based one.
>>>> As-is, having bits of mutually-dependent data handled across two
>>>> separate places just seems too messy and error-prone.
>>>
>>> Yes, How about create a new function "arm_smmu_cmdq_build_sync_msi_cmd"?
>>>
>>> static inline
>>> void arm_smmu_cmdq_build_sync_msi_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>> {
>>>     cmd[0]  = FIELD_PREP(CMDQ_0_OP, ent->opcode);
>>>     cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
>>>     cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>>>     cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);

miss:   cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);

>>>     cmd[1]  = ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>>> }
>>
>> None of this seems justified given the numbers from John, so please just do
>> the simple thing and build the command with the lock held.

In order to observe the optimization effect, I conducted 5 tests for each
case. Although the test result is volatility, but we can still get which case
is good or bad. It accords with our theoretical analysis.

Test command: fio -numjobs=8 -rw=randread -runtime=30 ... -bs=4k
Test Result: IOPS, for example: read : io=86790MB, bw=2892.1MB/s, iops=740586, runt= 30001msec

Case 1: (without these patches)
675480
672055
665275
648610
661146

Case 2: (move arm_smmu_cmdq_build_cmd into lock)
688714
697355
632951
700540
678459

Case 3: (base on case 2, replace arm_smmu_cmdq_build_cmd with arm_smmu_cmdq_build_sync_msi_cmd)
721582
729226
689574
679710
727770

Case 4: (base on case 3, plus patch 2)
734077
742868
738194
682544
740586

Case 2 is better than case 1, I think the main reason is the atomic_inc_return_relaxed(&smmu->sync_nr)
has been removed. Case 3 is better than case 2, because the assembly code is reduced, see below.


> 
> Agreed - sorry if my wording was unclear, but that suggestion was only for the possibility of it proving genuinely worthwhile to build the command outside the lock. Since that isn't the case, I definitely prefer the simpler approach too.

Yes, I mean replace arm_smmu_cmdq_build_cmd with arm_smmu_cmdq_build_sync_msi_cmd to build the command inside the lock.
         spin_lock_irqsave(&smmu->cmdq.lock, flags);
+        ent.sync.msidata = ++smmu->sync_nr;
+        arm_smmu_cmdq_build_sync_msi_cmd(cmd, &ent);
         arm_smmu_cmdq_insert_cmd(smmu, cmd);
         spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

The assembly code showed me that it's very nice.
ffff0000085e6928:       94123207        bl      ffff000008a73144 <_raw_spin_lock_irqsave>
ffff0000085e692c:       b9410ad5        ldr     w21, [x22,#264]
ffff0000085e6930:       d28208c2        mov     x2, #0x1046                     // #4166
ffff0000085e6934:       aa0003fa        mov     x26, x0
ffff0000085e6938:       110006b5        add     w21, w21, #0x1
ffff0000085e693c:       f2a1f802        movk    x2, #0xfc0, lsl #16
ffff0000085e6940:       aa1603e0        mov     x0, x22
ffff0000085e6944:       910163a1        add     x1, x29, #0x58
ffff0000085e6948:       aa158042        orr     x2, x2, x21, lsl #32
ffff0000085e694c:       b9010ad5        str     w21, [x22,#264]
ffff0000085e6950:       f9002fa2        str     x2, [x29,#88]
ffff0000085e6954:       d2994016        mov     x22, #0xca00                    // #51712
ffff0000085e6958:       f90033b3        str     x19, [x29,#96]
ffff0000085e695c:       97fffd5b        bl      ffff0000085e5ec8 <arm_smmu_cmdq_insert_cmd>
ffff0000085e6960:       aa1903e0        mov     x0, x25
ffff0000085e6964:       aa1a03e1        mov     x1, x26
ffff0000085e6968:       f2a77356        movk    x22, #0x3b9a, lsl #16
ffff0000085e696c:       94123145        bl      ffff000008a72e80 <_raw_spin_unlock_irqrestore>


> 
> Robin.
> 
> .
> 

-- 
Thanks!
BestRegards

