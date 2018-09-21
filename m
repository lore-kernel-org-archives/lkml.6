Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA965ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9292154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9292154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbeIUTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32709 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeIUTgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9AB130034AB;
        Fri, 21 Sep 2018 13:47:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E46347FFF1;
        Fri, 21 Sep 2018 13:47:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B9D139EE56; Fri, 21 Sep 2018 15:47:04 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/6] drm: move native byte order quirk to new drm_driver_legacy_fb_format function
Date:   Fri, 21 Sep 2018 15:46:59 +0200
Message-Id: <20180921134704.12826-2-kraxel@redhat.com>
In-Reply-To: <20180921134704.12826-1-kraxel@redhat.com>
References: <20180921134704.12826-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 21 Sep 2018 13:47:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out we need the pixel format fixup not only for the addfb ioctl,
but also for fbdev emulation code.

Ideally we would place it in drm_mode_legacy_fb_format().  That would
create alot of churn though, and most drivers don't care because they
never ever run on a big endian platform.  So add a new
drm_driver_legacy_fb_format() function instead which looks at the
mode_config->quirk_addfb_prefer_host_byte_order flag.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/drm/drm_fourcc.h          |  2 ++
 drivers/gpu/drm/drm_fourcc.c      | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_framebuffer.c | 13 +------------
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index fac831c401..865ef60c17 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -88,6 +88,8 @@ const struct drm_format_info *
 drm_get_format_info(struct drm_device *dev,
 		    const struct drm_mode_fb_cmd2 *mode_cmd);
 uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
+uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
+				     uint32_t bpp, uint32_t depth);
 int drm_format_num_planes(uint32_t format);
 int drm_format_plane_cpp(uint32_t format, int plane);
 int drm_format_horz_chroma_subsampling(uint32_t format);
diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index be1d6aaef6..7c6d3922ed 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -96,6 +96,36 @@ uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth)
 EXPORT_SYMBOL(drm_mode_legacy_fb_format);
 
 /**
+ * drm_driver_legacy_fb_format - compute drm fourcc code from legacy description
+ * @bpp: bits per pixels
+ * @depth: bit depth per pixel
+ * @native: use host native byte order
+ *
+ * Computes a drm fourcc pixel format code for the given @bpp/@depth values.
+ * Unlike drm_mode_legacy_fb_format() this looks at the drivers mode_config,
+ * and depending on the quirk_addfb_prefer_host_byte_order flag it returns
+ * little endian byte order or host byte order framebuffer formats.
+ */
+uint32_t drm_driver_legacy_fb_format(struct drm_device *dev,
+				     uint32_t bpp, uint32_t depth)
+{
+	uint32_t fmt = drm_mode_legacy_fb_format(bpp, depth);
+
+	if (dev->mode_config.quirk_addfb_prefer_host_byte_order) {
+		if (fmt == DRM_FORMAT_XRGB8888)
+			fmt = DRM_FORMAT_HOST_XRGB8888;
+		if (fmt == DRM_FORMAT_ARGB8888)
+			fmt = DRM_FORMAT_HOST_ARGB8888;
+		if (fmt == DRM_FORMAT_RGB565)
+			fmt = DRM_FORMAT_HOST_RGB565;
+		if (fmt == DRM_FORMAT_XRGB1555)
+			fmt = DRM_FORMAT_HOST_XRGB1555;
+	}
+	return fmt;
+}
+EXPORT_SYMBOL(drm_driver_legacy_fb_format);
+
+/**
  * drm_get_format_name - fill a string with a drm fourcc format's name
  * @format: format to compute name of
  * @buf: caller-supplied buffer
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 1ee3d6b442..1e2126101c 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -116,7 +116,7 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
 
-	r.pixel_format = drm_mode_legacy_fb_format(or->bpp, or->depth);
+	r.pixel_format = drm_driver_legacy_fb_format(dev, or->bpp, or->depth);
 	if (r.pixel_format == DRM_FORMAT_INVALID) {
 		DRM_DEBUG("bad {bpp:%d, depth:%d}\n", or->bpp, or->depth);
 		return -EINVAL;
@@ -133,17 +133,6 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
 	    r.pixel_format == DRM_FORMAT_XRGB2101010)
 		r.pixel_format = DRM_FORMAT_XBGR2101010;
 
-	if (dev->mode_config.quirk_addfb_prefer_host_byte_order) {
-		if (r.pixel_format == DRM_FORMAT_XRGB8888)
-			r.pixel_format = DRM_FORMAT_HOST_XRGB8888;
-		if (r.pixel_format == DRM_FORMAT_ARGB8888)
-			r.pixel_format = DRM_FORMAT_HOST_ARGB8888;
-		if (r.pixel_format == DRM_FORMAT_RGB565)
-			r.pixel_format = DRM_FORMAT_HOST_RGB565;
-		if (r.pixel_format == DRM_FORMAT_XRGB1555)
-			r.pixel_format = DRM_FORMAT_HOST_XRGB1555;
-	}
-
 	ret = drm_mode_addfb2(dev, &r, file_priv);
 	if (ret)
 		return ret;
-- 
2.9.3

