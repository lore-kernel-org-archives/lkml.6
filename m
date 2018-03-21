Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeCUPcg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:32:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47279 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbeCUPat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:30:49 -0400
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 07/10] drm/sun4i: Add support for YUV formats through the frontend
Date: Wed, 21 Mar 2018 16:29:01 +0100
Message-Id: <20180321152904.22411-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frontend supports many YUV formats as input and also contains a
color-space converter (CSC) block that can convert YUV input into
RGB output. It also allows scaling between the input and output for
every possible combination of supported formats.

This adds support for all the (untiled) YUV video formats supported by
the frontend, with associated changes in the backend and layer
management.

A specific dumb GEM create function translates a hardware constraint,
that the stride must be an even number, when allocating dumb (linear)
buffers.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  |  10 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c      |  11 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h      |   4 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 234 ++++++++++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  48 ++++++-
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  34 +++--
 6 files changed, 293 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index e8af9f3cf20b..3de7f3a427c3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -500,6 +500,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 			layer_state->uses_frontend = true;
 			num_frontend_planes++;
 		} else {
+			if (sun4i_format_is_yuv(fb->format->format)) {
+				DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
+				num_yuv_planes++;
+			}
+
 			layer_state->uses_frontend = false;
 		}
 
@@ -510,11 +515,6 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		if (fb->format->has_alpha)
 			num_alpha_planes++;
 
-		if (sun4i_format_is_yuv(fb->format->format)) {
-			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
-			num_yuv_planes++;
-		}
-
 		DRM_DEBUG_DRIVER("Plane zpos is %d\n",
 				 plane_state->normalized_zpos);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 3957c2ff6870..d374bb61c565 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -42,7 +42,7 @@ static struct drm_driver sun4i_drv_driver = {
 	.minor			= 0,
 
 	/* GEM Operations */
-	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_create		= drm_sun4i_gem_dumb_create,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops		= &drm_gem_cma_vm_ops,
 
@@ -60,6 +60,15 @@ static struct drm_driver sun4i_drv_driver = {
 	/* Frame Buffer Operations */
 };
 
+int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
+			      struct drm_device *drm,
+			      struct drm_mode_create_dumb *args)
+{
+	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), 2);
+
+	return drm_gem_cma_dumb_create_internal(file_priv, drm, args);
+}
+
 static void sun4i_remove_framebuffers(void)
 {
 	struct apertures_struct *ap;
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
index 5750b8ce8b31..47969711a889 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.h
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
@@ -23,4 +23,8 @@ struct sun4i_drv {
 	struct list_head	tcon_list;
 };
 
+int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
+			      struct drm_device *drm,
+			      struct drm_mode_create_dumb *args);
+
 #endif /* _SUN4I_DRV_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 2dc33383be22..d9e58e96119c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -16,6 +16,7 @@
 #include <linux/reset.h>
 
 #include "sun4i_drv.h"
+#include "sun4i_format.h"
 #include "sun4i_frontend.h"
 
 static const u32 sun4i_frontend_vert_coef[32] = {
@@ -89,26 +90,135 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	uint32_t format = fb->format->format;
+	uint32_t width, height;
+	uint32_t stride, offset;
+	bool swap;
 	dma_addr_t paddr;
 
-	/* Set the line width */
-	DRM_DEBUG_DRIVER("Frontend stride: %d bytes\n", fb->pitches[0]);
+	width = state->src_w >> 16;
+	height = state->src_h >> 16;
+
 	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
 		     fb->pitches[0]);
 
+	if (drm_format_num_planes(format) > 1)
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
+			     fb->pitches[1]);
+
+	if (drm_format_num_planes(format) > 2)
+		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
+			     fb->pitches[2]);
+
 	/* Set the physical address of the buffer in memory */
 	paddr = drm_fb_cma_get_gem_addr(fb, state, 0);
 	paddr -= PHYS_OFFSET;
