Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeCUPa7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:30:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47255 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbeCUPas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:30:48 -0400
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with the frontend
Date: Wed, 21 Mar 2018 16:28:57 +0100
Message-Id: <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the frontend is not capable of preserving the alpha
component (that is always set to 0xff), so only support XRGB8888
instead.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 +--
 drivers/gpu/drm/sun4i/sun4i_layer.c    | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index b98dafda52f8..274a1db6fa8e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -440,6 +440,10 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	if (IS_ERR(backend->frontend))
 		return false;
 
+	/*
+	 * TODO: Don't use the frontend for x2/x4 scaling and allow RGB formats
+	 * with an alpha component then.
+	 */
 	return sun4i_backend_plane_uses_scaler(state);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index ddf6cfa6dd23..3ea925584891 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -107,7 +107,7 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
-	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB8888:
 		*val = 5;
 		return 0;
 
@@ -120,7 +120,6 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-	case DRM_FORMAT_ARGB8888:
 		*val = 2;
 		return 0;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index eb93df445a10..15238211a61a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -100,9 +100,9 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 		sun4i_frontend_update_coord(frontend, plane);
 		sun4i_frontend_update_buffer(frontend, plane);
 		sun4i_frontend_update_formats(frontend, plane,
-					      DRM_FORMAT_ARGB8888);
+					      DRM_FORMAT_XRGB8888);
 		sun4i_backend_update_layer_frontend(backend, layer->id, plane,
-						    DRM_FORMAT_ARGB8888);
+						    DRM_FORMAT_XRGB8888);
 		sun4i_frontend_enable(frontend);
 	} else {
 		sun4i_backend_update_layer_formats(backend, layer->id, plane);
-- 
2.16.2
