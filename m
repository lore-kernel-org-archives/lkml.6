Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C6421903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfBSH5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:57:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfBSH5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:57:08 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C81D06C226B520B95EC4;
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
Subject: [PATCH 5/5] iommu/arm-smmu-v3: workaround for STE abort in kdump kernel
Date:   Tue, 19 Feb 2019 15:54:43 +0800
Message-ID: <20190219075443.17732-6-thunder.leizhen@huawei.com>
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

Some boards may not implement the STE.config=0b000 correctly, it also
reports event C_BAD_STE when a transaction incoming. To make kdump kernel
can be worked well in this situation, backup the strtab_base which is used
in the first kernel, to make the unexpected devices can reuse the old
mapping if we detected the STE.config=0b000 take no effect.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 84adecc..4e95710 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -335,6 +335,9 @@
 #define EVTQ_MAX_SZ_SHIFT		7

 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
+#define EVTQ_0_ID_C_BAD_STE		0x4
+#define EVTQ_0_SSV			GENMASK_ULL(11, 11)
+#define EVTQ_0_SID			GENMASK_ULL(63, 32)

 /* PRI queue */
 #define PRIQ_ENT_DWORDS			2
@@ -525,6 +528,7 @@ struct arm_smmu_strtab_ent {
 struct arm_smmu_strtab_cfg {
 	__le64				*strtab;
 	dma_addr_t			strtab_dma;
+	dma_addr_t			former_strtab_dma;
 	struct arm_smmu_strtab_l1_desc	*l1_desc;
 	unsigned int			num_l1_ents;

@@ -1295,6 +1299,95 @@ static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	return step;
 }

+/*
+ * This function is only called in the kdump kernel, and mainly because of the
+ * smmu hardware feature "ste abort" is not effective.
+ *
+ * The first kernel flushed all cache before start the secondary kernel, so
+ * it's safe base on ioremap() to access the former smmu tables.
+ *
+ * If any error detected, just simply give up the attempt, directly return
+ * without any error reported.
+ */
+static void arm_smmu_ste_abort_quirks(struct arm_smmu_device *smmu, u64 evt0)
+{
+	int i;
+	__le64 *dst, *src;
+	u64 val, paddr;
+	u32 sid = FIELD_GET(EVTQ_0_SID, evt0);
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	/* SubStreamID is not support yet */
+	if (FIELD_GET(EVTQ_0_SSV, evt0))
+		return;
+
+	/*
+	 * If no device within this L2ST range has been added, the L1STD.L2Ptr
+	 * still point to the dummy L2ST, we should allocate one now.
+	 */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		int idx, ret;
+
+		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
+		if (!cfg->l1_desc[idx].l2ptr) {
+			ret = arm_smmu_init_l2_strtab(smmu, sid);
+			if (ret)
+				return;
+		}
+	}
+
+	dst = arm_smmu_get_step_for_sid(smmu, sid);
+	val = le64_to_cpu(dst[0]);
+	if (FIELD_GET(STRTAB_STE_0_CFG, val) != STRTAB_STE_0_CFG_ABORT)
+		return;
+
+	/* The value of SMMU_STRTAB_BASE maybe corrupted, sanity check it */
+	if (cfg->former_strtab_dma & ~(STRTAB_BASE_RA | STRTAB_BASE_ADDR_MASK))
+		return;
+
+	/* Find the STE base address of "sid" */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		u32 span;
+
+		paddr = cfg->former_strtab_dma +
+			(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_SIZE;
+		src = ioremap(paddr, STRTAB_L1_DESC_SIZE);
+		if (!src)
+			return;
+
+		val   = le64_to_cpu(*src);
+		paddr = val & STRTAB_L1_DESC_L2PTR_MASK;
+		span  = val & STRTAB_L1_DESC_SPAN;
+		iounmap(src);
+
+		/* The content of L1STD maybe corrupted, sanity check it */
+		if (val & ~(STRTAB_L1_DESC_L2PTR_MASK | STRTAB_L1_DESC_SPAN))
+			return;
+		paddr += (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_SIZE;
+	} else {
+		paddr = cfg->former_strtab_dma + (sid * STRTAB_STE_SIZE);
+	}
+
+	src = ioremap(paddr, STRTAB_STE_SIZE);
+	if (!src)
+		return;
+
+	/*
+	 * Copy the former STE content, so that the device can base the former
+	 * mapping to access "memory", and does not report any event again.
+	 *
+	 * Please note that, the "memory" is legally allocated in the first
+	 * kernel, so that it will not corrupt the memory of current secondary
+	 * kernel.
+	 */
+	for (i = 1; i < STRTAB_STE_DWORDS; i++)
+		dst[i] = src[i];
+	arm_smmu_sync_ste_for_sid(smmu, sid);
+	dst[0] = src[0];
+	arm_smmu_sync_ste_for_sid(smmu, sid);
+	iounmap(src);
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -1312,6 +1405,8 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 				dev_info(smmu->dev, "\t0x%016llx\n",
 					 (unsigned long long)evt[i]);

+			if ((id == EVTQ_0_ID_C_BAD_STE) && is_kdump_kernel())
+				arm_smmu_ste_abort_quirks(smmu, evt[0]);
 		}

 		/*
@@ -2491,6 +2586,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 {
 	int ret;
 	u32 reg, enables;
+	u64 reg64;
 	struct arm_smmu_cmdq_ent cmd;

 	/* Clear CR0 and sync (disables SMMU and queue processing) */
@@ -2519,6 +2615,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	reg = CR2_PTM | CR2_RECINVSID | CR2_E2H;
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR2);

+	/* save the former strtab base */
+	reg64 = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
+	smmu->strtab_cfg.former_strtab_dma = reg64 & STRTAB_BASE_ADDR_MASK;
+
 	/* Stream table */
 	writeq_relaxed(smmu->strtab_cfg.strtab_base,
 		       smmu->base + ARM_SMMU_STRTAB_BASE);
--
1.8.3