-	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
+	DRM_DEBUG_DRIVER("Setting buffer #0 address to %pad\n", &paddr);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR0_REG, paddr);
+
+	/* Some planar formats require chroma channel swapping by hand. */
+	swap = sun4i_frontend_format_chroma_requires_swap(format);
+
+	if (drm_format_num_planes(format) > 1) {
+		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 2 : 1);
+		paddr -= PHYS_OFFSET;
+		DRM_DEBUG_DRIVER("Setting buffer #1 address to %pad\n", &paddr);
+		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR1_REG,
+			     paddr);
+	}
+
+	if (drm_format_num_planes(format) > 2) {
+		paddr = drm_fb_cma_get_gem_addr(fb, state, swap ? 1 : 2);
+		paddr -= PHYS_OFFSET;
+		DRM_DEBUG_DRIVER("Setting buffer #2 address to %pad\n", &paddr);
+		regmap_write(frontend->regs, SUN4I_FRONTEND_BUF_ADDR2_REG,
+			     paddr);
+	}
 }
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
 static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
+	if (sun4i_format_is_rgb(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
+	else if (sun4i_format_is_yuv411(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV411;
+	else if (sun4i_format_is_yuv420(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420;
+	else if (sun4i_format_is_yuv422(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422;
+	else if (sun4i_format_is_yuv444(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
+{
+	if (sun4i_format_is_packed(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
+	else if (sun4i_format_is_semiplanar(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR;
+	else if (sun4i_format_is_planar(fmt))
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
+{
+	/* Planar formats have an explicit input sequence. */
+	if (sun4i_format_is_planar(fmt)) {
+		*val = 0;
+		return 0;
+	}
+
 	switch (fmt) {
+	/* RGB */
 	case DRM_FORMAT_XRGB8888:
-		*val = 5;
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB;
+		return 0;
+
+	case DRM_FORMAT_BGRX8888:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
+		return 0;
+
+	/* YUV420 */
+	case DRM_FORMAT_NV12:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV;
+		return 0;
+
+	case DRM_FORMAT_NV21:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU;
+		return 0;
+
+	/* YUV422 */
+	case DRM_FORMAT_YUYV:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV;
+		return 0;
+
+	case DRM_FORMAT_VYUY:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY;
+		return 0;
+
+	case DRM_FORMAT_YVYU:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU;
+		return 0;
+
+	case DRM_FORMAT_UYVY:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY;
+		return 0;
+
+	case DRM_FORMAT_NV16:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV;
+		return 0;
+
+	case DRM_FORMAT_NV61:
+		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU;
 		return 0;
 
 	default:
@@ -120,7 +230,11 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-		*val = 2;
+		*val = SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888;
+		return 0;
+
+	case DRM_FORMAT_BGRX8888:
+		*val = SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_BGRX8888;
 		return 0;
 
 	default:
@@ -172,22 +286,52 @@ bool sun4i_frontend_format_is_supported(uint32_t fmt)
 	return true;
 }
 
+bool sun4i_frontend_format_chroma_requires_swap(uint32_t fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_YVU444:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YVU411:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	uint32_t format = fb->format->format;
 	u32 out_fmt_val;
 	u32 in_fmt_val;
+	u32 in_mod_val;
+	u32 in_ps_val;
+	u32 bypass;
+	unsigned int i;
 	int ret;
 
-	ret = sun4i_frontend_drm_format_to_input_fmt(fb->format->format,
-						     &in_fmt_val);
+	ret = sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input format\n");
 		return ret;
 	}
 
+	ret = sun4i_frontend_drm_format_to_input_mode(format, &in_mod_val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid input mode\n");
+		return ret;
+	}
+
+	ret = sun4i_frontend_drm_format_to_input_sequence(format, &in_ps_val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid pixel sequence\n");
+		return ret;
+	}
+
 	ret = sun4i_frontend_drm_format_to_output_fmt(out_fmt, &out_fmt_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid output format\n");
@@ -205,10 +349,30 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
 
+	if (sun4i_format_is_yuv(format) &&
+	    !sun4i_format_is_yuv(out_fmt)) {
+		/* Setup the CSC engine for YUV to RGB conversion. */
+
+		for (i = 0; i < ARRAY_SIZE(sunxi_bt601_yuv2rgb_coef); i++)
+			regmap_write(frontend->regs,
+				     SUN4I_FRONTEND_CSC_COEF_REG(i),
+				     sunxi_bt601_yuv2rgb_coef[i]);
+
+		regmap_update_bits(frontend->regs,
+				   SUN4I_FRONTEND_FRM_CTRL_REG,
+				   SUN4I_FRONTEND_FRM_CTRL_COEF_RDY,
+				   SUN4I_FRONTEND_FRM_CTRL_COEF_RDY);
+
+		bypass = 0;
+	} else {
+		bypass = SUN4I_FRONTEND_BYPASS_CSC_EN;
+	}
+
+	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_BYPASS_REG,
+			   SUN4I_FRONTEND_BYPASS_CSC_EN, bypass);
+
 	regmap_write(frontend->regs, SUN4I_FRONTEND_INPUT_FMT_REG,
-		     SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(1) |
-		     SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(in_fmt_val) |
-		     SUN4I_FRONTEND_INPUT_FMT_PS(1));
+		     in_mod_val | in_fmt_val | in_ps_val);
 
 	/*
 	 * TODO: It look like the A31 and A80 at least will need the
@@ -216,7 +380,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	 * ARGB8888).
 	 */
 	regmap_write(frontend->regs, SUN4I_FRONTEND_OUTPUT_FMT_REG,
-		     SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT(out_fmt_val));
+		     out_fmt_val);
 
 	return 0;
 }
@@ -226,31 +390,45 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct drm_framebuffer *fb = state->fb;
+	uint32_t format = fb->format->format;
+	uint32_t luma_width, luma_height;
+	uint32_t chroma_width, chroma_height;
 
 	/* Set height and width */
-	DRM_DEBUG_DRIVER("Frontend size W: %u H: %u\n",
+	DRM_DEBUG_DRIVER("Frontend crtc size W: %u H: %u\n",
 			 state->crtc_w, state->crtc_h);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_INSIZE_REG,
-		     SUN4I_FRONTEND_INSIZE(state->src_h >> 16,
-					   state->src_w >> 16));
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_INSIZE_REG,
-		     SUN4I_FRONTEND_INSIZE(state->src_h >> 16,
-					   state->src_w >> 16));
 
+	luma_width = chroma_width = state->src_w >> 16;
+	luma_height = chroma_height = state->src_h >> 16;
+
+	if (sun4i_format_is_yuv411(format)) {
+		chroma_width = DIV_ROUND_UP(luma_width, 4);
+	} else if (sun4i_format_is_yuv420(format)) {
+		chroma_width = DIV_ROUND_UP(luma_width, 2);
+		chroma_height = DIV_ROUND_UP(luma_height, 2);
+	} else if (sun4i_format_is_yuv422(format)) {
+		chroma_width = DIV_ROUND_UP(luma_width, 2);
+	}
+
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_INSIZE_REG,
+		     SUN4I_FRONTEND_INSIZE(luma_height, luma_width));
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_OUTSIZE_REG,
 		     SUN4I_FRONTEND_OUTSIZE(state->crtc_h, state->crtc_w));
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZFACT_REG,
+		     (luma_width << 16) / state->crtc_w);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTFACT_REG,
+		     (luma_height << 16) / state->crtc_h);
+
+	/* These also have to be specified, even for interleaved formats. */
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_INSIZE_REG,
+		     SUN4I_FRONTEND_INSIZE(chroma_height, chroma_width));
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_OUTSIZE_REG,
 		     SUN4I_FRONTEND_OUTSIZE(state->crtc_h, state->crtc_w));
-
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZFACT_REG,
-		     state->src_w / state->crtc_w);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZFACT_REG,
-		     state->src_w / state->crtc_w);
-
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTFACT_REG,
-		     state->src_h / state->crtc_h);
+		     (chroma_width << 16) / state->crtc_w);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTFACT_REG,
-		     state->src_h / state->crtc_h);
+		     (chroma_height << 16) / state->crtc_h);
 
 	regmap_write_bits(frontend->regs, SUN4I_FRONTEND_FRM_CTRL_REG,
 			  SUN4I_FRONTEND_FRM_CTRL_REG_RDY,
@@ -382,10 +560,6 @@ static int sun4i_frontend_runtime_resume(struct device *dev)
 			   SUN4I_FRONTEND_EN_EN,
 			   SUN4I_FRONTEND_EN_EN);
 
