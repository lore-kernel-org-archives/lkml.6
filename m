Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD91ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D052064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XmnaihAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D052064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeKAItL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:49:11 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2086 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:49:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bda3f510000>; Wed, 31 Oct 2018 16:48:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Oct 2018 16:48:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Oct 2018 16:48:46 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 31 Oct
 2018 23:48:46 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 31 Oct
 2018 23:48:46 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 31 Oct 2018 23:48:46 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bda3f5e0000>; Wed, 31 Oct 2018 16:48:46 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <avanbrunt@nvidia.com>, <nicolinc@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v2 3/5] iommu/tegra194_smmu: Add Tegra194 SMMU driver
Date:   Wed, 31 Oct 2018 16:48:34 -0700
Message-ID: <1541029716-14353-4-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
References: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541029713; bh=m7YcGwLrjYiCqWK2ivwxC74RcYgbsIVv37ppuCCKOco=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XmnaihAJEe5dZGF5kjw0DGeaZsSsbZl0R8RZY1C3rbVNQrOjBdtEFStav/kuihviA
         S3sIDuQjebtzDVXHSG8/VRHthAlodATo56csyATtbXc3wL/j4XpBQ9uEGM6fZAmrJo
         3spCY796STTvWreJtZV6K8P3m94ED+2f/nNnP+NTBDi8ZWOGr/VCD5zx7S394hNc9Q
         9KYvgojzoICz8zDw4nZE64JGt5x6x0YEn9b/4IbfT/KJiKEUEuz40rkFxitx2hi+Hl
         yHJonG6Je9QYIbB589krDoXYCJdGKPShtKcqnrRBedcZ0EM/PvGcasMNS9yX+nQJ42
         /E/legp47BZDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 SMMU driver supports Dual ARM SMMU configuration
