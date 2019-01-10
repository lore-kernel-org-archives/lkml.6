Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181D0214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfAJLQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:16:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfAJLQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:16:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F8745F789;
        Thu, 10 Jan 2019 11:15:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D957B68B02;
        Thu, 10 Jan 2019 11:15:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5920316E03; Thu, 10 Jan 2019 12:15:45 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: drop prime import/export callbacks
Date:   Thu, 10 Jan 2019 12:15:45 +0100
Message-Id: <20190110111545.26768-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 10 Jan 2019 11:16:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
userspace.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ----
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  4 ----
 drivers/gpu/drm/virtio/virtgpu_prime.c | 14 --------------
 3 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index cf896d8793..4f2f3c43a4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -354,10 +354,6 @@ int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
 /* virtgpu_prime.c */
 int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
 void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
-struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
-struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
-	struct drm_device *dev, struct dma_buf_attachment *attach,
-	struct sg_table *sgt);
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
 void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index af92964b68..b996ac1d4f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -205,14 +205,10 @@ static struct drm_driver driver = {
 #if defined(CONFIG_DEBUG_FS)
 	.debugfs_init = virtio_gpu_debugfs_init,
 #endif
-	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_export = drm_gem_prime_export,
 	.gem_prime_import = drm_gem_prime_import,
 	.gem_prime_pin = virtgpu_gem_prime_pin,
 	.gem_prime_unpin = virtgpu_gem_prime_unpin,
-	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
-	.gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
 	.gem_prime_vmap = virtgpu_gem_prime_vmap,
 	.gem_prime_vunmap = virtgpu_gem_prime_vunmap,
 	.gem_prime_mmap = virtgpu_gem_prime_mmap,
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 86ce0ae93f..c59ec34c80 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -39,20 +39,6 @@ void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
 	WARN_ONCE(1, "not implemented");
 }
 
-struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
-{
-	WARN_ONCE(1, "not implemented");
-	return ERR_PTR(-ENODEV);
-}
-
-struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
-	struct drm_device *dev, struct dma_buf_attachment *attach,
-	struct sg_table *table)
-{
-	WARN_ONCE(1, "not implemented");
-	return ERR_PTR(-ENODEV);
-}
-
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-- 
2.9.3

