Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A885C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A68216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A68216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbeHIO1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:27:23 -0400
Received: from foss.arm.com ([217.140.101.70]:52914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeHIO1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:27:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD4080D;
        Thu,  9 Aug 2018 05:02:49 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E90973F5D4;
        Thu,  9 Aug 2018 05:02:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: avoid redundant CMD_SYNCs if
 possible
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <1533815333-17320-1-git-send-email-thunder.leizhen@huawei.com>
 <1533815333-17320-3-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <647c4478-d8b9-4af6-65ed-0023e81408e3@arm.com>
Date:   Thu, 9 Aug 2018 13:02:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533815333-17320-3-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/18 12:48, Zhen Lei wrote:
> More than two CMD_SYNCs maybe adjacent in the command queue, and the first
> one has done what others want to do. Drop the redundant CMD_SYNCs can
> improve IO performance especially under the pressure scene.
> 
> I did the statistics in my test environment, the number of CMD_SYNCs can
> be reduced about 1/3. See below:
> CMD_SYNCs reduced:	19542181
> CMD_SYNCs total:	58098548	(include reduced)
> CMDs total:		116197099	(TLBI:SYNC about 1:1)
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d17a9a7..b96d2d2 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -567,6 +567,7 @@ struct arm_smmu_device {
>   	int				gerr_irq;
>   	int				combined_irq;
>   	u32				sync_nr;
> +	u8				prev_cmd_opcode;
> 
>   	unsigned long			ias; /* IPA */
>   	unsigned long			oas; /* PA */
> @@ -775,6 +776,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>   	return 0;
>   }
> 
> +static inline u8 arm_smmu_cmd_opcode_get(u64 *cmd)
> +{
> +	return cmd[0] & CMDQ_0_OP;
> +}
> +
>   /* High-level queue accessors */
>   static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   {
> @@ -900,6 +906,8 @@ static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
>   	struct arm_smmu_queue *q = &smmu->cmdq.q;
>   	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
> 
> +	smmu->prev_cmd_opcode = arm_smmu_cmd_opcode_get(cmd);
> +
>   	while (queue_insert_raw(q, cmd) == -ENOSPC) {
>   		if (queue_poll_cons(q, false, wfe))
>   			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> @@ -952,9 +960,17 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>   	};
> 
>   	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> -	ent.sync.msidata = ++smmu->sync_nr;
> -	arm_smmu_cmdq_build_cmd(cmd, &ent);
> -	arm_smmu_cmdq_insert_cmd(smmu, cmd);
> +	if (smmu->prev_cmd_opcode == CMDQ_OP_CMD_SYNC) {
> +		/*
> +		 * Previous command is CMD_SYNC also, there is no need to add
> +		 * one more. Just poll it.
> +		 */
> +		ent.sync.msidata = smmu->sync_nr;

Aha! at the time I had pondered how to make multiple callers wait on a 
previous sync instead of issuing another back-to-back, but it seemed 
complicated precisely *because* of the counter being updated outside the 
lock. If only I'd realised... :)

Now I just need to figure out if we can do the same for the polling case.

Robin.

> +	} else {
> +		ent.sync.msidata = ++smmu->sync_nr;
> +		arm_smmu_cmdq_build_cmd(cmd, &ent);
> +		arm_smmu_cmdq_insert_cmd(smmu, cmd);
> +	}
>   	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
> 
>   	return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
> --
> 1.8.3
> 
> 
