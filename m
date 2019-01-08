Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE920850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfAHLZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:25:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbfAHLZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:25:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02E87C05D3E4;
        Tue,  8 Jan 2019 11:25:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com [10.36.116.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A72C6601A7;
        Tue,  8 Jan 2019 11:25:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2E89F5EE3; Tue,  8 Jan 2019 12:25:21 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 11/15] drm/bochs: add basic prime support
Date:   Tue,  8 Jan 2019 12:25:15 +0100
Message-Id: <20190108112519.27473-12-kraxel@redhat.com>
In-Reply-To: <20190108112519.27473-1-kraxel@redhat.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 08 Jan 2019 11:25:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic framebuffer emulation needs this.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/bochs/bochs.h     | 11 +++++++
 drivers/gpu/drm/bochs/bochs_drv.c | 15 +++++++++-
 drivers/gpu/drm/bochs/bochs_mm.c  | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index d0d474e06f..df9ff6425d 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -145,6 +145,17 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
 int bochs_bo_unpin(struct bochs_bo *bo);
 
+int bochs_gem_prime_pin(struct drm_gem_object *obj);
+void bochs_gem_prime_unpin(struct drm_gem_object *obj);
+struct sg_table *bochs_gem_prime_get_sg_table(struct drm_gem_object *obj);
+struct drm_gem_object *bochs_gem_prime_import_sg_table(
+	struct drm_device *dev, struct dma_buf_attachment *attach,
+	struct sg_table *sgt);
+void *bochs_gem_prime_vmap(struct drm_gem_object *obj);
+void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+int bochs_gem_prime_mmap(struct drm_gem_object *obj,
+			 struct vm_area_struct *vma);
+
 /* bochs_kms.c */
 int bochs_kms_init(struct bochs_device *bochs);
 void bochs_kms_fini(struct bochs_device *bochs);
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 278f9d2e7f..a9c7140e3b 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -81,7 +81,8 @@ static const struct file_operations bochs_fops = {
 };
 
 static struct drm_driver bochs_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
+				  DRIVER_PRIME,
 	.fops			= &bochs_fops,
 	.name			= "bochs-drm",
 	.desc			= "bochs dispi vga interface (qemu stdvga)",
@@ -91,6 +92,18 @@ static struct drm_driver bochs_driver = {
 	.gem_free_object_unlocked = bochs_gem_free_object,
 	.dumb_create            = bochs_dumb_create,
 	.dumb_map_offset        = bochs_dumb_mmap_offset,
+
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_pin = bochs_gem_prime_pin,
+	.gem_prime_unpin = bochs_gem_prime_unpin,
+	.gem_prime_get_sg_table = bochs_gem_prime_get_sg_table,
+	.gem_prime_import_sg_table = bochs_gem_prime_import_sg_table,
+	.gem_prime_vmap = bochs_gem_prime_vmap,
+	.gem_prime_vunmap = bochs_gem_prime_vunmap,
+	.gem_prime_mmap = bochs_gem_prime_mmap,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 5a0e092847..cfe061c25f 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -387,3 +387,66 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 	drm_gem_object_put_unlocked(obj);
 	return 0;
 }
+
+/* ---------------------------------------------------------------------- */
+
+int bochs_gem_prime_pin(struct drm_gem_object *obj)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
+}
+
+void bochs_gem_prime_unpin(struct drm_gem_object *obj)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	bochs_bo_unpin(bo);
+}
+
+struct sg_table *bochs_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	WARN_ONCE(1, "not implemented");
+	return ERR_PTR(-ENODEV);
+}
+
+struct drm_gem_object *bochs_gem_prime_import_sg_table(
+	struct drm_device *dev, struct dma_buf_attachment *attach,
+	struct sg_table *table)
+{
+	WARN_ONCE(1, "not implemented");
+	return ERR_PTR(-ENODEV);
+}
+
+void *bochs_gem_prime_vmap(struct drm_gem_object *obj)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+	bool is_iomem;
+	int ret;
+
+	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
+	if (ret)
+		return NULL;
+	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
+	if (ret) {
+		bochs_bo_unpin(bo);
+		return NULL;
+	}
+	return ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
+}
+
+void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	ttm_bo_kunmap(&bo->kmap);
+	bochs_bo_unpin(bo);
+}
+
+int bochs_gem_prime_mmap(struct drm_gem_object *obj,
+			 struct vm_area_struct *vma)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	return ttm_fbdev_mmap(vma, &bo->bo);
+}
-- 
2.9.3

