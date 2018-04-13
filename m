Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeDMJlE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:41:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753927AbeDMJlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:41:01 -0400
From: Thomas Huth <thuth@redhat.com>
To: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Farhan Ali <alifm@linux.ibm.com>, borntraeger@de.ibm.com
Subject: [PATCH 1/2] drm: Move CONFIG_HDMI-dependent code to a separate file
Date: Fri, 13 Apr 2018 11:40:55 +0200
Message-Id: <1523612456-14827-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1523612456-14827-1-git-send-email-thuth@redhat.com>
References: <1523612456-14827-1-git-send-email-thuth@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting CONFIG_HDMI for S390 is inappropriate - there is no real
graphic hardware on this architecture. The drm subsystem is only
enabled here for using the virtual graphics card "virtio-gpu". So
it should be possible to compile the drm subsystem also without
CONFIG_DRM. Let's move the related code to a separate file for this.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 drivers/gpu/drm/Kconfig             |   2 +-
 drivers/gpu/drm/Makefile            |   1 +
 drivers/gpu/drm/drm_crtc_internal.h |   2 +
 drivers/gpu/drm/drm_edid.c          | 163 +-------------------------------
 drivers/gpu/drm/drm_hdmi.c          | 182 ++++++++++++++++++++++++++++++++++++
 5 files changed, 188 insertions(+), 162 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_hdmi.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index deeefa7..298a518 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -8,7 +8,7 @@ menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
 	select DRM_PANEL_ORIENTATION_QUIRKS
-	select HDMI
+	select HDMI if !S390
 	select FB_CMDLINE
 	select I2C
 	select I2C_ALGOBIT
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 50093ff..16fd8e3 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -20,6 +20,7 @@ drm-y       :=	drm_auth.o drm_bufs.o drm_cache.o \
 		drm_dumb_buffers.o drm_mode_config.o drm_vblank.o \
 		drm_syncobj.o drm_lease.o
 
+drm-$(CONFIG_HDMI) += drm_hdmi.o
 drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
 drm-$(CONFIG_DRM_VM) += drm_vm.o
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 3c2b828..0804348 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -220,3 +220,5 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 
 /* drm_edid.c */
 void drm_mode_fixup_1366x768(struct drm_display_mode *mode);
