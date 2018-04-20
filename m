Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeDTLux (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:50:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41089 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754619AbeDTLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:50:52 -0400
X-Google-Smtp-Source: AIpwx48aeOVXuDH5XOlSAOw3ZBoMAH+jY9xYZiwcBCsk65JT78ecIP2vMFS90BOaQ0p6j7pZ4TqBEA==
From: Emil Lundmark <lndmrk@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, Emil Lundmark <lndmrk@chromium.org>
Subject: [PATCH] drm: udl: Destroy framebuffer only if it was initialized
Date: Fri, 20 Apr 2018 13:50:01 +0200
Message-Id: <20180420115001.161745-1-lndmrk@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a NULL pointer dereference that can happen if the UDL
driver is unloaded before the framebuffer is initialized. This can
happen e.g. if the USB device is unplugged right after it was plugged
in.

Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
---
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
2.17.0.484.g0c8726318c-goog
