Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BF6C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE392082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbfAPIf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:35:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388753AbfAPIf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:35:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0032C0528B9;
        Wed, 16 Jan 2019 08:35:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-186.ams2.redhat.com [10.36.117.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B816F60BEC;
        Wed, 16 Jan 2019 08:35:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B7B72A213; Wed, 16 Jan 2019 09:35:21 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/qxl: add mode/framebuffer check functions
Date:   Wed, 16 Jan 2019 09:35:19 +0100
Message-Id: <20190116083521.22673-2-kraxel@redhat.com>
In-Reply-To: <20190116083521.22673-1-kraxel@redhat.com>
References: <20190116083521.22673-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 16 Jan 2019 08:35:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper functions to check video modes.  Also add a helper to check
framebuffer buffer objects, using the former for consistency.  That way
we should not fail in qxl_primary_atomic_check() because video modes
which are too big will not be added to the mode list in the first place.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1f8fddcc34..07a37d52c4 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -191,6 +191,21 @@ void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 	}
 }
 
+static int qxl_check_mode(struct qxl_device *qdev,
+			  unsigned int width,
+			  unsigned int height)
+{
+	if (width * height * 4 > qdev->vram_size)
+		return -ENOMEM;
+	return 0;
+}
+
+static int qxl_check_framebuffer(struct qxl_device *qdev,
+				 struct qxl_bo *bo)
+{
+	return qxl_check_mode(qdev, bo->surf.width, bo->surf.height);
+}
+
 static int qxl_add_monitors_config_modes(struct drm_connector *connector,
                                          unsigned *pwidth,
                                          unsigned *pheight)
@@ -466,12 +481,7 @@ static int qxl_primary_atomic_check(struct drm_plane *plane,
 
 	bo = gem_to_qxl_bo(state->fb->obj[0]);
 
-	if (bo->surf.stride * bo->surf.height > qdev->vram_size) {
-		DRM_ERROR("Mode doesn't fit in vram size (vgamem)");
-		return -EINVAL;
-	}
-
-	return 0;
+	return qxl_check_framebuffer(qdev, bo);
 }
 
 static int qxl_primary_apply_cursor(struct drm_plane *plane)
@@ -941,20 +951,11 @@ static enum drm_mode_status qxl_conn_mode_valid(struct drm_connector *connector,
 {
 	struct drm_device *ddev = connector->dev;
 	struct qxl_device *qdev = ddev->dev_private;
-	int i;
 
-	/* TODO: is this called for user defined modes? (xrandr --add-mode)
-	 * TODO: check that the mode fits in the framebuffer */
+	if (qxl_check_mode(qdev, mode->hdisplay, mode->vdisplay) != 0)
+		return MODE_BAD;
 
-	if (qdev->monitors_config_width == mode->hdisplay &&
-	    qdev->monitors_config_height == mode->vdisplay)
-		return MODE_OK;
-
-	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-		if (common_modes[i].w == mode->hdisplay && common_modes[i].h == mode->vdisplay)
-			return MODE_OK;
-	}
-	return MODE_BAD;
+	return MODE_OK;
 }
 
 static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
-- 
2.9.3

