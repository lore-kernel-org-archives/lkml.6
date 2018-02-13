Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933787AbeBMIo2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:44:28 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44094 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933631AbeBMIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:44:26 -0500
X-Google-Smtp-Source: AH8x225wb2P8/HL/KCYHJ3sMREEWHGOBWAtdjeerk3guh/ZtDfIH04yFtUwlHXvgyTRleMGXMKdQ0Q==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: daniel.vetter@intel.com, gustavo@padovan.org, airlied@linux.ie,
        seanpaul@chromium.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] drm/simple_kms_helper: Fix NULL pointer dereference with no active CRTC
Date: Tue, 13 Feb 2018 10:44:16 +0200
Message-Id: <1518511456-28257-1-git-send-email-andr2000@gmail.com>
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
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 9ca8a4a59b74..a05eca9cec8b 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -121,8 +121,10 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
 	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
 	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
 						   &pipe->crtc);
-	if (!crtc_state->enable)
-		return 0; /* nothing to check when disabling or disabled */
+
+	if (!crtc_state || !crtc_state->enable)
+		/* nothing to check when disabling or disabled or no CRTC set */
+		return 0;
 
 	if (crtc_state->enable)
 		drm_mode_get_hv_timing(&crtc_state->mode,
-- 
2.7.4
