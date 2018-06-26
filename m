Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C689FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B21F20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B21F20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeFZIyG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:54:06 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:47213 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeFZIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:54:03 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.76])
        by regular1.263xmail.com (Postfix) with ESMTP id 557465E08;
        Tue, 26 Jun 2018 16:53:52 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 5D67E323;
        Tue, 26 Jun 2018 16:53:48 +0800 (CST)
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <f7d8ad340e59440ac27fb2eecfcb6d21>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 27298DG8PVC;
        Tue, 26 Jun 2018 16:53:50 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/rockchip: vop: add px30 vop support
Date:   Tue, 26 Jun 2018 16:53:35 +0800
Message-Id: <1530003215-46593-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530003215-46593-1-git-send-email-hjc@rock-chips.com>
References: <1530003215-46593-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30 have vop big and vop lite, just like rk3036 and rk3126
the max input and output resolution is 1920x1080, the main
difference between the two vop is:

vop big:
    win0 support yuv and rgb format;
    win1 and win2 support rgb format;
vop lit:
    win1 support rgb format;

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 126 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  74 ++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 08023d3..5af60eb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -177,6 +177,128 @@ static const struct vop_data rk3126_vop = {
 	.win_size = ARRAY_SIZE(rk3126_vop_win_data),
 };
 
