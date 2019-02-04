Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6DF214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfBDMQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:16:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfBDMQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:16:40 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48E5E7EEFEC3B13033DA;
        Mon,  4 Feb 2019 20:16:38 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Mon, 4 Feb 2019 20:16:30 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
CC:     <andrew.murray@arm.com>, <jean-philippe.brucker@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <pabba@codeaurora.org>, <vkilari@codeaurora.org>,
        <rruigrok@codeaurora.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
Subject: [PATCH v6 3/4] perf/smmuv3: Add MSI irq support
Date:   Mon, 4 Feb 2019 12:13:23 +0000
Message-ID: <20190204121324.11460-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for MSI-based counter overflow interrupt.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 0371c01..eeb9dee 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -67,6 +67,7 @@
 #define SMMU_PMCG_OVSSET0               0xCC0
 #define SMMU_PMCG_CFGR                  0xE00
 #define SMMU_PMCG_CFGR_SID_FILTER_TYPE  BIT(23)
+#define SMMU_PMCG_CFGR_MSI              BIT(21)
 #define SMMU_PMCG_CFGR_RELOC_CTRS       BIT(20)
 #define SMMU_PMCG_CFGR_SIZE             GENMASK(13, 8)
 #define SMMU_PMCG_CFGR_NCTR             GENMASK(5, 0)
@@ -77,6 +78,12 @@
 #define SMMU_PMCG_IRQ_CTRL              0xE50
 #define SMMU_PMCG_IRQ_CTRL_IRQEN        BIT(0)
 #define SMMU_PMCG_IRQ_CFG0              0xE58
+#define SMMU_PMCG_IRQ_CFG1              0xE60
+#define SMMU_PMCG_IRQ_CFG2              0xE64
+
+/* MSI config fields */
+#define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
+#define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
 
 #define SMMU_PMCG_DEFAULT_FILTER_SPAN   1
 #define SMMU_PMCG_DEFAULT_FILTER_SID    GENMASK(31, 0)
@@ -589,11 +596,62 @@ static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
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
+		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
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
 static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
 {
 	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
 	int irq, ret = -ENXIO;
 
+	smmu_pmu_setup_msi(pmu);
+
 	irq = pmu->irq;
 	if (irq)
 		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
-- 
2.7.4


