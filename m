Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642DFFC6173
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D471221712
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D471221712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIMVxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:53:07 -0400
Received: from foss.arm.com ([217.140.101.70]:51156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeIMVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:53:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EF8715BF;
        Thu, 13 Sep 2018 09:42:49 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A47763F703;
        Thu, 13 Sep 2018 09:42:47 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v6 6/7] iommu/arm-smmu: Support non-strict mode
Date:   Thu, 13 Sep 2018 17:42:23 +0100
Message-Id: <95986001c4e7e9a9ffec3d8d1555f8f3c92ed14f.1536856828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1536856828.git.robin.murphy@arm.com>
References: <cover.1536856828.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All we need is to wire up .flush_iotlb_all properly and implement the
domain attribute, and iommu-dma and io-pgtable-arm will do the rest for
us. Rather than bother implementing it for v7s format for the highly
unlikely chance of that being relevant, we can simply hide the
non-strict flag from io-pgtable for that combination just so anyone who
does actually try it will simply get over-invalidation instead of
failure to initialise domains.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 43 +++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fd1b80ef9490..c727080e7acd 100644
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
@@ -863,6 +864,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
 
+	if (smmu_domain->non_strict && cfg->fmt != ARM_SMMU_CTX_FMT_AARCH32_S)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+
 	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
@@ -1252,6 +1256,14 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
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
@@ -1470,13 +1482,17 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
-		return -EINVAL;
-
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
+		if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+			return -EINVAL;
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+		if (domain->type != IOMMU_DOMAIN_DMA)
+			return -EINVAL;
+		*(int *)data = smmu_domain->non_strict;
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -1488,13 +1504,15 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	int ret = 0;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
-		return -EINVAL;
-
 	mutex_lock(&smmu_domain->init_mutex);
 
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
+		if (domain->type != IOMMU_DOMAIN_UNMANAGED) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
 		if (smmu_domain->smmu) {
 			ret = -EPERM;
 			goto out_unlock;
@@ -1506,6 +1524,17 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
 		break;
+	case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+		if (domain->type != IOMMU_DOMAIN_DMA) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		smmu_domain->non_strict = *(int *)data;
+		if (smmu_domain->pgtbl_ops)
+			io_pgtable_set_non_strict(smmu_domain->pgtbl_ops,
+						  smmu_domain->non_strict);
+		break;
 	default:
 		ret = -ENODEV;
 	}
@@ -1562,7 +1591,7 @@ static struct iommu_ops arm_smmu_ops = {
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