+static const int px30_vop_intrs[] = {
+	FS_INTR,
+	0, 0,
+	LINE_FLAG_INTR,
+	0,
+	BUS_ERROR_INTR,
+	0, 0,
+	DSP_HOLD_VALID_INTR,
+};
+
+static const struct vop_intr px30_intr = {
+	.intrs = px30_vop_intrs,
+	.nintrs = ARRAY_SIZE(px30_vop_intrs),
+	.line_flag_num[0] = VOP_REG(PX30_LINE_FLAG, 0xfff, 12),
+	.status = VOP_REG_SYNC(PX30_INTR_STATUS, 0xf, 0),
+	.enable = VOP_REG_SYNC(PX30_INTR_EN, 0xf, 4),
+	.clear = VOP_REG_SYNC(PX30_INTR_CLEAR, 0xf, 8),
+};
+
+static const struct vop_common px30_common = {
+	.standby = VOP_REG_SYNC(PX30_SYS_CTRL2, 0x1, 1),
+	.out_mode = VOP_REG(PX30_DSP_CTRL2, 0xf, 16),
+	.dsp_blank = VOP_REG(PX30_DSP_CTRL2, 0x1, 14),
+	.cfg_done = VOP_REG_SYNC(PX30_REG_CFG_DONE, 0x1, 0),
+};
+
+static const struct vop_modeset px30_modeset = {
+	.htotal_pw = VOP_REG(PX30_DSP_HTOTAL_HS_END, 0x0fff0fff, 0),
+	.hact_st_end = VOP_REG(PX30_DSP_HACT_ST_END, 0x0fff0fff, 0),
+	.vtotal_pw = VOP_REG(PX30_DSP_VTOTAL_VS_END, 0x0fff0fff, 0),
+	.vact_st_end = VOP_REG(PX30_DSP_VACT_ST_END, 0x0fff0fff, 0),
+};
+
+static const struct vop_output px30_output = {
+	.rgb_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 1),
+	.hdmi_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 9),
+	.mipi_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 25),
+	.rgb_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 0),
+	.hdmi_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 8),
+	.mipi_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 24),
+};
+
+static const struct vop_scl_regs px30_win_scl = {
+	.scale_yrgb_x = VOP_REG(PX30_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(PX30_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
+	.scale_cbcr_x = VOP_REG(PX30_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
+	.scale_cbcr_y = VOP_REG(PX30_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
+};
+
+static const struct vop_win_phy px30_win0_data = {
+	.scl = &px30_win_scl,
+	.data_formats = formats_win_full,
+	.nformats = ARRAY_SIZE(formats_win_full),
+	.enable = VOP_REG(PX30_WIN0_CTRL0, 0x1, 0),
+	.format = VOP_REG(PX30_WIN0_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(PX30_WIN0_CTRL0, 0x1, 12),
+	.act_info = VOP_REG(PX30_WIN0_ACT_INFO, 0xffffffff, 0),
+	.dsp_info = VOP_REG(PX30_WIN0_DSP_INFO, 0xffffffff, 0),
+	.dsp_st = VOP_REG(PX30_WIN0_DSP_ST, 0xffffffff, 0),
+	.yrgb_mst = VOP_REG(PX30_WIN0_YRGB_MST0, 0xffffffff, 0),
+	.uv_mst = VOP_REG(PX30_WIN0_CBR_MST0, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(PX30_WIN0_VIR, 0x1fff, 0),
+	.uv_vir = VOP_REG(PX30_WIN0_VIR, 0x1fff, 16),
+};
+
+static const struct vop_win_phy px30_win1_data = {
+	.data_formats = formats_win_lite,
+	.nformats = ARRAY_SIZE(formats_win_lite),
+	.enable = VOP_REG(PX30_WIN1_CTRL0, 0x1, 0),
+	.format = VOP_REG(PX30_WIN1_CTRL0, 0x7, 4),
+	.rb_swap = VOP_REG(PX30_WIN1_CTRL0, 0x1, 12),
+	.dsp_info = VOP_REG(PX30_WIN1_DSP_INFO, 0xffffffff, 0),
+	.dsp_st = VOP_REG(PX30_WIN1_DSP_ST, 0xffffffff, 0),
+	.yrgb_mst = VOP_REG(PX30_WIN1_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(PX30_WIN1_VIR, 0x1fff, 0),
+};
+
+static const struct vop_win_phy px30_win2_data = {
+	.data_formats = formats_win_lite,
+	.nformats = ARRAY_SIZE(formats_win_lite),
+	.gate = VOP_REG(PX30_WIN2_CTRL0, 0x1, 0),
+	.enable = VOP_REG(PX30_WIN2_CTRL0, 0x1, 4),
+	.format = VOP_REG(PX30_WIN2_CTRL0, 0x3, 5),
+	.rb_swap = VOP_REG(PX30_WIN2_CTRL0, 0x1, 20),
+	.dsp_info = VOP_REG(PX30_WIN2_DSP_INFO0, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(PX30_WIN2_DSP_ST0, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(PX30_WIN2_MST0, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(PX30_WIN2_VIR0_1, 0x1fff, 0),
+};
+
+static const struct vop_win_data px30_vop_lit_win_data[] = {
+	{ .base = 0x00, .phy = &px30_win1_data,
+	  .type = DRM_PLANE_TYPE_PRIMARY },
+};
+
+static const struct vop_win_data px30_vop_big_win_data[] = {
+	{ .base = 0x00, .phy = &px30_win0_data,
+	  .type = DRM_PLANE_TYPE_PRIMARY },
+	{ .base = 0x00, .phy = &px30_win1_data,
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &px30_win2_data,
+	  .type = DRM_PLANE_TYPE_CURSOR },
+};
+
+static const struct vop_data px30_vop_lit = {
+	.intr = &px30_intr,
+	.common = &px30_common,
+	.modeset = &px30_modeset,
+	.output = &px30_output,
+	.win = px30_vop_lit_win_data,
+	.win_size = ARRAY_SIZE(px30_vop_lit_win_data),
+};
+
+static const struct vop_data px30_vop_big = {
+	.intr = &px30_intr,
+	.common = &px30_common,
+	.modeset = &px30_modeset,
+	.output = &px30_output,
+	.win = px30_vop_big_win_data,
+	.win_size = ARRAY_SIZE(px30_vop_big_win_data),
+};
+
 static const struct vop_scl_extension rk3288_win_full_scl_ext = {
 	.cbcr_vsd_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 31),
 	.cbcr_vsu_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 30),
@@ -541,6 +663,10 @@ static const struct of_device_id vop_driver_dt_match[] = {
 	  .data = &rk3036_vop },
 	{ .compatible = "rockchip,rk3126-vop",
 	  .data = &rk3126_vop },
+	{ .compatible = "rockchip,px30-vop-lit",
+	  .data = &rk3126_vop }
+	{ .compatible = "rockchip,px30-vop-big",
+	  .data = &rk3126_vop }
 	{ .compatible = "rockchip,rk3288-vop",
 	  .data = &rk3288_vop },
 	{ .compatible = "rockchip,rk3368-vop",
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index f81b510..71527cb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -884,4 +884,78 @@
 #define RK3126_WIN1_DSP_ST		0x54
 /* rk3126 register definition end */
 
+/* px30 register definition */
+#define PX30_REG_CFG_DONE			0x00000
+#define PX30_VERSION				0x00004
+#define PX30_DSP_BG				0x00008
+#define PX30_MCU_CTRL				0x0000c
+#define PX30_SYS_CTRL0				0x00010
+#define PX30_SYS_CTRL1				0x00014
+#define PX30_SYS_CTRL2				0x00018
+#define PX30_DSP_CTRL0				0x00020
+#define PX30_DSP_CTRL2				0x00028
+#define PX30_VOP_STATUS				0x0002c
+#define PX30_LINE_FLAG				0x00030
+#define PX30_INTR_EN				0x00034
+#define PX30_INTR_CLEAR				0x00038
+#define PX30_INTR_STATUS			0x0003c
+#define PX30_WIN0_CTRL0				0x00050
+#define PX30_WIN0_CTRL1				0x00054
+#define PX30_WIN0_COLOR_KEY			0x00058
+#define PX30_WIN0_VIR				0x0005c
+#define PX30_WIN0_YRGB_MST0			0x00060
+#define PX30_WIN0_CBR_MST0			0x00064
+#define PX30_WIN0_ACT_INFO			0x00068
+#define PX30_WIN0_DSP_INFO			0x0006c
+#define PX30_WIN0_DSP_ST			0x00070
+#define PX30_WIN0_SCL_FACTOR_YRGB		0x00074
+#define PX30_WIN0_SCL_FACTOR_CBR		0x00078
+#define PX30_WIN0_SCL_OFFSET			0x0007c
+#define PX30_WIN0_ALPHA_CTRL			0x00080
+#define PX30_WIN1_CTRL0				0x00090
+#define PX30_WIN1_CTRL1				0x00094
+#define PX30_WIN1_VIR				0x00098
+#define PX30_WIN1_MST				0x000a0
+#define PX30_WIN1_DSP_INFO			0x000a4
+#define PX30_WIN1_DSP_ST			0x000a8
+#define PX30_WIN1_COLOR_KEY			0x000ac
+#define PX30_WIN1_ALPHA_CTRL			0x000bc
+#define PX30_HWC_CTRL0				0x000e0
+#define PX30_HWC_CTRL1				0x000e4
+#define PX30_HWC_MST				0x000e8
+#define PX30_HWC_DSP_ST				0x000ec
+#define PX30_HWC_ALPHA_CTRL			0x000f0
+#define PX30_DSP_HTOTAL_HS_END			0x00100
+#define PX30_DSP_HACT_ST_END			0x00104
+#define PX30_DSP_VTOTAL_VS_END			0x00108
+#define PX30_DSP_VACT_ST_END			0x0010c
+#define PX30_DSP_VS_ST_END_F1			0x00110
+#define PX30_DSP_VACT_ST_END_F1			0x00114
+#define PX30_BCSH_CTRL				0x00160
+#define PX30_BCSH_COL_BAR			0x00164
+#define PX30_BCSH_BCS				0x00168
+#define PX30_BCSH_H				0x0016c
+#define PX30_FRC_LOWER01_0			0x00170
+#define PX30_FRC_LOWER01_1			0x00174
+#define PX30_FRC_LOWER10_0			0x00178
+#define PX30_FRC_LOWER10_1			0x0017c
+#define PX30_FRC_LOWER11_0			0x00180
+#define PX30_FRC_LOWER11_1			0x00184
+#define PX30_MCU_RW_BYPASS_PORT			0x0018c
+#define PX30_WIN2_CTRL0				0x00190
+#define PX30_WIN2_CTRL1				0x00194
+#define PX30_WIN2_VIR0_1			0x00198
+#define PX30_WIN2_VIR2_3			0x0019c
+#define PX30_WIN2_MST0				0x001a0
+#define PX30_WIN2_DSP_INFO0			0x001a4
+#define PX30_WIN2_DSP_ST0			0x001a8
+#define PX30_WIN2_COLOR_KEY			0x001ac
+#define PX30_WIN2_ALPHA_CTRL			0x001bc
+#define PX30_BLANKING_VALUE			0x001f4
+#define PX30_FLAG_REG_FRM_VALID			0x001f8
+#define PX30_FLAG_REG				0x001fc
+#define PX30_HWC_LUT_ADDR			0x00600
+#define PX30_GAMMA_LUT_ADDR			0x00a00
+/* px30 register definition end */
+
 #endif /* _ROCKCHIP_VOP_REG_H */
-- 
2.7.4


