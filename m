Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9928DC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA6F216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA6F216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeHCFFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:05:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37586 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727226AbeHCFFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:05:36 -0400
X-UUID: 5bf9609b61794a1ea0ddf2d82fa9b48c-20180803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 446501579; Fri, 03 Aug 2018 11:11:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 11:11:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 11:11:13 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v2 09/15] drm/mediatek: add YUYV/UYVY color format support for RDMA
Date:   Fri, 3 Aug 2018 11:11:02 +0800
Message-ID: <1533265868-28110-10-git-send-email-stu.hsieh@mediatek.com>
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

This patch add YUYV/UYVY color format support for RDMA
and transform matrix for YUYV/UYVY.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index b6a01438ac76..b728f0f42611 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -33,6 +33,8 @@
 #define RDMA_ENGINE_EN					BIT(0)
 #define RDMA_MODE_MEMORY				BIT(1)
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
+#define RDMA_MATRIX_ENABLE				BIT(17)
+#define RDMA_MATRIX_INT_MTX_SEL				(7UL << 20)
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
 #define DISP_RDMA_MEM_CON			0x0024
@@ -46,12 +48,15 @@
 #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
 #define DISP_RDMA_MEM_START_ADDR		0x0f00
 
+#define MATRIX_INT_MTX_SEL_DEFAULT		0xb00000
 #define RDMA_MEM_GMC				0x40402020
 
 #define MEM_MODE_INPUT_FORMAT_RGB565		0x0
 #define MEM_MODE_INPUT_FORMAT_RGB888		(0x001 << 4)
 #define MEM_MODE_INPUT_FORMAT_RGBA8888		(0x002 << 4)
 #define MEM_MODE_INPUT_FORMAT_ARGB8888		(0x003 << 4)
+#define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
+#define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
@@ -182,6 +187,10 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
 		return MEM_MODE_INPUT_FORMAT_RGBA8888 | MEM_MODE_INPUT_SWAP;
+	case DRM_FORMAT_UYVY:
+		return MEM_MODE_INPUT_FORMAT_UYVY;
+	case DRM_FORMAT_YUYV:
+		return MEM_MODE_INPUT_FORMAT_YUYV;
 	}
 }
 
@@ -200,6 +209,12 @@ static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 
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
2.12.5.2.gbdf23ab

