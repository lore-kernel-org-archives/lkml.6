Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeBSJ42 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:56:28 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35935 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeBSJ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:56:25 -0500
X-Google-Smtp-Source: AH8x224+extqMSKiauP7y3PpcivsJrrDRac0UA9wTvKSOQLyAgpHXN6i5/v51h/HiH5tXXbCvCYZLg==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/ttm: keep BOs reserved until end of eviction
Date: Mon, 19 Feb 2018 10:56:10 +0100
Message-Id: <20180219095610.2747-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180219095610.2747-1-christian.koenig@amd.com>
References: <20180219095610.2747-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids problems when BOs are evicted but directly moved back into
the domain from other threads.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index fba40e22d088..568cf216b374 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -742,7 +742,8 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
 static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 			       uint32_t mem_type,
 			       const struct ttm_place *place,
-			       struct ttm_operation_ctx *ctx)
+			       struct ttm_operation_ctx *ctx,
+			       struct list_head *evicted)
 {
 	struct ttm_bo_global *glob = bdev->glob;
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
@@ -792,17 +793,28 @@ static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 
 	ret = ttm_bo_evict(bo, ctx);
 	if (locked) {
-		ttm_bo_unreserve(bo);
+		list_add_tail(&bo->lru, evicted);
 	} else {
 		spin_lock(&glob->lru_lock);
 		ttm_bo_add_to_lru(bo);
 		spin_unlock(&glob->lru_lock);
+		kref_put(&bo->list_kref, ttm_bo_release_list);
 	}
 
-	kref_put(&bo->list_kref, ttm_bo_release_list);
 	return ret;
 }
 
+static void ttm_mem_evict_cleanup(struct list_head *evicted)
+{
+	struct ttm_buffer_object *bo, *tmp;
+
+	list_for_each_entry_safe(bo, tmp, evicted, lru) {
+		list_del_init(&bo->lru);
+		ttm_bo_unreserve(bo);
+		kref_put(&bo->list_kref, ttm_bo_release_list);
+	}
+}
+
 void ttm_bo_mem_put(struct ttm_buffer_object *bo, struct ttm_mem_reg *mem)
 {
 	struct ttm_mem_type_manager *man = &bo->bdev->man[mem->mem_type];
@@ -852,20 +864,26 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,
 {
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
+	struct list_head evicted;
 	int ret;
 
+	INIT_LIST_HEAD(&evicted);
 	do {
 		ret = (*man->func->get_node)(man, bo, place, mem);
 		if (unlikely(ret != 0))
 			return ret;
 		if (mem->mm_node)
 			break;
-		ret = ttm_mem_evict_first(bdev, mem_type, place, ctx);
+		ret = ttm_mem_evict_first(bdev, mem_type, place, ctx, &evicted);
 		if (unlikely(ret != 0))
-			return ret;
+			goto error;
 	} while (1);
 	mem->mem_type = mem_type;
-	return ttm_bo_add_move_fence(bo, man, mem);
+	ret = ttm_bo_add_move_fence(bo, man, mem);
+
+error:
+	ttm_mem_evict_cleanup(&evicted);
+	return ret;
 }
 
 static uint32_t ttm_bo_select_caching(struct ttm_mem_type_manager *man,
@@ -1345,6 +1363,7 @@ static int ttm_bo_force_list_clean(struct ttm_bo_device *bdev,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
 	struct ttm_bo_global *glob = bdev->glob;
+	struct list_head evicted;
 	struct dma_fence *fence;
 	int ret;
 	unsigned i;
@@ -1352,18 +1371,20 @@ static int ttm_bo_force_list_clean(struct ttm_bo_device *bdev,
 	/*
 	 * Can't use standard list traversal since we're unlocking.
 	 */
-
+	INIT_LIST_HEAD(&evicted);
 	spin_lock(&glob->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
 		while (!list_empty(&man->lru[i])) {
 			spin_unlock(&glob->lru_lock);
-			ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx);
+			ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx,
+						  &evicted);
 			if (ret)
 				return ret;
 			spin_lock(&glob->lru_lock);
 		}
 	}
 	spin_unlock(&glob->lru_lock);
+	ttm_mem_evict_cleanup(&evicted);
 
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
-- 
2.14.1
