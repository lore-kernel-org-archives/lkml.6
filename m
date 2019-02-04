Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71762C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4831C2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBDLBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:01:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBDLBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:01:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0579158E43;
        Mon,  4 Feb 2019 11:01:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BF8E6246B;
        Mon,  4 Feb 2019 11:01:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6F02DA1E8; Mon,  4 Feb 2019 12:01:31 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/cirrus: add plane setup
Date:   Mon,  4 Feb 2019 12:01:31 +0100
Message-Id: <20190204110131.21467-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 04 Feb 2019 11:01:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "f4bd542bca drm/fb-helper: Scale back depth to supported maximum"
uncovered a bug in the cirrus driver.  It must create its own primary
plane, using the correct format list, depending on the bpp module
parameter, so it is consistent with mode_config->preferred_depth.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_mode.c | 67 +++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index a830e70fc0..2e966a22c5 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -360,10 +360,67 @@ static const struct drm_crtc_helper_funcs cirrus_helper_funcs = {
 };
 
 /* CRTC setup */
+static const uint32_t cirrus_formats_16[] = {
+	DRM_FORMAT_RGB565,
+};
+
+static const uint32_t cirrus_formats_24[] = {
+	DRM_FORMAT_RGB888,
+};
+
+static const uint32_t cirrus_formats_32[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+};
+
+static struct drm_plane *cirrus_primary_plane(struct drm_device *dev)
+{
+	const uint32_t *formats;
+	uint32_t nformats;
+	struct drm_plane *primary;
+	int ret;
+
+	switch (cirrus_bpp) {
+	case 16:
+		formats = cirrus_formats_16;
+		nformats = ARRAY_SIZE(cirrus_formats_16);
+		break;
+	case 24:
+		formats = cirrus_formats_24;
+		nformats = ARRAY_SIZE(cirrus_formats_24);
+		break;
+	case 32:
+		formats = cirrus_formats_32;
+		nformats = ARRAY_SIZE(cirrus_formats_32);
+		break;
+	default:
+		return NULL;
+	}
+
+	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
+	if (primary == NULL) {
+		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
+		return NULL;
+	}
+
+	ret = drm_universal_plane_init(dev, primary, 0,
+				       &drm_primary_helper_funcs,
+				       formats, nformats,
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
 static void cirrus_crtc_init(struct drm_device *dev)
 {
 	struct cirrus_device *cdev = dev->dev_private;
 	struct cirrus_crtc *cirrus_crtc;
+	struct drm_plane *primary;
 
 	cirrus_crtc = kzalloc(sizeof(struct cirrus_crtc) +
 			      (CIRRUSFB_CONN_LIMIT * sizeof(struct drm_connector *)),
@@ -372,7 +429,15 @@ static void cirrus_crtc_init(struct drm_device *dev)
 	if (cirrus_crtc == NULL)
 		return;
 
-	drm_crtc_init(dev, &cirrus_crtc->base, &cirrus_crtc_funcs);
+	primary = cirrus_primary_plane(dev);
+	if (primary == NULL) {
+		kfree(cirrus_crtc);
+		return;
+	}
+
+	drm_crtc_init_with_planes(dev, &cirrus_crtc->base,
+				  primary, NULL,
+				  &cirrus_crtc_funcs, NULL);
 
 	drm_mode_crtc_set_gamma_size(&cirrus_crtc->base, CIRRUS_LUT_SIZE);
 	cdev->mode_info.crtc = cirrus_crtc;
-- 
2.9.3

