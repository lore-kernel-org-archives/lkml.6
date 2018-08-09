Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C8EC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD78121C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD78121C1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeHIEie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:38:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49895 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728130AbeHIEid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:38:33 -0400
X-UUID: 8f12c5bbfd38454e8dd13db84bf1b093-20180809
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 422758907; Thu, 09 Aug 2018 10:15:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 9 Aug 2018 10:15:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 9 Aug 2018 10:15:52 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v4 12/14] drm/mediatek: use layer_nr function to get layer number to init plane
Date:   Thu, 9 Aug 2018 10:15:47 +0800
Message-ID: <1533780949-30141-13-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch use layer_nr function to get layer number to init plane

When plane init in crtc create,
it use the number of OVL layer to init plane.
That's OVL can read 4 memory address.

For mt2712 third ddp, it use RDMA to read memory.
RDMA can read 1 memory address, so it just init one plane.

For compatibility, this patch use mtk_ddp_comp_layer_nr function
to get layer number from their HW component in ddp for plane init.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 21 ++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  1 -
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 2d6aa150a9ff..845d1608465e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -45,7 +45,8 @@ struct mtk_drm_crtc {
 	bool				pending_needs_vblank;
 	struct drm_pending_vblank_event	*event;
 
-	struct drm_plane		planes[OVL_LAYER_NR];
+	struct drm_plane		*planes;
+	unsigned int			layer_nr;
 	bool				pending_planes;
 
 	void __iomem			*config_regs;
@@ -286,7 +287,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 	}
 
 	/* Initially configure all planes */
-	for (i = 0; i < OVL_LAYER_NR; i++) {
+	for (i = 0; i < mtk_crtc->layer_nr; i++) {
 		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
 
@@ -351,7 +352,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 	}
 
 	if (mtk_crtc->pending_planes) {
-		for (i = 0; i < OVL_LAYER_NR; i++) {
+		for (i = 0; i < mtk_crtc->layer_nr; i++) {
 			struct drm_plane *plane = &mtk_crtc->planes[i];
 			struct mtk_plane_state *plane_state;
 
@@ -403,7 +404,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 		return;
 
 	/* Set all pending plane state to disabled */
-	for (i = 0; i < OVL_LAYER_NR; i++) {
+	for (i = 0; i < mtk_crtc->layer_nr; i++) {
 		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
 
@@ -450,7 +451,7 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	if (mtk_crtc->event)
 		mtk_crtc->pending_needs_vblank = true;
-	for (i = 0; i < OVL_LAYER_NR; i++) {
+	for (i = 0; i < mtk_crtc->layer_nr; i++) {
 		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
 
@@ -598,7 +599,12 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		mtk_crtc->ddp_comp[i] = comp;
 	}
 
-	for (zpos = 0; zpos < OVL_LAYER_NR; zpos++) {
+	mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
+	mtk_crtc->planes = devm_kzalloc(dev, mtk_crtc->layer_nr *
+					sizeof(struct drm_plane),
+					GFP_KERNEL);
+
+	for (zpos = 0; zpos < mtk_crtc->layer_nr; zpos++) {
 		type = (zpos == 0) ? DRM_PLANE_TYPE_PRIMARY :
 				(zpos == 1) ? DRM_PLANE_TYPE_CURSOR :
 						DRM_PLANE_TYPE_OVERLAY;
@@ -609,7 +615,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	}
 
 	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
-				&mtk_crtc->planes[1], pipe);
+				mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
+				NULL, pipe);
 	if (ret < 0)
 		goto unprepare;
 	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
index 9d9410c67ae9..60bcc8aba8e3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
@@ -18,7 +18,6 @@
 #include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_plane.h"
 
-#define OVL_LAYER_NR	4
 #define MTK_LUT_SIZE	512
 #define MTK_MAX_BPC	10
 #define MTK_MIN_BPC	3
-- 
2.12.5.2.gbdf23ab

