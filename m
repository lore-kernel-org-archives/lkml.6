Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A418FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF292075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF292075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965358AbeFSHe6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:34:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10019 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S937251AbeFSHey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:34:54 -0400
X-UUID: a84d4297ffee46d3b568e4a692abe01e-20180619
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1487658932; Tue, 19 Jun 2018 15:34:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 19 Jun 2018 15:34:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 19 Jun 2018 15:34:48 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v6 02/29] drm/mediatek: support maximum 64 mutex mod
Date:   Tue, 19 Jun 2018 15:34:03 +0800
Message-ID: <1529393670-26862-3-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
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

