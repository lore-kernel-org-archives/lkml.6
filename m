Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6051C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771932146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfBTCyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:54:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64633 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730380AbfBTCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:54:31 -0500
X-UUID: 06fb1654abb74b59b3d97b9c094346b0-20190220
X-UUID: 06fb1654abb74b59b3d97b9c094346b0-20190220
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 493453467; Wed, 20 Feb 2019 10:54:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 10:54:23 +0800
Received: from mszsdaap41.mediatek.inc (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 10:54:22 +0800
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
Subject: [PATCH V5 8/8] drm/mediatek: fix the rate of parent for hdmi phy in MT2701
Date:   Wed, 20 Feb 2019 10:53:57 +0800
Message-ID: <20190220025357.7354-9-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190220025357.7354-1-wangyan.wang@mediatek.com>
References: <20190220025357.7354-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

We should not change the rate of parent for hdmi phy when
doing round_rate for this clock. The parent clock of hdmi
phy must be the same as it. We change it when doing set_rate
only.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 14 --------------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  3 ---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 11 +++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 14 ++++++++++++++
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 370309d684ec..ca8bc1489f37 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -15,20 +15,6 @@ static const struct phy_ops mtk_hdmi_phy_dev_ops = {
 	.owner = THIS_MODULE,
 };
 
-long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-			     unsigned long *parent_rate)
-{
-	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
-
-	hdmi_phy->pll_rate = rate;
-	if (rate <= 74250000)
-		*parent_rate = rate;
-	else
-		*parent_rate = rate / 2;
-
-	return rate;
-}
-
 u32 mtk_hdmi_phy_read(struct mtk_hdmi_phy *hdmi_phy, u32 offset)
 {
 	return readl(hdmi_phy->regs + offset);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index 446e2acd1926..c6061ad15ff0 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -50,9 +50,6 @@ void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 		       u32 val, u32 mask);
 struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
-long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-			     unsigned long *parent_rate);
-
 extern struct platform_driver mtk_hdmi_phy_driver;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index 88dd9e812ca0..33893a180c2e 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -152,6 +152,17 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 			  RG_HDMITX_DRV_IBIAS_MASK);
 	return 0;
 }
+
+static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long *parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	hdmi_phy->pll_rate = rate;
+
+	return rate;
+}
+
 static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
 				       unsigned long parent_rate)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index 63dde42521b8..3a339f516613 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -285,6 +285,20 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long *parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	hdmi_phy->pll_rate = rate;
+	if (rate <= 74250000)
+		*parent_rate = rate;
+	else
+		*parent_rate = rate / 2;
+
+	return rate;
+}
+
 static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
 				       unsigned long parent_rate)
 {
-- 
2.14.1

