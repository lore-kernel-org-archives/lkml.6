Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C0BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148E42133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148E42133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeK1Hhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:37:33 -0500
Received: from anholt.net ([50.246.234.109]:45512 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1Hhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:37:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9687610A0F9D;
        Tue, 27 Nov 2018 12:38:26 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OGGDH0RtzG46; Tue, 27 Nov 2018 12:38:22 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0556810A0612;
        Tue, 27 Nov 2018 12:38:22 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 87E9C2FE2D5B; Tue, 27 Nov 2018 12:38:21 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/2] drm/vkms: Add PRIME support by converting to Noralf's shmem helpers.
Date:   Tue, 27 Nov 2018 12:38:21 -0800
Message-Id: <20181127203821.12636-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181127203821.12636-1-eric@anholt.net>
References: <20181127203821.12636-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cuts out a tremendous amount of boilerplate.  I've used the PRIME
support now to test V3D rendering on a STB development board with no
KMS driver.

v2: Use the DEFINE_DRM_GEM_SHMEM_FOPS for proper mmap setup.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1)
---
 drivers/gpu/drm/Kconfig           |   1 +
 drivers/gpu/drm/vkms/vkms_crc.c   |  28 ++--
 drivers/gpu/drm/vkms/vkms_drv.c   |  28 +---
 drivers/gpu/drm/vkms/vkms_drv.h   |  22 ----
 drivers/gpu/drm/vkms/vkms_gem.c   | 212 ++----------------------------
 drivers/gpu/drm/vkms/vkms_plane.c |  17 ++-
 6 files changed, 43 insertions(+), 265 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 0dedbc040c77..3bdd95f99feb 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -253,6 +253,7 @@ config DRM_VKMS
 	tristate "Virtual KMS (EXPERIMENTAL)"
 	depends on DRM
 	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
 	default n
 	help
 	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
