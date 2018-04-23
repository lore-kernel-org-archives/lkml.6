Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755135AbeDWL5A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:57:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755015AbeDWL4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:56:38 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <liubo95@huawei.com>, <dingtianhong@huawei.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [RFC 2/2] iommu/arm-smmu-v3: Support software retention for pm_resume
Date: Mon, 23 Apr 2018 19:45:59 +0800
Message-ID: <1524483959-54940-3-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
References: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When system suspend, hisilicon's smmu will do power gating for smmu,
this time smmu's reg will be set to default value for not having
hardware retention, which means need software do the retention instead.

The patch is to use arm_smmu_device_reset() to restore the register of
smmu. However, it need to save the msis setting at probe if smmu do not
support hardware retention.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 69 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 044df6e..6cb56d8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -534,6 +534,11 @@ struct arm_smmu_strtab_cfg {
 	u32				strtab_base_cfg;
 };
 
+struct arm_smmu_msi_val {
+	u64				doorbell;
+	u32				data;
+};
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
@@ -558,6 +563,7 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
+#define ARM_SMMU_OPT_SW_RETENTION	(1 << 2)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -587,6 +593,8 @@ struct arm_smmu_device {
 
 	u32				sync_count;
 
+	struct arm_smmu_msi_val		*msi;
+	bool				probed;
 	bool				bypass;
 
 	/* IOMMU core code handle */
@@ -630,6 +638,7 @@ struct arm_smmu_option_prop {
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
+	{ ARM_SMMU_OPT_SW_RETENTION, "hisilicon,broken-hardware-retention" },
 	{ 0, NULL},
 };
 
@@ -2228,7 +2237,8 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	phys_addr_t doorbell;
 	struct device *dev = msi_desc_to_dev(desc);
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
-	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->platform.msi_index];
+	int msi_index = desc->platform.msi_index;
+	phys_addr_t *cfg = arm_smmu_msi_cfg[msi_index];
 
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
@@ -2236,6 +2246,28 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writeq_relaxed(doorbell, smmu->base + cfg[0]);
 	writel_relaxed(msg->data, smmu->base + cfg[1]);
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
+
+	if (smmu->options & ARM_SMMU_OPT_SW_RETENTION) {
+		smmu->msi[msi_index].doorbell = doorbell;
+		smmu->msi[msi_index].data = msg->data;
+	}
+}
+
+static void arm_smmu_restore_msis(struct arm_smmu_device *smmu)
+{
+	int nevc = ARM_SMMU_MAX_MSIS - 1;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
+		nevc--;
+
+	for (; nevc >= 0; nevc--) {
+		phys_addr_t *cfg = arm_smmu_msi_cfg[nevc];
+		struct arm_smmu_msi_val msi_val = smmu->msi[nevc];
+
+		writeq_relaxed(msi_val.doorbell, smmu->base + cfg[0]);
+		writel_relaxed(msi_val.data, smmu->base + cfg[1]);
+		writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
+	}
 }
 
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
@@ -2261,6 +2293,16 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 		return;
 	}
 
+	if (smmu->probed) {
+		BUG_ON(!(smmu->options & ARM_SMMU_OPT_SW_RETENTION));
+		arm_smmu_restore_msis(smmu);
+		return;
+	} else if (smmu->options & ARM_SMMU_OPT_SW_RETENTION) {
+		smmu->msi = devm_kmalloc_array(dev, nvec,
+					       sizeof(*(smmu->msi)),
+					       GFP_KERNEL);
+	}
+
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
 	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
@@ -2294,6 +2336,9 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 
 	arm_smmu_setup_msis(smmu);
 
+	if (smmu->probed)
+		return;
+
 	/* Request interrupt lines */
 	irq = smmu->evtq.q.irq;
 	if (irq) {
@@ -2348,7 +2393,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	}
 
 	irq = smmu->combined_irq;
-	if (irq) {
+	if (irq && !smmu->probed) {
 		/*
 		 * Cavium ThunderX2 implementation doesn't not support unique
 		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
@@ -2360,7 +2405,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 					"arm-smmu-v3-combined-irq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable combined irq\n");
-	} else
+	} else if (!irq)
 		arm_smmu_setup_unique_irqs(smmu);
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
@@ -2882,6 +2927,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 	}
+
+	smmu->probed = true;
+
 	return 0;
 }
 
@@ -2899,6 +2947,20 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_remove(pdev);
 }
 
+static int arm_smmu_pm_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	if (smmu->options & ARM_SMMU_OPT_SW_RETENTION)
+		return arm_smmu_device_reset(smmu);
+
+	return 0;
+}
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
@@ -2909,6 +2971,7 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	.driver	= {
 		.name		= "arm-smmu-v3",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.pm		= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
1.7.12.4
