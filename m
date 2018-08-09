Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA89C46473
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005C221C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005C221C1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeHIEig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:38:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49144 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725779AbeHIEif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:38:35 -0400
X-UUID: 78fbb1f0aeba453388bef7ac4d3952ae-20180809
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1020796618; Thu, 09 Aug 2018 10:15:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 9 Aug 2018 10:15:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 9 Aug 2018 10:15:51 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v4 06/14] drm/mediatek: add RGB color format support for RDMA
Date:   Thu, 9 Aug 2018 10:15:41 +0800
Message-ID: <1533780949-30141-7-git-send-email-stu.hsieh@mediatek.com>
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

This patch add RGB color format support for RDMA,
including RGB565, RGB888, RGBA8888 and ARGB8888.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 08866550740f..1f57f86c7910 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -35,6 +35,8 @@
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
+#define DISP_RDMA_MEM_CON			0x0024
+#define MEM_MODE_INPUT_SWAP				BIT(8)
 #define DISP_RDMA_MEM_SRC_PITCH			0x002c
 #define DISP_RDMA_MEM_GMC_SETTING_0		0x0030
 #define DISP_REG_RDMA_FIFO_CON			0x0040
@@ -46,6 +48,11 @@
 
 #define RDMA_MEM_GMC				0x40402020
 
+#define MEM_MODE_INPUT_FORMAT_RGB565		0x0
+#define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
+#define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
+#define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
+
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
 };
@@ -144,12 +151,51 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
 
+static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
+				     unsigned int fmt)
+{
+	/* The return value in switch "MEM_MODE_INPUT_FORMAT_XXX"
+	 * is defined in mediatek HW data sheet.
+	 * The alphabet order in XXX is no relation to data
+	 * arrangement in memory.
+	 */
+	switch (fmt) {
+	default:
+	case DRM_FORMAT_RGB565:
+		return MEM_MODE_INPUT_FORMAT_RGB565;
+	case DRM_FORMAT_BGR565:
+		return MEM_MODE_INPUT_FORMAT_RGB565 | MEM_MODE_INPUT_SWAP;
+	case DRM_FORMAT_RGB888:
+		return MEM_MODE_INPUT_FORMAT_RGB888;
+	case DRM_FORMAT_BGR888:
+		return MEM_MODE_INPUT_FORMAT_RGB888 | MEM_MODE_INPUT_SWAP;
+	case DRM_FORMAT_RGBX8888:
+	case DRM_FORMAT_RGBA8888:
+		return MEM_MODE_INPUT_FORMAT_ARGB8888;
+	case DRM_FORMAT_BGRX8888:
+	case DRM_FORMAT_BGRA8888:
+		return MEM_MODE_INPUT_FORMAT_ARGB8888 | MEM_MODE_INPUT_SWAP;
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+		return MEM_MODE_INPUT_FORMAT_RGBA8888;
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ABGR8888:
+		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
+	}
+}
+
 static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 				  struct mtk_plane_state *state)
 {
+	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
 	struct mtk_plane_pending_state *pending = &state->pending;
 	unsigned int addr = pending->addr;
 	unsigned int pitch = pending->pitch & 0xffff;
+	unsigned int fmt = pending->format;
+	unsigned int con;
+
+	con = rdma_fmt_convert(rdma, fmt);
+	writel_relaxed(con, comp->regs + DISP_RDMA_MEM_CON);
 
 	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
 	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
-- 
2.12.5.2.gbdf23ab