index 9d9e8146db90..72d6422fb1a5 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -4,6 +4,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
 
 /**
  * compute_crc - Compute CRC value on output frame
@@ -91,21 +92,19 @@ static void compose_cursor(struct vkms_crc_data *cursor_crc,
 			   struct vkms_crc_data *primary_crc, void *vaddr_out)
 {
 	struct drm_gem_object *cursor_obj;
-	struct vkms_gem_object *cursor_vkms_obj;
+	void *vaddr;
 
 	cursor_obj = drm_gem_fb_get_obj(&cursor_crc->fb, 0);
-	cursor_vkms_obj = drm_gem_to_vkms_gem(cursor_obj);
+	vaddr = drm_gem_shmem_vmap(cursor_obj);
 
-	mutex_lock(&cursor_vkms_obj->pages_lock);
-	if (!cursor_vkms_obj->vaddr) {
+	if (IS_ERR(vaddr)) {
 		DRM_WARN("cursor plane vaddr is NULL");
-		goto out;
+		return;
 	}
 
-	blend(vaddr_out, cursor_vkms_obj->vaddr, primary_crc, cursor_crc);
+	blend(vaddr_out, vaddr, primary_crc, cursor_crc);
 
-out:
-	mutex_unlock(&cursor_vkms_obj->pages_lock);
+	drm_gem_shmem_vunmap(cursor_obj, vaddr);
 }
 
 static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
@@ -113,8 +112,8 @@ static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
 {
 	struct drm_framebuffer *fb = &primary_crc->fb;
 	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
-	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(gem_obj);
-	void *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
+	void *vaddr;
+	void *vaddr_out = kzalloc(gem_obj->size, GFP_KERNEL);
 	u32 crc = 0;
 
 	if (!vaddr_out) {
@@ -122,21 +121,20 @@ static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
 		return 0;
 	}
 
-	mutex_lock(&vkms_obj->pages_lock);
-	if (WARN_ON(!vkms_obj->vaddr)) {
-		mutex_unlock(&vkms_obj->pages_lock);
+	vaddr = drm_gem_shmem_vmap(gem_obj);
+	if (WARN_ON(IS_ERR(vaddr))) {
 		kfree(vaddr_out);
 		return crc;
 	}
 
-	memcpy(vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
-	mutex_unlock(&vkms_obj->pages_lock);
+	memcpy(vaddr_out, vaddr, gem_obj->size);
 
 	if (cursor_crc)
 		compose_cursor(cursor_crc, primary_crc, vaddr_out);
 
 	crc = compute_crc(vaddr_out, primary_crc);
 
+	drm_gem_shmem_vunmap(gem_obj, vaddr);
 	kfree(vaddr_out);
 
 	return crc;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 83087877565c..18f145f0f4db 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -19,6 +19,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_fb_helper.h>
 #include "vkms_drv.h"
 
@@ -34,23 +35,7 @@ bool enable_cursor;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
 
-static const struct file_operations vkms_driver_fops = {
-	.owner		= THIS_MODULE,
-	.open		= drm_open,
-	.mmap		= drm_gem_mmap,
-	.unlocked_ioctl	= drm_ioctl,
-	.compat_ioctl	= drm_compat_ioctl,
-	.poll		= drm_poll,
-	.read		= drm_read,
-	.llseek		= no_llseek,
-	.release	= drm_release,
-};
-
-static const struct vm_operations_struct vkms_gem_vm_ops = {
-	.fault = vkms_gem_fault,
-	.open = drm_gem_vm_open,
-	.close = drm_gem_vm_close,
-};
+DEFINE_DRM_GEM_SHMEM_FOPS(vkms_driver_fops);
 
 static void vkms_release(struct drm_device *dev)
 {
@@ -64,12 +49,13 @@ static void vkms_release(struct drm_device *dev)
 }
 
 static struct drm_driver vkms_driver = {
-	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
+	.driver_features	= (DRIVER_MODESET |
+				   DRIVER_ATOMIC |
+				   DRIVER_GEM |
+				   DRIVER_PRIME),
 	.release		= vkms_release,
 	.fops			= &vkms_driver_fops,
-	.dumb_create		= vkms_dumb_create,
-	.gem_vm_ops		= &vkms_gem_vm_ops,
-	.gem_free_object_unlocked = vkms_gem_free_object,
+	DRM_GEM_SHMEM_DRIVER_OPS,
 	.get_vblank_timestamp	= vkms_get_vblank_timestamp,
 
 	.name			= DRIVER_NAME,
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index e4469cd3d254..3faf49f43feb 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -80,23 +80,12 @@ struct vkms_device {
 	struct vkms_output output;
 };
 
-struct vkms_gem_object {
-	struct drm_gem_object gem;
-	struct mutex pages_lock; /* Page lock used in page fault handler */
-	struct page **pages;
-	unsigned int vmap_count;
-	void *vaddr;
-};
-
 #define drm_crtc_to_vkms_output(target) \
 	container_of(target, struct vkms_output, crtc)
 
 #define drm_device_to_vkms_device(target) \
 	container_of(target, struct vkms_device, drm)
 
-#define drm_gem_to_vkms_gem(target)\
-	container_of(target, struct vkms_gem_object, gem)
-
 #define to_vkms_crtc_state(target)\
 	container_of(target, struct vkms_crtc_state, base)
 
@@ -122,17 +111,6 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 				       u32 *handle,
 				       u64 size);
 
-vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
-
-int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
-		     struct drm_mode_create_dumb *args);
-
-void vkms_gem_free_object(struct drm_gem_object *obj);
-
-int vkms_gem_vmap(struct drm_gem_object *obj);
-
-void vkms_gem_vunmap(struct drm_gem_object *obj);
-
 /* CRC Support */
 int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name);
 int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index 80311daed47a..11f52aa4e732 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -7,222 +7,34 @@
  */
 
 #include <linux/shmem_fs.h>
+#include <drm/drm_gem_shmem_helper.h>
 
 #include "vkms_drv.h"
 
