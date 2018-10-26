Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3688A2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3688A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeJZP6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:58:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726020AbeJZP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:58:41 -0400
X-UUID: 239817b9c3fd4db8b501fc4e3e475c28-20181026
X-UUID: 239817b9c3fd4db8b501fc4e3e475c28-20181026
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 337886093; Fri, 26 Oct 2018 15:22:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 2/3] drm: Add drm_gem_cma_dumb_create_no_kmap() helper function
Date:   Fri, 26 Oct 2018 15:22:02 +0800
Message-ID: <1540538523-1973-3-git-send-email-ck.hu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
References: <1540538523-1973-1-git-send-email-ck.hu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For iommu-supporting device, mapping kernel virtual address would reduce
free virtual memory area, and kernel usually need not using this virtual
address, so add drm_gem_cma_dumb_create_no_kmap() to create cma dumb
without mapping kernel virtual address.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 99 +++++++++++++++++++++++++++++-------
 include/drm/drm_gem_cma_helper.h     |  7 +++
 2 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 0ba2c2a..c8e0e8e 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -85,20 +85,23 @@
 }
 
 /**
- * drm_gem_cma_create - allocate an object with the given size
+ * drm_gem_cma_create_kmap - allocate an object with the given size and
+ * map kernel virtual address.
  * @drm: DRM device
  * @size: size of the object to allocate
+ * @alloc_kmap: dma allocation with kernel mapping
  *
- * This function creates a CMA GEM object and allocates a contiguous chunk of
- * memory as backing store. The backing memory has the writecombine attribute
- * set.
+ * This function creates a CMA GEM object and allocates a memory as
+ * backing store. The backing memory has the writecombine attribute
+ * set. If alloc_kmap is true, the backing memory also has the kernel mapping
+ * attribute set.
  *
  * Returns:
  * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
  * error code on failure.
  */
-struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
-					      size_t size)
+static struct drm_gem_cma_object *
+drm_gem_cma_create_kmap(struct drm_device *drm, size_t size, bool alloc_kmap)
 {
 	struct drm_gem_cma_object *cma_obj;
 	struct device *dev = drm->dma_dev ? drm->dma_dev : drm->dev;
@@ -110,21 +113,48 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 	if (IS_ERR(cma_obj))
 		return cma_obj;
 
-	cma_obj->vaddr = dma_alloc_wc(dev, size, &cma_obj->paddr,
-				      GFP_KERNEL | __GFP_NOWARN);
-	if (!cma_obj->vaddr) {
+	cma_obj->dma_attrs = DMA_ATTR_WRITE_COMBINE;
+	if (!alloc_kmap)
+		cma_obj->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
+
+	cma_obj->cookie = dma_alloc_attrs(dev, size, &cma_obj->paddr,
+					 GFP_KERNEL | __GFP_NOWARN,
+					 cma_obj->dma_attrs);
+	if (!cma_obj->cookie) {
 		dev_dbg(dev, "failed to allocate buffer with size %zu\n",
 			size);
 		ret = -ENOMEM;
 		goto error;
 	}
 
+	if (alloc_kmap)
+		cma_obj->vaddr = cma_obj->cookie;
+
 	return cma_obj;
 
 error:
 	drm_gem_object_put_unlocked(&cma_obj->base);
 	return ERR_PTR(ret);
 }
+
+/**
+ * drm_gem_cma_create - allocate an object with the given size
+ * @drm: DRM device
+ * @size: size of the object to allocate
+ *
+ * This function creates a CMA GEM object and allocates a contiguous chunk of
+ * memory as backing store. The backing memory has the writecombine attribute
+ * set.
+ *
+ * Returns:
+ * A struct drm_gem_cma_object * on success or an ERR_PTR()-encoded negative
+ * error code on failure.
+ */
+struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
+					      size_t size)
+{
+	return drm_gem_cma_create_kmap(drm, size, true);
+}
 EXPORT_SYMBOL_GPL(drm_gem_cma_create);
 
 /**
@@ -146,13 +176,13 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 static struct drm_gem_cma_object *
 drm_gem_cma_create_with_handle(struct drm_file *file_priv,
 			       struct drm_device *drm, size_t size,
-			       uint32_t *handle)
+			       uint32_t *handle, bool alloc_kmap)
 {
 	struct drm_gem_cma_object *cma_obj;
 	struct drm_gem_object *gem_obj;
 	int ret;
 
-	cma_obj = drm_gem_cma_create(drm, size);
+	cma_obj = drm_gem_cma_create_kmap(drm, size, alloc_kmap);
 	if (IS_ERR(cma_obj))
 		return cma_obj;
 
@@ -187,11 +217,12 @@ void drm_gem_cma_free_object(struct drm_gem_object *gem_obj)
 
 	cma_obj = to_drm_gem_cma_obj(gem_obj);
 
-	if (cma_obj->vaddr) {
+	if (cma_obj->cookie) {
 		dev = gem_obj->dev->dma_dev ?
 		      gem_obj->dev->dma_dev : gem_obj->dev->dev;
-		dma_free_wc(dev, cma_obj->base.size,
-			    cma_obj->vaddr, cma_obj->paddr);
+		dma_free_attrs(dev, cma_obj->base.size,
+			       cma_obj->cookie, cma_obj->paddr,
+			       cma_obj->dma_attrs);
 	} else if (gem_obj->import_attach) {
 		drm_prime_gem_destroy(gem_obj, cma_obj->sgt);
 	}
@@ -230,7 +261,7 @@ int drm_gem_cma_dumb_create_internal(struct drm_file *file_priv,
 		args->size = args->pitch * args->height;
 
 	cma_obj = drm_gem_cma_create_with_handle(file_priv, drm, args->size,
-						 &args->handle);
+						 &args->handle, true);
 	return PTR_ERR_OR_ZERO(cma_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_dumb_create_internal);
@@ -263,11 +294,43 @@ int drm_gem_cma_dumb_create(struct drm_file *file_priv,
 	args->size = args->pitch * args->height;
 
 	cma_obj = drm_gem_cma_create_with_handle(file_priv, drm, args->size,
-						 &args->handle);
+						 &args->handle, true);
 	return PTR_ERR_OR_ZERO(cma_obj);
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_dumb_create);
 
+/**
+ * drm_gem_cma_dumb_create_no_kmap - create a dumb buffer object without
+ *                                   kernel mapping
+ * @file_priv: DRM file-private structure to create the dumb buffer for
+ * @drm: DRM device
+ * @args: IOCTL data
+ *
+ * This function computes the pitch of the dumb buffer and rounds it up to an
+ * integer number of bytes per pixel. Drivers for hardware that doesn't have
+ * any additional restrictions on the pitch can directly use this function as
+ * their &drm_driver.dumb_create callback.
+ *
+ * For hardware with additional restrictions, don't use this function.
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_cma_dumb_create_no_kmap(struct drm_file *file_priv,
+				    struct drm_device *drm,
+				    struct drm_mode_create_dumb *args)
+{
+	struct drm_gem_cma_object *cma_obj;
+
+	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
+	args->size = args->pitch * args->height;
+
+	cma_obj = drm_gem_cma_create_with_handle(file_priv, drm, args->size,
+						 &args->handle, false);
+	return PTR_ERR_OR_ZERO(cma_obj);
+}
+EXPORT_SYMBOL_GPL(drm_gem_cma_dumb_create_no_kmap);
+
 const struct vm_operations_struct drm_gem_cma_vm_ops = {
 	.open = drm_gem_vm_open,
 	.close = drm_gem_vm_close,
@@ -290,7 +353,7 @@ static int drm_gem_cma_mmap_obj(struct drm_gem_cma_object *cma_obj,
 
 	dev = cma_obj->base.dev->dma_dev ?
 	      cma_obj->base.dev->dma_dev : cma_obj->base.dev->dev;
-	ret = dma_mmap_wc(dev, vma, cma_obj->vaddr,
+	ret = dma_mmap_wc(dev, vma, cma_obj->cookie,
 			  cma_obj->paddr, vma->vm_end - vma->vm_start);
 	if (ret)
 		drm_gem_vm_close(vma);
@@ -447,7 +510,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
 		return NULL;
 
 	dev = obj->dev->dma_dev ? obj->dev->dma_dev : obj->dev->dev;
-	ret = dma_get_sgtable(dev, sgt, cma_obj->vaddr,
+	ret = dma_get_sgtable(dev, sgt, cma_obj->cookie,
 			      cma_obj->paddr, obj->size);
 	if (ret < 0)
 		goto out;
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 1977714..5164925 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -20,7 +20,9 @@ struct drm_gem_cma_object {
 	struct sg_table *sgt;
 
 	/* For objects with DMA memory allocated by GEM CMA */
+	void *cookie;
 	void *vaddr;
+	unsigned long dma_attrs;
 };
 
 #define to_drm_gem_cma_obj(gem_obj) \
@@ -73,6 +75,11 @@ int drm_gem_cma_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *drm,
 			    struct drm_mode_create_dumb *args);
 
+/* create memory region for DRM framebuffer */
+int drm_gem_cma_dumb_create_no_kmap(struct drm_file *file_priv,
+				    struct drm_device *drm,
+				    struct drm_mode_create_dumb *args);
+
 /* set vm_flags and we can change the VM attribute to other one at here */
 int drm_gem_cma_mmap(struct file *filp, struct vm_area_struct *vma);
 
-- 
1.9.1

