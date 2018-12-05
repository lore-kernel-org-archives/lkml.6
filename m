Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988E1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5029320850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5029320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeLENwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:52:55 -0500
Received: from kozue.soulik.info ([108.61.200.231]:38744 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLENwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:52:54 -0500
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:f0e])
        by kozue.soulik.info (Postfix) with ESMTPA id EB1AB1001C5;
        Wed,  5 Dec 2018 22:52:46 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     dri-devel@lists.freedesktop.org
Cc:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ayaka <ayaka@soulik.info>
Subject: [PATCH v3] drm/rockchip: support hwc layer
Date:   Wed,  5 Dec 2018 21:52:30 +0800
Message-Id: <20181205135230.17677-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ayaka <ayaka@soulik.info>

The Windows 2/3 or a RGB UI layer is a high performance flexibly
plane. It is too waste to use it as a cursor plane.

I have verified this patch with weston git version, I am not
sure whether X would meet with this patch. As the previous
author is gone, I can't confirm this problem with him.

Also the weston only use the only two achors with a same
size and pixel format, I need more users to verify this
patch.

changelog:
v2: the previous version is mixed with the code for the other
patches, I forget to remove it.
v3: fix the error for the rk3399 vop little.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 20 ++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fb70fb486fbf..1a3b72391ee8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -751,6 +751,26 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 
 	dsp_info = (drm_rect_height(dest) - 1) << 16;
 	dsp_info |= (drm_rect_width(dest) - 1) & 0xffff;
+	/* HWC layer only supports various of square icon */
+	if (plane->type == DRM_PLANE_TYPE_CURSOR) {
+		switch (actual_w) {
+		case 32:
+			dsp_info = 0;
+			break;
+		case 64:
+			dsp_info = 0x1;
+			break;
+		case 94:
+			dsp_info = 0x10;
+			break;
+		case 128:
+			dsp_info = 0x11;
+			break;
+		/* Unsupported pixel resolution */
+		default:
+			return;
+		}
+	}
 
 	dsp_stx = dest->x1 + crtc->mode.htotal - crtc->mode.hsync_start;
 	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 08fc40af52c8..694f43fdeb23 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -63,6 +63,15 @@ static const uint32_t formats_win_lite[] = {
 	DRM_FORMAT_BGR565,
 };
 
+static const uint32_t formats_win_hwc[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+};
+
 static const struct vop_scl_regs rk3036_win_scl = {
 	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
@@ -456,6 +465,19 @@ static const struct vop_win_phy rk3288_win23_data = {
 	.dst_alpha_ctl = VOP_REG(RK3288_WIN2_DST_ALPHA_CTRL, 0xff, 0),
 };
 
+static const struct vop_win_phy rk3288_winhwc_data = {
+	.data_formats = formats_win_hwc,
+	.nformats = ARRAY_SIZE(formats_win_hwc),
+	.enable = VOP_REG(RK3288_HWC_CTRL0, 0x1, 0),
+	.format = VOP_REG(RK3288_HWC_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(RK3288_HWC_CTRL0, 0x1, 12),
+	.dsp_info = VOP_REG(RK3288_HWC_CTRL0, 0x3, 5),
+	.dsp_st = VOP_REG(RK3288_HWC_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_HWC_MST, 0xffffffff, 0),
+	.src_alpha_ctl = VOP_REG(RK3288_HWC_SRC_ALPHA_CTRL, 0xffff, 0),
+	.dst_alpha_ctl = VOP_REG(RK3288_HWC_DST_ALPHA_CTRL, 0xffffffff, 0),
+};
+
 static const struct vop_modeset rk3288_modeset = {
 	.htotal_pw = VOP_REG(RK3288_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
 	.hact_st_end = VOP_REG(RK3288_DSP_HACT_ST_END, 0x1fff1fff, 0),
@@ -500,7 +522,10 @@ static const struct vop_win_data rk3288_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3288_win23_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x50, .phy = &rk3288_win23_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const int rk3288_vop_intrs[] = {
@@ -573,7 +598,10 @@ static const struct vop_win_data rk3368_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3368_win23_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x50, .phy = &rk3368_win23_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const struct vop_output rk3368_output = {
@@ -653,7 +681,10 @@ static const struct vop_win_data rk3399_vop_lit_win_data[] = {
 	{ .base = 0x00, .phy = &rk3288_win01_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3368_win23_data,
-	  .type = DRM_PLANE_TYPE_CURSOR},
+	  .type = DRM_PLANE_TYPE_OVERLAY},
+	{ .base = 0x00, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const struct vop_data rk3399_vop_lit = {
@@ -735,7 +766,10 @@ static const struct vop_win_data rk3328_vop_win_data[] = {
 	{ .base = 0x1d0, .phy = &rk3288_win01_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x2d0, .phy = &rk3288_win01_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x3d0, .phy = &rk3288_winhwc_data,
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	},
 };
 
 static const struct vop_data rk3328_vop = {
-- 
2.14.5

