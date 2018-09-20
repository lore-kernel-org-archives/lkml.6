Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9069ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D092087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D092087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbeITVzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:55:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731009AbeITVy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A25C01688;
        Thu, 20 Sep 2018 09:10:48 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D88873F557;
        Thu, 20 Sep 2018 09:10:46 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v8 7/7] iommu/arm-smmu: Support non-strict mode
Date:   Thu, 20 Sep 2018 17:10:27 +0100
Message-Id: <c52126546bc7e5f9c01d07fd70675776877d020d.1537458163.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All we need is to wire up .flush_iotlb_all properly and implement the
domain attribute, and iommu-dma and io-pgtable will do the rest for us.
The only real subtlety is documenting the barrier semantics we're
introducing between io-pgtable and the drivers for non-strict flushes.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8:
 - Use nested switches for attrs
 - Fix barriers

 drivers/iommu/arm-smmu.c | 93 ++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fd1b80ef9490..79ece565d96d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -246,6 +246,7 @@ struct arm_smmu_domain {
 	const struct iommu_gather_ops	*tlb_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
+	bool				non_strict;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
@@ -447,7 +448,11 @@ static void arm_smmu_tlb_inv_context_s1(void *cookie)
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	void __iomem *base = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
 
-	writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
+	/*
+	 * NOTE: this is not a relaxed write; it needs to guarantee that PTEs
+	 * cleared by the current CPU are visible to the SMMU before the TLBI.
+	 */
+	writel(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
 	arm_smmu_tlb_sync_context(cookie);
 }
 
@@ -457,7 +462,8 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *base = ARM_SMMU_GR0(smmu);
 
-	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
+	/* NOTE: see above */
+	writel(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 	arm_smmu_tlb_sync_global(smmu);
 }
 
@@ -863,6 +869,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
 
+	if (smmu_domain->non_strict)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
@@ -1252,6 +1261,14 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ops->unmap(ops, iova, size);
 }
 
+static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->tlb_ops)
+		smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
+}
+
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -1470,15 +1487,27 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
-		return -EINVAL;
-
-	switch (attr) {
-	case DOMAIN_ATTR_NESTING:
-		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
-		return 0;
+	switch(domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		switch (attr) {
+		case DOMAIN_ATTR_NESTING:
+			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
+			return 0;
+		default:
+			return -ENODEV;
+		}
+		break;
+	case IOMMU_DOMAIN_DMA:
+		switch (attr) {
+		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+			*(int *)data = smmu_domain->non_strict;
+			return 0;
+		default:
+			return -ENODEV;
+		}
+		break;
 	default:
-		return -ENODEV;
+		return -EINVAL;
 	}
 }
 
@@ -1488,28 +1517,38 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
-		return -EINVAL;
-
 	mutex_lock(&smmu_domain->init_mutex);
 
-	switch (attr) {
-	case DOMAIN_ATTR_NESTING:
-		if (smmu_domain->smmu) {
-			ret = -EPERM;
-			goto out_unlock;
+	switch(domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		switch (attr) {
+		case DOMAIN_ATTR_NESTING:
+			if (smmu_domain->smmu) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+
+			if (*(int *)data)
+				smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
+			else
+				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
+			break;
+		default:
+			ret = -ENODEV;
+		}
+		break;
+	case IOMMU_DOMAIN_DMA:
+		switch (attr) {
+		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+			smmu_domain->non_strict = *(int *)data;
+			break;
+		default:
+			ret = -ENODEV;
 		}
-
-		if (*(int *)data)
-			smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-		else
-			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
-
 		break;
 	default:
-		ret = -ENODEV;
+		ret = -EINVAL;
 	}
-
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
@@ -1562,7 +1601,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
-	.flush_iotlb_all	= arm_smmu_iotlb_sync,
+	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
-- 
2.19.0.dirty

