Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F86C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAA32173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfAJI3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:29:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfAJI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:28:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF3DB2DACC0;
        Thu, 10 Jan 2019 08:28:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC8DD68B1B;
        Thu, 10 Jan 2019 08:28:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 551D3998A; Thu, 10 Jan 2019 09:28:47 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 12/15] drm/bochs: add basic prime support
Date:   Thu, 10 Jan 2019 09:28:42 +0100
Message-Id: <20190110082845.3453-13-kraxel@redhat.com>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 10 Jan 2019 08:28:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just enough to make the generic framebuffer emulation happy.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs.h     |  7 ++++++
 drivers/gpu/drm/bochs/bochs_drv.c | 11 ++++++++-
 drivers/gpu/drm/bochs/bochs_mm.c  | 49 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index d0d474e06f..ede22beb85 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -145,6 +145,13 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
 int bochs_bo_unpin(struct bochs_bo *bo);
 
+int bochs_gem_prime_pin(struct drm_gem_object *obj);
+void bochs_gem_prime_unpin(struct drm_gem_object *obj);
+void *bochs_gem_prime_vmap(struct drm_gem_object *obj);
+void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+int bochs_gem_prime_mmap(struct drm_gem_object *obj,
+			 struct vm_area_struct *vma);
+
 /* bochs_kms.c */
 int bochs_kms_init(struct bochs_device *bochs);
 void bochs_kms_fini(struct bochs_device *bochs);
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 278f9d2e7f..379111f5a0 100644
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
@@ -91,6 +92,14 @@ static struct drm_driver bochs_driver = {
 	.gem_free_object_unlocked = bochs_gem_free_object,
 	.dumb_create            = bochs_dumb_create,
 	.dumb_map_offset        = bochs_dumb_mmap_offset,
+
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_pin = bochs_gem_prime_pin,
+	.gem_prime_unpin = bochs_gem_prime_unpin,
+	.gem_prime_vmap = bochs_gem_prime_vmap,
+	.gem_prime_vunmap = bochs_gem_prime_vunmap,
+	.gem_prime_mmap = bochs_gem_prime_mmap,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index fcbf35456d..641a33f134 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -395,3 +395,52 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
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

