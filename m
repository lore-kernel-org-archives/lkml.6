Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeETRXV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:23:21 -0400
Received: from kozue.soulik.info ([108.61.200.231]:37402 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeETRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:23:14 -0400
From: Randy Li <ayaka@soulik.info>
To: dri-devel@lists.freedesktop.org
Cc: Randy Li <ayaka@soulik.info>, hjc@rock-chips.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.dufresne@collabora.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie
Subject: [PATCH 2/2] drm/rockchip: Support 10 bits yuv format in vop
Date: Mon, 21 May 2018 01:17:05 +0800
Message-Id: <20180520171705.29690-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180520171705.29690-1-ayaka@soulik.info>
References: <20180520171705.29690-1-ayaka@soulik.info>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip use fully packed pixel format variants
for YUV 10bits.

This patch only make the VOP accept this pixel format,
but it doesn't add the converting data path for
the color gamuts that the target display are supported.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 27 +++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 2121345a61af..6a54b20501ac 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -232,6 +232,7 @@ static enum vop_data_format vop_convert_format(uint32_t format)
 	case DRM_FORMAT_BGR565:
 		return VOP_FMT_RGB565;
 	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV12_10LE40:
 		return VOP_FMT_YUV420SP;
 	case DRM_FORMAT_NV16:
 		return VOP_FMT_YUV422SP;
@@ -249,6 +250,17 @@ static bool is_yuv_support(uint32_t format)
 	case DRM_FORMAT_NV12:
 	case DRM_FORMAT_NV16:
 	case DRM_FORMAT_NV24:
+	case DRM_FORMAT_NV12_10LE40:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool is_yuv_10bit(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV12_10LE40:
 		return true;
 	default:
 		return false;
@@ -711,6 +723,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	dma_addr_t dma_addr;
 	uint32_t val;
 	bool rb_swap;
+	bool is_10_bits = false;
 	int win_index = VOP_WIN_TO_INDEX(vop_win);
 	int format;
 
@@ -728,6 +741,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
+	is_10_bits = is_yuv_10bit(fb->format->format);
+
 	obj = rockchip_fb_get_gem_obj(fb, 0);
 	rk_obj = to_rockchip_obj(obj);
 
@@ -742,7 +757,11 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	dsp_sty = dest->y1 + crtc->mode.vtotal - crtc->mode.vsync_start;
 	dsp_st = dsp_sty << 16 | (dsp_stx & 0xffff);
 
-	offset = (src->x1 >> 16) * fb->format->cpp[0];
+	if (is_10_bits)
+		offset = (src->x1 >> 16) * (fb->format->cpp[0] * 5 / 4);
+	else
+		offset = (src->x1 >> 16) * fb->format->cpp[0];
+
 	offset += (src->y1 >> 16) * fb->pitches[0];
 	dma_addr = rk_obj->dma_addr + offset + fb->offsets[0];
 
@@ -753,6 +772,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, format, format);
 	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
 	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
+	VOP_WIN_SET(vop, win, fmt_10, is_10_bits);
 	if (is_yuv_support(fb->format->format)) {
 		int hsub = drm_format_horz_chroma_subsampling(fb->format->format);
 		int vsub = drm_format_vert_chroma_subsampling(fb->format->format);
@@ -761,7 +781,10 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		uv_obj = rockchip_fb_get_gem_obj(fb, 1);
 		rk_uv_obj = to_rockchip_obj(uv_obj);
 
-		offset = (src->x1 >> 16) * bpp / hsub;
+		if (is_10_bits)
+			offset = (src->x1 >> 16) * (bpp * 5 / 4) / hsub;
+		else
+			offset = (src->x1 >> 16) * bpp / hsub;
 		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
 
 		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 084acdd0019a..d9ec993f420a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -131,6 +131,7 @@ struct vop_win_phy {
 	struct vop_reg enable;
 	struct vop_reg gate;
 	struct vop_reg format;
+	struct vop_reg fmt_10;
 	struct vop_reg rb_swap;
 	struct vop_reg act_info;
 	struct vop_reg dsp_info;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 08023d3ecb76..5393886ddd95 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -50,6 +50,7 @@ static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV16,
 	DRM_FORMAT_NV24,
+	DRM_FORMAT_NV12_10LE40,
 };
 
 static const uint32_t formats_win_lite[] = {
@@ -215,6 +216,7 @@ static const struct vop_win_phy rk3288_win01_data = {
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
+	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
 	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
 	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
-- 
2.14.3
