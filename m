Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeEHCWo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:22:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:21646 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753645AbeEHCVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:21:05 -0400
X-UUID: 170cf6c8188d4796a5c9896da225e9fc-20180508
From: Bibby Hsieh <bibby.hsieh@mediatek.com>
To: David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC: Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>, CK Hu <ck.hu@mediatek.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: [PATCH 5/7] drm/mediatek: implement connection from BLS to DPI0
Date: Tue, 8 May 2018 10:20:55 +0800
Message-ID: <20180508022057.29379-6-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
References: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify display driver to support connection from BLS to DPI.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8130f3dab661..289a68c6731f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -35,6 +35,7 @@
 #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
 #define DISP_REG_CONFIG_OUT_SEL			0x04c
 #define DISP_REG_CONFIG_DSI_SEL			0x050
+#define DISP_REG_CONFIG_DPI_SEL			0x064
 
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
@@ -84,7 +85,10 @@
 
 #define OVL_MOUT_EN_RDMA		0x1
 #define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
+#define BLS_TO_DPI_RDMA1_TO_DSI		0x2
 #define DSI_SEL_IN_BLS			0x0
+#define DPI_SEL_IN_BLS			0x0
+#define DSI_SEL_IN_RDMA			0x1
 
 struct mtk_disp_mutex {
 	int id;
@@ -189,9 +193,17 @@ static void mtk_ddp_sout_sel(void __iomem *config_regs,
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
2.12.5
