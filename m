Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DCF2190C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfBSH5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:57:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727438AbfBSH5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:57:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5739DA62C566277D21B;
        Tue, 19 Feb 2019 15:57:05 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:57 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 4/5] iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a little ahead
Date:   Tue, 19 Feb 2019 15:54:42 +0800
Message-ID: <20190219075443.17732-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, just prepare for the next patch.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5bb5dcd..84adecc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1273,6 +1273,28 @@ static int arm_smmu_init_dummy_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return __arm_smmu_init_l2_strtab(smmu, sid, &dummy_desc);
 }

+static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__le64 *step;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		struct arm_smmu_strtab_l1_desc *l1_desc;
+		int idx;
+
+		/* Two-level walk */
+		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
+		l1_desc = &cfg->l1_desc[idx];
+		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
+		step = &l1_desc->l2ptr[idx];
+	} else {
+		/* Simple linear lookup */
+		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
+	}
+
+	return step;
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -1704,28 +1726,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	return 0;
 }

-static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
-{
-	__le64 *step;
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		struct arm_smmu_strtab_l1_desc *l1_desc;
-		int idx;
-
-		/* Two-level walk */
-		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
-		l1_desc = &cfg->l1_desc[idx];
-		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
-		step = &l1_desc->l2ptr[idx];
-	} else {
-		/* Simple linear lookup */
-		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
-	}
-
-	return step;
-}
-
 static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 {
 	int i, j;
--
1.8.3


