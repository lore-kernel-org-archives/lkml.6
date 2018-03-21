Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeCUPbE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:31:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47275 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbeCUPat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH 06/10] drm/sun4i: Move and extend format-related helpers and tables
Date: Wed, 21 Mar 2018 16:29:00 +0100
Message-Id: <20180321152904.22411-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the various helpers and tables related to format detection
and conversion to a dedicated file, while adding a bunch of new helpers
(especially for YUV and tiling support) along the way.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/Makefile        |   1 +
 drivers/gpu/drm/sun4i/sun4i_backend.c |  54 ++--------
 drivers/gpu/drm/sun4i/sun4i_format.c  | 193 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_format.h  |  35 ++++++
 4 files changed, 235 insertions(+), 48 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_format.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_format.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 582607c0c488..c89c42ff803e 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -4,6 +4,7 @@ sun4i-frontend-y		+= sun4i_frontend.o
 
 sun4i-drm-y			+= sun4i_drv.o
 sun4i-drm-y			+= sun4i_framebuffer.o
+sun4i-drm-y			+= sun4i_format.o
 
 sun4i-drm-hdmi-y		+= sun4i_hdmi_ddc_clk.o
 sun4i-drm-hdmi-y		+= sun4i_hdmi_enc.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 1fad0714c70e..e8af9f3cf20b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -29,6 +29,7 @@
 #include "sun4i_drv.h"
 #include "sun4i_frontend.h"
 #include "sun4i_layer.h"
