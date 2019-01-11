Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F934C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3701320870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfAKFiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbfAKFh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:37:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C24F0432CA;
        Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABC095C26E;
        Fri, 11 Jan 2019 05:37:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 07CC19AD3; Fri, 11 Jan 2019 06:37:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 02/16] drm/bochs: split bochs_hw_setmode
Date:   Fri, 11 Jan 2019 06:37:38 +0100
Message-Id: <20190111053752.4004-3-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a separate bochs_hw_setformat function to configure
the framebuffer format (actually just the byteorder).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs.h     |  5 +++--
 drivers/gpu/drm/bochs/bochs_hw.c  | 19 ++++++++++++-------
 drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index fb38c8b857..4dc1b6384e 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -121,8 +121,9 @@ int bochs_hw_init(struct drm_device *dev);
 void bochs_hw_fini(struct drm_device *dev);
 
 void bochs_hw_setmode(struct bochs_device *bochs,
-		      struct drm_display_mode *mode,
-		      const struct drm_format_info *format);
+		      struct drm_display_mode *mode);
+void bochs_hw_setformat(struct bochs_device *bochs,
+			const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
 		      int x, int y, u64 addr);
 int bochs_hw_load_edid(struct bochs_device *bochs);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index d0b4e1cee8..3e04b2f0ec 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -204,8 +204,7 @@ void bochs_hw_fini(struct drm_device *dev)
 }
 
 void bochs_hw_setmode(struct bochs_device *bochs,
-		      struct drm_display_mode *mode,
-		      const struct drm_format_info *format)
+		      struct drm_display_mode *mode)
 {
 	bochs->xres = mode->hdisplay;
 	bochs->yres = mode->vdisplay;
@@ -213,12 +212,8 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
 	bochs->yres_virtual = bochs->fb_size / bochs->stride;
 
-	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, format %c%c%c%c, vy %d\n",
+	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, vy %d\n",
 			 bochs->xres, bochs->yres, bochs->bpp,
-			 (format->format >>  0) & 0xff,
-			 (format->format >>  8) & 0xff,
-			 (format->format >> 16) & 0xff,
-			 (format->format >> 24) & 0xff,
 			 bochs->yres_virtual);
 
 	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
@@ -236,6 +231,16 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,
 			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
+}
+
+void bochs_hw_setformat(struct bochs_device *bochs,
+			const struct drm_format_info *format)
+{
+	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
+			 (format->format >>  0) & 0xff,
+			 (format->format >>  8) & 0xff,
+			 (format->format >> 16) & 0xff,
+			 (format->format >> 24) & 0xff);
 
 	switch (format->format) {
 	case DRM_FORMAT_XRGB8888:
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index c8ce54498d..f7e6d1a9b3 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -80,7 +80,8 @@ static int bochs_crtc_mode_set(struct drm_crtc *crtc,
 	if (WARN_ON(crtc->primary->fb == NULL))
 		return -EINVAL;
 
-	bochs_hw_setmode(bochs, mode, crtc->primary->fb->format);
+	bochs_hw_setmode(bochs, mode);
+	bochs_hw_setformat(bochs, crtc->primary->fb->format);
 	bochs_crtc_mode_set_base(crtc, x, y, old_fb);
 	return 0;
 }
-- 
2.9.3

