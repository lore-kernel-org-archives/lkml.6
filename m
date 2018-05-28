Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753762AbeE1GkA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:40:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7549 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753564AbeE1Gim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:38:42 -0400
X-UUID: 2dff1d6957bb42d79aa38010032de32e-20180528
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v4 9/9] drm/mediatek: Add support for mediatek SOC MT2712
Date: Mon, 28 May 2018 14:38:27 +0800
Message-ID: <1527489507-24453-10-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for the Mediatek MT2712 DISP subsystem.
There are two OVL engine and three disp output in MT2712.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 39 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8bfc0debd2c2..3b22b48a6022 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -61,6 +61,24 @@
 #define MT8173_MUTEX_MOD_DISP_PWM1		24
 #define MT8173_MUTEX_MOD_DISP_OD		25
 
+#define MT2712_MUTEX_MOD_DISP_PWM2		10
+#define MT2712_MUTEX_MOD_DISP_OVL0		11
+#define MT2712_MUTEX_MOD_DISP_OVL1		12
+#define MT2712_MUTEX_MOD_DISP_RDMA0		13
+#define MT2712_MUTEX_MOD_DISP_RDMA1		14
+#define MT2712_MUTEX_MOD_DISP_RDMA2		15
+#define MT2712_MUTEX_MOD_DISP_WDMA0		16
+#define MT2712_MUTEX_MOD_DISP_WDMA1		17
+#define MT2712_MUTEX_MOD_DISP_COLOR0		18
+#define MT2712_MUTEX_MOD_DISP_COLOR1		19
+#define MT2712_MUTEX_MOD_DISP_AAL0		20
+#define MT2712_MUTEX_MOD_DISP_UFOE		22
+#define MT2712_MUTEX_MOD_DISP_PWM0		23
+#define MT2712_MUTEX_MOD_DISP_PWM1		24
+#define MT2712_MUTEX_MOD_DISP_OD0		25
+#define MT2712_MUTEX_MOD2_DISP_AAL1		33
+#define MT2712_MUTEX_MOD2_DISP_OD1		34
+
 #define MT2701_MUTEX_MOD_DISP_OVL		3
 #define MT2701_MUTEX_MOD_DISP_WDMA		6
 #define MT2701_MUTEX_MOD_DISP_COLOR		7
@@ -110,6 +128,26 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
 };
 
+static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT2712_MUTEX_MOD_DISP_AAL0,
+	[DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
+	[DDP_COMPONENT_COLOR0] = MT2712_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_COLOR1] = MT2712_MUTEX_MOD_DISP_COLOR1,
+	[DDP_COMPONENT_OD0] = MT2712_MUTEX_MOD_DISP_OD0,
+	[DDP_COMPONENT_OD1] = MT2712_MUTEX_MOD2_DISP_OD1,
+	[DDP_COMPONENT_OVL0] = MT2712_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL1] = MT2712_MUTEX_MOD_DISP_OVL1,
+	[DDP_COMPONENT_PWM0] = MT2712_MUTEX_MOD_DISP_PWM0,
+	[DDP_COMPONENT_PWM1] = MT2712_MUTEX_MOD_DISP_PWM1,
+	[DDP_COMPONENT_PWM2] = MT2712_MUTEX_MOD_DISP_PWM2,
+	[DDP_COMPONENT_RDMA0] = MT2712_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT2712_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_RDMA2] = MT2712_MUTEX_MOD_DISP_RDMA2,
+	[DDP_COMPONENT_UFOE] = MT2712_MUTEX_MOD_DISP_UFOE,
+	[DDP_COMPONENT_WDMA0] = MT2712_MUTEX_MOD_DISP_WDMA0,
+	[DDP_COMPONENT_WDMA1] = MT2712_MUTEX_MOD_DISP_WDMA1,
+};
+
 static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
@@ -430,6 +468,7 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 
 static const struct of_device_id ddp_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
+	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
 	{},
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 3d279a299383..3a866e1d6af4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -146,6 +146,32 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_OD0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_DPI0,
+	DDP_COMPONENT_PWM0,
+};
+
+static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] = {
+	DDP_COMPONENT_OVL1,
+	DDP_COMPONENT_COLOR1,
+	DDP_COMPONENT_AAL1,
+	DDP_COMPONENT_OD1,
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_DPI1,
+	DDP_COMPONENT_PWM1,
+};
+
+static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
+	DDP_COMPONENT_RDMA2,
+	DDP_COMPONENT_DSI2,
+	DDP_COMPONENT_PWM2,
+};
+
 static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
@@ -173,6 +199,15 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.shadow_register = true,
 };
 
+static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
+	.main_path = mt2712_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
+	.ext_path = mt2712_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
+	.third_path = mt2712_mtk_ddp_third,
+	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
+};
+
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.main_path = mt8173_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
@@ -379,6 +414,7 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	{ .compatible = "mediatek,mt8173-dsi",        .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dpi",        .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt2712-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex", .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2701-disp-pwm",   .data = (void *)MTK_DISP_BLS },
 	{ .compatible = "mediatek,mt8173-disp-pwm",   .data = (void *)MTK_DISP_PWM },
@@ -557,6 +593,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 static const struct of_device_id mtk_drm_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmsys",
 	  .data = &mt2701_mmsys_driver_data},
+	{ .compatible = "mediatek,mt2712-mmsys",
+	  .data = &mt2712_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
-- 
2.12.5
