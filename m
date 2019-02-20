Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB01C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1E12196F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfBTCyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:54:20 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29835 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbfBTCyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:54:18 -0500
X-UUID: ef25cb04a54446cd8269031dcfc965ac-20190220
X-UUID: ef25cb04a54446cd8269031dcfc965ac-20190220
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 139721804; Wed, 20 Feb 2019 10:54:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 10:54:08 +0800
Received: from mszsdaap41.mediatek.inc (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 10:54:07 +0800
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
Subject: [PATCH V5 2/8] drm/mediatek: move the setting of fixed divider
Date:   Wed, 20 Feb 2019 10:53:51 +0800
Message-ID: <20190220025357.7354-3-wangyan.wang@mediatek.com>
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

move the setting of fixed divider from enable/disable
to the function of setting rate.

the patch is for hdmi pll divider, the divder should
be configured before clock calculation to ensure the
clock is right.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index b25c9dfc432a..b26fb7dbdb28 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -79,7 +79,6 @@ static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
-	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
@@ -94,7 +93,6 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
-	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
@@ -123,6 +121,7 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_PREDIV_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IC),
 			  RG_HTPLL_IC_MASK);
 	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IR),
@@ -209,7 +208,6 @@ static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
-	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
@@ -221,7 +219,6 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
-	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
 	usleep_range(80, 100);
 	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
-- 
2.14.1

