Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbeCUPct (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:32:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbeCUPat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH 05/10] drm/sun4i: Explicitly list and check formats supported by the frontend
Date: Wed, 21 Mar 2018 16:28:59 +0100
Message-Id: <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to check whether the frontend supports a specific format, an
explicit list and a related helper are introduced.

They are then used to determine whether the frontend can actually support
the requested format when it was selected to be used.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  |  5 ++++
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 44 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
 3 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 7703ba989743..1fad0714c70e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -532,6 +532,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		struct drm_format_name_buf format_name;
 
 		if (sun4i_backend_plane_uses_frontend(plane_state)) {
+			if (!sun4i_frontend_format_is_supported(fb->format->format)) {
+				DRM_DEBUG_DRIVER("Frontend plane check failed\n");
+				return -EINVAL;
+			}
+
 			DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
 					 plane->index);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 3ea925584891..2dc33383be22 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -128,6 +128,50 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 	}
 }
 
+static const uint32_t sun4i_frontend_formats[] = {
+	/* RGB */
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGRX8888,
+	/* YUV444 */
+	DRM_FORMAT_YUV444,
+	DRM_FORMAT_YVU444,
+	/* YUV422 */
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
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
+};
+
+bool sun4i_frontend_format_is_supported(uint32_t fmt)
+{
+	bool found = false;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun4i_frontend_formats); i++) {
+		if (sun4i_frontend_formats[i] == fmt) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return false;
+
+	return true;
+}
+
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt)
 {
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 02661ce81f3e..a9cb908ced16 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -95,5 +95,6 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane);
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt);
+bool sun4i_frontend_format_is_supported(uint32_t fmt);
 
 #endif /* _SUN4I_FRONTEND_H_ */
-- 
2.16.2
