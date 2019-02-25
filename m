Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1285420989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfBYCJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:09:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39870 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728470AbfBYCJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 21:09:35 -0500
X-UUID: ff3c27f2db1a449eaa819f012109d8df-20190225
X-UUID: ff3c27f2db1a449eaa819f012109d8df-20190225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 614246140; Mon, 25 Feb 2019 10:09:30 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 25 Feb
 2019 10:09:29 +0800
Received: from mszsdaap41.mediatek.inc (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Feb 2019 10:09:28 +0800
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
Subject: [PATCH V6 3/8] drm/mediatek: using different flags of clk for HDMI phy
Date:   Mon, 25 Feb 2019 10:09:07 +0800
Message-ID: <20190225020912.29120-4-wangyan.wang@mediatek.com>
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

The parent rate of hdmi phy had set by DPI driver.
We should not set or change the parent rate of MT2701 hdmi phy,
as a result we should remove the flags of "CLK_SET_RATE_PARENT"
from the clock of MT2701 hdmi phy.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
Signed-off-by: wangyan wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 13 +++++--------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  1 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  1 +
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  1 +
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 13c5e65b9ead..370309d684ec 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -107,13 +107,11 @@ mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
 		return NULL;
 }
 
-static void mtk_hdmi_phy_clk_get_ops(struct mtk_hdmi_phy *hdmi_phy,
-				     const struct clk_ops **ops)
+static void mtk_hdmi_phy_clk_get_data(struct mtk_hdmi_phy *hdmi_phy,
+				     struct clk_init_data *clk_init)
 {
-	if (hdmi_phy && hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_clk_ops)
-		*ops = hdmi_phy->conf->hdmi_phy_clk_ops;
-	else
-		dev_err(hdmi_phy->dev, "Failed to get clk ops of phy\n");
+	clk_init->flags = hdmi_phy->conf->flags;
+	clk_init->ops = hdmi_phy->conf->hdmi_phy_clk_ops;
 }
 
 static int mtk_hdmi_phy_probe(struct platform_device *pdev)
@@ -126,7 +124,6 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 	struct clk_init_data clk_init = {
 		.num_parents = 1,
 		.parent_names = (const char * const *)&ref_clk_name,
-		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	};
 
 	struct phy *phy;
@@ -164,7 +161,7 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 	hdmi_phy->dev = dev;
 	hdmi_phy->conf =
 		(struct mtk_hdmi_phy_conf *)of_device_get_match_data(dev);
-	mtk_hdmi_phy_clk_get_ops(hdmi_phy, &clk_init.ops);
+	mtk_hdmi_phy_clk_get_data(hdmi_phy, &clk_init);
 	hdmi_phy->pll_hw.init = &clk_init;
 	hdmi_phy->pll = devm_clk_register(dev, &hdmi_phy->pll_hw);
 	if (IS_ERR(hdmi_phy->pll)) {
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index fdad8b17a915..446e2acd1926 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -21,6 +21,7 @@ struct mtk_hdmi_phy;
 
 struct mtk_hdmi_phy_conf {
 	bool tz_disabled;
+	unsigned long flags;
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
 	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index b26fb7dbdb28..43bc058d5528 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -234,6 +234,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
 	.tz_disabled = true,
+	.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_GATE,
 	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
 	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
 	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index cb23c1e4692a..63dde42521b8 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -317,6 +317,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 }
 
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf = {
+	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
 	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
 	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
-- 
2.14.1

