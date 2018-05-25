Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964908AbeEYCeo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:34:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11266 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S935556AbeEYCeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:34:37 -0400
X-UUID: 35d93adefdd54d398f2ee4cef82116e8-20180525
From: <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v3 2/8] drm/mediatek: support maximum 64 mutex mod
Date: Fri, 25 May 2018 10:34:19 +0800
Message-ID: <1527215665-11937-3-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stu Hsieh <stu.hsieh@mediatek.com>

This patch support that if modules more than 32,
add index more than 31 when using DISP_REG_MUTEX_MOD2 bit

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
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
