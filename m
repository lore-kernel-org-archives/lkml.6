Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1593C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8178A21945
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8178A21945
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeHFOk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:40:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeHFOk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:40:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60C0F5ADB2FA1;
        Mon,  6 Aug 2018 20:32:00 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 20:31:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>
Subject: [PATCH 1/1] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Date:   Mon, 6 Aug 2018 20:31:29 +0800
Message-ID: <1533558689-3000-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
__arm_smmu_sync_poll_msi requires that sync_idx must be increased
monotonously according to the sequence of the CMDs in the cmdq.

But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
by spinlock, so the following scenarios may appear:
cpu0			cpu1
msidata=0
			msidata=1
			insert cmd1
insert cmd0
			smmu execute cmd1
smmu execute cmd0
			poll timeout, because msidata=1 is overridden by
			cmd0, that means VAL=0, sync_idx=1.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d64710..4810f61 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -566,7 +566,7 @@ struct arm_smmu_device {

 	int				gerr_irq;
 	int				combined_irq;
-	atomic_t			sync_nr;
+	u32				sync_nr;

 	unsigned long			ias; /* IPA */
 	unsigned long			oas; /* PA */
@@ -836,7 +836,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
 		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		break;
 	default:
@@ -947,7 +946,6 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
 	struct arm_smmu_cmdq_ent ent = {
 		.opcode = CMDQ_OP_CMD_SYNC,
 		.sync	= {
-			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
 			.msiaddr = virt_to_phys(&smmu->sync_count),
 		},
 	};
@@ -955,6 +953,8 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
 	arm_smmu_cmdq_build_cmd(cmd, &ent);

 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
+	ent.sync.msidata = ++smmu->sync_nr;
+	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent.sync.msidata);
 	arm_smmu_cmdq_insert_cmd(smmu, cmd);
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

@@ -2179,7 +2179,6 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;

-	atomic_set(&smmu->sync_nr, 0);
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
--
1.8.3


