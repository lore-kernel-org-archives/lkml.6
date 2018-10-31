Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E20DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2953B20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JLkNyNNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2953B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeKAItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:49:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2075 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKAItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:49:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bda3f4b0000>; Wed, 31 Oct 2018 16:48:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Oct 2018 16:48:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Oct 2018 16:48:40 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 31 Oct
 2018 23:48:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 31 Oct 2018 23:48:40 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bda3f580000>; Wed, 31 Oct 2018 16:48:40 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <nicolinc@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v2 2/5] iommu/arm-smmu: Prepare fault, probe, sync functions for sharing code
Date:   Wed, 31 Oct 2018 16:48:33 -0700
Message-ID: <1541029716-14353-3-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
References: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541029707; bh=aEAtOrre8PYbKDtJNGI10pa15gCE5D3rp4SrswducyM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JLkNyNNz/yLZnxBe3yNcVDgjtSjdy8eWbLB3bsIS/lZ24NXB2XsfRbDlp5433lWxJ
         OlyrQLMaLf0lh14rEZ+LrYCIMg63+08fna+q7EdAF+shbggGKas9x62YFbH0wfTkV6
         alnjuHuo44OUeH5gM977Xxq5zaxnMWoZwNKWfI8c2S4MGE3FxtgtbVQIj/DcatpiRU
         2qgUohH+rlO/vn2uMXcrydPIWKWD2Rd4nxnLw4k45Wma6iCmxNZr6KosorZEkz7EVL
         31wUSFohn82ndYeCHqnf7u3FcJYtkQ9eoJ++68f50rQ9GW0Ctpwx+wPxWY18uRIiAs
         mE+/4Ok+ewqBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare fault handling, probe and tlb sync functions to allow sharing
code between ARM SMMU driver and Tegra194 SMMU driver.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu-common.c | 53 +++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.c        | 42 +++++++-------------------------
 2 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/arm-smmu-common.c b/drivers/iommu/arm-smmu-common.c
index 1ad8e5f..0166319 100644
--- a/drivers/iommu/arm-smmu-common.c
+++ b/drivers/iommu/arm-smmu-common.c
@@ -166,7 +166,7 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
 {
 	unsigned int spin_cnt, delay;
 
-	writel_relaxed(0, sync);
+	writel_relaxed_one(0, sync);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
 			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
@@ -287,6 +287,52 @@ static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb_sync	= arm_smmu_tlb_sync_vmid,
 };
 
+static irqreturn_t arm_smmu_context_fault_common(struct arm_smmu_device *smmu,
+	struct arm_smmu_cfg *cfg, void __iomem *cb_base)
+{
+	u32 fsr, fsynr;
+	unsigned long iova;
+
+	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
+	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
+
+	if (!(fsr & FSR_FAULT))
+		return IRQ_NONE;
+
+	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
+	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+
+	dev_err_ratelimited(smmu->dev,
+	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
+			    fsr, iova, fsynr, cfg->cbndx);
+
+	writel_one(fsr, cb_base + ARM_SMMU_CB_FSR);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t arm_smmu_global_fault_common(
+	struct arm_smmu_device *smmu, void __iomem *gr0_base)
+{
+	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
+
+	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
+	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
+	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
+	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
+
+	if (!gfsr)
+		return IRQ_NONE;
+
+	dev_err_ratelimited(smmu->dev,
+		"Unexpected global fault, this could be serious\n");
+	dev_err_ratelimited(smmu->dev,
+		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
+		gfsr, gfsynr0, gfsynr1, gfsynr2);
+
+	writel_one(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
+	return IRQ_HANDLED;
+}
+
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
@@ -1757,7 +1803,8 @@ static void arm_smmu_bus_init(void)
 #endif
 }
 
-static int arm_smmu_device_probe(struct platform_device *pdev)
+static int arm_smmu_device_probe_common(struct platform_device *pdev,
+					  void __iomem **pbase)
 {
 	struct resource *res;
 	resource_size_t ioaddr;
@@ -1786,6 +1833,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 	smmu->cb_base = smmu->base + resource_size(res) / 2;
+	if (pbase)
+		*pbase = smmu->base;
 
 	num_irqs = 0;
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a341c9f..d076b3b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -31,6 +31,8 @@
 
 #include "arm-smmu-common.h"
 
+#define writel_one writel
+#define writel_relaxed_one writel_relaxed
 #include "arm-smmu-common.c"
 
 static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
@@ -59,8 +61,6 @@ static void arm_smmu_tlb_sync_context(void *cookie)
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
-	u32 fsr, fsynr;
-	unsigned long iova;
 	struct iommu_domain *domain = dev;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
@@ -68,44 +68,15 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	void __iomem *cb_base;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
-	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
-
-	if (!(fsr & FSR_FAULT))
-		return IRQ_NONE;
-
-	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
-	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
-
-	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cfg->cbndx);
-
-	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
-	return IRQ_HANDLED;
+	return arm_smmu_context_fault_common(smmu, cfg, cb_base);
 }
 
 static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 {
-	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
 	struct arm_smmu_device *smmu = dev;
 	void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);
 
-	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
-	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
-	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
-	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
-
-	if (!gfsr)
-		return IRQ_NONE;
-
-	dev_err_ratelimited(smmu->dev,
-		"Unexpected global fault, this could be serious\n");
-	dev_err_ratelimited(smmu->dev,
-		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
-		gfsr, gfsynr0, gfsynr1, gfsynr2);
-
-	writel(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
-	return IRQ_HANDLED;
+	return arm_smmu_global_fault_common(smmu, gr0_base);
 }
 
 ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
@@ -125,6 +96,11 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	return arm_smmu_device_probe_common(pdev, NULL);
+}
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu",
-- 
2.1.4

