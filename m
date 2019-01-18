Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1378DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA08420652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfARMV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:21:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbfARMUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90F18C0528BD;
        Fri, 18 Jan 2019 12:20:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62CE960BE8;
        Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 20E871FCD6; Fri, 18 Jan 2019 13:20:23 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU)
Subject: [PATCH v3 18/23] drm/qxl: remove dead qxl fbdev emulation code
Date:   Fri, 18 Jan 2019 13:20:15 +0100
Message-Id: <20190118122020.27596-19-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 18 Jan 2019 12:20:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lovely diffstat, thanks to the new generic fbdev emulation.

 drm/qxl/Makefile   |    2
 drm/qxl/qxl_draw.c |  232 ----------------------------------------
 drm/qxl/qxl_drv.h  |   21 ---
 drm/qxl/qxl_fb.c   |  300 -----------------------------------------------------

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h  |  21 ---
 drivers/gpu/drm/qxl/qxl_draw.c | 232 -------------------------------
 drivers/gpu/drm/qxl/qxl_fb.c   | 300 -----------------------------------------
 drivers/gpu/drm/qxl/Makefile   |   2 +-
 4 files changed, 1 insertion(+), 554 deletions(-)
 delete mode 100644 drivers/gpu/drm/qxl/qxl_fb.c

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 8c3af1cdbe..4a0331b3ff 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -220,8 +220,6 @@ struct qxl_device {
 	struct qxl_mman		mman;
 	struct qxl_gem		gem;
 
-	struct drm_fb_helper	fb_helper;
-
 	void *ram_physical;
 
 	struct qxl_ring *release_ring;
@@ -322,12 +320,6 @@ qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 	return slot->high_bits | (bo->tbo.offset - slot->gpu_offset + offset);
 }
 
-/* qxl_fb.c */
-#define QXLFB_CONN_LIMIT 1
-
-int qxl_fbdev_init(struct qxl_device *qdev);
-void qxl_fbdev_fini(struct qxl_device *qdev);
-
 /* qxl_display.c */
 void qxl_display_read_client_monitors_config(struct qxl_device *qdev);
 int qxl_create_monitors_object(struct qxl_device *qdev);
@@ -432,9 +424,6 @@ int qxl_alloc_bo_reserved(struct qxl_device *qdev,
 			  struct qxl_bo **_bo);
 /* qxl drawing commands */
 
-void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
-			int stride /* filled in if 0 */);
-
 void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       struct drm_framebuffer *fb,
 		       struct qxl_bo *bo,
@@ -443,13 +432,6 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       unsigned int num_clips, int inc,
 		       uint32_t dumb_shadow_offset);
 
-void qxl_draw_fill(struct qxl_draw_fill *qxl_draw_fill_rec);
-
-void qxl_draw_copyarea(struct qxl_device *qdev,
-		       u32 width, u32 height,
-		       u32 sx, u32 sy,
-		       u32 dx, u32 dy);
-
 void qxl_release_free(struct qxl_device *qdev,
 		      struct qxl_release *release);
 
