Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4275FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CBD20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CBD20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeICPRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:17:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeICPRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:17:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B472801145A;
        Mon,  3 Sep 2018 10:58:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E18C063539;
        Mon,  3 Sep 2018 10:57:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4521B1746F; Mon,  3 Sep 2018 12:57:58 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/bochs: fix DRM_FORMAT_* handling for big endian machines.
Date:   Mon,  3 Sep 2018 12:57:55 +0200
Message-Id: <20180903105756.24912-5-kraxel@redhat.com>
In-Reply-To: <20180903105756.24912-1-kraxel@redhat.com>
References: <20180903105756.24912-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 10:58:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 10:58:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DRM_FORMAT_HOST_XRGB8888, so we are using the correct format code
on bigendian machines.  Also add DRIVER_PREFER_HOST_BYTE_ORDER driver
feature flag so drm_mode_addfb() asks for the correct format code.

Create our own plane and use drm_crtc_init_with_planes() instead of
depending on the default created by drm_crtc_init().  That way the plane
format list is correct on bigendian machines.

With this patch applied both ADDFB and ADDFB2 ioctls work correctly in
the bochs-drm.ko driver on big endian machines.  Without the patch only
ADDFB (which still seems to be used by the majority of userspace) works
correctly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c   |  3 ++-
 drivers/gpu/drm/bochs/bochs_fbdev.c |  5 ++---
 drivers/gpu/drm/bochs/bochs_kms.c   | 33 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/bochs/bochs_mm.c    |  2 +-
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 7b20318483..fa84a3c841 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -81,7 +81,8 @@ static const struct file_operations bochs_fops = {
 };
 
 static struct drm_driver bochs_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET,
+	.driver_features	= (DRIVER_GEM | DRIVER_MODESET |
+				   DRIVER_PREFER_HOST_BYTE_ORDER),
 	.load			= bochs_load,
 	.unload			= bochs_unload,
 	.fops			= &bochs_fops,
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 14eb8d0d5a..bf728790fa 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -64,9 +64,8 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = mode_cmd.width * ((sizes->surface_bpp + 7) / 8);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
+	mode_cmd.pitches[0] = sizes->surface_width * 4;
+	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
 	size = mode_cmd.pitches[0] * mode_cmd.height;
 
 	/* alloc, pin & map bo */
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index ca5a9afdd5..2662cdcf2d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -129,12 +129,43 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.commit = bochs_crtc_commit,
 };
 
+static const uint32_t bochs_formats[] = {
+	DRM_FORMAT_HOST_XRGB8888,
+};
+
+static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
+{
+	struct drm_plane *primary;
+	int ret;
+
+	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
+	if (primary == NULL) {
+		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
+		return NULL;
+	}
+
+	ret = drm_universal_plane_init(dev, primary, 0,
+				       &drm_primary_helper_funcs,
+				       bochs_formats,
+				       ARRAY_SIZE(bochs_formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret) {
+		kfree(primary);
+		primary = NULL;
+	}
+
+	return primary;
+}
+
 static void bochs_crtc_init(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
 	struct drm_crtc *crtc = &bochs->crtc;
+	struct drm_plane *primary = bochs_primary_plane(dev);
 
-	drm_crtc_init(dev, crtc, &bochs_crtc_funcs);
+	drm_crtc_init_with_planes(dev, crtc, primary, NULL,
+				  &bochs_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
 }
 
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index c9c7097030..fdf151fbdb 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -506,7 +506,7 @@ bochs_user_framebuffer_create(struct drm_device *dev,
 	       (mode_cmd->pixel_format >> 16) & 0xff,
 	       (mode_cmd->pixel_format >> 24) & 0xff);
 
-	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888)
+	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888)
 		return ERR_PTR(-ENOENT);
 
 	obj = drm_gem_object_lookup(filp, mode_cmd->handles[0]);
-- 
2.9.3

