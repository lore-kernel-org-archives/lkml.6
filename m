Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EC227AD4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EC227AD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030618AbeF2CUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:20:52 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31537 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030535AbeF2CUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:20:44 -0400
X-UUID: 976f1a3a51ae42d6a28c3e916bd54da5-20180629
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1213337827; Fri, 29 Jun 2018 10:20:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 29 Jun 2018 10:20:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 29 Jun 2018 10:20:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 3/5] phy: phy-mtk-tphy: add properties for eye diagram test
Date:   Fri, 29 Jun 2018 10:20:29 +0800
Message-ID: <e7cc9f7aa65b07abb3bd0f94029ef0b07de5d3d7.1530238400.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
References: <54260d59ae39c2335e97892fe85db16cac30b33b.1530238400.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties for Eye diagram test of HQA which sometimes need
adjust some parameters of u2phy

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index b962339..9ab6f2e 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -42,6 +42,12 @@
 #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
 #define PA0_RG_USB20_INTR_EN		BIT(5)
 
+#define U3P_USBPHYACR1		0x004
+#define PA1_RG_VRT_SEL			GENMASK(14, 12)
+#define PA1_RG_VRT_SEL_VAL(x)	((0x7 & (x)) << 12)
+#define PA1_RG_TERM_SEL		GENMASK(10, 8)
+#define PA1_RG_TERM_SEL_VAL(x)	((0x7 & (x)) << 8)
+
 #define U3P_USBPHYACR2		0x008
 #define PA2_RG_SIF_U2PLL_FORCE_EN	BIT(18)
 
@@ -288,6 +294,9 @@ struct mtk_phy_instance {
 	struct clk *ref_clk;	/* reference clock of anolog phy */
 	u32 index;
 	u8 type;
+	int eye_src;
+	int eye_vrt;
+	int eye_term;
 };
 
 struct mtk_tphy {
@@ -312,6 +321,10 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 	int fm_out;
 	u32 tmp;
 
+	/* use force value */
+	if (instance->eye_src)
+		return;
+
 	/* enable USB ring oscillator */
 	tmp = readl(com + U3P_USBPHYACR5);
 	tmp |= PA5_RG_U2_HSTX_SRCAL_EN;
@@ -818,6 +831,52 @@ static void phy_v2_banks_init(struct mtk_tphy *tphy,
 	}
 }
 
+static void phy_parse_property(struct mtk_tphy *tphy,
+				struct mtk_phy_instance *instance)
+{
+	struct device *dev = &instance->phy->dev;
+
+	if (instance->type != PHY_TYPE_USB2)
+		return;
+
+	device_property_read_u32(dev, "mediatek,eye-src",
+				 &instance->eye_src);
+	device_property_read_u32(dev, "mediatek,eye-vrt",
+				 &instance->eye_vrt);
+	device_property_read_u32(dev, "mediatek,eye-term",
+				 &instance->eye_term);
+}
+
+static void u2_phy_props_set(struct mtk_tphy *tphy,
+			     struct mtk_phy_instance *instance)
+{
+	struct u2phy_banks *u2_banks = &instance->u2_banks;
+	void __iomem *com = u2_banks->com;
+	u32 tmp;
+
+
+	if (instance->eye_src) {
+		tmp = readl(com + U3P_USBPHYACR5);
+		tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
+		tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(instance->eye_src);
+		writel(tmp, com + U3P_USBPHYACR5);
+	}
+
+	if (instance->eye_vrt) {
+		tmp = readl(com + U3P_USBPHYACR1);
+		tmp &= ~PA1_RG_VRT_SEL;
+		tmp |= PA1_RG_VRT_SEL_VAL(instance->eye_vrt);
+		writel(tmp, com + U3P_USBPHYACR1);
+	}
+
+	if (instance->eye_term) {
+		tmp = readl(com + U3P_USBPHYACR1);
+		tmp &= ~PA1_RG_TERM_SEL;
+		tmp |= PA1_RG_TERM_SEL_VAL(instance->eye_term);
+		writel(tmp, com + U3P_USBPHYACR1);
+	}
+}
+
 static int mtk_phy_init(struct phy *phy)
 {
 	struct mtk_phy_instance *instance = phy_get_drvdata(phy);
@@ -839,6 +898,7 @@ static int mtk_phy_init(struct phy *phy)
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
 		u2_phy_instance_init(tphy, instance);
+		u2_phy_props_set(tphy, instance);
 		break;
 	case PHY_TYPE_USB3:
 		u3_phy_instance_init(tphy, instance);
@@ -951,6 +1011,8 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	phy_parse_property(tphy, instance);
+
 	return instance->phy;
 }
 
-- 
1.9.1

