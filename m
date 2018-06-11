Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +XPPMP3rHVt6IwAAmS7hNA
	; Mon, 11 Jun 2018 03:26:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B6CF2606DD; Mon, 11 Jun 2018 03:26:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 15736607E4;
	Mon, 11 Jun 2018 03:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15736607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeFKD0t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 23:26:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48026 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753866AbeFKD0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 23:26:47 -0400
X-UUID: aa5a8b559c5e4835b2c326576abd8e0c-20180611
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2010131235; Mon, 11 Jun 2018 11:26:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 11 Jun 2018 11:26:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 11 Jun 2018 11:26:43 +0800
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH 02/28] drm/mediatek: support maximum 64 mutex mod
Date: Mon, 11 Jun 2018 11:25:54 +0800
Message-ID: <1528687580-549-3-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch support that if modules more than 32,
add index more than 31 when using DISP_REG_MUTEX_MOD2 bit

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 75 +++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8130f3dab661..47ffa240bd25 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -41,31 +41,32 @@
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
 #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
+#define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
 
 #define INT_MUTEX				BIT(1)
 
-#define MT8173_MUTEX_MOD_DISP_OVL0		BIT(11)
-#define MT8173_MUTEX_MOD_DISP_OVL1		BIT(12)
-#define MT8173_MUTEX_MOD_DISP_RDMA0		BIT(13)
-#define MT8173_MUTEX_MOD_DISP_RDMA1		BIT(14)
-#define MT8173_MUTEX_MOD_DISP_RDMA2		BIT(15)
-#define MT8173_MUTEX_MOD_DISP_WDMA0		BIT(16)
-#define MT8173_MUTEX_MOD_DISP_WDMA1		BIT(17)
-#define MT8173_MUTEX_MOD_DISP_COLOR0		BIT(18)
-#define MT8173_MUTEX_MOD_DISP_COLOR1		BIT(19)
-#define MT8173_MUTEX_MOD_DISP_AAL		BIT(20)
-#define MT8173_MUTEX_MOD_DISP_GAMMA		BIT(21)
-#define MT8173_MUTEX_MOD_DISP_UFOE		BIT(22)
-#define MT8173_MUTEX_MOD_DISP_PWM0		BIT(23)
-#define MT8173_MUTEX_MOD_DISP_PWM1		BIT(24)
-#define MT8173_MUTEX_MOD_DISP_OD		BIT(25)
-
-#define MT2701_MUTEX_MOD_DISP_OVL		BIT(3)
-#define MT2701_MUTEX_MOD_DISP_WDMA		BIT(6)
-#define MT2701_MUTEX_MOD_DISP_COLOR		BIT(7)
-#define MT2701_MUTEX_MOD_DISP_BLS		BIT(9)
-#define MT2701_MUTEX_MOD_DISP_RDMA0		BIT(10)
-#define MT2701_MUTEX_MOD_DISP_RDMA1		BIT(12)
+#define MT8173_MUTEX_MOD_DISP_OVL0		11
+#define MT8173_MUTEX_MOD_DISP_OVL1		12
+#define MT8173_MUTEX_MOD_DISP_RDMA0		13
+#define MT8173_MUTEX_MOD_DISP_RDMA1		14
+#define MT8173_MUTEX_MOD_DISP_RDMA2		15
+#define MT8173_MUTEX_MOD_DISP_WDMA0		16
+#define MT8173_MUTEX_MOD_DISP_WDMA1		17
+#define MT8173_MUTEX_MOD_DISP_COLOR0		18
+#define MT8173_MUTEX_MOD_DISP_COLOR1		19
+#define MT8173_MUTEX_MOD_DISP_AAL		20
+#define MT8173_MUTEX_MOD_DISP_GAMMA		21
+#define MT8173_MUTEX_MOD_DISP_UFOE		22
+#define MT8173_MUTEX_MOD_DISP_PWM0		23
+#define MT8173_MUTEX_MOD_DISP_PWM1		24
+#define MT8173_MUTEX_MOD_DISP_OD		25
+
+#define MT2701_MUTEX_MOD_DISP_OVL		3
+#define MT2701_MUTEX_MOD_DISP_WDMA		6
+#define MT2701_MUTEX_MOD_DISP_COLOR		7
+#define MT2701_MUTEX_MOD_DISP_BLS		9
+#define MT2701_MUTEX_MOD_DISP_RDMA0		10
+#define MT2701_MUTEX_MOD_DISP_RDMA1		12
 
 #define MUTEX_SOF_SINGLE_MODE		0
 #define MUTEX_SOF_DSI0			1
@@ -278,6 +279,7 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
 					   mutex[mutex->id]);
 	unsigned int reg;
+	unsigned int offset;
 
 	WARN_ON(&ddp->mutex[mutex->id] != mutex);
 
@@ -292,9 +294,17 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 		reg = MUTEX_SOF_DPI0;
 		break;
 	default:
-		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg |= ddp->mutex_mod[id];
-		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
+		if (ddp->mutex_mod[id] < 32) {
+			offset = DISP_REG_MUTEX_MOD(mutex->id);
+			reg = readl_relaxed(ddp->regs + offset);
+			reg |= 1 << ddp->mutex_mod[id];
+			writel_relaxed(reg, ddp->regs + offset);
+		} else {
+			offset = DISP_REG_MUTEX_MOD2(mutex->id);
+			reg = readl_relaxed(ddp->regs + offset);
+			reg |= 1 << (ddp->mutex_mod[id] - 32);
+			writel_relaxed(reg, ddp->regs + offset);
+		}
 		return;
 	}
 
@@ -307,6 +317,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
 					   mutex[mutex->id]);
 	unsigned int reg;
+	unsigned int offset;
 
 	WARN_ON(&ddp->mutex[mutex->id] != mutex);
 
@@ -318,9 +329,17 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
 		break;
 	default:
-		reg = readl_relaxed(ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
-		reg &= ~(ddp->mutex_mod[id]);
-		writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_MOD(mutex->id));
+		if (ddp->mutex_mod[id] < 32) {
+			offset = DISP_REG_MUTEX_MOD(mutex->id);
+			reg = readl_relaxed(ddp->regs + offset);
+			reg &= ~(1 << ddp->mutex_mod[id]);
+			writel_relaxed(reg, ddp->regs + offset);
+		} else {
+			offset = DISP_REG_MUTEX_MOD2(mutex->id);
+			reg = readl_relaxed(ddp->regs + offset);
+			reg &= ~(1 << (ddp->mutex_mod[id] - 32));
+			writel_relaxed(reg, ddp->regs + offset);
+		}
 		break;
 	}
 }
-- 
2.12.5
