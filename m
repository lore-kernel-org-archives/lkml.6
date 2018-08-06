Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785C0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CD921A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CD921A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHFOHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:07:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3495 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731574AbeHFOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:07:18 -0400
X-UUID: 04f7b53956ba48ff8506c242241048ee-20180806
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 600681818; Mon, 06 Aug 2018 19:58:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 6 Aug 2018 19:58:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 6 Aug 2018 19:58:23 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v3 05/13] drm/mediatek: add memory mode and layer_config for RDMA
Date:   Mon, 6 Aug 2018 19:58:12 +0800
Message-ID: <1533556700-26525-6-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add memory mode for RDMA and layer_config for RDMA

If use RDMA to read data from memory, it should set memory mode to RDMA

Layer config set the data address and pitch to RDMA from plane setting.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 585943c81e1f..08866550740f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -31,14 +31,20 @@
 #define RDMA_REG_UPDATE_INT				BIT(0)
 #define DISP_REG_RDMA_GLOBAL_CON		0x0010
 #define RDMA_ENGINE_EN					BIT(0)
+#define RDMA_MODE_MEMORY				BIT(1)
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
@@ -138,12 +144,27 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
 
+static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
+				  struct mtk_plane_state *state)
+{
+	struct mtk_plane_pending_state *pending = &state->pending;
+	unsigned int addr = pending->addr;
+	unsigned int pitch = pending->pitch & 0xffff;
+
+	writel_relaxed(addr, comp->regs + DISP_RDMA_MEM_START_ADDR);
+	writel_relaxed(pitch, comp->regs + DISP_RDMA_MEM_SRC_PITCH);
+	writel(RDMA_MEM_GMC, comp->regs + DISP_RDMA_MEM_GMC_SETTING_0);
+	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
+			 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
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

