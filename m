Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F68FECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDB12150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDB12150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbeISQuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:50:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731206AbeISQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:50:23 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA7263082DD0;
        Wed, 19 Sep 2018 11:12:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2D842010D59;
        Wed, 19 Sep 2018 11:12:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C49699C421; Wed, 19 Sep 2018 13:12:52 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/5] drm/bochs: fix DRM_FORMAT_* handling for big endian machines.
Date:   Wed, 19 Sep 2018 13:12:50 +0200
Message-Id: <20180919111252.7932-4-kraxel@redhat.com>
In-Reply-To: <20180919111252.7932-1-kraxel@redhat.com>
References: <20180919111252.7932-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 19 Sep 2018 11:12:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DRM_FORMAT_HOST_XRGB8888, so we are using the correct format code
on bigendian machines.  Also set the quirk_addfb_prefer_host_byte_order
mode_config bit so drm_mode_addfb() asks for the correct format code.

Create our own plane and use drm_crtc_init_with_planes() instead of
depending on the default created by drm_crtc_init().  That way the plane
format list is correct on bigendian machines.

Also re-add the framebuffer format check dropped by "df2052cc92 bochs:
convert to drm_fb_helper_fbdev_setup/teardown".

With this patch applied both ADDFB and ADDFB2 ioctls work correctly in
the bochs-drm.ko driver on big endian machines.  Without the patch only
ADDFB (which still seems to be used by the majority of userspace) works
correctly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c | 17 +++++++++++++----
 drivers/gpu/drm/bochs/bochs_kms.c   | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 8f4d6c052f..c46fdae44e 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -63,9 +63,8 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = mode_cmd.width * ((sizes->surface_bpp + 7) / 8);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
+	mode_cmd.pitches[0] = sizes->surface_width * 4;
+	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
 	size = mode_cmd.pitches[0] * mode_cmd.height;
 
 	/* alloc, pin & map bo */
@@ -137,8 +136,18 @@ static const struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
 	.fb_probe = bochsfb_create,
 };
 
+static struct drm_framebuffer *
+bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
+		    const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888)
+		return ERR_PTR(-EINVAL);
+
+	return drm_gem_fb_create(dev, file, mode_cmd);
+}
+
 const struct drm_mode_config_funcs bochs_mode_funcs = {
-	.fb_create = drm_gem_fb_create,
+	.fb_create = bochs_gem_fb_create,
 };
 
 int bochs_fbdev_init(struct bochs_device *bochs)
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index ea9a43d31b..f3fdaf9456 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -126,12 +126,43 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
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
 
@@ -250,6 +281,7 @@ int bochs_kms_init(struct bochs_device *bochs)
 	bochs->dev->mode_config.fb_base = bochs->fb_base;
 	bochs->dev->mode_config.preferred_depth = 24;
 	bochs->dev->mode_config.prefer_shadow = 0;
+	bochs->dev->mode_config.quirk_addfb_prefer_host_byte_order = true;
 
 	bochs->dev->mode_config.funcs = &bochs_mode_funcs;
 
-- 
2.9.3

