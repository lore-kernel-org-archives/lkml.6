Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E473FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AEC2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AEC2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeKRDRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:17:13 -0500
Received: from kozue.soulik.info ([108.61.200.231]:45122 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKRDRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:17:12 -0500
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 5D7E71018E8;
        Sun, 18 Nov 2018 01:54:40 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, linux-kernel@vger.kernel.org,
        hjc@rock-chips.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>
Subject: [PATCH v4 2/2] drm/rockchip: Support 10 bits yuv format in vop
Date:   Sun, 18 Nov 2018 00:53:46 +0800
Message-Id: <20181117165346.25091-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181117165346.25091-1-ayaka@soulik.info>
References: <20181117165346.25091-1-ayaka@soulik.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip use fully packed pixel format variants
for YUV 10bits.

This patch only make the VOP accept this pixel format,
but it doesn't add the converting data path for
the color gamuts that the target display are supported.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 16 ++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fb70fb486fbf..9301006329e8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -238,6 +238,7 @@ static enum vop_data_format vop_convert_format(uint32_t format)
 	case DRM_FORMAT_BGR565:
 		return VOP_FMT_RGB565;
 	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV12_10LE40:
 		return VOP_FMT_YUV420SP;
 	case DRM_FORMAT_NV16:
 		return VOP_FMT_YUV422SP;
@@ -725,6 +726,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	dma_addr_t dma_addr;
 	uint32_t val;
 	bool rb_swap;
+	bool is_10_bits = false;
 	int win_index = VOP_WIN_TO_INDEX(vop_win);
 	int format;
 
@@ -743,6 +745,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	obj = fb->obj[0];
+	is_10_bits = is_yuv_10bit(fb->format->format);
+
 	rk_obj = to_rockchip_obj(obj);
 
 	actual_w = drm_rect_width(src) >> 16;
@@ -756,7 +760,11 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
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
 
@@ -767,6 +775,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, format, format);
 	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
 	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
+	VOP_WIN_SET(vop, win, fmt_10, is_10_bits);
 	if (fb->format->is_yuv) {
 		int hsub = drm_format_horz_chroma_subsampling(fb->format->format);
 		int vsub = drm_format_vert_chroma_subsampling(fb->format->format);
@@ -775,7 +784,10 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		uv_obj = fb->obj[1];
 		rk_uv_obj = to_rockchip_obj(uv_obj);
 
-		offset = (src->x1 >> 16) * bpp / hsub;
+		if (is_10_bits)
+			offset = (src->x1 >> 16) * (bpp * 5 / 4) / hsub;
+		else
+			offset = (src->x1 >> 16) * bpp / hsub;
 		offset += (src->y1 >> 16) * fb->pitches[1] / vsub;
 
 		dma_addr = rk_uv_obj->dma_addr + offset + fb->offsets[1];
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 0fe40e1983d9..1ab32d8be599 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -132,6 +132,7 @@ struct vop_win_phy {
 	struct vop_reg enable;
 	struct vop_reg gate;
 	struct vop_reg format;
+	struct vop_reg fmt_10;
 	struct vop_reg rb_swap;
 	struct vop_reg act_info;
 	struct vop_reg dsp_info;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 08fc40af52c8..6370f7d33273 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -50,6 +50,7 @@ static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV16,
 	DRM_FORMAT_NV24,
+	DRM_FORMAT_NV12_10LE40,
 };
 
 static const uint32_t formats_win_lite[] = {
@@ -428,6 +429,7 @@ static const struct vop_win_phy rk3288_win01_data = {
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
 	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
+	.fmt_10 = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 4),
 	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
 	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
-- 
2.14.5

