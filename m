Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C73C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885420844
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C885420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHFOHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:07:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36055 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731868AbeHFOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:07:18 -0400
X-UUID: e27d287bad4f4b338ea6bb68fc46d5ab-20180806
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 752020223; Mon, 06 Aug 2018 19:58:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 6 Aug 2018 19:58:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 6 Aug 2018 19:58:22 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v3 03/13] drm/mediatek: add connection from RDMA1 to DSI0
Date:   Mon, 6 Aug 2018 19:58:10 +0800
Message-ID: <1533556700-26525-4-git-send-email-stu.hsieh@mediatek.com>
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

This patch add connection from RDMA1 to DSI0

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 310d8482d5a0..31189fad8d4e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -124,6 +124,7 @@
 #define DPI0_SEL_IN_RDMA2		0x3
 #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
 #define DPI1_SEL_IN_RDMA2		(0x3 << 8)
+#define DSI0_SEL_IN_RDMA1		0x1
 #define DSI1_SEL_IN_RDMA1		0x1
 #define DSI1_SEL_IN_RDMA2		0x4
 #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
@@ -290,6 +291,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
 		value = DPI1_SEL_IN_RDMA1;
+	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
+		value = DSI0_SEL_IN_RDMA1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
 		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
 		value = DSI1_SEL_IN_RDMA1;
-- 
2.12.5.2.gbdf23ab

