Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165EC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9720684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D9720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJBOwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:52:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11182 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727374AbeJBOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:52:53 -0400
X-UUID: 4119bf958e3a4ecd8045cadecbab81e9-20181002
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 860496337; Tue, 02 Oct 2018 16:10:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Oct 2018 16:10:45 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Oct 2018 16:10:45 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: [PATCH v4 10/11] drm/mediatek: implement connection from BLS to DPI0
Date:   Tue, 2 Oct 2018 16:10:40 +0800
Message-ID: <20181002081041.32629-11-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
In-Reply-To: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
References: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CCC2AE4CA3F0872636DDA95A583F27F67A6AE970BCE8811E9BDF0C39C887F2982000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify display driver to support connection from BLS to DPI.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 87e4191c250e..f3068c62ed48 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -39,6 +39,7 @@
 #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
 #define DISP_REG_CONFIG_OUT_SEL			0x04c
 #define DISP_REG_CONFIG_DSI_SEL			0x050
+#define DISP_REG_CONFIG_DPI_SEL			0x064
 
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
@@ -132,7 +133,10 @@
 
 #define OVL_MOUT_EN_RDMA		0x1
 #define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
+#define BLS_TO_DPI_RDMA1_TO_DSI		0x2
 #define DSI_SEL_IN_BLS			0x0
+#define DPI_SEL_IN_BLS			0x0
+#define DSI_SEL_IN_RDMA			0x1
 
 struct mtk_disp_mutex {
 	int id;
@@ -323,9 +327,17 @@ static void mtk_ddp_sout_sel(void __iomem *config_regs,
 			     enum mtk_ddp_comp_id cur,
 			     enum mtk_ddp_comp_id next)
 {
-	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
+	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
 		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
 			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
+		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
+			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+		writel_relaxed(DSI_SEL_IN_RDMA,
+			       config_regs + DISP_REG_CONFIG_DSI_SEL);
+		writel_relaxed(DPI_SEL_IN_BLS,
+			       config_regs + DISP_REG_CONFIG_DPI_SEL);
+	}
 }
 
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
-- 
2.12.5.2.gbdf23ab

