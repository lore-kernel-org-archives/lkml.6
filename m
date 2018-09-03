Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF66EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E4B20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E4B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeICKVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:21:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55737 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbeICKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:21:48 -0400
X-UUID: da524edea40140119a0079cd22734e3c-20180903
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1171274622; Mon, 03 Sep 2018 14:03:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 3 Sep 2018 14:03:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 3 Sep 2018 14:03:03 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>
Subject: [PATCH 04/13] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB mode
Date:   Mon, 3 Sep 2018 14:01:33 +0800
Message-ID: <1535954502-30646-5-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
References: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek extend the arm v7s descriptor to support the dram over 4GB.

In the mt2712 and mt8173, it's called "4GB mode", the physical address
is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
bit32 is always enabled. thus, in the M4U, we always enable the bit9
for all PTEs which means to enable bit32 of physical address.

but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
32bits.

In order to unify code, in the "4GB mode", we add the bit32 for the
physical address manually in our driver.

Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
has to been moved into v7s.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
In mt8183, the PA is from 0x4000_0000 to 0x3_ffff_ffff while the iova
still is 32bits. Acturally, our HW extend the v7s pgtable. currently
the lvl1 pgtable is 16KB, our HW double it. but 32bit iova is enough
for us currently, thus we don't change it.
---
 drivers/iommu/io-pgtable-arm-v7s.c | 38 ++++++++++++++++++++++++++++++--------
 drivers/iommu/io-pgtable.h         |  8 ++++----
 drivers/iommu/mtk_iommu.c          | 15 +++++++++------
 drivers/iommu/mtk_iommu.h          |  1 +
 4 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index b5948ba..47538dd 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -124,7 +124,9 @@
 #define ARM_V7S_TEX_MASK		0x7
 #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
 
-#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
+/* MTK extend the two bits below for over 4GB mode */
+#define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
+#define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
 
 /* *well, except for TEX on level 2 large pages, of course :( */
 #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
@@ -268,7 +270,8 @@ static void __arm_v7s_set_pte(arm_v7s_iopte *ptep, arm_v7s_iopte pte,
 }
 
 static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
-					 struct io_pgtable_cfg *cfg)
+					 struct io_pgtable_cfg *cfg,
+					 phys_addr_t paddr) /* Only for MTK */
 {
 	bool ap = !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS);
 	arm_v7s_iopte pte = ARM_V7S_ATTR_NG | ARM_V7S_ATTR_S;
@@ -295,8 +298,12 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
 		pte |= ARM_V7S_ATTR_NS_SECTION;
 
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
-		pte |= ARM_V7S_ATTR_MTK_4GB;
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
+		if (paddr & BIT_ULL(32))
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
+		if (paddr & BIT_ULL(33))
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
+	}
 
 	return pte;
 }
@@ -392,7 +399,7 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 			return -EEXIST;
 		}
 
-	pte = arm_v7s_prot_to_pte(prot, lvl, cfg);
+	pte = arm_v7s_prot_to_pte(prot, lvl, cfg, paddr);
 	if (num_entries > 1)
 		pte = arm_v7s_pte_to_cont(pte, lvl);
 
@@ -484,7 +491,11 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
-	if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
+	if (WARN_ON(upper_32_bits(iova)))
+		return -ERANGE;
+
+	if (WARN_ON(upper_32_bits(paddr) &&
+		    !(iop->cfg.quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
 		return -ERANGE;
 
 	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
@@ -563,7 +574,7 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 	num_entries = size >> ARM_V7S_LVL_SHIFT(2);
 	unmap_idx = ARM_V7S_LVL_IDX(iova, 2);
 
-	pte = arm_v7s_prot_to_pte(arm_v7s_pte_to_prot(blk_pte, 1), 2, cfg);
+	pte = arm_v7s_prot_to_pte(arm_v7s_pte_to_prot(blk_pte, 1), 2, cfg, 0);
 	if (num_entries > 1)
 		pte = arm_v7s_pte_to_cont(pte, 2);
 
@@ -677,7 +688,9 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
 					unsigned long iova)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_v7s_iopte *ptep = data->pgd, pte;
+	phys_addr_t paddr;
 	int lvl = 0;
 	u32 mask;
 
@@ -693,7 +706,16 @@ static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
 	mask = ARM_V7S_LVL_MASK(lvl);
 	if (arm_v7s_pte_is_cont(pte, lvl))
 		mask *= ARM_V7S_CONT_PAGES;
-	return (pte & mask) | (iova & ~mask);
+	paddr = (pte & mask) | (iova & ~mask);
+
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
+	    cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
+			paddr |= BIT_ULL(32);
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
+			paddr |= BIT_ULL(33);
+	}
+	return paddr;
 }
 
 static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 2df7909..0eeed94 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -62,10 +62,10 @@ struct io_pgtable_cfg {
 	 *	(unmapped) entries but the hardware might do so anyway, perform
 	 *	TLB maintenance when mapping as well as when unmapping.
 	 *
-	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
-	 *	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
-	 *	when the SoC is in "4GB mode" and they can only access the high
-	 *	remap of DRAM (0x1_00000000 to 0x1_ffffffff).
+	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 4 and 9 in all
+	 *	PTEs, for Mediatek IOMMUs which treat it as the 33rd and 32rd
+	 *	address bit when the SoC dram is over 4GB and they can access
+	 *	the physical address from 0x4000_0000 to 0x3_ffff_ffff.
 	 *
 	 * IO_PGTABLE_QUIRK_NO_DMA: Guarantees that the tables will only ever
 	 *	be accessed by a fully cache-coherent IOMMU or CPU (e.g. for a
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c0e2da5..86bf647 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -367,12 +367,17 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
+	    data->plat_data->has_4gb_mode &&
+	    data->enable_4GB)
+		paddr |= BIT_ULL(32);
+
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	ret = dom->iop->map(dom->iop, iova, paddr & DMA_BIT_MASK(32),
-			    size, prot);
+	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	return ret;
@@ -401,7 +406,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -409,9 +413,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	if (data->enable_4GB)
-		pa |= BIT_ULL(32);
-
 	return pa;
 }
 
@@ -735,10 +736,12 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat = M4U_MT2712,
+	.has_4gb_mode = true,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat = M4U_MT8173,
+	.has_4gb_mode = true,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 333a0ef..a243047 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -43,6 +43,7 @@ enum mtk_iommu_plat {
 
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
+	bool has_4gb_mode;
 };
 
 struct mtk_iommu_domain;
-- 
1.9.1

