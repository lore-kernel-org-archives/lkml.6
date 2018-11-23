Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667CB20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667CB20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409012AbeKWUKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49430 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408928AbeKWUK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:28 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ECCB62160D; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9CAFA20EB7;
        Fri, 23 Nov 2018 10:26:35 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 31/43] drm/sun4i: Add a dedicated ioctl call for allocating tiled buffers
Date:   Fri, 23 Nov 2018 10:25:03 +0100
Message-Id: <20181123092515.2511-32-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a dedicated ioctl for allocating buffers for the VPU
tiling mode. It allows setting up buffers that comply to the hardware
alignment requirements, by aligning the stride and height to 32 bytes.

Only YUV semiplanar and planar formats are allowed by the ioctl, as the
hardware does not support the tiling mode for other formats.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 89 +++++++++++++++++++++++++++++++
 include/uapi/drm/sun4i_drm.h      | 42 +++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 include/uapi/drm/sun4i_drm.h

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index ccdeae6299eb..5ae32973cf34 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -21,6 +21,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_of.h>
+#include <drm/sun4i_drm.h>
 
 #include "sun4i_drv.h"
 #include "sun4i_frontend.h"
@@ -28,6 +29,92 @@
 #include "sun4i_tcon.h"
 #include "sun8i_tcon_top.h"
 
+int drm_sun4i_gem_create_tiled(struct drm_device *drm, void *data,
+			       struct drm_file *file_priv)
+{
+	struct drm_sun4i_gem_create_tiled *args = data;
+	struct drm_gem_cma_object *cma_obj;
+	struct drm_gem_object *gem_obj;
+	uint32_t luma_stride, chroma_stride;
+	uint32_t luma_height, chroma_height;
+	uint32_t chroma_width;
+	const struct drm_format_info *info;
+	int ret;
+
+	info = drm_format_info(args->format);
+	if (!info)
+		return -EINVAL;
+
+	/* The tiled output format only applies to non-packed YUV formats. */
+	if (!info->is_yuv || info->num_planes == 1)
+		return -EINVAL;
+
+	memset(args->pitches, 0, sizeof(args->pitches));
+	memset(args->offsets, 0, sizeof(args->offsets));
+
+	/* Stride and height are aligned to 32 bytes for our tiled format. */
+	luma_stride = ALIGN(args->width, 32);
+	luma_height = ALIGN(args->height, 32);
+
+	chroma_width = args->width;
+
+	/* Semiplanar formats have both U and V data in their chroma plane. */
+	if (drm_format_info_is_yuv_semiplanar(info))
+		chroma_width *= 2;
+
+	chroma_stride = ALIGN(DIV_ROUND_UP(chroma_width, info->hsub), 32);
+	chroma_height = ALIGN(DIV_ROUND_UP(args->height, info->vsub), 32);
+
+	if (drm_format_info_is_yuv_semiplanar(info)) {
+		args->pitches[0] = luma_stride;
+		args->pitches[1] = chroma_stride;
+
+		args->offsets[0] = 0;
+		args->offsets[1] = luma_stride * luma_height;
+
+		args->size = luma_stride * luma_height +
+			     chroma_stride * chroma_height;
+	} else if (drm_format_info_is_yuv_planar(info)) {
+		args->pitches[0] = luma_stride;
+		args->pitches[1] = chroma_stride;
+		args->pitches[2] = chroma_stride;
+
+		args->offsets[0] = 0;
+		args->offsets[1] = luma_stride * luma_height;
+		args->offsets[2] = luma_stride * luma_height +
+				   chroma_stride * chroma_height;
+
+		args->size = luma_stride * luma_height +
+			     chroma_stride * chroma_height * 2;
+	} else {
+		/* No support for other formats in tiled mode. */
+		return -EINVAL;
+	}
+
+	cma_obj = drm_gem_cma_create(drm, args->size);
+	if (IS_ERR(cma_obj))
+		return PTR_ERR(cma_obj);
+
+	gem_obj = &cma_obj->base;
+
+	/*
+	 * allocate a id of idr table where the obj is registered
+	 * and handle has the id what user can see.
+	 */
+	ret = drm_gem_handle_create(file_priv, gem_obj, &args->handle);
+	/* drop reference from allocate - handle holds it now. */
+	drm_gem_object_put_unlocked(gem_obj);
+	if (ret)
+		return ret;
+
+	return PTR_ERR_OR_ZERO(cma_obj);
+}
+
+static const struct drm_ioctl_desc sun4i_drv_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(SUN4I_GEM_CREATE_TILED, drm_sun4i_gem_create_tiled,
+			  DRM_UNLOCKED),
+};
+
 static int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
 				     struct drm_device *drm,
 				     struct drm_mode_create_dumb *args)
@@ -44,6 +131,8 @@ static struct drm_driver sun4i_drv_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_ATOMIC,
 
 	/* Generic Operations */
+	.ioctls			= sun4i_drv_ioctls,
+	.num_ioctls		= ARRAY_SIZE(sun4i_drv_ioctls),
 	.fops			= &sun4i_drv_fops,
 	.name			= "sun4i-drm",
 	.desc			= "Allwinner sun4i Display Engine",
diff --git a/include/uapi/drm/sun4i_drm.h b/include/uapi/drm/sun4i_drm.h
new file mode 100644
index 000000000000..2c77584b057b
--- /dev/null
+++ b/include/uapi/drm/sun4i_drm.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* sun4i_drm.h
+ *
+ * Copyright (C) 2018 Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _UAPI_SUN4I_DRM_H_
+#define _UAPI_SUN4I_DRM_H_
+
+#include "drm.h"
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+struct drm_sun4i_gem_create_tiled {
+	__u32 height;
+	__u32 width;
+	__u32 format;
+	/* handle, offsets, pitches, size will be returned */
+	__u32 handle;
+	__u32 pitches[4];
+	__u32 offsets[4];
+	__u64 size;
+};
+
+#define DRM_SUN4I_GEM_CREATE_TILED	0x00
+
+#define DRM_IOCTL_SUN4I_GEM_CREATE_TILED \
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_SUN4I_GEM_CREATE_TILED, \
+		 struct drm_sun4i_gem_create_tiled)
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* _UAPI_SUN4I_DRM_H_ */
-- 
2.19.1

