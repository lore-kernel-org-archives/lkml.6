Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeDYE51 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:57:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40145 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDYE50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:57:26 -0400
X-Google-Smtp-Source: AIpwx4+qjUcm6Ti8C3AbzXPDo6HwHZd78DnDvyDaNk+9cr1dPH+6KC5vJu0iZXcqoNyJ8tgPmlDqMQ==
Date: Wed, 25 Apr 2018 10:29:22 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: airlied@redhat.com, christian.koenig@amd.com, cakturk@gmail.com,
        seanpaul@chromium.org, daniel.vetter@ffwll.ch, mhocko@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v2] gpu: drm: udl: Adding new typedef vm_fault_t
Message-ID: <20180425045922.GA21590@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault and huge_fault
handler. For now, this is just documenting that the
function returns a VM_FAULT value rather than an errno.
Once all instances are converted, vm_fault_t will become
a distinct type.

Commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_page() returns err which driver
mapped into VM_FAULT_* type. The new function vmf_
insert_page() will replace this inefficiency by
returning VM_FAULT_* type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Updated the change log

 drivers/gpu/drm/udl/udl_drv.h |  3 ++-
 drivers/gpu/drm/udl/udl_gem.c | 15 ++-------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 2a75ab8..11151c4 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -16,6 +16,7 @@

 #include <linux/usb.h>
 #include <drm/drm_gem.h>
+#include <linux/mm_types.h>

 #define DRIVER_NAME		"udl"
 #define DRIVER_DESC		"DisplayLink"
@@ -134,7 +135,7 @@ struct drm_gem_object *udl_gem_prime_import(struct drm_device *dev,
 int udl_gem_vmap(struct udl_gem_object *obj);
 void udl_gem_vunmap(struct udl_gem_object *obj);
 int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
-int udl_gem_fault(struct vm_fault *vmf);
+vm_fault_t udl_gem_fault(struct vm_fault *vmf);

 int udl_handle_damage(struct udl_framebuffer *fb, int x, int y,
 		      int width, int height);
diff --git a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
index dee6bd9..cf5fe35 100644
--- a/drivers/gpu/drm/udl/udl_gem.c
+++ b/drivers/gpu/drm/udl/udl_gem.c
@@ -100,13 +100,12 @@ int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }

-int udl_gem_fault(struct vm_fault *vmf)
+vm_fault_t udl_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct udl_gem_object *obj = to_udl_bo(vma->vm_private_data);
 	struct page *page;
 	unsigned int page_offset;
-	int ret = 0;

 	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;

@@ -114,17 +113,7 @@ int udl_gem_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;

 	page = obj->pages[page_offset];
-	ret = vm_insert_page(vma, vmf->address, page);
-	switch (ret) {
-	case -EAGAIN:
-	case 0:
-	case -ERESTARTSYS:
-		return VM_FAULT_NOPAGE;
-	case -ENOMEM:
-		return VM_FAULT_OOM;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
+	return vmf_insert_page(vma, vmf->address, page);
 }

 int udl_gem_get_pages(struct udl_gem_object *obj)
--
1.9.1
