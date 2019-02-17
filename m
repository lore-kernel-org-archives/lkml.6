Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1682AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25C621900
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfBQJJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:09:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41745 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727866AbfBQJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:09:34 -0500
X-UUID: b797d83fc235450d944ad4fbfaf9790a-20190217
X-UUID: b797d83fc235450d944ad4fbfaf9790a-20190217
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 441582375; Sun, 17 Feb 2019 17:09:29 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 17:09:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 17:09:26 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 20/22] iommu/mediatek: Rename enable_4GB to dram_is_4gb
Date:   Sun, 17 Feb 2019 17:04:58 +0800
Message-ID: <1550394300-17420-21-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5B0FB1D48A92A447B225EC4968B7729CBEFB9D291F130389DD051641658FA1BE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only rename the variable name from enable_4GB to
dram_is_4gb for readable.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 10 +++++-----
 drivers/iommu/mtk_iommu.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8742841..0277396 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -382,7 +382,7 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	int ret;
 
 	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
-	if (data->plat_data->has_4gb_mode && data->enable_4GB)
+	if (data->plat_data->has_4gb_mode && data->dram_is_4gb)
 		paddr |= BIT_ULL(32);
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
@@ -554,13 +554,13 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
 	if (data->plat_data->m4u_plat == M4U_MT8173)
-		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
+		regval = (data->protect_base >> 1) | (data->dram_is_4gb << 31);
 	else
 		regval = lower_32_bits(data->protect_base) |
 			 upper_32_bits(data->protect_base);
 	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
 
-	if (data->enable_4GB && data->plat_data->has_vld_pa_rng) {
+	if (data->dram_is_4gb && data->plat_data->has_vld_pa_rng) {
 		/*
 		 * If 4GB mode is enabled, the validate PA range is from
 		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
@@ -611,8 +611,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
-	/* Whether the current dram is over 4GB */
-	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
+	/* Whether the current dram is 4GB. */
+	data->dram_is_4gb = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->base = devm_ioremap_resource(dev, res);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index dedf05c..90e98a6 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -66,7 +66,7 @@ struct mtk_iommu_data {
 	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group;
 	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
-	bool                            enable_4GB;
+	bool                            dram_is_4gb;
 	bool				tlb_flush_active;
 
 	struct iommu_device		iommu;
-- 
1.9.1

