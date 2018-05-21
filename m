Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeEURKg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:10:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36008 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeEURK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:10:29 -0400
X-Google-Smtp-Source: AB8JxZp9sXwEIAYjCRnT+nZujs4pi1jHFqtJPqBVddxqXkXM+OYh+SWvKD37dLxoBeOWeU6fvklfvQ==
Date: Mon, 21 May 2018 22:42:41 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, willy@infradead.org,
        daniel.vetter@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: etnaviv: Change return type to vm_fault_t
Message-ID: <20180521171241.GA18441@jordon-HP-15-Notebook-PC>
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

Previously vm_insert_page() returns err which driver
mapped into VM_FAULT_* type. The new function 
vmf_insert_page() will replace this inefficiency by
returning VM_FAULT_* type.

A non-fatal signal being delivered to a task which is
in the middle of a page fault may well end up in an
infinite loop, attempting to handle the page fault and
failing forever.

On seeing NOPAGE, the fault handler believes the PTE
is in the page table, so does nothing before it returns
to arch code. It will end up returning to userspace if
the signal is non-fatal, at which point it'll go right
back into the page fault handler, and mutex_lock_interruptible()
will immediately fail.  So we've converted a sleeping lock
into the most expensive spinlock.

I don't think the graphics drivers really want to be
interrupted by any signal.  I think they want to be
interruptible by fatal signals and should use the
mutex_lock_killable / fatal_signal_pending family of
functions. So mutex_lock_interruptible() is replaced
by mutex_lock_killable()

vmf_error() is the newly introduce inline function
in 4.17-rc6.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.h |  3 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 31 ++++++-------------------------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index a54f0b7..f6777f0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/sizes.h>
+#include <linux/mm_types.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
@@ -62,7 +63,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file);
 
 int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma);
-int etnaviv_gem_fault(struct vm_fault *vmf);
+vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf);
 int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset);
 struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj);
 void *etnaviv_gem_prime_vmap(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index fcc969f..d9b13f0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -180,7 +180,7 @@ int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	return obj->ops->mmap(obj, vma);
 }
 
-int etnaviv_gem_fault(struct vm_fault *vmf)
+vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
@@ -191,20 +191,19 @@ int etnaviv_gem_fault(struct vm_fault *vmf)
 
 	/*
 	 * Make sure we don't parallel update on a fault, nor move or remove
-	 * something from beneath our feet.  Note that vm_insert_page() is
+	 * something from beneath our feet.  Note that vmf_insert_page() is
 	 * specifically coded to take care of this, so we don't have to.
 	 */
-	ret = mutex_lock_interruptible(&etnaviv_obj->lock);
+	ret = mutex_lock_killable(&etnaviv_obj->lock);
 	if (ret)
-		goto out;
-
+		return VM_FAULT_NOPAGE;
 	/* make sure we have pages attached now */
 	pages = etnaviv_gem_get_pages(etnaviv_obj);
 	mutex_unlock(&etnaviv_obj->lock);
 
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
-		goto out;
+		return vmf_error(ret);
 	}
 
 	/* We don't use vmf->pgoff since that has the fake offset: */
@@ -215,25 +214,7 @@ int etnaviv_gem_fault(struct vm_fault *vmf)
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 	     page_to_pfn(page), page_to_pfn(page) << PAGE_SHIFT);
 
-	ret = vm_insert_page(vma, vmf->address, page);
-
-out:
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
+	return vmf_insert_page(vma, vmf->address, page);
 }
 
 int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset)
-- 
1.9.1
