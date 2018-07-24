Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778EEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D855205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D855205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbeGXJWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:22:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11920 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388673AbeGXJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:47 -0400
X-UUID: 9b0e6666a3e84016ae7c9b564f143add-20180724
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 584516807; Tue, 24 Jul 2018 16:17:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 24 Jul 2018 16:17:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 24 Jul 2018 16:17:20 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v1 05/15] drm/mediatek: add RDMA memory mode for crtc created
Date:   Tue, 24 Jul 2018 16:17:05 +0800
Message-ID: <1532420235-22268-6-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add RDMA memory mode for crtc created

For mt2712, the third ddp use RDMA engine to read data from dram.

Therefore, when crtc created, crtc need to decide using OVL or RDMA
by ddp to read data from dram.

If this ddp use RDMA, the crtc should set this RDMA which in the crtc
using memory mode.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 5 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 8 ++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 585943c81e1f..60851bb2dd63 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -150,6 +150,7 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 			      void *data)
 {
 	struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
+	struct mtk_ddp_comp *comp = &priv->ddp_comp;
 	struct drm_device *drm_dev = data;
 	int ret;
 
@@ -160,8 +161,10 @@ static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	return 0;
 
+	comp->comp_mode = &priv->rdma_memory_mode;
+
+	return 0;
 }
 
 static void mtk_disp_rdma_unbind(struct device *dev, struct device *master,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 2d6aa150a9ff..4bf636e466f2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -578,6 +578,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		enum mtk_ddp_comp_id comp_id = path[i];
 		struct mtk_ddp_comp *comp;
 		struct device_node *node;
+		bool *rdma_memory_mode;
 
 		node = priv->comp_node[comp_id];
 		comp = priv->ddp_comp[comp_id];
@@ -595,6 +596,13 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 			goto unprepare;
 		}
 
+		if (i == 0 && (comp_id == DDP_COMPONENT_RDMA0 ||
+			       comp_id == DDP_COMPONENT_RDMA1 ||
+			       comp_id == DDP_COMPONENT_RDMA2)) {
+			rdma_memory_mode = comp->comp_mode;
+			*rdma_memory_mode = true;
+		}
+
 		mtk_crtc->ddp_comp[i] = comp;
 	}
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 7413ffeb3c9d..a1988ce15141 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -93,6 +93,7 @@ struct mtk_ddp_comp {
 	struct device *larb_dev;
 	enum mtk_ddp_comp_id id;
 	const struct mtk_ddp_comp_funcs *funcs;
+	void *comp_mode;
 };
 
 static inline void mtk_ddp_comp_config(struct mtk_ddp_comp *comp,
-- 
2.12.5