-static struct vkms_gem_object *__vkms_gem_create(struct drm_device *dev,
-						 u64 size)
-{
-	struct vkms_gem_object *obj;
-	int ret;
-
-	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
-	if (!obj)
-		return ERR_PTR(-ENOMEM);
-
-	size = roundup(size, PAGE_SIZE);
-	ret = drm_gem_object_init(dev, &obj->gem, size);
-	if (ret) {
-		kfree(obj);
-		return ERR_PTR(ret);
-	}
-
-	mutex_init(&obj->pages_lock);
-
-	return obj;
-}
-
-void vkms_gem_free_object(struct drm_gem_object *obj)
-{
-	struct vkms_gem_object *gem = container_of(obj, struct vkms_gem_object,
-						   gem);
-
-	WARN_ON(gem->pages);
-	WARN_ON(gem->vaddr);
-
-	mutex_destroy(&gem->pages_lock);
-	drm_gem_object_release(obj);
-	kfree(gem);
-}
-
-vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
-{
-	struct vm_area_struct *vma = vmf->vma;
-	struct vkms_gem_object *obj = vma->vm_private_data;
-	unsigned long vaddr = vmf->address;
-	pgoff_t page_offset;
-	loff_t num_pages;
-	vm_fault_t ret = VM_FAULT_SIGBUS;
-
-	page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
-	num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
-
-	if (page_offset > num_pages)
-		return VM_FAULT_SIGBUS;
-
-	mutex_lock(&obj->pages_lock);
-	if (obj->pages) {
-		get_page(obj->pages[page_offset]);
-		vmf->page = obj->pages[page_offset];
-		ret = 0;
-	}
-	mutex_unlock(&obj->pages_lock);
-	if (ret) {
-		struct page *page;
-		struct address_space *mapping;
-
-		mapping = file_inode(obj->gem.filp)->i_mapping;
-		page = shmem_read_mapping_page(mapping, page_offset);
-
-		if (!IS_ERR(page)) {
-			vmf->page = page;
-			ret = 0;
-		} else {
-			switch (PTR_ERR(page)) {
-			case -ENOSPC:
-			case -ENOMEM:
-				ret = VM_FAULT_OOM;
-				break;
-			case -EBUSY:
-				ret = VM_FAULT_RETRY;
-				break;
-			case -EFAULT:
-			case -EINVAL:
-				ret = VM_FAULT_SIGBUS;
-				break;
-			default:
-				WARN_ON(PTR_ERR(page));
-				ret = VM_FAULT_SIGBUS;
-				break;
-			}
-		}
-	}
-	return ret;
-}
-
 struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 				       struct drm_file *file,
 				       u32 *handle,
 				       u64 size)
 {
-	struct vkms_gem_object *obj;
+	struct drm_gem_shmem_object *obj;
 	int ret;
 
 	if (!file || !dev || !handle)
 		return ERR_PTR(-EINVAL);
 
-	obj = __vkms_gem_create(dev, size);
+	obj = drm_gem_shmem_create(dev, size);
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 
-	ret = drm_gem_handle_create(file, &obj->gem, handle);
-	drm_gem_object_put_unlocked(&obj->gem);
-	if (ret) {
-		drm_gem_object_release(&obj->gem);
-		kfree(obj);
+	/*
+	 * Allocate an id of idr table where the obj is registered
+	 * and handle has the id what user can see.
+	 */
+	ret = drm_gem_handle_create(file, &obj->base, handle);
+	/* drop reference from allocate - handle holds it now. */
+	drm_gem_object_put_unlocked(&obj->base);
+	if (ret)
 		return ERR_PTR(ret);
-	}
-
-	return &obj->gem;
-}
-
-int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
-		     struct drm_mode_create_dumb *args)
-{
-	struct drm_gem_object *gem_obj;
-	u64 pitch, size;
-
-	if (!args || !dev || !file)
-		return -EINVAL;
-
-	pitch = args->width * DIV_ROUND_UP(args->bpp, 8);
-	size = pitch * args->height;
-
-	if (!size)
-		return -EINVAL;
-
-	gem_obj = vkms_gem_create(dev, file, &args->handle, size);
-	if (IS_ERR(gem_obj))
-		return PTR_ERR(gem_obj);
-
-	args->size = gem_obj->size;
-	args->pitch = pitch;
-
-	DRM_DEBUG_DRIVER("Created object of size %lld\n", size);
-
-	return 0;
-}
-
-static struct page **_get_pages(struct vkms_gem_object *vkms_obj)
-{
-	struct drm_gem_object *gem_obj = &vkms_obj->gem;
-
-	if (!vkms_obj->pages) {
-		struct page **pages = drm_gem_get_pages(gem_obj);
-
-		if (IS_ERR(pages))
-			return pages;
-
-		if (cmpxchg(&vkms_obj->pages, NULL, pages))
-			drm_gem_put_pages(gem_obj, pages, false, true);
-	}
-
-	return vkms_obj->pages;
-}
-
-void vkms_gem_vunmap(struct drm_gem_object *obj)
-{
-	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(obj);
-
-	mutex_lock(&vkms_obj->pages_lock);
-	if (vkms_obj->vmap_count < 1) {
-		WARN_ON(vkms_obj->vaddr);
-		WARN_ON(vkms_obj->pages);
-		mutex_unlock(&vkms_obj->pages_lock);
-		return;
-	}
-
-	vkms_obj->vmap_count--;
-
-	if (vkms_obj->vmap_count == 0) {
-		vunmap(vkms_obj->vaddr);
-		vkms_obj->vaddr = NULL;
-		drm_gem_put_pages(obj, vkms_obj->pages, false, true);
-		vkms_obj->pages = NULL;
-	}
-
-	mutex_unlock(&vkms_obj->pages_lock);
-}
-
-int vkms_gem_vmap(struct drm_gem_object *obj)
-{
-	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(obj);
-	int ret = 0;
-
-	mutex_lock(&vkms_obj->pages_lock);
-
-	if (!vkms_obj->vaddr) {
-		unsigned int n_pages = obj->size >> PAGE_SHIFT;
-		struct page **pages = _get_pages(vkms_obj);
-
-		if (IS_ERR(pages)) {
-			ret = PTR_ERR(pages);
-			goto out;
-		}
-
-		vkms_obj->vaddr = vmap(pages, n_pages, VM_MAP, PAGE_KERNEL);
-		if (!vkms_obj->vaddr)
-			goto err_vmap;
-	}
-
-	vkms_obj->vmap_count++;
-	goto out;
 
-err_vmap:
-	ret = -ENOMEM;
-	drm_gem_put_pages(obj, vkms_obj->pages, false, true);
-	vkms_obj->pages = NULL;
-out:
-	mutex_unlock(&vkms_obj->pages_lock);
-	return ret;
+	return &obj->base;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 7041007396ae..29e6e870d7ac 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -11,6 +11,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
 
 static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
@@ -138,17 +139,17 @@ static int vkms_prepare_fb(struct drm_plane *plane,
 			   struct drm_plane_state *state)
 {
 	struct drm_gem_object *gem_obj;
-	struct vkms_gem_object *vkms_obj;
-	int ret;
+	void *map;
 
 	if (!state->fb)
 		return 0;
 
 	gem_obj = drm_gem_fb_get_obj(state->fb, 0);
-	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
-	ret = vkms_gem_vmap(gem_obj);
-	if (ret)
-		DRM_ERROR("vmap failed: %d\n", ret);
+	map = drm_gem_shmem_vmap(gem_obj);
+	if (IS_ERR(map)) {
+		DRM_ERROR("vmap failed: %ld\n", PTR_ERR(map));
+		return PTR_ERR(map);
+	}
 
 	return drm_gem_fb_prepare_fb(plane, state);
 }
@@ -157,12 +158,14 @@ static void vkms_cleanup_fb(struct drm_plane *plane,
 			    struct drm_plane_state *old_state)
 {
 	struct drm_gem_object *gem_obj;
+	struct drm_gem_shmem_object *shmem_obj;
 
 	if (!old_state->fb)
 		return;
 
 	gem_obj = drm_gem_fb_get_obj(old_state->fb, 0);
-	vkms_gem_vunmap(gem_obj);
+	shmem_obj = to_drm_gem_shmem_obj(gem_obj);
+	drm_gem_shmem_vunmap(gem_obj, shmem_obj->vaddr);
 }
 
 static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
-- 
2.20.0.rc1

