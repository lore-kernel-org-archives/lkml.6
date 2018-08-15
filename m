Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B383C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2E221470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2E221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeHOPSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:18:33 -0400
Received: from foss.arm.com ([217.140.101.70]:54618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbeHOPSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6A37A9;
        Wed, 15 Aug 2018 05:26:34 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A34DA3F5D0;
        Wed, 15 Aug 2018 05:26:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
Date:   Wed, 15 Aug 2018 13:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/18 11:23, Zhen Lei wrote:
> The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
> __arm_smmu_sync_poll_msi requires that sync_idx must be increased
> monotonously according to the sequence of the CMDs in the cmdq.
> 
> But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
> by spinlock, so the following scenarios may appear:
> cpu0			cpu1
> msidata=0
> 			msidata=1
> 			insert cmd1
> insert cmd0
> 			smmu execute cmd1
> smmu execute cmd0
> 			poll timeout, because msidata=1 is overridden by
> 			cmd0, that means VAL=0, sync_idx=1.
> 
> This is not a functional problem, just make the caller wait for a long
> time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
> during the waiting period will break it.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..3f5c236 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -566,7 +566,7 @@ struct arm_smmu_device {
> 
>   	int				gerr_irq;
>   	int				combined_irq;
> -	atomic_t			sync_nr;
> +	u32				sync_nr;
> 
>   	unsigned long			ias; /* IPA */
>   	unsigned long			oas; /* PA */
> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   	return 0;
>   }
> 
> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)

If we *are* going to go down this route then I think it would make sense 
to move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e. 
arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync 
command, then calling this guy would convert it to an MSI-based one. 
As-is, having bits of mutually-dependent data handled across two 
separate places just seems too messy and error-prone.

That said, I still don't think that just building the whole command 
under the lock is really all that bad - even when it doesn't get 
optimised into one of the assignments that memset you call out is only a 
single "stp xzr, xzr, ...", and a couple of extra branches doesn't seem 
a huge deal compared to the DSB and MMIO accesses (and potentially 
polling) that we're about to do anyway. I've tried hacking things up 
enough to convince GCC to inline a specialisation of the relevant switch 
case when ent->opcode is known, and that reduces the "overhead" down to 
just a handful of ALU instructions. I still need to try cleaning said 
hack up and double-check that it doesn't have any adverse impact on all 
the other SMMUv3 stuff in development, but watch this space...

Robin.

> +{
> +	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, msidata);
> +}
> +
>   /* High-level queue accessors */
>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   {
> @@ -836,7 +841,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>   		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
>   		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>   		break;
>   	default:
> @@ -947,7 +951,6 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>   	struct arm_smmu_cmdq_ent ent = {
>   		.opcode = CMDQ_OP_CMD_SYNC,
>   		.sync	= {
> -			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
>   			.msiaddr = virt_to_phys(&smmu->sync_count),
>   		},
>   	};
> @@ -955,6 +958,8 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>   	arm_smmu_cmdq_build_cmd(cmd, &ent);
> 
>   	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> +	ent.sync.msidata = ++smmu->sync_nr;
> +	arm_smmu_cmdq_sync_set_msidata(cmd, ent.sync.msidata);
>   	arm_smmu_cmdq_insert_cmd(smmu, cmd);
>   	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
> @@ -2179,7 +2184,6 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>   {
>   	int ret;
> 
> -	atomic_set(&smmu->sync_nr, 0);
>   	ret = arm_smmu_init_queues(smmu);
>   	if (ret)
>   		return ret;
> --
> 1.8.3
> 
> 
