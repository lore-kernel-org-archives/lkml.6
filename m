Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeEUR1o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:27:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36364 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbeEUR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:27:36 -0400
X-Google-Smtp-Source: AB8JxZqAAEVRFDQYjPzlm9HFFc8zNHZS+cXnvxcgZwQLsiUUx3o31lNAGkf2Tc6r3E7SsIC3SZIOHg==
Date: Mon, 21 May 2018 22:59:48 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: robdclark@gmail.com, airlied@linux.ie, willy@infradead.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH] gpu: drm: msm: Change return type to vm_fault_t
Message-ID: <20180521172948.GA18605@jordon-HP-15-Notebook-PC>
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

Ref- commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_mixed() returns err which driver
mapped into VM_FAULT_* type. The new function 
vmf_insert_mixed() will replace this inefficiency by
returning VM_FAULT_* type.

vmf_error() is the newly introduce inline function
in 4.17-rc6.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/gpu/drm/msm/msm_drv.h |  3 ++-
 drivers/gpu/drm/msm/msm_gem.c | 33 ++++++++++-----------------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 0a653dd..44b4ca7 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -33,6 +33,7 @@
 #include <linux/of_graph.h>
 #include <linux/of_device.h>
 #include <asm/sizes.h>
+#include <linux/mm_types.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
@@ -188,7 +189,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 int msm_gem_mmap_obj(struct drm_gem_object *obj,
 			struct vm_area_struct *vma);
 int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
-int msm_gem_fault(struct vm_fault *vmf);
+vm_fault_t msm_gem_fault(struct vm_fault *vmf);
 uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj);
 int msm_gem_get_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 07376de..27a5ab5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -217,7 +217,7 @@ int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	return msm_gem_mmap_obj(vma->vm_private_data, vma);
 }
 
-int msm_gem_fault(struct vm_fault *vmf)
+vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
@@ -225,15 +225,18 @@ int msm_gem_fault(struct vm_fault *vmf)
 	struct page **pages;
 	unsigned long pfn;
 	pgoff_t pgoff;
-	int ret;
+	int err;
+	vm_fault_t ret;
 
 	/*
 	 * vm_ops.open/drm_gem_mmap_obj and close get and put
 	 * a reference on obj. So, we dont need to hold one here.
 	 */
-	ret = mutex_lock_interruptible(&msm_obj->lock);
-	if (ret)
+	err = mutex_lock_interruptible(&msm_obj->lock);
+	if (err) {
+		ret = VM_FAULT_NOPAGE;
 		goto out;
+	}
 
 	if (WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED)) {
 		mutex_unlock(&msm_obj->lock);
@@ -243,7 +246,7 @@ int msm_gem_fault(struct vm_fault *vmf)
 	/* make sure we have pages attached now */
 	pages = get_pages(obj);
 	if (IS_ERR(pages)) {
-		ret = PTR_ERR(pages);
+		ret = vmf_error(PTR_ERR(pages));
 		goto out_unlock;
 	}
 
@@ -255,27 +258,11 @@ int msm_gem_fault(struct vm_fault *vmf)
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	ret = vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
-
+	ret = vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
 out_unlock:
 	mutex_unlock(&msm_obj->lock);
 out:
-	switch (ret) {
-	case -EAGAIN:
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
 
 /** get mmap offset */
-- 
1.9.1
