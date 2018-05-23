Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933396AbeEWOoE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:44:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34938 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933151AbeEWOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:44:02 -0400
X-Google-Smtp-Source: AB8JxZrS7UBlluM74Ch9izmB7eYkSQ+hNAcegdLZU72xzy7+wcU8c/EBclTwGiuv/rGKUQb1LGICcw==
Date: Wed, 23 May 2018 20:16:15 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: patrik.r.jakobsson@gmail.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v2] gpu: drm: gma500: Change return type to vm_fault_t
Message-ID: <20180523144615.GA24563@jordon-HP-15-Notebook-PC>
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

Previously vm_insert_{pfn,mixed} returns err which driver
mapped into VM_FAULT_* type. The new function 
vmf_insert_{pfn,mixed} will replace this inefficiency by
returning VM_FAULT_* type.

vmf_error() is the newly introduce inline function
in 4.17-rc6.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: updated the change log

 drivers/gpu/drm/gma500/framebuffer.c | 14 +++++---------
 drivers/gpu/drm/gma500/gem.c         | 27 ++++++++++-----------------
 drivers/gpu/drm/gma500/psb_drv.h     |  3 ++-
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index cb0a2ae..7635ce8 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -111,7 +111,7 @@ static int psbfb_pan(struct fb_var_screeninfo *var, struct fb_info *info)
         return 0;
 }
 
-static int psbfb_vm_fault(struct vm_fault *vmf)
+static vm_fault_t psbfb_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct psb_framebuffer *psbfb = vma->vm_private_data;
@@ -120,7 +120,7 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
 	int page_num;
 	int i;
 	unsigned long address;
-	int ret;
+	vm_fault_t ret;
 	unsigned long pfn;
 	unsigned long phys_addr = (unsigned long)dev_priv->stolen_base +
 				  psbfb->gtt->offset;
@@ -133,18 +133,14 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
 	for (i = 0; i < page_num; i++) {
 		pfn = (phys_addr >> PAGE_SHIFT);
 
-		ret = vm_insert_mixed(vma, address,
+		ret = vmf_insert_mixed(vma, address,
 				__pfn_to_pfn_t(pfn, PFN_DEV));
-		if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
+		if (unlikely(ret & VM_FAULT_ERROR))
 			break;
-		else if (unlikely(ret != 0)) {
-			ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
-			return ret;
-		}
 		address += PAGE_SIZE;
 		phys_addr += PAGE_SIZE;
 	}
-	return VM_FAULT_NOPAGE;
+	return ret;
 }
 
 static void psbfb_vm_open(struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 1312397..e7be5c9 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -134,12 +134,13 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
  *	vma->vm_private_data points to the GEM object that is backing this
  *	mapping.
  */
-int psb_gem_fault(struct vm_fault *vmf)
+vm_fault_t psb_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj;
 	struct gtt_range *r;
-	int ret;
+	int err;
+	vm_fault_t ret;
 	unsigned long pfn;
 	pgoff_t page_offset;
 	struct drm_device *dev;
@@ -158,9 +159,10 @@ int psb_gem_fault(struct vm_fault *vmf)
 	/* For now the mmap pins the object and it stays pinned. As things
 	   stand that will do us no harm */
 	if (r->mmapping == 0) {
-		ret = psb_gtt_pin(r);
-		if (ret < 0) {
-			dev_err(dev->dev, "gma500: pin failed: %d\n", ret);
+		err = psb_gtt_pin(r);
+		if (err < 0) {
+			dev_err(dev->dev, "gma500: pin failed: %d\n", err);
+			ret = vmf_error(err);
 			goto fail;
 		}
 		r->mmapping = 1;
@@ -175,18 +177,9 @@ int psb_gem_fault(struct vm_fault *vmf)
 		pfn = (dev_priv->stolen_base + r->offset) >> PAGE_SHIFT;
 	else
 		pfn = page_to_pfn(r->pages[page_offset]);
-	ret = vm_insert_pfn(vma, vmf->address, pfn);
-
+	ret = vmf_insert_pfn(vma, vmf->address, pfn);
 fail:
 	mutex_unlock(&dev_priv->mmap_mutex);
-	switch (ret) {
-	case 0:
-	case -ERESTARTSYS:
-	case -EINTR:
-		return VM_FAULT_NOPAGE;
-	case -ENOMEM:
-		return VM_FAULT_OOM;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
+
+	return ret;
 }
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index e8300f5..93d2f40 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -21,6 +21,7 @@
 #define _PSB_DRV_H_
 
 #include <linux/kref.h>
+#include <linux/mm_types.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_global.h>
@@ -749,7 +750,7 @@ extern int psb_gem_get_aperture(struct drm_device *dev, void *data,
 			struct drm_file *file);
 extern int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			struct drm_mode_create_dumb *args);
-extern int psb_gem_fault(struct vm_fault *vmf);
+extern vm_fault_t psb_gem_fault(struct vm_fault *vmf);
 
 /* psb_device.c */
 extern const struct psb_ops psb_chip_ops;
-- 
1.9.1
