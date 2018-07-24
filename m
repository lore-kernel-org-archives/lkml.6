Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1045AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92EE205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92EE205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeGXJWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:22:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388383AbeGXJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:52 -0400
X-UUID: f6c5b3e521334c009d896b67961fd91a-20180724
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1763269333; Tue, 24 Jul 2018 16:17:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 24 Jul 2018 16:17:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 24 Jul 2018 16:17:21 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v1 09/15] drm/mediatek: add YUYV/UYVY color format support for RDMA
Date:   Tue, 24 Jul 2018 16:17:09 +0800
Message-ID: <1532420235-22268-10-git-send-email-stu.hsieh@mediatek.com>
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

This patch add YUYV/UYVY color format support for RDMA
and transform matrix for YUYV/UYVY.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 5b7dadc21016..49edbae50167 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -34,6 +34,8 @@
 #define RDMA_SOFT_RESET					BIT(4)
 #define RDMA_MODE_MEMORY				BIT(1)
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
+#define RDMA_MATRIX_ENABLE				BIT(17)
+#define RDMA_MATRIX_INT_MTX_SEL				(7UL << 20)
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
 #define DISP_RDMA_MEM_CON			0x0024
@@ -54,6 +56,8 @@
 #define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
 #define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
 #define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
+#define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
+#define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
@@ -188,6 +192,10 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
 		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
+	case DRM_FORMAT_UYVY:
+		return MEM_MODE_INPUT_FORMAT_UYVY;
+	case DRM_FORMAT_YUYV:
+		return MEM_MODE_INPUT_FORMAT_YUYV;
 	}
 }
 
@@ -206,6 +214,12 @@ static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 
 	con = rdma_fmt_convert(rdma, fmt);
 	writel_relaxed(con, comp->regs + DISP_RDMA_MEM_CON);
+	if (fmt == DRM_FORMAT_UYVY || fmt == DRM_FORMAT_YUYV)
+		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
+				 RDMA_MATRIX_ENABLE | RDMA_MATRIX_INT_MTX_SEL);
+	else
+		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
+				 MATRIX_INT_MTX_SEL_DEFAULT);
 
 	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
 	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
-- 
2.12.5

