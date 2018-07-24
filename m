Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F74C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E52B205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E52B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbeGXJWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:22:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11920 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388383AbeGXJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:22:48 -0400
X-UUID: 291763715bda4491b45129532e76ac7b-20180724
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1024719291; Tue, 24 Jul 2018 16:17:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 24 Jul 2018 16:17:20 +0800
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
Subject: [PATCH v1 01/15] drm/mediatek: add connection from RDMA0 to DPI1
Date:   Tue, 24 Jul 2018 16:17:01 +0800
Message-ID: <1532420235-22268-2-git-send-email-stu.hsieh@mediatek.com>
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

This patch add connection from RDMA0 to DPI1

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 87e4191c250e..03e3628b5b0d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -106,6 +106,7 @@
 #define OVL1_MOUT_EN_COLOR1		0x1
 #define GAMMA_MOUT_EN_RDMA1		0x1
 #define RDMA0_SOUT_DPI0			0x2
+#define RDMA0_SOUT_DPI1			0x3
 #define RDMA0_SOUT_DSI2			0x4
 #define RDMA0_SOUT_DSI3			0x5
 #define RDMA1_SOUT_DPI0			0x2
@@ -224,6 +225,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
 		value = RDMA0_SOUT_DPI0;
+	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI1) {
+		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
+		value = RDMA0_SOUT_DPI1;
 	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
 		value = RDMA0_SOUT_DSI2;
-- 
2.12.5

