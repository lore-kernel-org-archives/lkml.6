Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3433C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F2C2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F2C2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeH3PUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:20:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728200AbeH3PUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:20:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC69C3E828722;
        Thu, 30 Aug 2018 19:18:35 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Thu, 30 Aug 2018
 19:18:28 +0800
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: avoid redundant CMD_SYNCs if
 possible
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1534665071-7976-1-git-send-email-thunder.leizhen@huawei.com>
 <1534665071-7976-3-git-send-email-thunder.leizhen@huawei.com>
CC:     LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <992a5e9a-ba0c-e25f-b881-89aa914d3a36@huawei.com>
Date:   Thu, 30 Aug 2018 12:18:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1534665071-7976-3-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2018 08:51, Zhen Lei wrote:
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
>  drivers/iommu/arm-smmu-v3.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index ac6d6df..f3a56e1 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -567,6 +567,7 @@ struct arm_smmu_device {
>  	int				gerr_irq;
>  	int				combined_irq;
>  	u32				sync_nr;
> +	u8				prev_cmd_opcode;
>
>  	unsigned long			ias; /* IPA */
>  	unsigned long			oas; /* PA */
> @@ -786,6 +787,11 @@ void arm_smmu_cmdq_build_sync_msi_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  	cmd[1]  = ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
>  }
>
> +static inline u8 arm_smmu_cmd_opcode_get(u64 *cmd)
> +{
> +	return cmd[0] & CMDQ_0_OP;
> +}
> +
>  /* High-level queue accessors */
>  static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  {
> @@ -906,6 +912,8 @@ static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
>  	struct arm_smmu_queue *q = &smmu->cmdq.q;
>  	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
>
> +	smmu->prev_cmd_opcode = arm_smmu_cmd_opcode_get(cmd);
> +
>  	while (queue_insert_raw(q, cmd) == -ENOSPC) {
>  		if (queue_poll_cons(q, false, wfe))
>  			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> @@ -958,9 +966,17 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>  	};
>
>  	spin_lock_irqsave(&smmu->cmdq.lock, flags);
> -	ent.sync.msidata = ++smmu->sync_nr;
> -	arm_smmu_cmdq_build_sync_msi_cmd(cmd, &ent);
> -	arm_smmu_cmdq_insert_cmd(smmu, cmd);
> +	if (smmu->prev_cmd_opcode == CMDQ_OP_CMD_SYNC) {
> +		/*
> +		 * Previous command is CMD_SYNC also, there is no need to add
> +		 * one more. Just poll it.
> +		 */
> +		ent.sync.msidata = smmu->sync_nr;
> +	} else {
> +		ent.sync.msidata = ++smmu->sync_nr;
> +		arm_smmu_cmdq_build_sync_msi_cmd(cmd, &ent);
> +		arm_smmu_cmdq_insert_cmd(smmu, cmd);
> +	}
>  	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

I find something like this adds support for combining CMD_SYNC commands 
for regular polling mode:

@@ -569,6 +569,7 @@ struct arm_smmu_device {
         int                             combined_irq;
         u32                             sync_nr;
         u8                              prev_cmd_opcode;
+       int                             prev_cmd_sync_res;

         unsigned long                   ias; /* IPA */
         unsigned long                   oas; /* PA */
@@ -985,17 +986,33 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct 
arm_smmu_device *smmu)

  static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
  {
-       u64 cmd[CMDQ_ENT_DWORDS];
+       static u64 cmd[CMDQ_ENT_DWORDS] = {
+               _FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
+               _FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV) |
+               _FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
+               _FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB)
+       };
         unsigned long flags;
         bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
-       struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
-       int ret;
+       int ret = 0;

-       arm_smmu_cmdq_build_cmd(cmd, &ent);

         spin_lock_irqsave(&smmu->cmdq.lock, flags);
-       arm_smmu_cmdq_insert_cmd(smmu, cmd);
-       ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
+       if (smmu->prev_cmd_opcode != CMDQ_OP_CMD_SYNC ||
+               smmu->prev_cmd_sync_res != 0) {
+               arm_smmu_cmdq_insert_cmd(smmu, cmd);
+               smmu->prev_cmd_sync_res = ret =
+                       queue_poll_cons(&smmu->cmdq.q, true, wfe);
+       }

I tested iperf on a 1G network link and was seeing 6-10% CMD_SYNC 
commands combined. I would really need to test this on a faster 
connection to see any throughout difference.

 From the above figures, I think leizhen was seeing 25% combine rate, right?

As for this code, it could be neatened...

Cheers,
John

>
>  	return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
> --
> 1.8.3
>
>
>
> .
>


