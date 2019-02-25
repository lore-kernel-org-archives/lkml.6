Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCDB21019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfBYCJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:09:31 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:22309 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbfBYCJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:09:30 -0500
X-UUID: 36f921b833c3465181685182becc0a42-20190225
X-UUID: 36f921b833c3465181685182becc0a42-20190225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 227076720; Mon, 25 Feb 2019 10:09:24 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 25 Feb
 2019 10:09:22 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 10:09:21 +0800
From:   wangyan wang <wangyan.wang@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     wangyan wang <wangyan.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v6 1/8] drm/mediatek: recalculate hdmi phy clock of MT2701 by querying hardware
Date:   Mon, 25 Feb 2019 10:09:05 +0800
Message-ID: <20190225020912.29120-2-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190225020912.29120-1-wangyan.wang@mediatek.com>
References: <20190225020912.29120-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

Recalculate the rate of this clock, by querying hardware.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |  7 ++----
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 +--
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 35 ++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  8 ++++++
 4 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 4ef9c57ffd44..13c5e65b9ead 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -29,12 +29,9 @@ long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	return rate;
 }
 
-unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
-				       unsigned long parent_rate)
+u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
 {
-	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
-
-	return hdmi_phy->pll_rate;
+	return readl(hdmi_phy->regs + offset);
 }
 
 void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index f39b1fc66612..fdad8b17a915 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -41,6 +41,7 @@ struct mtk_hdmi_phy {
 	unsigned int ibias_up;
 };
 
+u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset);
 void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 			     u32 bits);
 void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
@@ -50,8 +51,6 @@ void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
 long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 			     unsigned long *parent_rate);
-unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
-				       unsigned long parent_rate);
 
 extern struct platform_driver mtk_hdmi_phy_driver;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index fcc42dc6ea7f..b25c9dfc432a 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -153,6 +153,41 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 			  RG_HDMITX_DRV_IBIAS_MASK);
 	return 0;
 }
+static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+	unsigned long out_rate, val;
+
+	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
+			& RG_HTPLL_PREDIV_MASK) >> RG_HTPLL_PREDIV;
+	switch (val) {
+	case 0x00:
+		out_rate = parent_rate;
+		break;
+	case 0x01:
+		out_rate = parent_rate / 2;
+		break;
+	default:
+		out_rate = parent_rate / 4;
+		break;
+	}
+
+	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON6)
+			& RG_HTPLL_FBKDIV_MASK) >> RG_HTPLL_FBKDIV;
+	out_rate *= (val + 1) * 2;
+	val = (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2)
+			& RG_HDMITX_TX_POSDIV_MASK);
+
+	out_rate >>= (val >> RG_HDMITX_TX_POSDIV);
+
+	if (mtk_hdmi_phy_read(hdmi_phy, HDMI_CON2) & RG_HDMITX_EN_TX_POSDIV)
+		out_rate = out_rate / 5;
+
+	hdmi_phy->pll_rate = out_rate;
+
+	return hdmi_phy->pll_rate;
+}
 
 static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index ed5916b27658..cb23c1e4692a 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -285,6 +285,14 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	return hdmi_phy->pll_rate;
+}
+
 static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
-- 
2.14.1

