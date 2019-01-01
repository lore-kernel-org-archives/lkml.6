Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F09C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A460208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfAAD7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 22:59:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:14395 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727417AbfAAD7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 22:59:36 -0500
X-UUID: c515e5ccae194dd387687ef55beed27c-20190101
X-UUID: c515e5ccae194dd387687ef55beed27c-20190101
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1600415306; Tue, 01 Jan 2019 11:59:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 11:59:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 11:59:28 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v5 16/20] memory: mtk-smi: Add bus_sel for mt8183
Date:   Tue, 1 Jan 2019 11:55:48 +0800
Message-ID: <1546314952-15990-17-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
mmu0 or mmu1 to balance the bandwidth via the smi-common register
SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).

In mt8183, For better performance, we switch larb1/2/5/7 to enter
mmu1 while the others still keep enter mmu0.

In mt8173 and mt2712, we don't get the performance issue,
Keep its default value(0x0), that means all the larbs enter mmu0.

Note: smi gen1(mt2701/mt7623) don't have this bus_sel.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 9790801..08cf40d 100644
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
@@ -57,6 +63,7 @@ enum mtk_smi_gen {
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
 	bool             has_gals;
+	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 };
 
 struct mtk_smi_larb_gen {
@@ -72,8 +79,8 @@ struct mtk_smi {
 	struct clk			*clk_apb, *clk_smi;
 	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
-	void __iomem			*smi_ao_base;
-
+	void __iomem			*smi_ao_base; /* only for gen1 */
+	void __iomem			*base;	      /* only for gen2 */
 	const struct mtk_smi_common_plat *plat;
 };
 
@@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
 	.gen      = MTK_SMI_GEN2,
 	.has_gals = true,
+	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
+		    F_MMU1_LARB(7),
 };
 
 static const struct of_device_id mtk_smi_common_of_ids[] = {
@@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
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
@@ -497,6 +511,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
 {
 	struct mtk_smi *common = dev_get_drvdata(dev);
+	u32 bus_sel = common->plat->bus_sel;
 	int ret;
 
 	ret = mtk_smi_clk_enable(common);
@@ -504,6 +519,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
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

