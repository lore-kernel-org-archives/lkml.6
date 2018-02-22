Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeBVGJb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:09:31 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33313 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVGJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:09:30 -0500
X-Google-Smtp-Source: AH8x225YJAMh9n+KbIwX+XacfDEr16r2DDzHm8VvBqtA0940hJsBDniAP6QzDrIEX8FmpQfX8Jeqng==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@intel.com
Cc: gustavo@padovan.org, airlied@linux.ie, seanpaul@chromium.org,
        andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v1] drm/simple_kms_helper: Fix NULL pointer dereference with no active CRTC
Date: Thu, 22 Feb 2018 08:09:19 +0200
Message-Id: <1519279759-7803-1-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

It is possible that drm_simple_kms_plane_atomic_check called
with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
to 0 before doing any actual drawing. This leads to NULL pointer
dereference because in this case new CRTC state is NULL and must be
checked before accessing.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---
Changes since initial:
- re-worked checks for null CRTC as suggested by Daniel Vetter
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 9ca8a4a59b74..4a1dbd88b1ec 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -121,12 +121,6 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
 	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
 	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
 						   &pipe->crtc);
-	if (!crtc_state->enable)
-		return 0; /* nothing to check when disabling or disabled */
-
-	if (crtc_state->enable)
-		drm_mode_get_hv_timing(&crtc_state->mode,
-				       &clip.x2, &clip.y2);
 
 	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
 						  &clip,
@@ -137,7 +131,9 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
 		return ret;
 
 	if (!plane_state->visible)
-		return -EINVAL;
+		return 0;
+
+	drm_mode_get_hv_timing(&crtc_state->mode, &clip.x2, &clip.y2);
 
 	if (!pipe->funcs || !pipe->funcs->check)
 		return 0;
-- 
2.7.4
