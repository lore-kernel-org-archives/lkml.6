Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D08EC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25C3216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25C3216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeHCFGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:06:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10730 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727171AbeHCFFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:05:36 -0400
X-UUID: 719cd0b7a22347e0b0e31cc3391f060f-20180803
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 384554160; Fri, 03 Aug 2018 11:11:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 11:11:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 11:11:11 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v2 05/15] drm/mediatek: add RDMA memory mode for crtc created
Date:   Fri, 3 Aug 2018 11:10:58 +0800
Message-ID: <1533265868-28110-6-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
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
2.12.5.2.gbdf23ab

