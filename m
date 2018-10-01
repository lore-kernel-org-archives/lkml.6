Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B065C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8AB2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8AB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeJARJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbeJARJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:09:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 314DD30821F3;
        Mon,  1 Oct 2018 10:32:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8730070588;
        Mon,  1 Oct 2018 10:32:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6EFE39D367; Mon,  1 Oct 2018 12:32:24 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach,detach} calls.
Date:   Mon,  1 Oct 2018 12:32:21 +0200
Message-Id: <20181001103222.11924-8-kraxel@redhat.com>
In-Reply-To: <20181001103222.11924-1-kraxel@redhat.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 01 Oct 2018 10:32:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the virtio_gpu_object_{attach,detach} calls from move_notify()
callback.  Add them to the ttm_tt_{populate,unpopulate} callbacks, which
is the correct place to handle this.

The new ttm_tt_{populate,unpopulate} callbacks call the
ttm_pool_populate()/unpopulate() functions (which are the default
implementation in case the callbacks not present) for the actual ttm
work.  Additionally virtio_gpu_object_{attach,detach} is called to
update the state on the host.

With that in place the move and move_notify callbacks are not needed
any more, so drop them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ttm.c | 70 +++++++++++-------------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index cd63dffa6d..96fb17e0fc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -250,33 +250,24 @@ static void virtio_gpu_ttm_io_mem_free(struct ttm_bo_device *bdev,
  */
 struct virtio_gpu_ttm_tt {
 	struct ttm_dma_tt		ttm;
-	struct virtio_gpu_device	*vgdev;
-	u64				offset;
+	struct virtio_gpu_object        *obj;
 };
 
 static int virtio_gpu_ttm_backend_bind(struct ttm_tt *ttm,
 				       struct ttm_mem_reg *bo_mem)
 {
-	struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
-
-	gtt->offset = (unsigned long)(bo_mem->start << PAGE_SHIFT);
-	if (!ttm->num_pages)
-		WARN(1, "nothing to bind %lu pages for mreg %p back %p!\n",
-		     ttm->num_pages, bo_mem, ttm);
-
-	/* Not implemented */
 	return 0;
 }
 
 static int virtio_gpu_ttm_backend_unbind(struct ttm_tt *ttm)
 {
-	/* Not implemented */
 	return 0;
 }
 
 static void virtio_gpu_ttm_backend_destroy(struct ttm_tt *ttm)
 {
-	struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
+	struct virtio_gpu_ttm_tt *gtt =
+		container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
 
 	ttm_dma_tt_fini(&gtt->ttm);
 	kfree(gtt);
@@ -299,7 +290,7 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
 	if (gtt == NULL)
 		return NULL;
 	gtt->ttm.ttm.func = &virtio_gpu_backend_func;
-	gtt->vgdev = vgdev;
+	gtt->obj = container_of(bo, struct virtio_gpu_object, tbo);
 	if (ttm_dma_tt_init(&gtt->ttm, bo, page_flags)) {
 		kfree(gtt);
 		return NULL;
@@ -307,49 +298,30 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
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
+static int virtio_gpu_ttm_tt_populate(struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
 {
+	struct virtio_gpu_ttm_tt *gtt =
+		container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
+	struct virtio_gpu_device *vgdev =
+		(struct virtio_gpu_device *)gtt->obj->gem_base.dev->dev_private;
 	int ret;
 
-	ret = ttm_bo_wait(bo, ctx->interruptible, ctx->no_wait_gpu);
+	ret = ttm_pool_populate(ttm, ctx);
 	if (ret)
 		return ret;
-
-	virtio_gpu_move_null(bo, new_mem);
-	return 0;
+	virtio_gpu_object_attach(vgdev, gtt->obj, NULL);
+	return ret;
 }
 
-static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
-				      bool evict,
-				      struct ttm_mem_reg *new_mem)
+static void virtio_gpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
 {
-	struct virtio_gpu_object *bo;
-	struct virtio_gpu_device *vgdev;
+	struct virtio_gpu_ttm_tt *gtt =
+		container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
+	struct virtio_gpu_device *vgdev =
+		(struct virtio_gpu_device *)gtt->obj->gem_base.dev->dev_private;
 
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
+	virtio_gpu_object_detach(vgdev, gtt->obj);
+	ttm_pool_unpopulate(ttm);
 }
 
 static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
@@ -366,15 +338,15 @@ static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
 
 static struct ttm_bo_driver virtio_gpu_bo_driver = {
 	.ttm_tt_create = &virtio_gpu_ttm_tt_create,
+	.ttm_tt_populate = &virtio_gpu_ttm_tt_populate,
+	.ttm_tt_unpopulate = &virtio_gpu_ttm_tt_unpopulate,
 	.invalidate_caches = &virtio_gpu_invalidate_caches,
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

