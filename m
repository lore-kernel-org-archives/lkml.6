Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F213EC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B9C216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B9C216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeHCFFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:05:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37586 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726182AbeHCFFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:05:33 -0400
X-UUID: 2e2550024a844e4884951ff3b1624dba-20180803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1963587853; Fri, 03 Aug 2018 11:11:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 11:11:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 11:11:12 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v2 07/15] drm/mediatek: add layer config to set RDMA for plane setting
Date:   Fri, 3 Aug 2018 11:11:00 +0800
Message-ID: <1533265868-28110-8-git-send-email-stu.hsieh@mediatek.com>
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

This patch add layer config to set RDMA for plane setting

Layer config set the data address and pitch to RDMA from plane setting.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 1985035451ce..51ee5f0734df 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -35,11 +35,16 @@
 #define DISP_REG_RDMA_SIZE_CON_0		0x0014
 #define DISP_REG_RDMA_SIZE_CON_1		0x0018
 #define DISP_REG_RDMA_TARGET_LINE		0x001c
+#define DISP_RDMA_MEM_SRC_PITCH			0x002c
+#define DISP_RDMA_MEM_GMC_SETTING_0		0x0030
 #define DISP_REG_RDMA_FIFO_CON			0x0040
 #define RDMA_FIFO_UNDERFLOW_EN				BIT(31)
 #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
 #define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
 #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
+#define DISP_RDMA_MEM_START_ADDR		0x0f00
+
+#define RDMA_MEM_GMC				0x40402020
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
@@ -145,12 +150,28 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
 
+static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
+				  struct mtk_plane_state *state)
+{
+	struct mtk_plane_pending_state *pending = &state->pending;
+	unsigned int addr = pending->addr;
+	unsigned int pitch = pending->pitch & 0xffff;
+
+	if (pending->height == 0u || pending->width == 0u)
+		return;
+
+	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
+	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
+	writel(RDMA_MEM_GMC, comp->regs + DISP_RDMA_MEM_GMC_SETTING_0);
+}
+
 static const struct mtk_ddp_comp_funcs mtk_disp_rdma_funcs = {
 	.config = mtk_rdma_config,
 	.start = mtk_rdma_start,
 	.stop = mtk_rdma_stop,
 	.enable_vblank = mtk_rdma_enable_vblank,
 	.disable_vblank = mtk_rdma_disable_vblank,
+	.layer_config = mtk_rdma_layer_config,
 };
 
 static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
-- 
2.12.5.2.gbdf23ab

