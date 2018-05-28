Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165712AbeE1O1Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:27:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36990 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161787AbeE1O1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:27:20 -0400
X-Google-Smtp-Source: ADUXVKIxEG8xkTZug7dhFffp+qHpdPU+sgR5aQOdSxHm/dELNUWCxbIJcr4A177XlGgdrp7WM45ItA==
From: Emil Lundmark <lndmrk@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, Emil Lundmark <lndmrk@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?=
        <stephane.marchesin@gmail.com>
Subject: [PATCH v2] drm: udl: Destroy framebuffer only if it was initialized
Date: Mon, 28 May 2018 16:27:11 +0200
Message-Id: <20180528142711.142466-1-lndmrk@chromium.org>
In-Reply-To: <20180420115001.161745-1-lndmrk@chromium.org>
References: <20180420115001.161745-1-lndmrk@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a NULL pointer dereference that can happen if the UDL
driver is unloaded before the framebuffer is initialized. This can
happen e.g. if the USB device is unplugged right after it was plugged
in.

As explained by Stéphane Marchesin:

It happens when fbdev is disabled (which is the case for Chrome OS).
Even though intialization of the fbdev part is optional (it's done in
udlfb_create which is the callback for fb_probe()), the teardown isn't
optional (udl_driver_unload -> udl_fbdev_cleanup ->
udl_fbdev_destroy).

Note that udl_fbdev_cleanup *tries* to be conditional (you can see it
does if (!udl->fbdev)) but that doesn't work, because udl->fbdev is
always set during udl_fbdev_init.

Suggested-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
---
Changes in v2:
- Updated commit message with explanation from Stéphane Marchesin

 drivers/gpu/drm/udl/udl_fb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index 2ebdc6d5a76e..5754e37f741b 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -426,9 +426,11 @@ static void udl_fbdev_destroy(struct drm_device *dev,
 {
 	drm_fb_helper_unregister_fbi(&ufbdev->helper);
 	drm_fb_helper_fini(&ufbdev->helper);
-	drm_framebuffer_unregister_private(&ufbdev->ufb.base);
-	drm_framebuffer_cleanup(&ufbdev->ufb.base);
-	drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
+	if (ufbdev->ufb.obj) {
+		drm_framebuffer_unregister_private(&ufbdev->ufb.base);
+		drm_framebuffer_cleanup(&ufbdev->ufb.base);
+		drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
+	}
 }
 
 int udl_fbdev_init(struct drm_device *dev)
-- 
2.17.0.921.gf22659ad46-goog
