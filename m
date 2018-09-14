Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99155FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A016206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A016206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeINTpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:45:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34248 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINTp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:45:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27DC01650;
        Fri, 14 Sep 2018 07:30:43 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DE173F575;
        Fri, 14 Sep 2018 07:30:41 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v7 5/6] iommu/arm-smmu-v3: Add support for non-strict mode
Date:   Fri, 14 Sep 2018 15:30:23 +0100
Message-Id: <4f9444c7224ea0e6e4cef8ddbf77bb5292a383e3.1536935328.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1536935328.git.robin.murphy@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Dynamically choose strict or non-strict mode for page table config based
on the iommu domain type.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: convert to domain attribute]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f10c852479fc..7bbfa5f7ce8e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -612,6 +612,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
+	bool				non_strict;
 
 	enum arm_smmu_domain_stage	stage;
 	union {
@@ -1633,6 +1634,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
 
+	if (smmu_domain->non_strict)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
@@ -1934,13 +1938,17 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
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
@@ -1952,13 +1960,15 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
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
@@ -1969,6 +1979,14 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 		else
 			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
+		break;
+	case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+		if (domain->type != IOMMU_DOMAIN_DMA) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		smmu_domain->non_strict = *(int *)data;
 		break;
 	default:
 		ret = -ENODEV;
-- 
2.19.0.dirty

