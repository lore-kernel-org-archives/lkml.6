Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F8F218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfA3Jn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:43:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730516AbfA3Jno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:43:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64FDF356F2;
        Wed, 30 Jan 2019 09:43:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-190.ams2.redhat.com [10.36.117.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3E155C21A;
        Wed, 30 Jan 2019 09:43:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C9A0097BF; Wed, 30 Jan 2019 10:43:38 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] drm/virtio: move virtio_gpu_object_{attach,detach} calls.
Date:   Wed, 30 Jan 2019 10:43:33 +0100
Message-Id: <20190130094338.14203-2-kraxel@redhat.com>
In-Reply-To: <20190130094338.14203-1-kraxel@redhat.com>
References: <20190130094338.14203-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 30 Jan 2019 09:43:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the dummy ttm backend implementation, add a real one for
TTM_PL_FLAG_TT objects.  The bin/unbind callbacks will call
virtio_gpu_object_{attach,detach}, to update the object state
on the host side, instead of invoking those calls from the
move_notify() callback.

With that in place the move and move_notify callbacks are not
needed any more, so drop them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ttm.c | 92 ++++++++++--------------------------
 1 file changed, 24 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 4bfbf25fab..77407976c7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -194,42 +194,45 @@ static void virtio_gpu_ttm_io_mem_free(struct ttm_bo_device *bdev,
  */
 struct virtio_gpu_ttm_tt {
 	struct ttm_dma_tt		ttm;
-	struct virtio_gpu_device	*vgdev;
-	u64				offset;
+	struct virtio_gpu_object        *obj;
 };
 
-static int virtio_gpu_ttm_backend_bind(struct ttm_tt *ttm,
-				       struct ttm_mem_reg *bo_mem)
+static int virtio_gpu_ttm_tt_bind(struct ttm_tt *ttm,
+				  struct ttm_mem_reg *bo_mem)
 {
-	struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
+	struct virtio_gpu_ttm_tt *gtt =
+		container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
+	struct virtio_gpu_device *vgdev =
+		virtio_gpu_get_vgdev(gtt->obj->tbo.bdev);
 
-	gtt->offset = (unsigned long)(bo_mem->start << PAGE_SHIFT);
-	if (!ttm->num_pages)
-		WARN(1, "nothing to bind %lu pages for mreg %p back %p!\n",
-		     ttm->num_pages, bo_mem, ttm);
-
-	/* Not implemented */
+	virtio_gpu_object_attach(vgdev, gtt->obj, NULL);
 	return 0;
 }
 
-static int virtio_gpu_ttm_backend_unbind(struct ttm_tt *ttm)
+static int virtio_gpu_ttm_tt_unbind(struct ttm_tt *ttm)
 {
-	/* Not implemented */
+	struct virtio_gpu_ttm_tt *gtt =
+		container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
+	struct virtio_gpu_device *vgdev =
+		virtio_gpu_get_vgdev(gtt->obj->tbo.bdev);
+
+	virtio_gpu_object_detach(vgdev, gtt->obj);
 	return 0;
 }
 
-static void virtio_gpu_ttm_backend_destroy(struct ttm_tt *ttm)
+static void virtio_gpu_ttm_tt_destroy(struct ttm_tt *ttm)
 {
-	struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
+	struct virtio_gpu_ttm_tt *gtt =
+		container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
 
 	ttm_dma_tt_fini(&gtt->ttm);
 	kfree(gtt);
 }
 
-static struct ttm_backend_func virtio_gpu_backend_func = {
-	.bind = &virtio_gpu_ttm_backend_bind,
-	.unbind = &virtio_gpu_ttm_backend_unbind,
-	.destroy = &virtio_gpu_ttm_backend_destroy,
+static struct ttm_backend_func virtio_gpu_tt_func = {
+	.bind = &virtio_gpu_ttm_tt_bind,
+	.unbind = &virtio_gpu_ttm_tt_unbind,
+	.destroy = &virtio_gpu_ttm_tt_destroy,
 };
 
 static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
@@ -242,8 +245,8 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
 	gtt = kzalloc(sizeof(struct virtio_gpu_ttm_tt), GFP_KERNEL);
 	if (gtt == NULL)
 		return NULL;
-	gtt->ttm.ttm.func = &virtio_gpu_backend_func;
-	gtt->vgdev = vgdev;
+	gtt->ttm.ttm.func = &virtio_gpu_tt_func;
+	gtt->obj = container_of(bo, struct virtio_gpu_object, tbo);
 	if (ttm_dma_tt_init(&gtt->ttm, bo, page_flags)) {
 		kfree(gtt);
 		return NULL;
@@ -251,51 +254,6 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
 	return &gtt->ttm.ttm;
 }
 
-static void virtio_gpu_move_null(struct ttm_buffer_object *bo,
-				 struct ttm_mem_reg *new_mem)
-{
-	struct ttm_mem_reg *old_mem = &bo->mem;
-
-	BUG_ON(old_mem->mm_node != NULL);
-	*old_mem = *new_mem;
-	new_mem->mm_node = NULL;
-}
-
-static int virtio_gpu_bo_move(struct ttm_buffer_object *bo, bool evict,
-			      struct ttm_operation_ctx *ctx,
-			      struct ttm_mem_reg *new_mem)
-{
-	int ret;
-
-	ret = ttm_bo_wait(bo, ctx->interruptible, ctx->no_wait_gpu);
-	if (ret)
-		return ret;
-
-	virtio_gpu_move_null(bo, new_mem);
-	return 0;
-}
-
-static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
-				      bool evict,
-				      struct ttm_mem_reg *new_mem)
-{
-	struct virtio_gpu_object *bo;
-	struct virtio_gpu_device *vgdev;
-
-	bo = container_of(tbo, struct virtio_gpu_object, tbo);
-	vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
-
-	if (!new_mem || (new_mem->placement & TTM_PL_FLAG_SYSTEM)) {
-		if (bo->hw_res_handle)
-			virtio_gpu_object_detach(vgdev, bo);
-
-	} else if (new_mem->placement & TTM_PL_FLAG_TT) {
-		if (bo->hw_res_handle) {
-			virtio_gpu_object_attach(vgdev, bo, NULL);
-		}
-	}
-}
-
 static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
 {
 	struct virtio_gpu_object *bo;
@@ -314,11 +272,9 @@ static struct ttm_bo_driver virtio_gpu_bo_driver = {
 	.init_mem_type = &virtio_gpu_init_mem_type,
 	.eviction_valuable = ttm_bo_eviction_valuable,
 	.evict_flags = &virtio_gpu_evict_flags,
-	.move = &virtio_gpu_bo_move,
 	.verify_access = &virtio_gpu_verify_access,
 	.io_mem_reserve = &virtio_gpu_ttm_io_mem_reserve,
 	.io_mem_free = &virtio_gpu_ttm_io_mem_free,
-	.move_notify = &virtio_gpu_bo_move_notify,
 	.swap_notify = &virtio_gpu_bo_swap_notify,
 };
 
-- 
2.9.3

