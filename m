Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD4ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2DB20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2DB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJZP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:58:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2685 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725983AbeJZP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:58:43 -0400
X-UUID: 87e5b7005fa44ef1a89b617dc6467c09-20181026
X-UUID: 87e5b7005fa44ef1a89b617dc6467c09-20181026
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1552256992; Fri, 26 Oct 2018 15:22:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 26 Oct 2018 15:22:29 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 26 Oct 2018 15:22:30 +0800
From:   CK Hu <ck.hu@mediatek.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 3/3] drm/mediatek: Use drm_gem_cma_object instead of mtk_drm_gem_obj
Date:   Fri, 26 Oct 2018 15:22:03 +0800
Message-ID: <1540538523-1973-4-git-send-email-ck.hu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
References: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6D83ABD964DB2FBEA90E90360F40C917AFA996A9204A57196686E404EE9AAD9E2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding dma_dev in struct drm_device and
drm_gem_cma_dumb_create_no_kmap(), drm_gem_cma_object could replace
mtk_drm_gem_obj, so use drm_gem_cma_object instead of mtk_drm_gem_obj to
reduce redundant code.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile        |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   |  15 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h   |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_fb.c    |   1 -
 drivers/gpu/drm/mediatek/mtk_drm_gem.c   | 243 -------------------------------
 drivers/gpu/drm/mediatek/mtk_drm_gem.h   |  56 -------
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |   8 +-
 8 files changed, 11 insertions(+), 315 deletions(-)
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_gem.c
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_gem.h

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index ce83c39..c4fa126 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -7,7 +7,6 @@ mediatek-drm-y := mtk_disp_color.o \
 		  mtk_drm_ddp_comp.o \
 		  mtk_drm_drv.o \
 		  mtk_drm_fb.o \
-		  mtk_drm_gem.o \
 		  mtk_drm_plane.o \
 		  mtk_dsi.o \
 		  mtk_mipi_tx.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 92ecb9b..534c22a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -24,7 +24,6 @@
 #include "mtk_drm_crtc.h"
 #include "mtk_drm_ddp.h"
 #include "mtk_drm_ddp_comp.h"