@@ -481,9 +463,6 @@ int qxl_gem_prime_mmap(struct drm_gem_object *obj,
 int qxl_irq_init(struct qxl_device *qdev);
 irqreturn_t qxl_irq_handler(int irq, void *arg);
 
-/* qxl_fb.c */
-bool qxl_fbdev_qobj_is_fb(struct qxl_device *qdev, struct qxl_bo *qobj);
-
 int qxl_debugfs_add_files(struct qxl_device *qdev,
 			  struct drm_info_list *files,
 			  unsigned int nfiles);
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 5313ad21c1..97c3f1a95a 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -109,152 +109,6 @@ make_drawable(struct qxl_device *qdev, int surface, uint8_t type,
 	return 0;
 }
 
-static int alloc_palette_object(struct qxl_device *qdev,
-				struct qxl_release *release,
-				struct qxl_bo **palette_bo)
-{
-	return qxl_alloc_bo_reserved(qdev, release,
-				     sizeof(struct qxl_palette) + sizeof(uint32_t) * 2,
-				     palette_bo);
-}
-
-static int qxl_palette_create_1bit(struct qxl_bo *palette_bo,
-				   struct qxl_release *release,
-				   const struct qxl_fb_image *qxl_fb_image)
-{
-	const struct fb_image *fb_image = &qxl_fb_image->fb_image;
-	uint32_t visual = qxl_fb_image->visual;
-	const uint32_t *pseudo_palette = qxl_fb_image->pseudo_palette;
-	struct qxl_palette *pal;
-	int ret;
-	uint32_t fgcolor, bgcolor;
-	static uint64_t unique; /* we make no attempt to actually set this
-				 * correctly globaly, since that would require
-				 * tracking all of our palettes. */
-	ret = qxl_bo_kmap(palette_bo, (void **)&pal);
-	if (ret)
-		return ret;
-	pal->num_ents = 2;
-	pal->unique = unique++;
-	if (visual == FB_VISUAL_TRUECOLOR || visual == FB_VISUAL_DIRECTCOLOR) {
-		/* NB: this is the only used branch currently. */
-		fgcolor = pseudo_palette[fb_image->fg_color];
-		bgcolor = pseudo_palette[fb_image->bg_color];
-	} else {
-		fgcolor = fb_image->fg_color;
-		bgcolor = fb_image->bg_color;
-	}
-	pal->ents[0] = bgcolor;
-	pal->ents[1] = fgcolor;
-	qxl_bo_kunmap(palette_bo);
-	return 0;
-}
-
-void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
-			int stride /* filled in if 0 */)
-{
-	struct qxl_device *qdev = qxl_fb_image->qdev;
-	struct qxl_drawable *drawable;
-	struct qxl_rect rect;
-	const struct fb_image *fb_image = &qxl_fb_image->fb_image;
-	int x = fb_image->dx;
-	int y = fb_image->dy;
-	int width = fb_image->width;
-	int height = fb_image->height;
-	const char *src = fb_image->data;
-	int depth = fb_image->depth;
-	struct qxl_release *release;
-	struct qxl_image *image;
-	int ret;
-	struct qxl_drm_image *dimage;
-	struct qxl_bo *palette_bo = NULL;
-
-	if (stride == 0)
-		stride = depth * width / 8;
-
-	ret = alloc_drawable(qdev, &release);
-	if (ret)
-		return;
-
-	ret = qxl_image_alloc_objects(qdev, release,
-				      &dimage,
-				      height, stride);
-	if (ret)
-		goto out_free_drawable;
-
-	if (depth == 1) {
-		ret = alloc_palette_object(qdev, release, &palette_bo);
-		if (ret)
-			goto out_free_image;
-	}
-
-	/* do a reservation run over all the objects we just allocated */
-	ret = qxl_release_reserve_list(release, true);
-	if (ret)
-		goto out_free_palette;
-
-	rect.left = x;
-	rect.right = x + width;
-	rect.top = y;
-	rect.bottom = y + height;
-
-	ret = make_drawable(qdev, 0, QXL_DRAW_COPY, &rect, release);
-	if (ret) {
-		qxl_release_backoff_reserve_list(release);
-		goto out_free_palette;
-	}
-
-	ret = qxl_image_init(qdev, release, dimage,
-			     (const uint8_t *)src, 0, 0,
-			     width, height, depth, stride);
-	if (ret) {
-		qxl_release_backoff_reserve_list(release);
-		qxl_release_free(qdev, release);
-		return;
-	}
-
-	if (depth == 1) {
-		void *ptr;
-
-		ret = qxl_palette_create_1bit(palette_bo, release, qxl_fb_image);
-
-		ptr = qxl_bo_kmap_atomic_page(qdev, dimage->bo, 0);
-		image = ptr;
-		image->u.bitmap.palette =
-			qxl_bo_physical_address(qdev, palette_bo, 0);
-		qxl_bo_kunmap_atomic_page(qdev, dimage->bo, ptr);
-	}
-
-	drawable = (struct qxl_drawable *)qxl_release_map(qdev, release);
-
-	drawable->u.copy.src_area.top = 0;
-	drawable->u.copy.src_area.bottom = height;
-	drawable->u.copy.src_area.left = 0;
-	drawable->u.copy.src_area.right = width;
-
-	drawable->u.copy.rop_descriptor = SPICE_ROPD_OP_PUT;
-	drawable->u.copy.scale_mode = 0;
-	drawable->u.copy.mask.flags = 0;
-	drawable->u.copy.mask.pos.x = 0;
-	drawable->u.copy.mask.pos.y = 0;
-	drawable->u.copy.mask.bitmap = 0;
-
-	drawable->u.copy.src_bitmap =
-		qxl_bo_physical_address(qdev, dimage->bo, 0);
-	qxl_release_unmap(qdev, release, &drawable->release_info);
-
-	qxl_push_command_ring_release(qdev, release, QXL_CMD_DRAW, false);
-	qxl_release_fence_buffer_objects(release);
-
-out_free_palette:
-	qxl_bo_unref(&palette_bo);
-out_free_image:
-	qxl_image_free_objects(qdev, dimage);
-out_free_drawable:
-	if (ret)
-		free_drawable(qdev, release);
-}
-
 /* push a draw command using the given clipping rectangles as
  * the sources from the shadow framebuffer.
  *
@@ -402,89 +256,3 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		free_drawable(qdev, release);
 
 }
-
-void qxl_draw_copyarea(struct qxl_device *qdev,
-		       u32 width, u32 height,
-		       u32 sx, u32 sy,
-		       u32 dx, u32 dy)
-{
-	struct qxl_drawable *drawable;
-	struct qxl_rect rect;
-	struct qxl_release *release;
-	int ret;
-
-	ret = alloc_drawable(qdev, &release);
-	if (ret)
-		return;
-
-	/* do a reservation run over all the objects we just allocated */
-	ret = qxl_release_reserve_list(release, true);
-	if (ret)
-		goto out_free_release;
-
-	rect.left = dx;
-	rect.top = dy;
-	rect.right = dx + width;
-	rect.bottom = dy + height;
-	ret = make_drawable(qdev, 0, QXL_COPY_BITS, &rect, release);
-	if (ret) {
-		qxl_release_backoff_reserve_list(release);
-		goto out_free_release;
-	}
-
-	drawable = (struct qxl_drawable *)qxl_release_map(qdev, release);
-	drawable->u.copy_bits.src_pos.x = sx;
-	drawable->u.copy_bits.src_pos.y = sy;
-	qxl_release_unmap(qdev, release, &drawable->release_info);
-
-	qxl_push_command_ring_release(qdev, release, QXL_CMD_DRAW, false);
-	qxl_release_fence_buffer_objects(release);
-
-out_free_release:
-	if (ret)
-		free_drawable(qdev, release);
-}
-
-void qxl_draw_fill(struct qxl_draw_fill *qxl_draw_fill_rec)
-{
-	struct qxl_device *qdev = qxl_draw_fill_rec->qdev;
-	struct qxl_rect rect = qxl_draw_fill_rec->rect;
-	uint32_t color = qxl_draw_fill_rec->color;
-	uint16_t rop = qxl_draw_fill_rec->rop;
-	struct qxl_drawable *drawable;
-	struct qxl_release *release;
-	int ret;
-
-	ret = alloc_drawable(qdev, &release);
-	if (ret)
-		return;
-
-	/* do a reservation run over all the objects we just allocated */
-	ret = qxl_release_reserve_list(release, true);
-	if (ret)
-		goto out_free_release;
-
-	ret = make_drawable(qdev, 0, QXL_DRAW_FILL, &rect, release);
-	if (ret) {
-		qxl_release_backoff_reserve_list(release);
-		goto out_free_release;
-	}
-
-	drawable = (struct qxl_drawable *)qxl_release_map(qdev, release);
-	drawable->u.fill.brush.type = SPICE_BRUSH_TYPE_SOLID;
-	drawable->u.fill.brush.u.color = color;
-	drawable->u.fill.rop_descriptor = rop;
-	drawable->u.fill.mask.flags = 0;
-	drawable->u.fill.mask.pos.x = 0;
-	drawable->u.fill.mask.pos.y = 0;
-	drawable->u.fill.mask.bitmap = 0;
-
-	qxl_release_unmap(qdev, release, &drawable->release_info);
-
-	qxl_push_command_ring_release(qdev, release, QXL_CMD_DRAW, false);
-	qxl_release_fence_buffer_objects(release);
-
-out_free_release:
-	if (ret)
-		free_drawable(qdev, release);
-}
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
deleted file mode 100644
index a819d24225..0000000000
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ /dev/null
@@ -1,300 +0,0 @@
-/*
- * Copyright © 2013 Red Hat
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
- *
- * Authors:
- *     David Airlie
- */
-#include <linux/module.h>
-
-#include <drm/drmP.h>
-#include <drm/drm.h>
-#include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
-#include <drm/drm_gem_framebuffer_helper.h>
-
-#include "qxl_drv.h"
-
-#include "qxl_object.h"
-
-static void qxl_fb_image_init(struct qxl_fb_image *qxl_fb_image,
-			      struct qxl_device *qdev, struct fb_info *info,
-			      const struct fb_image *image)
-{
-	qxl_fb_image->qdev = qdev;
-	if (info) {
-		qxl_fb_image->visual = info->fix.visual;
-		if (qxl_fb_image->visual == FB_VISUAL_TRUECOLOR ||
-		    qxl_fb_image->visual == FB_VISUAL_DIRECTCOLOR)
-			memcpy(&qxl_fb_image->pseudo_palette,
-			       info->pseudo_palette,
-			       sizeof(qxl_fb_image->pseudo_palette));
-	} else {
-		 /* fallback */
-		if (image->depth == 1)
-			qxl_fb_image->visual = FB_VISUAL_MONO10;
-		else
-			qxl_fb_image->visual = FB_VISUAL_DIRECTCOLOR;
-	}
-	if (image) {
-		memcpy(&qxl_fb_image->fb_image, image,
-		       sizeof(qxl_fb_image->fb_image));
-	}
-}
-
-static struct fb_ops qxlfb_ops = {
-	.owner = THIS_MODULE,
-	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_fillrect = drm_fb_helper_sys_fillrect,
-	.fb_copyarea = drm_fb_helper_sys_copyarea,
-	.fb_imageblit = drm_fb_helper_sys_imageblit,
-};
-
-static void qxlfb_destroy_pinned_object(struct drm_gem_object *gobj)
-{
-	struct qxl_bo *qbo = gem_to_qxl_bo(gobj);
-
-	qxl_bo_kunmap(qbo);
-	qxl_bo_unpin(qbo);
-
-	drm_gem_object_put_unlocked(gobj);
-}
-
-static int qxlfb_create_pinned_object(struct qxl_device *qdev,
-				      const struct drm_mode_fb_cmd2 *mode_cmd,
-				      struct drm_gem_object **gobj_p)
-{
-	struct drm_gem_object *gobj = NULL;
-	struct qxl_bo *qbo = NULL;
-	int ret;
-	int aligned_size, size;
-	int height = mode_cmd->height;
-
-	size = mode_cmd->pitches[0] * height;
-	aligned_size = ALIGN(size, PAGE_SIZE);
-	/* TODO: unallocate and reallocate surface0 for real. Hack to just
-	 * have a large enough surface0 for 1024x768 Xorg 32bpp mode */
-	ret = qxl_gem_object_create(qdev, aligned_size, 0,
-				    QXL_GEM_DOMAIN_SURFACE,
-				    false, /* is discardable */
-				    false, /* is kernel (false means device) */
-				    NULL,
-				    &gobj);
-	if (ret) {
-		pr_err("failed to allocate framebuffer (%d)\n",
-		       aligned_size);
-		return -ENOMEM;
-	}
-	qbo = gem_to_qxl_bo(gobj);
-
-	qbo->surf.width = mode_cmd->width;
-	qbo->surf.height = mode_cmd->height;
-	qbo->surf.stride = mode_cmd->pitches[0];
-	qbo->surf.format = SPICE_SURFACE_FMT_32_xRGB;
-
-	ret = qxl_bo_pin(qbo);
-	if (ret) {
-		goto out_unref;
-	}
-	ret = qxl_bo_kmap(qbo, NULL);
-
-	if (ret)
-		goto out_unref;
-
-	*gobj_p = gobj;
-	return 0;
-out_unref:
-	qxlfb_destroy_pinned_object(gobj);
-	*gobj_p = NULL;
-	return ret;
-}
-
-/*
- * FIXME
- * It should not be necessary to have a special dirty() callback for fbdev.
- */
-static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
-				   struct drm_file *file_priv,
-				   unsigned int flags, unsigned int color,
-				   struct drm_clip_rect *clips,
-				   unsigned int num_clips)
-{
-	struct qxl_device *qdev = fb->dev->dev_private;
-	struct fb_info *info = qdev->fb_helper.fbdev;
-	struct qxl_fb_image qxl_fb_image;
-	struct fb_image *image = &qxl_fb_image.fb_image;
-
-	/* TODO: hard coding 32 bpp */
-	int stride = fb->pitches[0];
-
-	/*
-	 * we are using a shadow draw buffer, at qdev->surface0_shadow
-	 */
-	image->dx = clips->x1;
-	image->dy = clips->y1;
-	image->width = clips->x2 - clips->x1;
-	image->height = clips->y2 - clips->y1;
-	image->fg_color = 0xffffffff; /* unused, just to avoid uninitialized
-					 warnings */
-	image->bg_color = 0;
-	image->depth = 32;	     /* TODO: take from somewhere? */
-	image->cmap.start = 0;
-	image->cmap.len = 0;
-	image->cmap.red = NULL;
-	image->cmap.green = NULL;
-	image->cmap.blue = NULL;
-	image->cmap.transp = NULL;
-	image->data = info->screen_base + (clips->x1 * 4) + (stride * clips->y1);
-
-	qxl_fb_image_init(&qxl_fb_image, qdev, info, NULL);
-	qxl_draw_opaque_fb(&qxl_fb_image, stride);
-
-	return 0;
-}
-
-static const struct drm_framebuffer_funcs qxlfb_fb_funcs = {
-	.destroy = drm_gem_fb_destroy,
-	.create_handle = drm_gem_fb_create_handle,
-	.dirty = qxlfb_framebuffer_dirty,
-};
-
-static int qxlfb_create(struct drm_fb_helper *helper,
-			struct drm_fb_helper_surface_size *sizes)
-{
-	struct qxl_device *qdev =
-		container_of(helper, struct qxl_device, fb_helper);
-	struct fb_info *info;
-	struct drm_framebuffer *fb = NULL;
-	struct drm_mode_fb_cmd2 mode_cmd;
-	struct drm_gem_object *gobj = NULL;
-	struct qxl_bo *qbo = NULL;
-	int ret;
-	int bpp = sizes->surface_bpp;
-	int depth = sizes->surface_depth;
-	void *shadow;
-
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-
-	mode_cmd.pitches[0] = ALIGN(mode_cmd.width * ((bpp + 1) / 8), 64);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(bpp, depth);
-
-	ret = qxlfb_create_pinned_object(qdev, &mode_cmd, &gobj);
-	if (ret < 0)
-		return ret;
-
-	qbo = gem_to_qxl_bo(gobj);
-	DRM_DEBUG_DRIVER("%dx%d %d\n", mode_cmd.width,
-			 mode_cmd.height, mode_cmd.pitches[0]);
-
-	shadow = vmalloc(array_size(mode_cmd.pitches[0], mode_cmd.height));
-	/* TODO: what's the usual response to memory allocation errors? */
-	BUG_ON(!shadow);
-	DRM_DEBUG_DRIVER("surface0 at gpu offset %lld, mmap_offset %lld (virt %p, shadow %p)\n",
-			 qxl_bo_gpu_offset(qbo), qxl_bo_mmap_offset(qbo),
-			 qbo->kptr, shadow);
-
-	info = drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info)) {
-		ret = PTR_ERR(info);
-		goto out_unref;
-	}
-
-	info->par = helper;
-
-	fb = drm_gem_fbdev_fb_create(&qdev->ddev, sizes, 64, gobj,
-				     &qxlfb_fb_funcs);
-	if (IS_ERR(fb)) {
-		DRM_ERROR("Failed to create framebuffer: %ld\n", PTR_ERR(fb));
-		ret = PTR_ERR(fb);
-		goto out_unref;
-	}
-
-	/* setup helper with fb data */
-	qdev->fb_helper.fb = fb;
-
-	strcpy(info->fix.id, "qxldrmfb");
-
-	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
-
-	info->fbops = &qxlfb_ops;
-
-	/*
-	 * TODO: using gobj->size in various places in this function. Not sure
-	 * what the difference between the different sizes is.
-	 */
-	info->fix.smem_start = qdev->vram_base; /* TODO - correct? */
-	info->fix.smem_len = gobj->size;
-	info->screen_base = shadow;
-	info->screen_size = gobj->size;
-
-	drm_fb_helper_fill_var(info, &qdev->fb_helper, sizes->fb_width,
-			       sizes->fb_height);
-
-	/* setup aperture base/size for vesafb takeover */
-	info->apertures->ranges[0].base = qdev->ddev.mode_config.fb_base;
-	info->apertures->ranges[0].size = qdev->vram_size;
-
-	info->fix.mmio_start = 0;
-	info->fix.mmio_len = 0;
-
-	if (info->screen_base == NULL) {
-		ret = -ENOSPC;
-		goto out_unref;
-	}
-
-	/* XXX error handling. */
-	drm_fb_helper_defio_init(helper);
-
-	DRM_INFO("fb mappable at 0x%lX, size %lu\n",  info->fix.smem_start, (unsigned long)info->screen_size);
-	DRM_INFO("fb: depth %d, pitch %d, width %d, height %d\n",
-		 fb->format->depth, fb->pitches[0], fb->width, fb->height);
-	return 0;
-
-out_unref:
-	if (qbo) {
-		qxl_bo_kunmap(qbo);
-		qxl_bo_unpin(qbo);
-	}
-	drm_gem_object_put_unlocked(gobj);
-	return ret;
-}
-
-static const struct drm_fb_helper_funcs qxl_fb_helper_funcs = {
-	.fb_probe = qxlfb_create,
-};
-
-int qxl_fbdev_init(struct qxl_device *qdev)
-{
-	return drm_fb_helper_fbdev_setup(&qdev->ddev, &qdev->fb_helper,
-					 &qxl_fb_helper_funcs, 32,
-					 QXLFB_CONN_LIMIT);
-}
-
-void qxl_fbdev_fini(struct qxl_device *qdev)
-{
-	struct fb_info *fbi = qdev->fb_helper.fbdev;
-	void *shadow = fbi ? fbi->screen_buffer : NULL;
-
-	drm_fb_helper_fbdev_teardown(&qdev->ddev);
-	vfree(shadow);
-}
diff --git a/drivers/gpu/drm/qxl/Makefile b/drivers/gpu/drm/qxl/Makefile
index 33a7d0c434..fc59d42b31 100644
--- a/drivers/gpu/drm/qxl/Makefile
+++ b/drivers/gpu/drm/qxl/Makefile
@@ -2,6 +2,6 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-qxl-y := qxl_drv.o qxl_kms.o qxl_display.o qxl_ttm.o qxl_fb.o qxl_object.o qxl_gem.o qxl_cmd.o qxl_image.o qxl_draw.o qxl_debugfs.o qxl_irq.o qxl_dumb.o qxl_ioctl.o qxl_release.o qxl_prime.o
+qxl-y := qxl_drv.o qxl_kms.o qxl_display.o qxl_ttm.o qxl_object.o qxl_gem.o qxl_cmd.o qxl_image.o qxl_draw.o qxl_debugfs.o qxl_irq.o qxl_dumb.o qxl_ioctl.o qxl_release.o qxl_prime.o
 
 obj-$(CONFIG_DRM_QXL)+= qxl.o
-- 
2.9.3

