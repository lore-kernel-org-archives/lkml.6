Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCOBCG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:02:06 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37945 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeCOBBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:01:52 -0400
X-Google-Smtp-Source: AG47ELu7aAmMXs8FKNXrM/ZgK37aQvcnGNcPzuB7U3v8sbg7XBv3uEgvInOK3OGtOybmS33KzOE2bw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] drm/tegra: dc: Dedicate overlay plane to cursor on older Tegra's
Date: Thu, 15 Mar 2018 04:00:25 +0300
Message-Id: <f48200af36c3358d549fc451fbc754c2a37b0d47.1521075485.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
In-Reply-To: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Tegra's do not support RGBA format for the cursor, but instead
overlay plane could be used for it. Since there is no much use for the
overlays on a regular desktop and HW-accelerated cursor is much better
than a SW cursor, let's dedicate one overlay plane to the mouse cursor.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 22bf513612d1..e4d567ec07cc 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -857,9 +857,11 @@ static const u32 tegra124_overlay_formats[] = {
 
 static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 						       struct tegra_dc *dc,
-						       unsigned int index)
+						       unsigned int index,
+						       bool cursor)
 {
 	unsigned long possible_crtcs = tegra_plane_get_possible_crtcs(drm);
+	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	struct tegra_plane *plane;
 	unsigned int num_formats;
 	const u32 *formats;
@@ -876,10 +878,12 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	num_formats = dc->soc->num_overlay_formats;
 	formats = dc->soc->overlay_formats;
 
+	if (cursor)
+		type = DRM_PLANE_TYPE_CURSOR;
+
 	err = drm_universal_plane_init(drm, &plane->base, possible_crtcs,
 				       &tegra_plane_funcs, formats,
-				       num_formats, NULL,
-				       DRM_PLANE_TYPE_OVERLAY, NULL);
+				       num_formats, NULL, type, NULL);
 	if (err < 0) {
 		kfree(plane);
 		return ERR_PTR(err);
@@ -931,6 +935,7 @@ static struct drm_plane *tegra_dc_add_planes(struct drm_device *drm,
 					     struct tegra_dc *dc)
 {
 	struct drm_plane *planes[2], *primary;
+	unsigned int planes_num;
 	unsigned int i;
 	int err;
 
@@ -938,8 +943,14 @@ static struct drm_plane *tegra_dc_add_planes(struct drm_device *drm,
 	if (IS_ERR(primary))
 		return primary;
 
-	for (i = 0; i < 2; i++) {
-		planes[i] = tegra_dc_overlay_plane_create(drm, dc, 1 + i);
+	if (dc->soc->supports_cursor)
+		planes_num = 2;
+	else
+		planes_num = 1;
+
+	for (i = 0; i < planes_num; i++) {
+		planes[i] = tegra_dc_overlay_plane_create(drm, dc, 1 + i,
+							  false);
 		if (IS_ERR(planes[i])) {
 			err = PTR_ERR(planes[i]);
 
@@ -1857,6 +1868,13 @@ static int tegra_dc_init(struct host1x_client *client)
 			err = PTR_ERR(cursor);
 			goto cleanup;
 		}
+	} else {
+		/* dedicate one overlay to mouse cursor */
+		cursor = tegra_dc_overlay_plane_create(drm, dc, 2, true);
+		if (IS_ERR(cursor)) {
+			err = PTR_ERR(cursor);
+			goto cleanup;
+		}
 	}
 
 	err = drm_crtc_init_with_planes(drm, &dc->base, primary, cursor,
-- 
2.16.1