-#include "mtk_drm_gem.h"
 #include "mtk_drm_plane.h"
 
 /**
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 47ec604..306ba29 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -30,7 +30,6 @@
 #include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_fb.h"
-#include "mtk_drm_gem.h"
 
 #define DRIVER_NAME "mediatek"
 #define DRIVER_DESC "Mediatek SoC DRM"
@@ -282,7 +281,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 		goto err_component_unbind;
 	}
 
-	private->dma_dev = &pdev->dev;
+	drm->dma_dev = &pdev->dev;
 
 	/*
 	 * We don't use the drm_irq_install() helpers provided by the DRM
@@ -320,7 +319,7 @@ static void mtk_drm_kms_deinit(struct drm_device *drm)
 	.open = drm_open,
 	.release = drm_release,
 	.unlocked_ioctl = drm_ioctl,
-	.mmap = mtk_drm_gem_mmap,
+	.mmap = drm_gem_cma_mmap,
 	.poll = drm_poll,
 	.read = drm_read,
 	.compat_ioctl = drm_compat_ioctl,
@@ -330,17 +329,17 @@ static void mtk_drm_kms_deinit(struct drm_device *drm)
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME |
 			   DRIVER_ATOMIC,
 
-	.gem_free_object_unlocked = mtk_drm_gem_free_object,
+	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops = &drm_gem_cma_vm_ops,
-	.dumb_create = mtk_drm_gem_dumb_create,
+	.dumb_create = drm_gem_cma_dumb_create_no_kmap,
 
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_export = drm_gem_prime_export,
 	.gem_prime_import = drm_gem_prime_import,
-	.gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
-	.gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
-	.gem_prime_mmap = mtk_drm_gem_mmap_buf,
+	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
+	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
+	.gem_prime_mmap = drm_gem_cma_prime_mmap,
 	.fops = &mtk_drm_fops,
 
 	.name = DRIVER_NAME,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index ecc00ca..cbbe63b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -41,7 +41,6 @@ struct mtk_mmsys_driver_data {
 
 struct mtk_drm_private {
 	struct drm_device *drm;
-	struct device *dma_dev;
 
 	unsigned int num_pipes;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index be5f6f1..45c22aa 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -21,7 +21,6 @@
 
 #include "mtk_drm_drv.h"
 #include "mtk_drm_fb.h"
-#include "mtk_drm_gem.h"
 
 static const struct drm_framebuffer_funcs mtk_drm_fb_funcs = {
 	.create_handle = drm_gem_fb_create_handle,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
deleted file mode 100644
index 259b7b0..0000000
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ /dev/null
@@ -1,243 +0,0 @@
-/*
- * Copyright (c) 2015 MediaTek Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <drm/drmP.h>
-#include <drm/drm_gem.h>
-#include <linux/dma-buf.h>
-
-#include "mtk_drm_drv.h"
-#include "mtk_drm_gem.h"
-
-static struct mtk_drm_gem_obj *mtk_drm_gem_init(struct drm_device *dev,
-						unsigned long size)
-{
-	struct mtk_drm_gem_obj *mtk_gem_obj;
-	int ret;
-
-	size = round_up(size, PAGE_SIZE);
-
-	mtk_gem_obj = kzalloc(sizeof(*mtk_gem_obj), GFP_KERNEL);
-	if (!mtk_gem_obj)
-		return ERR_PTR(-ENOMEM);
-
-	ret = drm_gem_object_init(dev, &mtk_gem_obj->base, size);
-	if (ret < 0) {
-		DRM_ERROR("failed to initialize gem object\n");
-		kfree(mtk_gem_obj);
-		return ERR_PTR(ret);
-	}
-
-	return mtk_gem_obj;
-}
-
-struct mtk_drm_gem_obj *mtk_drm_gem_create(struct drm_device *dev,
-					   size_t size, bool alloc_kmap)
-{
-	struct mtk_drm_private *priv = dev->dev_private;
-	struct mtk_drm_gem_obj *mtk_gem;
-	struct drm_gem_object *obj;
-	int ret;
-
-	mtk_gem = mtk_drm_gem_init(dev, size);
-	if (IS_ERR(mtk_gem))
-		return ERR_CAST(mtk_gem);
-
-	obj = &mtk_gem->base;
-
-	mtk_gem->dma_attrs = DMA_ATTR_WRITE_COMBINE;
-
-	if (!alloc_kmap)
-		mtk_gem->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
-
-	mtk_gem->cookie = dma_alloc_attrs(priv->dma_dev, obj->size,
-					  &mtk_gem->dma_addr, GFP_KERNEL,
-					  mtk_gem->dma_attrs);
-	if (!mtk_gem->cookie) {
-		DRM_ERROR("failed to allocate %zx byte dma buffer", obj->size);
-		ret = -ENOMEM;
-		goto err_gem_free;
-	}
-
-	if (alloc_kmap)
-		mtk_gem->kvaddr = mtk_gem->cookie;
-
-	DRM_DEBUG_DRIVER("cookie = %p dma_addr = %pad size = %zu\n",
-			 mtk_gem->cookie, &mtk_gem->dma_addr,
-			 size);
-
-	return mtk_gem;
-
-err_gem_free:
-	drm_gem_object_release(obj);
-	kfree(mtk_gem);
-	return ERR_PTR(ret);
-}
-
-void mtk_drm_gem_free_object(struct drm_gem_object *obj)
-{
-	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
-	struct mtk_drm_private *priv = obj->dev->dev_private;
-
-	if (mtk_gem->sg)
-		drm_prime_gem_destroy(obj, mtk_gem->sg);
-	else
-		dma_free_attrs(priv->dma_dev, obj->size, mtk_gem->cookie,
-			       mtk_gem->dma_addr, mtk_gem->dma_attrs);
-
-	/* release file pointer to gem object. */
-	drm_gem_object_release(obj);
-
-	kfree(mtk_gem);
-}
-
-int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
-			    struct drm_mode_create_dumb *args)
-{
-	struct mtk_drm_gem_obj *mtk_gem;
-	int ret;
-
-	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
-	args->size = args->pitch * args->height;
-
-	mtk_gem = mtk_drm_gem_create(dev, args->size, false);
-	if (IS_ERR(mtk_gem))
-		return PTR_ERR(mtk_gem);
-
-	/*
-	 * allocate a id of idr table where the obj is registered
-	 * and handle has the id what user can see.
-	 */
-	ret = drm_gem_handle_create(file_priv, &mtk_gem->base, &args->handle);
-	if (ret)
-		goto err_handle_create;
-
-	/* drop reference from allocate - handle holds it now. */
-	drm_gem_object_put_unlocked(&mtk_gem->base);
-
-	return 0;
-
-err_handle_create:
-	mtk_drm_gem_free_object(&mtk_gem->base);
-	return ret;
-}
-
-static int mtk_drm_gem_object_mmap(struct drm_gem_object *obj,
-				   struct vm_area_struct *vma)
-
-{
-	int ret;
-	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
-	struct mtk_drm_private *priv = obj->dev->dev_private;
-
-	/*
-	 * dma_alloc_attrs() allocated a struct page table for mtk_gem, so clear
-	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
-	 */
-	vma->vm_flags &= ~VM_PFNMAP;
-	vma->vm_pgoff = 0;
-
-	ret = dma_mmap_attrs(priv->dma_dev, vma, mtk_gem->cookie,
-			     mtk_gem->dma_addr, obj->size, mtk_gem->dma_attrs);
-	if (ret)
-		drm_gem_vm_close(vma);
-
-	return ret;
-}
-
-int mtk_drm_gem_mmap_buf(struct drm_gem_object *obj, struct vm_area_struct *vma)
-{
-	int ret;
-
-	ret = drm_gem_mmap_obj(obj, obj->size, vma);
-	if (ret)
-		return ret;
-
-	return mtk_drm_gem_object_mmap(obj, vma);
-}
-
-int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_gem_object *obj;
-	int ret;
-
-	ret = drm_gem_mmap(filp, vma);
-	if (ret)
-		return ret;
-
-	obj = vma->vm_private_data;
-
-	return mtk_drm_gem_object_mmap(obj, vma);
-}
-
-/*
- * Allocate a sg_table for this GEM object.
- * Note: Both the table's contents, and the sg_table itself must be freed by
- *       the caller.
- * Returns a pointer to the newly allocated sg_table, or an ERR_PTR() error.
- */
-struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj)
-{
-	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
-	struct mtk_drm_private *priv = obj->dev->dev_private;
-	struct sg_table *sgt;
-	int ret;
-
-	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
-	if (!sgt)
-		return ERR_PTR(-ENOMEM);
-
-	ret = dma_get_sgtable_attrs(priv->dma_dev, sgt, mtk_gem->cookie,
-				    mtk_gem->dma_addr, obj->size,
-				    mtk_gem->dma_attrs);
-	if (ret) {
-		DRM_ERROR("failed to allocate sgt, %d\n", ret);
-		kfree(sgt);
-		return ERR_PTR(ret);
-	}
-
-	return sgt;
-}
-
-struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
-			struct dma_buf_attachment *attach, struct sg_table *sg)
-{
-	struct mtk_drm_gem_obj *mtk_gem;
-	int ret;
-	struct scatterlist *s;
-	unsigned int i;
-	dma_addr_t expected;
-
-	mtk_gem = mtk_drm_gem_init(dev, attach->dmabuf->size);
-
-	if (IS_ERR(mtk_gem))
-		return ERR_CAST(mtk_gem);
-
-	expected = sg_dma_address(sg->sgl);
-	for_each_sg(sg->sgl, s, sg->nents, i) {
-		if (sg_dma_address(s) != expected) {
-			DRM_ERROR("sg_table is not contiguous");
-			ret = -EINVAL;
-			goto err_gem_free;
-		}
-		expected = sg_dma_address(s) + sg_dma_len(s);
-	}
-
-	mtk_gem->dma_addr = sg_dma_address(sg->sgl);
-	mtk_gem->sg = sg;
-
-	return &mtk_gem->base;
-
-err_gem_free:
-	kfree(mtk_gem);
-	return ERR_PTR(ret);
-}
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
deleted file mode 100644
index 534639b..0000000
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright (c) 2015 MediaTek Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _MTK_DRM_GEM_H_
-#define _MTK_DRM_GEM_H_
-
-#include <drm/drm_gem.h>
-
-/*
- * mtk drm buffer structure.
- *
- * @base: a gem object.
- *	- a new handle to this gem object would be created
- *	by drm_gem_handle_create().
- * @cookie: the return value of dma_alloc_attrs(), keep it for dma_free_attrs()
- * @kvaddr: kernel virtual address of gem buffer.
- * @dma_addr: dma address of gem buffer.
- * @dma_attrs: dma attributes of gem buffer.
- *
- * P.S. this object would be transferred to user as kms_bo.handle so
- *	user can access the buffer through kms_bo.handle.
- */
-struct mtk_drm_gem_obj {
-	struct drm_gem_object	base;
-	void			*cookie;
-	void			*kvaddr;
-	dma_addr_t		dma_addr;
-	unsigned long		dma_attrs;
-	struct sg_table		*sg;
-};
-
-#define to_mtk_gem_obj(x)	container_of(x, struct mtk_drm_gem_obj, base)
-
-void mtk_drm_gem_free_object(struct drm_gem_object *gem);
-struct mtk_drm_gem_obj *mtk_drm_gem_create(struct drm_device *dev, size_t size,
-					   bool alloc_kmap);
-int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
-			    struct drm_mode_create_dumb *args);
-int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
-int mtk_drm_gem_mmap_buf(struct drm_gem_object *obj,
-			 struct vm_area_struct *vma);
-struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj);
-struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
-			struct dma_buf_attachment *attach, struct sg_table *sg);
-
-#endif
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index f7e6aa1..62de9d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -15,13 +15,13 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
 
 #include "mtk_drm_crtc.h"
 #include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_fb.h"
-#include "mtk_drm_gem.h"
 #include "mtk_drm_plane.h"
 
 static const u32 formats[] = {
@@ -115,7 +115,7 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	struct drm_crtc *crtc = plane->state->crtc;
 	struct drm_framebuffer *fb = plane->state->fb;
 	struct drm_gem_object *gem;
-	struct mtk_drm_gem_obj *mtk_gem;
+	struct drm_gem_cma_object *cma_obj;
 	unsigned int pitch, format;
 	dma_addr_t addr;
 
@@ -123,8 +123,8 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 		return;
 
 	gem = fb->obj[0];
-	mtk_gem = to_mtk_gem_obj(gem);
-	addr = mtk_gem->dma_addr;
+	cma_obj = to_drm_gem_cma_obj(gem);
+	addr = cma_obj->paddr;
 	pitch = fb->pitches[0];
 	format = fb->format->format;
 
-- 
1.9.1

