Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 93294C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3616E208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nqHFwjAm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O5auVtmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3616E208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965675AbeFOKxn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:53:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965590AbeFOKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:53:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38B75607A4; Fri, 15 Jun 2018 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529060021;
        bh=JqYt1Vh8U08DABINgiaA0TRoidDbUHPVT206s/IdVSU=;
        h=From:To:Cc:Subject:Date:From;
        b=nqHFwjAmYP7FAn2ocEW2Je+1DQ43uTujDJ4Hr0RDzXrrkS1km61eJXZSQhXtxjkSc
         3KlEIhwceFIo7UOcMBIl5Nu/4qE2ucaL6udW5adrudcWjUCJS10EE/A2s3Mbm8Hqdm
         nPK4a/03Re43cnOAIbbi2RKTrLKgIQS9y83a5+ng=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D5B760540;
        Fri, 15 Jun 2018 10:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529060020;
        bh=JqYt1Vh8U08DABINgiaA0TRoidDbUHPVT206s/IdVSU=;
        h=From:To:Cc:Subject:Date:From;
        b=O5auVtmZsEbt+oMVYrD5idc8s1hMfGUm+SVv3+2yS4JlsSkSLq8B5Dmp99clamhem
         MJYHitf/y8pYxrBaTJocu7+XKtdlNKS+X7N+Orrkt2f2YL5vhsgRf8RPmTtlae42bu
         eiCESNNRt2a2BbNP2tIXgD1QcnA1MONHdxROvzBE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D5B760540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, pdaly@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date:   Fri, 15 Jun 2018 16:23:29 +0530
Message-Id: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SoCs have an additional level of cache called as
System cache or Last level cache[1]. This cache sits right
before the DDR, and is tightly coupled with the memory
controller.
The cache is available to all the clients present in the
SoC system. The clients request their slices from this system
cache, make it active, and can then start using it. For these
clients with smmu, to start using the system cache for
dma buffers and related page tables [2], few of the memory
attributes need to be set accordingly.
This change makes the related memory Outer-Shareable, and
updates the MAIR with necessary protection.

The MAIR attribute requirements are:
    Inner Cacheablity = 0
    Outer Cacheablity = 1, Write-Back Write Allocate
    Outer Shareablity = 1

This change is a realisation of following changes
from downstream msm-4.9:
iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT
iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT

[1] https://patchwork.kernel.org/patch/10422531/
[2] https://patchwork.kernel.org/patch/10302791/

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c       | 14 ++++++++++++++
 drivers/iommu/io-pgtable-arm.c | 24 +++++++++++++++++++-----
 drivers/iommu/io-pgtable.h     |  4 ++++
 include/linux/iommu.h          |  4 ++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f7a96bcf94a6..8058e7205034 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -249,6 +249,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
+	bool				has_sys_cache;
 };
 
 struct arm_smmu_option_prop {
@@ -862,6 +863,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
+	if (smmu_domain->has_sys_cache)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
 
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
@@ -1477,6 +1480,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_USE_SYS_CACHE:
+		*((int *)data) = smmu_domain->has_sys_cache;
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -1506,6 +1512,14 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
 		break;
+	case DOMAIN_ATTR_USE_SYS_CACHE:
+		if (smmu_domain->smmu) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+		if (*((int *)data))
+			smmu_domain->has_sys_cache = true;
+		break;
 	default:
 		ret = -ENODEV;
 	}
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 010a254305dd..b2aee1828524 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -169,9 +169,11 @@
 #define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
 #define ARM_LPAE_MAIR_ATTR_NC		0x44
 #define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
+#define ARM_LPAE_MAIR_ATTR_SYS_CACHE	0xf4
 #define ARM_LPAE_MAIR_ATTR_IDX_NC	0
 #define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
+#define ARM_LPAE_MAIR_ATTR_IDX_SYS_CACHE	3
 
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
@@ -442,6 +444,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_SYS_CACHE)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_SYS_CACHE
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+
 	} else {
 		pte = ARM_LPAE_PTE_HAP_FAULT;
 		if (prot & IOMMU_READ)
@@ -771,7 +777,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	u64 reg;
 	struct arm_lpae_io_pgtable *data;
 
-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA))
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
+			    IO_PGTABLE_QUIRK_SYS_CACHE))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -779,9 +786,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/* TCR */
-	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
-	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
+	if (cfg->quirks & IO_PGTABLE_QUIRK_SYS_CACHE) {
+		reg = (ARM_LPAE_TCR_SH_OS << ARM_LPAE_TCR_SH0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT);
+	} else {
+		reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
+		      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT);
+	}
+	reg |= (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
 
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
@@ -833,7 +845,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	      (ARM_LPAE_MAIR_ATTR_WBRWA
 	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
 	      (ARM_LPAE_MAIR_ATTR_DEVICE
-	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
+	      (ARM_LPAE_MAIR_ATTR_SYS_CACHE
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_SYS_CACHE));
 
 	cfg->arm_lpae_s1_cfg.mair[0] = reg;
 	cfg->arm_lpae_s1_cfg.mair[1] = 0;
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 2df79093cad9..b5a398380e9f 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -71,12 +71,16 @@ struct io_pgtable_cfg {
 	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
 	 *	software-emulated IOMMU), such that pagetable updates need not
 	 *	be treated as explicit DMA data.
+	 *
+	 * IO_PGTABLE_QUIRK_SYS_CACHE: Override the attributes set in TCR for
+	 *	the page table walker when using system cache.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
 	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
 	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
 	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
+	#define IO_PGTABLE_QUIRK_SYS_CACHE	BIT(5)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..dacb9648e9b3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,9 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
+/* Use last level cache available with few architectures */
+#define IOMMU_SYS_CACHE	(1 << 6)
+
 
 struct iommu_ops;
 struct iommu_group;
@@ -124,6 +127,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	DOMAIN_ATTR_USE_SYS_CACHE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

