Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C6DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FC021723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FC021723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeHHMbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:31:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbeHHMbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:31:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 031AF18A;
        Wed,  8 Aug 2018 03:12:12 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF83B3F2EA;
        Wed,  8 Aug 2018 03:12:11 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0D62F1AE180A; Wed,  8 Aug 2018 11:12:16 +0100 (BST)
Date:   Wed, 8 Aug 2018 11:12:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Message-ID: <20180808101215.GB28557@arm.com>
References: <1533558689-3000-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533558689-3000-1-git-send-email-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thunder,

On Mon, Aug 06, 2018 at 08:31:29PM +0800, Zhen Lei wrote:
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

Oh yuck, you're right! We probably want a CC stable on this. Did you see
this go wrong in practice?

One comment on your patch...

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..4810f61 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -566,7 +566,7 @@ struct arm_smmu_device {
> 
>  	int				gerr_irq;
>  	int				combined_irq;
> -	atomic_t			sync_nr;
> +	u32				sync_nr;
> 
>  	unsigned long			ias; /* IPA */
>  	unsigned long			oas; /* PA */
> @@ -836,7 +836,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>  		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
>  		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> -		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
>  		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>  		break;
>  	default:
> @@ -947,7 +946,6 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>  	struct arm_smmu_cmdq_ent ent = {
>  		.opcode = CMDQ_OP_CMD_SYNC,
>  		.sync	= {
> -			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
>  			.msiaddr = virt_to_phys(&smmu->sync_count),
>  		},
>  	};
> @@ -955,6 +953,8 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>  	arm_smmu_cmdq_build_cmd(cmd, &ent);
> 
>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> +	ent.sync.msidata = ++smmu->sync_nr;
> +	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent.sync.msidata);

I really don't like splitting this out from building the rest of the
command. Can you just move the call to arm_smmu_cmdq_build_cmd into the
critical section, please?

Thanks,

Will
