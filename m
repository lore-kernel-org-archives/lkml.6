Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeBTM6g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:58:36 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40507 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeBTM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:58:33 -0500
X-Google-Smtp-Source: AH8x226F8n+aNWnh9FC/agHrvQazToseQcF+MK1+GnqC8rIvASIfXvLV+sS4mMZW8dVmK0zhlinCsw==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/ttm: handle already locked BOs during eviction and swapout.
Date: Tue, 20 Feb 2018 13:58:28 +0100
Message-Id: <20180220125829.27060-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180220125829.27060-1-christian.koenig@amd.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This solves the problem that when we swapout a BO from a domain we
sometimes couldn't make room for it because holding the lock blocks all
other BOs with this reservation object.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d90b1cf10b27..3a44c2ee4155 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -713,31 +713,30 @@ bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 EXPORT_SYMBOL(ttm_bo_eviction_valuable);
 
 /**
- * Check the target bo is allowable to be evicted or swapout, including cases:
- *
- * a. if share same reservation object with ctx->resv, have assumption
- * reservation objects should already be locked, so not lock again and
- * return true directly when either the opreation allow_reserved_eviction
- * or the target bo already is in delayed free list;
- *
- * b. Otherwise, trylock it.
+ * Check if the target bo is allowed to be evicted or swapedout.
  */
 static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
-			struct ttm_operation_ctx *ctx, bool *locked)
+					   struct ttm_operation_ctx *ctx,
+					   bool *locked)
 {
-	bool ret = false;
+	/* First check if we can lock it */
+	*locked = reservation_object_trylock(bo->resv);
+	if (*locked)
+		return true;
 
-	*locked = false;
+	/* Check if it's locked because it is part of the current operation */
 	if (bo->resv == ctx->resv) {
 		reservation_object_assert_held(bo->resv);
-		if (ctx->allow_reserved_eviction || !list_empty(&bo->ddestroy))
-			ret = true;
-	} else {
-		*locked = reservation_object_trylock(bo->resv);
-		ret = *locked;
+		return ctx->allow_reserved_eviction ||
+			!list_empty(&bo->ddestroy);
 	}
 
-	return ret;
+	/* Check if it's locked because it was already evicted */
+	if (ww_mutex_is_owned_by(&bo->resv->lock, NULL))
+		return true;
+
+	/* Some other thread is using it, don't touch it */
+	return false;
 }
 
 static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
-- 
2.14.1