supported in Tegra194 SOC.
The IOVA accesses from HW devices are interleaved across two
ARM SMMU devices.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/Kconfig         |  10 +++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/tegra194-smmu.c | 201 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/iommu/tegra194-smmu.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9a2571..c6f1620 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -357,6 +357,16 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_TEGRA
+	bool "Dual ARM SMMU(MMU-500) support on Tegra"
+	depends on ARM64 && MMU && ARCH_TEGRA
+	select IOMMU_API
+	select IOMMU_IO_PGTABLE_LPAE
+	help
+	  Support for implementation of Dual ARM SMMU Instances present
+	  on Tegra194. IOVA accesses from devices are interleaved across
+	  these dual SMMU Instances.
+
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index a158a68..cae3f54 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
+obj-$(CONFIG_ARM_SMMU_TEGRA) += tegra194-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
diff --git a/drivers/iommu/tegra194-smmu.c b/drivers/iommu/tegra194-smmu.c
new file mode 100644
index 0000000..02109c8
--- /dev/null
+++ b/drivers/iommu/tegra194-smmu.c
@@ -0,0 +1,201 @@
+/*
+ * IOMMU API for Tegra194 Dual ARM SMMU implementation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2018 Nvidia Corporation
+ *
+ * Author: Krishna Reddy <vdumpa@nvidia.com>
+ */
+
+#define pr_fmt(fmt) "tegra194-smmu: " fmt
+
+#include "arm-smmu-common.h"
+
+/* Tegra194 has three SMMU instances.
+ * Two of the SMMU instances are used by specific set of devices to
+ * access IOVA addresses in interleaved fashion.
+ * The 3rd SMMU instance is used alone by specific set of devices.
+ * This driver only support Dual SMMU configuration which interleaves
+ * IOVA accesses across two SMMU's.
+ * For the 3rd SMMU instance, Default ARM SMMU driver is used.
+ */
+#define NUM_SMMU_INSTANCES 2
+
+struct tegra194_smmu {
+	void __iomem			*bases[NUM_SMMU_INSTANCES];
+	struct arm_smmu_device		*smmu;
+};
+
+static struct tegra194_smmu t194_smmu;
+
+static inline void writel_one(u32 val, volatile void __iomem *virt_addr)
+{
+	writel(val, virt_addr);
+}
+
+static inline void writel_relaxed_one(u32 val,
+			volatile void __iomem *virt_addr)
+{
+	writel_relaxed(val, virt_addr);
+}
+
+#define WRITEL_FN(fn, call, type) \
+static inline void fn(type val, volatile void __iomem *virt_addr) \
+{ \
+	int i; \
+	u32 offset = abs(virt_addr - t194_smmu.bases[0]); \
+	for (i = 0; i < NUM_SMMU_INSTANCES; i++) \
+		call(val, t194_smmu.bases[i] + offset); \
+}
+
+/* Override writel* macros to program all the smmu instances
+ * transparently through arm-smmu-common.c code.
+ */
+WRITEL_FN(writel_relaxed_all, writel_relaxed, u32);
+WRITEL_FN(writeq_relaxed_all, writeq_relaxed, u64);
+WRITEL_FN(writel_all, writel, u32);
+
+#undef writel_relaxed
+#undef writeq_relaxed
+#undef writel
+#define writel_relaxed writel_relaxed_all
+#define writeq_relaxed writeq_relaxed_all
+#define writel writel_all
+
+#include "arm-smmu-common.c"
+
+#define TO_INSTANCE(addr, inst) \
+	(addr - t194_smmu.bases[0] + t194_smmu.bases[inst])
+
+static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
+{
+	int i;
+	void __iomem *base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu->global_sync_lock, flags);
+	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+		base = t194_smmu.bases[i];
+		__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_GR0_sTLBGSYNC,
+				    base + ARM_SMMU_GR0_sTLBGSTATUS);
+	}
+	spin_unlock_irqrestore(&smmu->global_sync_lock, flags);
+}
+
+static void arm_smmu_tlb_sync_context(void *cookie)
+{
+	int i;
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+		base = ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
+		base = TO_INSTANCE(base, i);
+		__arm_smmu_tlb_sync(smmu, base + ARM_SMMU_CB_TLBSYNC,
+				    base + ARM_SMMU_CB_TLBSTATUS);
+	}
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
+static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
+{
+	int i;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(dev);
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *cb_base;
+	irqreturn_t irq_state;
+
+	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+		cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
+		cb_base = TO_INSTANCE(cb_base, i);
+
+		irq_state = arm_smmu_context_fault_common(smmu, cfg, cb_base);
+
+		if (irq_state == IRQ_HANDLED)
+			break;
+	}
+
+	return irq_state;
+}
+
+static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
+{
+	int i;
+	struct arm_smmu_device *smmu = dev;
+	irqreturn_t irq_state;
+
+	for (i = 0; i < NUM_SMMU_INSTANCES; i++) {
+		void __iomem *gr0_base = t194_smmu.bases[i];
+
+		irq_state = arm_smmu_global_fault_common(smmu, gr0_base);
+
+		if (irq_state == IRQ_HANDLED)
+			break;
+	}
+
+	return irq_state;
+}
+
+ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
+
+static const struct of_device_id t194_smmu_of_match[] = {
+	{ .compatible = "tegra194,arm,mmu-500", .data = &arm_mmu500 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, t194_smmu_of_match);
+
+static int t194_smmu_device_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	int i, err;
+
+	if (t194_smmu.smmu) {
+		pr_err("One instance of Tegra194 SMMU platform device is allowed\n");
+		return -ENODEV;
+	}
+
+	for (i = 1; i < NUM_SMMU_INSTANCES; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			return -ENODEV;
+		t194_smmu.bases[i] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(t194_smmu.bases[i]))
+			return PTR_ERR(t194_smmu.bases[i]);
+	}
+
+	err = arm_smmu_device_probe_common(pdev, &t194_smmu.bases[0]);
+	if (err)
+		return err;
+
+	t194_smmu.smmu = platform_get_drvdata(pdev);
+	return 0;
+}
+
+static struct platform_driver arm_smmu_driver = {
+	.driver	= {
+		.name		= "tegra194-arm-smmu",
+		.of_match_table	= of_match_ptr(t194_smmu_of_match),
+		.pm		= &arm_smmu_pm_ops,
+	},
+	.probe	= t194_smmu_device_probe,
+	.remove	= arm_smmu_device_remove,
+	.shutdown = arm_smmu_device_shutdown,
+};
+module_platform_driver(arm_smmu_driver);
+
+MODULE_DESCRIPTION("IOMMU API for Tegra194 SMMU implementation");
+MODULE_AUTHOR("Krishna Reddy <vdumpa@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

