Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF43C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02DE20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02DE20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbeGXMwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:52:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388476AbeGXMwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:52:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 04571103E3B15;
        Tue, 24 Jul 2018 19:46:35 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.382.0; Tue, 24 Jul 2018 19:46:29 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
CC:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <pabba@codeaurora.org>, <vkilari@codeaurora.org>,
        <rruigrok@codeaurora.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
Subject: [PATCH v2 4/4] perf/smmuv3: Add MSI irq support
Date:   Tue, 24 Jul 2018 12:45:15 +0100
Message-ID: <20180724114515.21764-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for MSI based counter overflow interrupt.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 105 +++++++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 21 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index b3dc394..ca69813 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -94,6 +94,10 @@
 #define SMMU_PMCG_IRQ_CFG2              0xE64
 #define SMMU_PMCG_IRQ_STATUS            0xE68
 
+/* MSI config fields */
+#define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
+#define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
+
 #define SMMU_COUNTER_RELOAD             BIT(31)
 #define SMMU_DEFAULT_FILTER_SEC         0
 #define SMMU_DEFAULT_FILTER_SPAN        1
@@ -657,14 +661,89 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
 	return IRQ_HANDLED;
 }
 
+static void smmu_pmu_free_msis(void *data)
+{
+	struct device *dev = data;
+
+	platform_msi_domain_free_irqs(dev);
+}
+
+static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	phys_addr_t doorbell;
+	struct device *dev = msi_desc_to_dev(desc);
+	struct smmu_pmu *pmu = dev_get_drvdata(dev);
+
+	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
+	doorbell &= MSI_CFG0_ADDR_MASK;
+
+	writeq_relaxed(doorbell, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
+	writel_relaxed(msg->data, pmu->reg_base + SMMU_PMCG_IRQ_CFG1);
+	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
+				pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
+}
+
+static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
+{
+	struct msi_desc *desc;
+	struct device *dev = pmu->dev;
+	int ret;
+
+	/* Clear MSI address reg */
+	writeq_relaxed(0, pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
+
+	/* MSI supported or not */
+	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
+		return;
+
+	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
+	if (ret) {
+		dev_warn(dev, "failed to allocate MSIs\n");
+		return;
+	}
+
+	desc = first_msi_entry(dev);
+	if (desc)
+		pmu->irq = desc->irq;
+
+	/* Add callback to free MSIs on teardown */
+	devm_add_action(dev, smmu_pmu_free_msis, dev);
+}
+
+static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
+{
+	int irq, ret = -ENXIO;
+
+	smmu_pmu_setup_msi(pmu);
+
+	irq = pmu->irq;
+	if (irq)
+		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
+			       IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD,
+			       "smmu-v3-pmu", pmu);
+	return ret;
+}
+
 static int smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
 {
+	int ret;
+
 	/* Disable counter and interrupt */
 	writeq(smmu_pmu->counter_present_mask,
 			smmu_pmu->reg_base + SMMU_PMCG_CNTENCLR0);
 	writeq(smmu_pmu->counter_present_mask,
 		smmu_pmu->reg_base + SMMU_PMCG_INTENCLR0);
 
+	ret = smmu_pmu_setup_irq(smmu_pmu);
+	if (ret) {
+		dev_err(smmu_pmu->dev, "failed to setup irqs\n");
+		return ret;
+	}
+
+	/* Pick one CPU to be the preferred one to use */
+	smmu_pmu->on_cpu = smp_processor_id();
+	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
+
 	smmu_pmu_disable(&smmu_pmu->pmu);
 	return 0;
 }
@@ -738,26 +817,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get valid irq for smmu @%pa\n",
-			&mem_resource_0->start);
-		return irq;
-	}
-
-	err = devm_request_irq(dev, irq, smmu_pmu_handle_irq,
-			       IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD,
-			       "smmu-pmu", smmu_pmu);
-	if (err) {
-		dev_err(dev,
-			"Unable to request IRQ%d for SMMU PMU counters\n", irq);
-		return err;
-	}
-
-	smmu_pmu->irq = irq;
-
-	/* Pick one CPU to be the preferred one to use */
-	smmu_pmu->on_cpu = smp_processor_id();
-	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
+	if (irq > 0)
+		smmu_pmu->irq = irq;
 
 	smmu_pmu->num_counters = get_num_counters(smmu_pmu);
 	smmu_pmu->counter_present_mask = GENMASK(smmu_pmu->num_counters - 1, 0);
@@ -765,7 +826,9 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		    SMMU_PMCG_CFGR_SIZE_MASK) >> SMMU_PMCG_CFGR_SIZE_SHIFT;
 	smmu_pmu->counter_mask = GENMASK_ULL(reg_size, 0);
 
-	smmu_pmu_reset(smmu_pmu);
+	err = smmu_pmu_reset(smmu_pmu);
+	if (err)
+		return err;
 
 	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
 					       &smmu_pmu->node);
-- 
2.7.4


