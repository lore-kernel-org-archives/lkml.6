Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2C120817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2C120817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbeKQMxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:53:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729745AbeKQMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:53:31 -0500
X-UUID: 9a32579ffc5f4c0d96031d6dee4e57b2-20181117
X-UUID: 9a32579ffc5f4c0d96031d6dee4e57b2-20181117
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1403743666; Sat, 17 Nov 2018 10:38:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 17 Nov 2018 10:38:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 17 Nov 2018 10:38:26 +0800
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
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v3 09/15] memory: mtk-smi: Use a struct for the platform data for smi-common
Date:   Sat, 17 Nov 2018 10:35:36 +0800
Message-ID: <1542422142-30688-10-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a struct as the platform special data instead of the enumeration.

Also there is a minor change that moving the position of
"enum mtk_smi_gen" definition, this is because we expect define
"struct mtk_smi_common_plat" before it is referred.

This is a prepare patch for adding bus_sel for mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 7cf4573..3e6e0a8 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -49,6 +49,15 @@
 #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
 #define F_MMU_EN		BIT(0)
 
+enum mtk_smi_gen {
+	MTK_SMI_GEN1,
+	MTK_SMI_GEN2
+};
+
+struct mtk_smi_common_plat {
+	enum mtk_smi_gen gen;
+};
+
 struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
@@ -62,6 +71,8 @@ struct mtk_smi {
 	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
 	void __iomem			*smi_ao_base;
+
+	const struct mtk_smi_common_plat *plat;
 };
 
 struct mtk_smi_larb { /* larb: local arbiter */
@@ -73,11 +84,6 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	u32				*mmu;
 };
 
-enum mtk_smi_gen {
-	MTK_SMI_GEN1,
-	MTK_SMI_GEN2
-};
-
 static int mtk_smi_clk_enable(const struct mtk_smi *smi)
 {
 	int ret;
@@ -387,22 +393,30 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 	}
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
+	.gen = MTK_SMI_GEN1,
+};
+
+static const struct mtk_smi_common_plat mtk_smi_common_gen2 = {
+	.gen = MTK_SMI_GEN2,
+};
+
 static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{
 		.compatible = "mediatek,mt8173-smi-common",
-		.data = (void *)MTK_SMI_GEN2
+		.data = &mtk_smi_common_gen2,
 	},
 	{
 		.compatible = "mediatek,mt2701-smi-common",
-		.data = (void *)MTK_SMI_GEN1
+		.data = &mtk_smi_common_gen1,
 	},
 	{
 		.compatible = "mediatek,mt2712-smi-common",
-		.data = (void *)MTK_SMI_GEN2
+		.data = &mtk_smi_common_gen2,
 	},
 	{
 		.compatible = "mediatek,mt8183-smi-common",
-		.data = (void *)MTK_SMI_GEN2
+		.data = &mtk_smi_common_gen2,
 	},
 	{}
 };
@@ -412,13 +426,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_smi *common;
 	struct resource *res;
-	enum mtk_smi_gen smi_gen;
 	int ret;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
 		return -ENOMEM;
 	common->dev = dev;
+	common->plat = of_device_get_match_data(dev);
 
 	common->clk_apb = devm_clk_get(dev, "apb");
 	if (IS_ERR(common->clk_apb))
@@ -446,8 +460,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
 	 * base.
 	 */
-	smi_gen = (enum mtk_smi_gen)of_device_get_match_data(dev);
-	if (smi_gen == MTK_SMI_GEN1) {
+	if (common->plat->gen == MTK_SMI_GEN1) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		common->smi_ao_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(common->smi_ao_base))
-- 
1.9.1

