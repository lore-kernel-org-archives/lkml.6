Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55F1205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55F1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbeGXJWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:22:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3361 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388600AbeGXJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:46 -0400
X-UUID: 540b2c5db43d41b1a012b2f45b574e0f-20180724
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 801191891; Tue, 24 Jul 2018 16:17:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 24 Jul 2018 16:17:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 24 Jul 2018 16:17:22 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v1 11/15] drm/mediatek: add dummy buffer for RDMA memory mode
Date:   Tue, 24 Jul 2018 16:17:11 +0800
Message-ID: <1532420235-22268-12-git-send-email-stu.hsieh@mediatek.com>
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

This patch add dummy buffer for RDMA memory mode

When display power on, the drm frame work would modeset and
set up the display HW.

In this time, the RDMA would start wroking and read the data from memory.
But, user space not send the data to drm yet.

For this case, if user space not send data to display hw(RDMA) yet,
RDMA would read the wrong address to show garbage.

Therefore, we create dummy buffer for RDMA reading memory
when userspace not send the data yet.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 23 +++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 8d41f5cd485b..e28f368728cd 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -20,6 +20,7 @@
 
 #include "mtk_drm_crtc.h"
 #include "mtk_drm_ddp_comp.h"
+#include "mtk_drm_gem.h"
 
 #define DISP_REG_RDMA_INT_ENABLE		0x0000
 #define DISP_REG_RDMA_INT_STATUS		0x0004
@@ -59,6 +60,9 @@
 #define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
 #define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
 
+#define RDMA_DUMMY_BUFFER_SIZE(h, v)		((h) * (v) * 4)
+#define RDMA_DUMMY_BUFFER_PITCH(h)		((h) * 4)
+
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
 };
@@ -74,6 +78,7 @@ struct mtk_disp_rdma {
 	const struct mtk_disp_rdma_data	*data;
 	struct drm_device *drm_dev;
 	bool rdma_memory_mode;
+	unsigned int dummy_size;
 };
 
 static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
@@ -126,14 +131,29 @@ static void mtk_rdma_disable_vblank(struct mtk_ddp_comp *comp)
 
 static void mtk_rdma_start(struct mtk_ddp_comp *comp)
 {
+	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
+	bool *rdma_memory_mode = comp->comp_mode;
+
+	if (*rdma_memory_mode == true) {
+		comp->mtk_gem = mtk_drm_gem_create(rdma->drm_dev,
+						   rdma->dummy_size, false);
+		writel(comp->mtk_gem->dma_addr & 0xFFFFFFFF,
+		       comp->regs + DISP_RDMA_MEM_START_ADDR);
+	}
+
 	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN,
 			 RDMA_ENGINE_EN);
 }
 
 static void mtk_rdma_stop(struct mtk_ddp_comp *comp)
 {
+	bool *rdma_memory_mode = comp->comp_mode;
+
 	writel(RDMA_SOFT_RESET, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
 	writel(0, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
+
+	if (*rdma_memory_mode == true)
+		mtk_drm_gem_free_object(&comp->mtk_gem->base);
 }
 
 static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
@@ -149,8 +169,11 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
 
 	if (*rdma_memory_mode == true) {
+		rdma->dummy_size = RDMA_DUMMY_BUFFER_SIZE(width, height);
 		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
 				 MATRIX_INT_MTX_SEL_DEFAULT);
+		writel(RDMA_DUMMY_BUFFER_PITCH(width),
+		       comp->regs + DISP_RDMA_MEM_SRC_PITCH);
 		rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
 				 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
 	}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index a1988ce15141..6dbb83144a74 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -92,6 +92,7 @@ struct mtk_ddp_comp {
 	int irq;
 	struct device *larb_dev;
 	enum mtk_ddp_comp_id id;
+	struct mtk_drm_gem_obj *mtk_gem;
 	const struct mtk_ddp_comp_funcs *funcs;
 	void *comp_mode;
 };
-- 
2.12.5