+#include "sun4i_format.h"
 #include "sunxi_engine.h"
 
 struct sun4i_backend_quirks {
@@ -36,50 +37,6 @@ struct sun4i_backend_quirks {
 	bool needs_output_muxing;
 };
 
-static const u32 sunxi_rgb2yuv_coef[12] = {
-	0x00000107, 0x00000204, 0x00000064, 0x00000108,
-	0x00003f69, 0x00003ed6, 0x000001c1, 0x00000808,
-	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
-};
-
-static const u32 sunxi_bt601_yuv2rgb_coef[12] = {
-	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
-	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
-	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
-};
-
-static inline bool sun4i_backend_format_is_planar_yuv(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_YUV411:
-	case DRM_FORMAT_YUV422:
-	case DRM_FORMAT_YUV444:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static inline bool sun4i_backend_format_is_packed_yuv422(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_YUYV:
-	case DRM_FORMAT_YVYU:
-	case DRM_FORMAT_UYVY:
-	case DRM_FORMAT_VYUY:
-		return true;
-
-	default:
-		return false;
-	}
-}
-
-static inline bool sun4i_backend_format_is_yuv(uint32_t format)
-{
-	return sun4i_backend_format_is_planar_yuv(format) ||
-		sun4i_backend_format_is_packed_yuv422(format);
-}
-
 static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
 {
 	int i;
@@ -259,7 +216,7 @@ static int sun4i_backend_update_yuv_format(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN);
 
-	if (sun4i_backend_format_is_packed_yuv422(format))
+	if (sun4i_format_is_packed_yuv422(format))
 		val |= SUN4I_BACKEND_IYUVCTL_FBFMT_PACKED_YUV422;
 	else
 		DRM_DEBUG_DRIVER("Unknown YUV format\n");
@@ -310,7 +267,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 	DRM_DEBUG_DRIVER("Switching display backend interlaced mode %s\n",
 			 interlaced ? "on" : "off");
 
-	if (sun4i_backend_format_is_yuv(fb->format->format))
+	if (sun4i_format_is_yuv(fb->format->format))
 		return sun4i_backend_update_yuv_format(backend, layer, plane);
 
 	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
@@ -404,7 +361,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	 */
 	paddr -= PHYS_OFFSET;
 
-	if (sun4i_backend_format_is_yuv(fb->format->format))
+	if (sun4i_format_is_yuv(fb->format->format))
 		return sun4i_backend_update_yuv_buffer(backend, fb, paddr);
 
 	/* Write the 32 lower bits of the address (in bits) */
@@ -549,10 +506,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
 				 drm_get_format_name(fb->format->format,
 						     &format_name));
+
 		if (fb->format->has_alpha)
 			num_alpha_planes++;
 
-		if (sun4i_backend_format_is_yuv(fb->format->format)) {
+		if (sun4i_format_is_yuv(fb->format->format)) {
 			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
 			num_yuv_planes++;
 		}
diff --git a/drivers/gpu/drm/sun4i/sun4i_format.c b/drivers/gpu/drm/sun4i/sun4i_format.c
new file mode 100644
index 000000000000..3830767e6d5b
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_format.c
@@ -0,0 +1,193 @@
+/*
+ * Copyright (C) 2015-2018 Free Electrons/Bootlin
+ *
+ * Maxime Ripard <maxime.ripard@bootlin.com>
+ * Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/component.h>
+#include <linux/kfifo.h>
+#include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_of.h>
+
+#include "sun4i_drv.h"
+#include "sun4i_format.h"
+
+const u32 sunxi_rgb2yuv_coef[12] = {
+	0x00000107, 0x00000204, 0x00000064, 0x00000108,
+	0x00003f69, 0x00003ed6, 0x000001c1, 0x00000808,
+	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
+};
+
+const u32 sunxi_bt601_yuv2rgb_coef[12] = {
+	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
+	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
+	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
+};
+
+bool sun4i_format_is_rgb(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_ARGB4444:
+	case DRM_FORMAT_RGBA4444:
+	case DRM_FORMAT_ARGB1555:
+	case DRM_FORMAT_RGBA5551:
+	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_RGB565:
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_is_yuv(uint32_t format)
+{
+	return sun4i_format_is_yuv411(format) ||
+	       sun4i_format_is_yuv420(format) ||
+	       sun4i_format_is_yuv422(format) ||
+	       sun4i_format_is_yuv444(format);
+}
+
+bool sun4i_format_is_yuv411(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_YUV411:
+	case DRM_FORMAT_YVU411:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_is_yuv420(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
+	case DRM_FORMAT_YUV420:
+	case DRM_FORMAT_YVU420:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_is_yuv422(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_YUYV:
+	case DRM_FORMAT_YVYU:
+	case DRM_FORMAT_UYVY:
+	case DRM_FORMAT_VYUY:
+	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV61:
+	case DRM_FORMAT_YUV422:
+	case DRM_FORMAT_YVU422:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_is_yuv444(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_YUV444:
+	case DRM_FORMAT_YVU444:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_is_packed(uint32_t format)
+{
+	if (sun4i_format_is_rgb(format))
+		return true;
+
+	switch (format) {
+	case DRM_FORMAT_YUYV:
+	case DRM_FORMAT_YVYU:
+	case DRM_FORMAT_UYVY:
+	case DRM_FORMAT_VYUY:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_is_semiplanar(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
+	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV61:
+	case DRM_FORMAT_NV24:
+	case DRM_FORMAT_NV42:
+		return true;
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_is_planar(uint32_t format)
+{
+	switch (format) {
+	case DRM_FORMAT_YUV410:
+	case DRM_FORMAT_YVU410:
+	case DRM_FORMAT_YUV411:
+	case DRM_FORMAT_YVU411:
+	case DRM_FORMAT_YUV420:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YUV422:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YUV444:
+	case DRM_FORMAT_YVU444:
+		return true;
+	default:
+		return false;
+	}
+}
+
+bool sun4i_format_supports_tiling(uint32_t format)
+{
+	switch (format) {
+	/* Semiplanar */
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
+	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV61:
+	/* Planar */
+	case DRM_FORMAT_YUV420:
+	case DRM_FORMAT_YVU420:
+	case DRM_FORMAT_YUV422:
+	case DRM_FORMAT_YVU422:
+	case DRM_FORMAT_YUV411:
+	case DRM_FORMAT_YVU411:
+		return true;
+
+	default:
+		return false;
+	}
+}
diff --git a/drivers/gpu/drm/sun4i/sun4i_format.h b/drivers/gpu/drm/sun4i/sun4i_format.h
new file mode 100644
index 000000000000..1d6364cd3681
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun4i_format.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2015-2018 Free Electrons/Bootlin
+ *
+ * Maxime Ripard <maxime.ripard@bootlin.com>
+ * Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#ifndef _SUN4I_FORMAT_H_
+#define _SUN4I_FORMAT_H_
+
+extern const u32 sunxi_rgb2yuv_coef[12];
+extern const u32 sunxi_bt601_yuv2rgb_coef[12];
+
+bool sun4i_format_is_rgb(uint32_t format);
+bool sun4i_format_is_yuv(uint32_t format);
+bool sun4i_format_is_yuv411(uint32_t format);
+bool sun4i_format_is_yuv420(uint32_t format);
+bool sun4i_format_is_yuv422(uint32_t format);
+bool sun4i_format_is_yuv444(uint32_t format);
+bool sun4i_format_is_packed(uint32_t format);
+bool sun4i_format_is_semiplanar(uint32_t format);
+bool sun4i_format_is_planar(uint32_t format);
+bool sun4i_format_supports_tiling(uint32_t format);
+
+static inline bool sun4i_format_is_packed_yuv422(uint32_t format)
+{
+	return sun4i_format_is_packed(format) && sun4i_format_is_yuv422(format);
+}
+
+#endif /* _SUN4I_FORMAT_H_ */
-- 
2.16.2
