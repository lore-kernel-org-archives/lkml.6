Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeEHCVG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:21:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19579 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753525AbeEHCVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:21:04 -0400
X-UUID: 6d0be10b855a4706894a33d309d74ed8-20180508
From: Bibby Hsieh <bibby.hsieh@mediatek.com>
To: David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC: Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>, CK Hu <ck.hu@mediatek.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Subject: [PATCH 3/7] drm/mediatek: add dpi driver for mt2701 and mt7623
Date: Tue, 8 May 2018 10:20:53 +0800
Message-ID: <20180508022057.29379-4-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
References: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

This patch adds dpi dirver suppot for both mt2701 and mt7623.
And also support other (existing or future) chips that use
the same binding and driver.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c     | 24 ++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 2b8b34c72697..e1af1d0d213d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -640,8 +640,7 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
 	}
 	drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_funcs);
 
-	/* Currently DPI0 is fixed to be driven by OVL1 */
-	dpi->encoder.possible_crtcs = BIT(1);
+	dpi->encoder.possible_crtcs = BIT(0) | BIT(1);
 	dpi->encoder.bridge->encoder = &dpi->encoder;
 	ret = drm_bridge_attach(&dpi->encoder, dpi->encoder.bridge, NULL);
 	if (ret) {
@@ -690,12 +689,33 @@ static unsigned int mt8173_calculate_factor(int clock)
 		return 2 * 3;
 }
 
+static unsigned int mt2701_calculate_factor(int clock)
+{
+	if (clock <= 64000)
+		return 16;
+	else if (clock <= 128000)
+		return 8;
+	else if (clock <= 256000)
+		return 4;
+	else
+		return 2;
+}
+
 static const struct mtk_dpi_conf mt8173_conf = {
 	.cal_factor = mt8173_calculate_factor,
 	.reg_h_fre_con = 0xe0,
 };
 
+static const struct mtk_dpi_conf mt2701_conf = {
+	.cal_factor = mt2701_calculate_factor,
+	.reg_h_fre_con = 0xb0,
+	.edge_sel_en = true,
+};
+
 static const struct of_device_id mtk_dpi_of_ids[] = {
+	{ .compatible = "mediatek,mt2701-dpi",
+	  .data = &mt2701_conf,
+	},
 	{ .compatible = "mediatek,mt8173-dpi",
 	  .data = &mt8173_conf,
 	},
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a2ca90fc403c..f4fb86ab7b8d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -372,6 +372,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	{ .compatible = "mediatek,mt8173-disp-ufoe",  .data = (void *)MTK_DISP_UFOE },
 	{ .compatible = "mediatek,mt2701-dsi",	      .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt2701-dpi",	      .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
-- 
2.12.5