-	regmap_update_bits(frontend->regs, SUN4I_FRONTEND_BYPASS_REG,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN,
-			   SUN4I_FRONTEND_BYPASS_CSC_EN);
-
 	sun4i_frontend_scaler_init(frontend);
 
 	return 0;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index a9cb908ced16..6dd1d18752f4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -21,17 +21,56 @@
 #define SUN4I_FRONTEND_BYPASS_REG		0x008
 #define SUN4I_FRONTEND_BYPASS_CSC_EN			BIT(1)
 
+#define SUN4I_FRONTEND_AGTH_SEL_REG		0x00C
+#define SUN4I_FRONTEND_AGTH_SEL_ORIGINAL		BIT(8)
+
 #define SUN4I_FRONTEND_BUF_ADDR0_REG		0x020
+#define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
+#define SUN4I_FRONTEND_BUF_ADDR2_REG		0x028
+
+#define SUN4I_FRONTEND_TB_OFF0_REG		0x030
+#define SUN4I_FRONTEND_TB_OFF1_REG		0x034
+#define SUN4I_FRONTEND_TB_OFF2_REG		0x038
+
+#define SUN4I_FRONTEND_TB_OFF_X1(x1)			((x1) << 16)
+#define SUN4I_FRONTEND_TB_OFF_Y0(y0)			((y0) << 8)
+#define SUN4I_FRONTEND_TB_OFF_X0(x0)			(x0)
 
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
+#define SUN4I_FRONTEND_LINESTRD1_REG		0x044
+#define SUN4I_FRONTEND_LINESTRD2_REG		0x048
 
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
-#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD(mod)		((mod) << 8)
-#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT(fmt)		((fmt) << 4)
-#define SUN4I_FRONTEND_INPUT_FMT_PS(ps)			(ps)
+
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MASK			GENMASK(10, 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR		(0 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED		(1 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_SEMIPLANAR		(2 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_PLANAR		(4 << 8)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_MB32_SEMIPLANAR	(6 << 8)
+
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_MASK			GENMASK(6, 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV444		(0 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV422		(1 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV420		(2 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_YUV411		(3 << 4)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB			(5 << 4)
+
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_MASK			GENMASK(1, 0)
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UYVY			0
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YUYV			1
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VYUY			2
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_YVYU			3
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_UV			0
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_VU			1
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_XRGB			0
+#define SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX			1
 
 #define SUN4I_FRONTEND_OUTPUT_FMT_REG		0x05c
-#define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT(fmt)		(fmt)
+#define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_BGRX8888	1
+#define SUN4I_FRONTEND_OUTPUT_FMT_DATA_FMT_XRGB8888	2
+
+#define SUN4I_FRONTEND_CSC_COEF_REG(c)		(0x070 + (0x4 * (c)))
 
 #define SUN4I_FRONTEND_CH0_INSIZE_REG		0x100
 #define SUN4I_FRONTEND_INSIZE(h, w)			((((h) - 1) << 16) | (((w) - 1)))
@@ -96,5 +135,6 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt);
 bool sun4i_frontend_format_is_supported(uint32_t fmt);
+bool sun4i_frontend_format_chroma_requires_swap(uint32_t fmt);
 
 #endif /* _SUN4I_FRONTEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 15238211a61a..a39eed6a0e75 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -128,19 +128,37 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
-static const uint32_t sun4i_backend_layer_formats[] = {
-	DRM_FORMAT_ARGB8888,
+static const uint32_t sun4i_layer_formats[] = {
+	/* RGB */
 	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_RGBA4444,
 	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_RGBA5551,
-	DRM_FORMAT_RGBA4444,
-	DRM_FORMAT_RGB888,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_UYVY,
-	DRM_FORMAT_VYUY,
+	DRM_FORMAT_RGB888,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_ARGB8888,
+	/* YUV444 */
+	DRM_FORMAT_YUV444,
+	DRM_FORMAT_YVU444,
+	/* YUV422 */
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YVYU,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YVU422,
+	/* YUV420 */
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YVU420,
+	/* YUV411 */
+	DRM_FORMAT_YUV411,
+	DRM_FORMAT_YVU411,
 };
 
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
@@ -157,8 +175,8 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun4i_backend_layer_funcs,
-				       sun4i_backend_layer_formats,
-				       ARRAY_SIZE(sun4i_backend_layer_formats),
+				       sun4i_layer_formats,
+				       ARRAY_SIZE(sun4i_layer_formats),
 				       NULL, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
-- 
2.16.2
