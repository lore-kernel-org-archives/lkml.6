Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeEHCVJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:21:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49223 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753773AbeEHCVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:21:06 -0400
X-UUID: a521ceee9f9644d6bac41904e2d767d4-20180508
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
        Sascha Hauer <kernel@pengutronix.de>
Subject: [PATCH 7/7] drm/mediatek: config component output by device node port
Date: Tue, 8 May 2018 10:20:57 +0800
Message-ID: <20180508022057.29379-8-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
References: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can select output component by decive node port.
Main path default output component is DSI.
External path default output component is DPI.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 37 ++++++++++++++++++++++++++++++----
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 ++--
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index f4fb86ab7b8d..05333769d862 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -24,6 +24,8 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
 
 #include "mtk_drm_crtc.h"
 #include "mtk_drm_ddp.h"
@@ -133,7 +135,7 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.atomic_commit = mtk_atomic_commit,
 };
 
-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_COLOR0,
@@ -141,12 +143,12 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
 	DDP_COMPONENT_DSI0,
 };
 
-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
 	DDP_COMPONENT_RDMA1,
 	DDP_COMPONENT_DPI0,
 };
 
-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL,
@@ -157,7 +159,7 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_PWM0,
 };
 
-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_GAMMA,
@@ -411,6 +413,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(dev->of_node->parent, node) {
+		struct device_node *port, *ep, *remote;
 		const struct of_device_id *of_id;
 		enum mtk_ddp_comp_type comp_type;
 		int comp_id;
@@ -470,6 +473,32 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 			private->ddp_comp[comp_id] = comp;
 		}
+
+		if (comp_type != MTK_DSI && comp_type != MTK_DPI) {
+			port = of_graph_get_port_by_id(node, 0);
+			if (!port)
+				continue;
+			ep = of_get_child_by_name(port, "endpoint");
+			of_node_put(port);
+			if (!ep)
+				continue;
+			remote = of_graph_get_remote_port_parent(ep);
+			of_node_put(ep);
+			if (!remote)
+				continue;
+			of_id = of_match_node(mtk_ddp_comp_dt_ids, remote);
+			if (!of_id)
+				continue;
+			comp_type = (enum mtk_ddp_comp_type)of_id->data;
+			for (i = 0; i < private->data->main_len - 1; i++)
+				if (private->data->main_path[i] == comp_id)
+					private->data->main_path[i + 1] =
+					mtk_ddp_comp_get_id(node, comp_type);
+			for (i = 0; i < private->data->ext_len - 1; i++)
+				if (private->data->ext_path[i] == comp_id)
+					private->data->ext_path[i + 1] =
+					mtk_ddp_comp_get_id(node, comp_type);
+		}
 	}
 
 	if (!private->mutex_node) {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index c3378c452c0a..2bcba8eb06f4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -29,9 +29,9 @@ struct drm_property;
 struct regmap;
 
 struct mtk_mmsys_driver_data {
-	const enum mtk_ddp_comp_id *main_path;
+	enum mtk_ddp_comp_id *main_path;
 	unsigned int main_len;
-	const enum mtk_ddp_comp_id *ext_path;
+	enum mtk_ddp_comp_id *ext_path;
 	unsigned int ext_len;
 	bool shadow_register;
 };
-- 
2.12.5
