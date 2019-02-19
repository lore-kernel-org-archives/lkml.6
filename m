Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA34C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5704921903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfBSH5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:57:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3781 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbfBSH5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:57:08 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C2A23C5DFA5D557064F3;
        Tue, 19 Feb 2019 15:57:05 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 15:56:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/5] iommu/arm-smmu-v3: add macro xxx_SIZE to replace xxx_DWORDS shift
Date:   Tue, 19 Feb 2019 15:54:41 +0800
Message-ID: <20190219075443.17732-4-thunder.leizhen@huawei.com>
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

The (STRTAB_L1_DESC_DWORDS << 3) appears more than 1 times, replace it
with STRTAB_L1_DESC_SIZE to eliminate the duplication. And the latter
seems more clear when it's used to calculate memory size. And the same is
true for STRTAB_STE_DWORDS and CTXDESC_CD_DWORDS.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c3c4ff2..5bb5dcd 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -202,10 +202,12 @@
 #define STRTAB_SPLIT			8

 #define STRTAB_L1_DESC_DWORDS		1
+#define STRTAB_L1_DESC_SIZE		(STRTAB_L1_DESC_DWORDS << 3)
 #define STRTAB_L1_DESC_SPAN		GENMASK_ULL(4, 0)
 #define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 6)

 #define STRTAB_STE_DWORDS		8
+#define STRTAB_STE_SIZE			(STRTAB_STE_DWORDS << 3)
 #define STRTAB_STE_0_V			(1UL << 0)
 #define STRTAB_STE_0_CFG		GENMASK_ULL(3, 1)
 #define STRTAB_STE_0_CFG_ABORT		0
@@ -251,6 +253,7 @@

 /* Context descriptor (stage-1 only) */
 #define CTXDESC_CD_DWORDS		8
+#define CTXDESC_CD_SIZE			(CTXDESC_CD_DWORDS << 3)
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
 #define CTXDESC_CD_0_TCR_TG0		GENMASK_ULL(7, 6)
@@ -1563,7 +1566,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)

 		if (cfg->cdptr) {
 			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
+					   CTXDESC_CD_SIZE,
 					   cfg->cdptr,
 					   cfg->cdptr_dma);

@@ -1590,7 +1593,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;

-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
+	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_SIZE,
 					 &cfg->cdptr_dma,
 					 GFP_KERNEL | __GFP_ZERO);
 	if (!cfg->cdptr) {
@@ -2176,7 +2179,7 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 			arm_smmu_init_dummy_l2_strtab(smmu, i << STRTAB_SPLIT);
 		} else {
 			arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
-			strtab += STRTAB_L1_DESC_DWORDS << 3;
+			strtab += STRTAB_L1_DESC_SIZE;
 		}
 	}

@@ -2201,7 +2204,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 			 "2-level strtab only covers %u/%u bits of SID\n",
 			 size, smmu->sid_bits);

-	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
+	l1size = cfg->num_l1_ents * STRTAB_L1_DESC_SIZE;
 	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
 				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
@@ -2228,7 +2231,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	u32 size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;

-	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
+	size = (1 << smmu->sid_bits) * STRTAB_STE_SIZE;
 	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
 				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
--
1.8.3


