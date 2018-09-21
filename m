Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731EBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BD921533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BD921533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbeIUJP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:15:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17142 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389111AbeIUJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:15:28 -0400
X-UUID: 8101115220b34b048121ff59ad40422e-20180921
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 999576182; Fri, 21 Sep 2018 11:28:34 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 11:28:27 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 11:28:27 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: [PATCH v3 12/12] drm/mediatek: config component output by device node port
Date:   Fri, 21 Sep 2018 11:28:22 +0800
Message-ID: <20180921032822.30771-13-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
In-Reply-To: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
References: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index d961112fa2f5..a477fb878c06 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -21,7 +21,9 @@
 #include <drm/drm_of.h>
 #include <linux/component.h>
 #include <linux/iommu.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 
@@ -133,7 +135,7 @@ static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
 	.atomic_commit = mtk_atomic_commit,
 };
 
-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_COLOR0,
@@ -141,7 +143,7 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
 	DDP_COMPONENT_DSI0,
 };
 
-static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
+static enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
 	DDP_COMPONENT_RDMA1,
 	DDP_COMPONENT_DPI0,
 };
@@ -172,7 +174,7 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
 	DDP_COMPONENT_PWM2,
 };
 
-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_AAL0,
@@ -183,7 +185,7 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_PWM0,
 };
 
-static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
+static enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_GAMMA,
@@ -472,6 +474,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
 	/* Iterate over sibling DISP function blocks */
 	for_each_child_of_node(dev->of_node->parent, node) {
+		struct device_node *port, *ep, *remote;
 		const struct of_device_id *of_id;
 		enum mtk_ddp_comp_type comp_type;
 		int comp_id;
@@ -531,6 +534,32 @@ static int mtk_drm_probe(struct platform_device *pdev)
 
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
index ecc00ca3221d..256a3ff2e66e 100644
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
 	const enum mtk_ddp_comp_id *third_path;
 	unsigned int third_len;
-- 
2.12.5.2.gbdf23ab