+u8 drm_match_hdmi_mode(const struct drm_display_mode *to_match);
+bool drm_valid_hdmi_vic(u8 vic);
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 134069f..3820763 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -29,7 +29,6 @@
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/hdmi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/vga_switcheroo.h>
@@ -3062,7 +3061,7 @@ static u8 drm_match_hdmi_mode_clock_tolerance(const struct drm_display_mode *to_
  *
  * Returns the HDMI Video ID (VIC) of the mode or 0 if it isn't one.
  */
-static u8 drm_match_hdmi_mode(const struct drm_display_mode *to_match)
+u8 drm_match_hdmi_mode(const struct drm_display_mode *to_match)
 {
 	u8 vic;
 
@@ -3085,7 +3084,7 @@ static u8 drm_match_hdmi_mode(const struct drm_display_mode *to_match)
 	return 0;
 }
 
-static bool drm_valid_hdmi_vic(u8 vic)
+bool drm_valid_hdmi_vic(u8 vic)
 {
 	return vic > 0 && vic < ARRAY_SIZE(edid_4k_modes);
 }
@@ -4817,76 +4816,6 @@ void drm_set_preferred_mode(struct drm_connector *connector,
 EXPORT_SYMBOL(drm_set_preferred_mode);
 
 /**
- * drm_hdmi_avi_infoframe_from_display_mode() - fill an HDMI AVI infoframe with
- *                                              data from a DRM display mode
- * @frame: HDMI AVI infoframe
- * @mode: DRM display mode
- * @is_hdmi2_sink: Sink is HDMI 2.0 compliant
- *
- * Return: 0 on success or a negative error code on failure.
- */
-int
-drm_hdmi_avi_infoframe_from_display_mode(struct hdmi_avi_infoframe *frame,
-					 const struct drm_display_mode *mode,
-					 bool is_hdmi2_sink)
-{
-	int err;
-
-	if (!frame || !mode)
-		return -EINVAL;
-
-	err = hdmi_avi_infoframe_init(frame);
-	if (err < 0)
-		return err;
-
-	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
-		frame->pixel_repeat = 1;
-
-	frame->video_code = drm_match_cea_mode(mode);
-
-	/*
-	 * HDMI 1.4 VIC range: 1 <= VIC <= 64 (CEA-861-D) but
-	 * HDMI 2.0 VIC range: 1 <= VIC <= 107 (CEA-861-F). So we
-	 * have to make sure we dont break HDMI 1.4 sinks.
-	 */
-	if (!is_hdmi2_sink && frame->video_code > 64)
-		frame->video_code = 0;
-
-	/*
-	 * HDMI spec says if a mode is found in HDMI 1.4b 4K modes
-	 * we should send its VIC in vendor infoframes, else send the
-	 * VIC in AVI infoframes. Lets check if this mode is present in
-	 * HDMI 1.4b 4K modes
-	 */
-	if (frame->video_code) {
-		u8 vendor_if_vic = drm_match_hdmi_mode(mode);
-		bool is_s3d = mode->flags & DRM_MODE_FLAG_3D_MASK;
-
-		if (drm_valid_hdmi_vic(vendor_if_vic) && !is_s3d)
-			frame->video_code = 0;
-	}
-
-	frame->picture_aspect = HDMI_PICTURE_ASPECT_NONE;
-
-	/*
-	 * Populate picture aspect ratio from either
-	 * user input (if specified) or from the CEA mode list.
-	 */
-	if (mode->picture_aspect_ratio == HDMI_PICTURE_ASPECT_4_3 ||
-		mode->picture_aspect_ratio == HDMI_PICTURE_ASPECT_16_9)
-		frame->picture_aspect = mode->picture_aspect_ratio;
-	else if (frame->video_code > 0)
-		frame->picture_aspect = drm_get_cea_aspect_ratio(
-						frame->video_code);
-
-	frame->active_aspect = HDMI_ACTIVE_ASPECT_PICTURE;
-	frame->scan_mode = HDMI_SCAN_MODE_UNDERSCAN;
-
-	return 0;
-}
-EXPORT_SYMBOL(drm_hdmi_avi_infoframe_from_display_mode);
-
-/**
  * drm_hdmi_avi_infoframe_quant_range() - fill the HDMI AVI infoframe
  *                                        quantization range information
  * @frame: HDMI AVI infoframe
@@ -4945,94 +4874,6 @@ void drm_set_preferred_mode(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_hdmi_avi_infoframe_quant_range);
 
-static enum hdmi_3d_structure
-s3d_structure_from_display_mode(const struct drm_display_mode *mode)
-{
-	u32 layout = mode->flags & DRM_MODE_FLAG_3D_MASK;
-
-	switch (layout) {
-	case DRM_MODE_FLAG_3D_FRAME_PACKING:
-		return HDMI_3D_STRUCTURE_FRAME_PACKING;
-	case DRM_MODE_FLAG_3D_FIELD_ALTERNATIVE:
-		return HDMI_3D_STRUCTURE_FIELD_ALTERNATIVE;
-	case DRM_MODE_FLAG_3D_LINE_ALTERNATIVE:
-		return HDMI_3D_STRUCTURE_LINE_ALTERNATIVE;
-	case DRM_MODE_FLAG_3D_SIDE_BY_SIDE_FULL:
-		return HDMI_3D_STRUCTURE_SIDE_BY_SIDE_FULL;
-	case DRM_MODE_FLAG_3D_L_DEPTH:
-		return HDMI_3D_STRUCTURE_L_DEPTH;
-	case DRM_MODE_FLAG_3D_L_DEPTH_GFX_GFX_DEPTH:
-		return HDMI_3D_STRUCTURE_L_DEPTH_GFX_GFX_DEPTH;
-	case DRM_MODE_FLAG_3D_TOP_AND_BOTTOM:
-		return HDMI_3D_STRUCTURE_TOP_AND_BOTTOM;
-	case DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF:
-		return HDMI_3D_STRUCTURE_SIDE_BY_SIDE_HALF;
-	default:
-		return HDMI_3D_STRUCTURE_INVALID;
-	}
-}
-
-/**
- * drm_hdmi_vendor_infoframe_from_display_mode() - fill an HDMI infoframe with
- * data from a DRM display mode
- * @frame: HDMI vendor infoframe
- * @connector: the connector
- * @mode: DRM display mode
- *
- * Note that there's is a need to send HDMI vendor infoframes only when using a
- * 4k or stereoscopic 3D mode. So when giving any other mode as input this
- * function will return -EINVAL, error that can be safely ignored.
- *
- * Return: 0 on success or a negative error code on failure.
- */
-int
-drm_hdmi_vendor_infoframe_from_display_mode(struct hdmi_vendor_infoframe *frame,
-					    struct drm_connector *connector,
-					    const struct drm_display_mode *mode)
-{
-	/*
-	 * FIXME: sil-sii8620 doesn't have a connector around when
-	 * we need one, so we have to be prepared for a NULL connector.
-	 */
-	bool has_hdmi_infoframe = connector ?
-		connector->display_info.has_hdmi_infoframe : false;
-	int err;
-	u32 s3d_flags;
-	u8 vic;
-
-	if (!frame || !mode)
-		return -EINVAL;
-
-	if (!has_hdmi_infoframe)
-		return -EINVAL;
-
-	vic = drm_match_hdmi_mode(mode);
-	s3d_flags = mode->flags & DRM_MODE_FLAG_3D_MASK;
-
-	/*
-	 * Even if it's not absolutely necessary to send the infoframe
-	 * (ie.vic==0 and s3d_struct==0) we will still send it if we
-	 * know that the sink can handle it. This is based on a
-	 * suggestion in HDMI 2.0 Appendix F. Apparently some sinks
-	 * have trouble realizing that they shuld switch from 3D to 2D
-	 * mode if the source simply stops sending the infoframe when
-	 * it wants to switch from 3D to 2D.
-	 */
-
-	if (vic && s3d_flags)
-		return -EINVAL;
-
-	err = hdmi_vendor_infoframe_init(frame);
-	if (err < 0)
-		return err;
-
-	frame->vic = vic;
-	frame->s3d_struct = s3d_structure_from_display_mode(mode);
-
-	return 0;
-}
-EXPORT_SYMBOL(drm_hdmi_vendor_infoframe_from_display_mode);
-
 static int drm_parse_tiled_block(struct drm_connector *connector,
 				 struct displayid_block *block)
 {
diff --git a/drivers/gpu/drm/drm_hdmi.c b/drivers/gpu/drm/drm_hdmi.c
new file mode 100644
index 0000000..9ddf538
--- /dev/null
+++ b/drivers/gpu/drm/drm_hdmi.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (c) 2006 Luc Verhaegen (quirks list)
+ * Copyright (c) 2007-2008 Intel Corporation
+ *   Jesse Barnes <jesse.barnes@intel.com>
+ * Copyright 2010 Red Hat, Inc.
+ *
+ * DDC probing routines (drm_ddc_read & drm_do_probe_ddc_edid) originally from
+ * FB layer.
+ *   Copyright (C) 2006 Dennis Munsie <dmunsie@cecropia.com>
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/hdmi.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/vga_switcheroo.h>
+#include <drm/drmP.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_displayid.h>
+#include <drm/drm_scdc_helper.h>
+
+#include "drm_crtc_internal.h"
+
+/**
+ * drm_hdmi_avi_infoframe_from_display_mode() - fill an HDMI AVI infoframe with
+ *                                              data from a DRM display mode
+ * @frame: HDMI AVI infoframe
+ * @mode: DRM display mode
+ * @is_hdmi2_sink: Sink is HDMI 2.0 compliant
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int
+drm_hdmi_avi_infoframe_from_display_mode(struct hdmi_avi_infoframe *frame,
+					 const struct drm_display_mode *mode,
+					 bool is_hdmi2_sink)
+{
+	int err;
+
+	if (!frame || !mode)
+		return -EINVAL;
+
+	err = hdmi_avi_infoframe_init(frame);
+	if (err < 0)
+		return err;
+
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
+		frame->pixel_repeat = 1;
+
+	frame->video_code = drm_match_cea_mode(mode);
+
+	/*
+	 * HDMI 1.4 VIC range: 1 <= VIC <= 64 (CEA-861-D) but
+	 * HDMI 2.0 VIC range: 1 <= VIC <= 107 (CEA-861-F). So we
+	 * have to make sure we dont break HDMI 1.4 sinks.
+	 */
+	if (!is_hdmi2_sink && frame->video_code > 64)
+		frame->video_code = 0;
+
+	/*
+	 * HDMI spec says if a mode is found in HDMI 1.4b 4K modes
+	 * we should send its VIC in vendor infoframes, else send the
+	 * VIC in AVI infoframes. Lets check if this mode is present in
+	 * HDMI 1.4b 4K modes
+	 */
+	if (frame->video_code) {
+		u8 vendor_if_vic = drm_match_hdmi_mode(mode);
+		bool is_s3d = mode->flags & DRM_MODE_FLAG_3D_MASK;
+
+		if (drm_valid_hdmi_vic(vendor_if_vic) && !is_s3d)
+			frame->video_code = 0;
+	}
+
+	frame->picture_aspect = HDMI_PICTURE_ASPECT_NONE;
+
+	/*
+	 * Populate picture aspect ratio from either
+	 * user input (if specified) or from the CEA mode list.
+	 */
+	if (mode->picture_aspect_ratio == HDMI_PICTURE_ASPECT_4_3 ||
+		mode->picture_aspect_ratio == HDMI_PICTURE_ASPECT_16_9)
+		frame->picture_aspect = mode->picture_aspect_ratio;
+	else if (frame->video_code > 0)
+		frame->picture_aspect = drm_get_cea_aspect_ratio(
+						frame->video_code);
+
+	frame->active_aspect = HDMI_ACTIVE_ASPECT_PICTURE;
+	frame->scan_mode = HDMI_SCAN_MODE_UNDERSCAN;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_hdmi_avi_infoframe_from_display_mode);
+
+static enum hdmi_3d_structure
+s3d_structure_from_display_mode(const struct drm_display_mode *mode)
+{
+	u32 layout = mode->flags & DRM_MODE_FLAG_3D_MASK;
+
+	switch (layout) {
+	case DRM_MODE_FLAG_3D_FRAME_PACKING:
+		return HDMI_3D_STRUCTURE_FRAME_PACKING;
+	case DRM_MODE_FLAG_3D_FIELD_ALTERNATIVE:
+		return HDMI_3D_STRUCTURE_FIELD_ALTERNATIVE;
+	case DRM_MODE_FLAG_3D_LINE_ALTERNATIVE:
+		return HDMI_3D_STRUCTURE_LINE_ALTERNATIVE;
+	case DRM_MODE_FLAG_3D_SIDE_BY_SIDE_FULL:
+		return HDMI_3D_STRUCTURE_SIDE_BY_SIDE_FULL;
+	case DRM_MODE_FLAG_3D_L_DEPTH:
+		return HDMI_3D_STRUCTURE_L_DEPTH;
+	case DRM_MODE_FLAG_3D_L_DEPTH_GFX_GFX_DEPTH:
+		return HDMI_3D_STRUCTURE_L_DEPTH_GFX_GFX_DEPTH;
+	case DRM_MODE_FLAG_3D_TOP_AND_BOTTOM:
+		return HDMI_3D_STRUCTURE_TOP_AND_BOTTOM;
+	case DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF:
+		return HDMI_3D_STRUCTURE_SIDE_BY_SIDE_HALF;
+	default:
+		return HDMI_3D_STRUCTURE_INVALID;
+	}
+}
+
+/**
+ * drm_hdmi_vendor_infoframe_from_display_mode() - fill an HDMI infoframe with
+ * data from a DRM display mode
+ * @frame: HDMI vendor infoframe
+ * @connector: the connector
+ * @mode: DRM display mode
+ *
+ * Note that there's is a need to send HDMI vendor infoframes only when using a
+ * 4k or stereoscopic 3D mode. So when giving any other mode as input this
+ * function will return -EINVAL, error that can be safely ignored.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int
+drm_hdmi_vendor_infoframe_from_display_mode(struct hdmi_vendor_infoframe *frame,
+					    struct drm_connector *connector,
+					    const struct drm_display_mode *mode)
+{
+	/*
+	 * FIXME: sil-sii8620 doesn't have a connector around when
+	 * we need one, so we have to be prepared for a NULL connector.
+	 */
+	bool has_hdmi_infoframe = connector ?
+		connector->display_info.has_hdmi_infoframe : false;
+	int err;
+	u32 s3d_flags;
+	u8 vic;
+
+	if (!frame || !mode)
+		return -EINVAL;
+
+	if (!has_hdmi_infoframe)
+		return -EINVAL;
+
+	vic = drm_match_hdmi_mode(mode);
+	s3d_flags = mode->flags & DRM_MODE_FLAG_3D_MASK;
+
+	/*
+	 * Even if it's not absolutely necessary to send the infoframe
+	 * (ie.vic==0 and s3d_struct==0) we will still send it if we
+	 * know that the sink can handle it. This is based on a
+	 * suggestion in HDMI 2.0 Appendix F. Apparently some sinks
+	 * have trouble realizing that they shuld switch from 3D to 2D
+	 * mode if the source simply stops sending the infoframe when
+	 * it wants to switch from 3D to 2D.
+	 */
+
+	if (vic && s3d_flags)
+		return -EINVAL;
+
+	err = hdmi_vendor_infoframe_init(frame);
+	if (err < 0)
+		return err;
+
+	frame->vic = vic;
+	frame->s3d_struct = s3d_structure_from_display_mode(mode);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_hdmi_vendor_infoframe_from_display_mode);
-- 
1.8.3.1
