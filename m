Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeEVSLr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:11:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44242 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeEVSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:11:44 -0400
X-Google-Smtp-Source: AB8JxZqy+IfrGi7HabVR9mbYFATC3sU0BPhZQeWIChoRklhcOUhV8d4u1dKukKmcAulGwVicDfPrug==
Date: Tue, 22 May 2018 23:43:57 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: tomi.valkeinen@ti.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v2] gpu: drm: omapdrm: Adding new typedef vm_fault_t
Message-ID: <20180522181357.GA31257@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_mixed() returns err which driver
mapped into VM_FAULT_* type. Also return value of
vm_insert_mixed() not handled correctly and 0 was
returned inside fault_2d() as default. The new function
vmf_insert_mixed() will replace this inefficiency by
returning correct VM_FAULT_* type.

vmf_error() is the newly introduce inline function
in 4.17-rc6.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Fixed kbuild error by initialized ret
    in fault_2d().

 drivers/gpu/drm/omapdrm/omap_gem.c | 51 +++++++++++++++++---------------------
 drivers/gpu/drm/omapdrm/omap_gem.h |  3 ++-
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 0faf042..99e4300 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -371,7 +371,7 @@ size_t omap_gem_mmap_size(struct drm_gem_object *obj)
  */
 
 /* Normal handling for the case of faulting in non-tiled buffers */
-static int fault_1d(struct drm_gem_object *obj,
+static vm_fault_t fault_1d(struct drm_gem_object *obj,
 		struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct omap_gem_object *omap_obj = to_omap_bo(obj);
@@ -392,11 +392,12 @@ static int fault_1d(struct drm_gem_object *obj,
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
+	return vmf_insert_mixed(vma, vmf->address,
+			__pfn_to_pfn_t(pfn, PFN_DEV));
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
-static int fault_2d(struct drm_gem_object *obj,
+static vm_fault_t fault_2d(struct drm_gem_object *obj,
 		struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct omap_gem_object *omap_obj = to_omap_bo(obj);
@@ -407,7 +408,8 @@ static int fault_2d(struct drm_gem_object *obj,
 	unsigned long pfn;
 	pgoff_t pgoff, base_pgoff;
 	unsigned long vaddr;
-	int i, ret, slots;
+	int i, err, slots;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 
 	/*
 	 * Note the height of the slot is also equal to the number of pages
@@ -473,9 +475,10 @@ static int fault_2d(struct drm_gem_object *obj,
 	memset(pages + slots, 0,
 			sizeof(struct page *) * (n - slots));
 
-	ret = tiler_pin(entry->block, pages, ARRAY_SIZE(pages), 0, true);
-	if (ret) {
-		dev_err(obj->dev->dev, "failed to pin: %d\n", ret);
+	err = tiler_pin(entry->block, pages, ARRAY_SIZE(pages), 0, true);
+	if (err) {
+		ret = vmf_error(err);
+		dev_err(obj->dev->dev, "failed to pin: %d\n", err);
 		return ret;
 	}
 
@@ -485,7 +488,10 @@ static int fault_2d(struct drm_gem_object *obj,
 			pfn, pfn << PAGE_SHIFT);
 
 	for (i = n; i > 0; i--) {
-		vm_insert_mixed(vma, vaddr, __pfn_to_pfn_t(pfn, PFN_DEV));
+		ret = vmf_insert_mixed(vma,
+			vaddr, __pfn_to_pfn_t(pfn, PFN_DEV));
+		if (ret & VM_FAULT_ERROR)
+			break;
 		pfn += priv->usergart[fmt].stride_pfn;
 		vaddr += PAGE_SIZE * m;
 	}
@@ -494,7 +500,7 @@ static int fault_2d(struct drm_gem_object *obj,
 	priv->usergart[fmt].last = (priv->usergart[fmt].last + 1)
 				 % NUM_USERGART_ENTRIES;
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -509,14 +515,15 @@ static int fault_2d(struct drm_gem_object *obj,
  * vma->vm_private_data points to the GEM object that is backing this
  * mapping.
  */
-int omap_gem_fault(struct vm_fault *vmf)
+vm_fault_t omap_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct omap_gem_object *omap_obj = to_omap_bo(obj);
 	struct drm_device *dev = obj->dev;
 	struct page **pages;
-	int ret;
+	int err;
+	vm_fault_t ret;
 
 	/* Make sure we don't parallel update on a fault, nor move or remove
 	 * something from beneath our feet
@@ -524,9 +531,11 @@ int omap_gem_fault(struct vm_fault *vmf)
 	mutex_lock(&dev->struct_mutex);
 
 	/* if a shmem backed object, make sure we have pages attached now */
-	ret = get_pages(obj, &pages);
-	if (ret)
+	err = get_pages(obj, &pages);
+	if (err) {
+		ret = vmf_error(err);
 		goto fail;
+	}
 
 	/* where should we do corresponding put_pages().. we are mapping
 	 * the original page, rather than thru a GART, so we can't rely
@@ -542,21 +551,7 @@ int omap_gem_fault(struct vm_fault *vmf)
 
 fail:
 	mutex_unlock(&dev->struct_mutex);
-	switch (ret) {
-	case 0:
-	case -ERESTARTSYS:
-	case -EINTR:
-	case -EBUSY:
-		/*
-		 * EBUSY is ok: this just means that another thread
-		 * already did the job.
-		 */
-		return VM_FAULT_NOPAGE;
-	case -ENOMEM:
-		return VM_FAULT_OOM;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
+	return ret;
 }
 
 /** We override mainly to fix up some of the vm mapping flags.. */
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.h b/drivers/gpu/drm/omapdrm/omap_gem.h
index a78bde0..c1c45fb 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.h
+++ b/drivers/gpu/drm/omapdrm/omap_gem.h
@@ -21,6 +21,7 @@
 #define __OMAPDRM_GEM_H__
 
 #include <linux/types.h>
+#include <linux/mm_types.h>
 
 enum dma_data_direction;
 
@@ -80,7 +81,7 @@ struct dma_buf *omap_gem_prime_export(struct drm_device *dev,
 struct drm_gem_object *omap_gem_prime_import(struct drm_device *dev,
 		struct dma_buf *buffer);
 
-int omap_gem_fault(struct vm_fault *vmf);
+vm_fault_t omap_gem_fault(struct vm_fault *vmf);
 int omap_gem_roll(struct drm_gem_object *obj, u32 roll);
 void omap_gem_cpu_sync_page(struct drm_gem_object *obj, int pgoff);
 void omap_gem_dma_sync_buffer(struct drm_gem_object *obj,
-- 
1.9.1
