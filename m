Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BBFECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0739C2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0739C2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbeIUJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:15:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20215 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388084AbeIUJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:15:19 -0400
X-UUID: 051b9e8bede04cf6af4a03b387b8e3e3-20180921
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1383180600; Fri, 21 Sep 2018 11:28:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 11:28:26 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 11:28:26 +0800
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
        Sascha Hauer <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Subject: [PATCH v3 05/12] drm/mediatek: convert dpi driver to use drm_of_find_panel_or_bridge
Date:   Fri, 21 Sep 2018 11:28:15 +0800
Message-ID: <20180921032822.30771-6-bibby.hsieh@mediatek.com>
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

From: chunhui dai <chunhui.dai@mediatek.com>

Convert dpi driver to use drm_of_find_panel_or_bridge.
This changes some error messages to debug messages (in the graph core).
Graph connections are often "no connects" depending on the particular
board, so we want to avoid spurious messages. Plus the kernel is not a
DT validator.
related links:
[1] https://lkml.org/lkml/2017/2/3/716
[2] https://lkml.org/lkml/2017/2/3/719

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 022ccec49cea..7a4868a0afec 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -14,6 +14,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_of.h>
 #include <linux/kernel.h>
 #include <linux/component.h>
 #include <linux/platform_device.h>
@@ -697,7 +698,6 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_dpi *dpi;
 	struct resource *mem;
-	struct device_node *bridge_node;
 	int comp_id;
 	int ret;
 
@@ -743,16 +743,14 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
-	if (!bridge_node)
-		return -ENODEV;
-
-	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
-
-	dpi->bridge = of_drm_find_bridge(bridge_node);
-	of_node_put(bridge_node);
-	if (!dpi->bridge)
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
+					  NULL, &dpi->bridge);
+	if (ret) {
+		dev_err(dev, "Failed to find panel or bridge: %d\n", ret);
 		return -EPROBE_DEFER;
+	}
+
+	dev_info(dev, "Found bridge node: %pOF\n", dpi->bridge->of_node);
 
 	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
 	if (comp_id < 0) {
-- 
2.12.5.2.gbdf23ab

