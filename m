Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1873EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4A2208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4A2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeIXPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:03:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6894 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727462AbeIXPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:03:01 -0400
X-UUID: ee1072fd1fd841a7b682062dd070b519-20180924
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 424435262; Mon, 24 Sep 2018 17:01:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 24 Sep 2018 17:01:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 24 Sep 2018 17:01:50 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>
Subject: [PATCH v2 10/14] memory: mtk-smi: Add bus_sel for mt8183
Date:   Mon, 24 Sep 2018 16:58:50 +0800
Message-ID: <1537779534-23575-11-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
References: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 940A08610043E10A40FE91379BAE81DBCCFBD08E384E70246AEB92C3B88DD1A92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
mmu0 or mmu1 to balance the bandwidth via the smi-common register
SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).

In mt8183, For better performance, we switch larb1/2/3/7 to enter
mmu1 while the others still keep enter mmu0.

In mt8173 and mt2712, we don't get the performance issue,
Keep its default value(0x0), that means all the larbs enter mmu0.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 3e6e0a8..e4daabb 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -49,6 +49,12 @@
 #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
 #define F_MMU_EN		BIT(0)
 
+/* SMI COMMON */
+#define SMI_BUS_SEL			0x220
+#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
+/* All are MMU0 defaultly. Only specialize mmu1 here. */
+#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
+
 enum mtk_smi_gen {
 	MTK_SMI_GEN1,
 	MTK_SMI_GEN2
@@ -56,6 +62,8 @@ enum mtk_smi_gen {
 
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
+
+	u32 bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
 struct mtk_smi_larb_gen {
@@ -70,8 +78,8 @@ struct mtk_smi {
 	struct clk			*clk_apb, *clk_smi;
 	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
-	void __iomem			*smi_ao_base;
-
+	void __iomem			*smi_ao_base; /* only for gen1 */
+	void __iomem			*base;	      /* only for gen2 */
 	const struct mtk_smi_common_plat *plat;
 };
 
@@ -401,6 +409,12 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 	.gen = MTK_SMI_GEN2,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
+	.gen = MTK_SMI_GEN2,
+	.bus_sel = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(4) |
+		   F_MMU1_LARB(7),
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-common",
@@ -416,7 +430,7 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 	},
 	{
 		.compatible = "mediatek,mt8183-smi-common",
-		.data = &mtk_smi_common_gen2,
+		.data = &mtk_smi_common_mt8183,
 	},
 	{}
 };
@@ -473,6 +487,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(common->clk_async);
 		if (ret)
 			return ret;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		common->base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(common->base))
+			return PTR_ERR(common->base);
 	}
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
@@ -488,6 +507,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
+	u32 bus_sel = common->plat->bus_sel;
 	int ret;
 
 	ret = mtk_smi_clk_enable(common);
@@ -495,6 +515,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
 		return ret;
 	}
+
+	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
+		writel(bus_sel, common->base + SMI_BUS_SEL);
 	return 0;
 }
 
-- 
1.9.1

