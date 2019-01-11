Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8154FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5927220870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfAKFis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbfAKFiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:38:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A48211393C3;
        Fri, 11 Jan 2019 05:37:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9584768B1A;
        Fri, 11 Jan 2019 05:37:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D916B5EE5; Fri, 11 Jan 2019 06:37:54 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU)
Subject: [PATCH v4 16/16] drm/bochs: move remaining fb bits to kms
Date:   Fri, 11 Jan 2019 06:37:52 +0100
Message-Id: <20190111053752.4004-17-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 11 Jan 2019 05:37:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bochs_fbdev.c is almost empty now.  Move the remaining framebuffer bits
over to bochs_kms.c.  Pure code motion. No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c | 29 -----------------------------
 drivers/gpu/drm/bochs/bochs_kms.c   | 17 +++++++++++++++++
 drivers/gpu/drm/bochs/Makefile      |  2 +-
 3 files changed, 18 insertions(+), 30 deletions(-)
 delete mode 100644 drivers/gpu/drm/bochs/bochs_fbdev.c

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
deleted file mode 100644
index 7cac3f5253..0000000000
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include "bochs.h"
-#include <drm/drm_atomic_helper.h>
-#include <drm/drm_gem_framebuffer_helper.h>
-
-/* ---------------------------------------------------------------------- */
-
-static struct drm_framebuffer *
-bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
-		    const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
-	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
-		return ERR_PTR(-EINVAL);
-
-	return drm_gem_fb_create(dev, file, mode_cmd);
-}
-
-const struct drm_mode_config_funcs bochs_mode_funcs = {
-	.fb_create = bochs_gem_fb_create,
-	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
-};
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index fc856a02a2..e9d5dbc346 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -9,6 +9,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 static int defx = 1024;
 static int defy = 768;
@@ -256,6 +257,22 @@ static void bochs_connector_init(struct drm_device *dev)
 	}
 }
 
+static struct drm_framebuffer *
+bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
+		    const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
+		return ERR_PTR(-EINVAL);
+
+	return drm_gem_fb_create(dev, file, mode_cmd);
+}
+
+const struct drm_mode_config_funcs bochs_mode_funcs = {
+	.fb_create = bochs_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
 
 int bochs_kms_init(struct bochs_device *bochs)
 {
diff --git a/drivers/gpu/drm/bochs/Makefile b/drivers/gpu/drm/bochs/Makefile
index 98ef60a19e..e9e0f8f5eb 100644
--- a/drivers/gpu/drm/bochs/Makefile
+++ b/drivers/gpu/drm/bochs/Makefile
@@ -1,3 +1,3 @@
-bochs-drm-y := bochs_drv.o bochs_mm.o bochs_kms.o bochs_fbdev.o bochs_hw.o
+bochs-drm-y := bochs_drv.o bochs_mm.o bochs_kms.o bochs_hw.o
 
 obj-$(CONFIG_DRM_BOCHS)	+= bochs-drm.o
-- 
2.9.3

