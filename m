Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC4EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38FA27ADE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38FA27ADE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030657AbeF2CVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:21:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:15631 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030492AbeF2CUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:20:47 -0400
X-UUID: 6a65a604a5a04cd9885d716d994260e9-20180629
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1717969203; Fri, 29 Jun 2018 10:20:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 29 Jun 2018 10:20:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 29 Jun 2018 10:20:38 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 4/5] phy: phy-mtk-tphy: add property for BC12
Date:   Fri, 29 Jun 2018 10:20:30 +0800
Message-ID: <c074a2e2fad54c9be78635effe3ee5044ebbfdc5.1530238400.git.chunfeng.yun@mediatek.com>
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

Some platforms support BC12 which is disabled by default,
here add a property to enable it if need

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 9ab6f2e..3eb8e1b 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -101,6 +101,9 @@
 #define P2C_RG_AVALID			BIT(2)
 #define P2C_RG_IDDIG			BIT(1)
 
+#define U3P_U2PHYBC12C		0x080
+#define P2C_RG_CHGDT_EN		BIT(0)
+
 #define U3P_U3_CHIP_GPIO_CTLD		0x0c
 #define P3C_REG_IP_SW_RST		BIT(31)
 #define P3C_MCU_BUS_CK_GATE_EN		BIT(30)
@@ -297,6 +300,7 @@ struct mtk_phy_instance {
 	int eye_src;
 	int eye_vrt;
 	int eye_term;
+	bool bc12_en;
 };
 
 struct mtk_tphy {
@@ -839,12 +843,16 @@ static void phy_parse_property(struct mtk_tphy *tphy,
 	if (instance->type != PHY_TYPE_USB2)
 		return;
 
+	instance->bc12_en = device_property_read_bool(dev, "mediatek,bc12");
 	device_property_read_u32(dev, "mediatek,eye-src",
 				 &instance->eye_src);
 	device_property_read_u32(dev, "mediatek,eye-vrt",
 				 &instance->eye_vrt);
 	device_property_read_u32(dev, "mediatek,eye-term",
 				 &instance->eye_term);
+	dev_dbg(dev, "bc12:%d, src:%d, vrt:%d, term:%d\n",
+		instance->bc12_en, instance->eye_src,
+		instance->eye_vrt, instance->eye_term);
 }
 
 static void u2_phy_props_set(struct mtk_tphy *tphy,
@@ -854,6 +862,11 @@ static void u2_phy_props_set(struct mtk_tphy *tphy,
 	void __iomem *com = u2_banks->com;
 	u32 tmp;
 
+	if (instance->bc12_en) {
+		tmp = readl(com + U3P_U2PHYBC12C);
+		tmp |= P2C_RG_CHGDT_EN;	/* BC1.2 path Enable */
+		writel(tmp, com + U3P_U2PHYBC12C);
+	}
 
 	if (instance->eye_src) {
 		tmp = readl(com + U3P_USBPHYACR5);
-- 
1.9.1

