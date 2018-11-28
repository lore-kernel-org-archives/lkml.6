Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E4D208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E4D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeK2KMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:12:45 -0500
Received: from anholt.net ([50.246.234.109]:53870 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeK2KMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:12:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E74C510A156C;
        Wed, 28 Nov 2018 15:09:29 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id d-pggeT1UdXD; Wed, 28 Nov 2018 15:09:28 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 07DA710A11D0;
        Wed, 28 Nov 2018 15:09:28 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 514CA2FE2D5B; Wed, 28 Nov 2018 15:09:27 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Dave Emett <david.emett@broadcom.com>
Subject: [PATCH 2/3] drm/v3d: Drop the "dev" argument to lock/unlock of BO reservations.
Date:   Wed, 28 Nov 2018 15:09:26 -0800
Message-Id: <20181128230927.10951-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128230927.10951-1-eric@anholt.net>
References: <20181128230927.10951-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They were unused, as Dave Emett noticed in TFU review.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Dave Emett <david.emett@broadcom.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 41cbe2cdad50..778657d9b6e7 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -219,8 +219,7 @@ v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
 }
 
 static void
-v3d_unlock_bo_reservations(struct drm_device *dev,
-			   struct v3d_bo **bos,
+v3d_unlock_bo_reservations(struct v3d_bo **bos,
 			   int bo_count,
 			   struct ww_acquire_ctx *acquire_ctx)
 {
@@ -240,8 +239,7 @@ v3d_unlock_bo_reservations(struct drm_device *dev,
  * to v3d, so we don't attach dma-buf fences to them.
  */
 static int
-v3d_lock_bo_reservations(struct drm_device *dev,
-			 struct v3d_bo **bos,
+v3d_lock_bo_reservations(struct v3d_bo **bos,
 			 int bo_count,
 			 struct ww_acquire_ctx *acquire_ctx)
 {
@@ -298,7 +296,7 @@ v3d_lock_bo_reservations(struct drm_device *dev,
 	for (i = 0; i < bo_count; i++) {
 		ret = reservation_object_reserve_shared(bos[i]->resv, 1);
 		if (ret) {
-			v3d_unlock_bo_reservations(dev, bos, bo_count,
+			v3d_unlock_bo_reservations(bos, bo_count,
 						   acquire_ctx);
 			return ret;
 		}
@@ -566,7 +564,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_lock_bo_reservations(dev, exec->bo, exec->bo_count,
+	ret = v3d_lock_bo_reservations(exec->bo, exec->bo_count,
 				       &acquire_ctx);
 	if (ret)
 		goto fail;
@@ -604,7 +602,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	v3d_attach_object_fences(exec->bo, exec->bo_count,
 				 exec->render_done_fence);
 
-	v3d_unlock_bo_reservations(dev, exec->bo, exec->bo_count, &acquire_ctx);
+	v3d_unlock_bo_reservations(exec->bo, exec->bo_count, &acquire_ctx);
 
 	/* Update the return sync object for the */
 	sync_out = drm_syncobj_find(file_priv, args->out_sync);
@@ -620,7 +618,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
-	v3d_unlock_bo_reservations(dev, exec->bo, exec->bo_count, &acquire_ctx);
+	v3d_unlock_bo_reservations(exec->bo, exec->bo_count, &acquire_ctx);
 fail:
 	v3d_exec_put(exec);
 
@@ -691,7 +689,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	}
 	spin_unlock(&file_priv->table_lock);
 
-	ret = v3d_lock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
+	ret = v3d_lock_bo_reservations(job->bo, bo_count, &acquire_ctx);
 	if (ret)
 		goto fail;
 
@@ -710,7 +708,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 
 	v3d_attach_object_fences(job->bo, bo_count, sched_done_fence);
 
-	v3d_unlock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
+	v3d_unlock_bo_reservations(job->bo, bo_count, &acquire_ctx);
 
 	/* Update the return sync object */
 	sync_out = drm_syncobj_find(file_priv, args->out_sync);
@@ -726,7 +724,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 
 fail_unreserve:
 	mutex_unlock(&v3d->sched_lock);
-	v3d_unlock_bo_reservations(dev, job->bo, bo_count, &acquire_ctx);
+	v3d_unlock_bo_reservations(job->bo, bo_count, &acquire_ctx);
 fail:
 	v3d_tfu_job_put(job);
 
-- 
2.20.0.rc1

