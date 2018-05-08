Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeEHCWc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:22:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19579 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753668AbeEHCVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:21:05 -0400
X-UUID: 4c0299ca664f4b5095dd8fb1aa0268c5-20180508
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
Subject: [PATCH 2/7] drm/mediatek: fix to get right bridge for dpi encoder
Date: Tue, 8 May 2018 10:20:52 +0800
Message-ID: <20180508022057.29379-3-bibby.hsieh@mediatek.com>
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

1, dpi is an encoder, there is an bridge in the struct
of decoder, we could use it.
2, using of_graph_get_remote_port_parent to get right
bridge in device tree.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 0a44ab175422..2b8b34c72697 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -63,7 +63,6 @@ enum mtk_dpi_out_color_format {
 struct mtk_dpi {
 	struct mtk_ddp_comp ddp_comp;
 	struct drm_encoder encoder;
-	struct drm_bridge *bridge;
 	void __iomem *regs;
 	struct device *dev;
 	struct clk *engine_clk;
@@ -643,8 +642,8 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
 
 	/* Currently DPI0 is fixed to be driven by OVL1 */
 	dpi->encoder.possible_crtcs = BIT(1);
-
-	ret = drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL);
+	dpi->encoder.bridge->encoder = &dpi->encoder;
+	ret = drm_bridge_attach(&dpi->encoder, dpi->encoder.bridge, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to attach bridge: %d\n", ret);
 		goto err_cleanup;
@@ -709,7 +708,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_dpi *dpi;
 	struct resource *mem;
-	struct device_node *bridge_node;
+	struct device_node *ep, *bridge_node;
 	int comp_id;
 	const struct of_device_id *match;
 	int ret;
@@ -759,15 +758,21 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
-	if (!bridge_node)
+	ep = of_graph_get_next_endpoint(dev->of_node, NULL);
+	if (ep) {
+		bridge_node = of_graph_get_remote_port_parent(ep);
+		of_node_put(ep);
+	}
+	if (!bridge_node) {
+		dev_err(dev, "Failed to find bridge node\n");
 		return -ENODEV;
+	}
 
 	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
 
-	dpi->bridge = of_drm_find_bridge(bridge_node);
+	dpi->encoder.bridge = of_drm_find_bridge(bridge_node);
 	of_node_put(bridge_node);
-	if (!dpi->bridge)
+	if (!dpi->encoder.bridge)
 		return -EPROBE_DEFER;
 
 	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
-- 
2.12.5
