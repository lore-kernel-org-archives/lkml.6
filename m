Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE84ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8482133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8482133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKIBxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:53:16 -0500
Received: from anholt.net ([50.246.234.109]:33410 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbeKIBxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:53:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0A5C410A1339;
        Thu,  8 Nov 2018 08:17:03 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id mBACcP1FQJaz; Thu,  8 Nov 2018 08:17:00 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7448210A1314;
        Thu,  8 Nov 2018 08:16:55 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 102F52FE1BF5; Thu,  8 Nov 2018 08:16:54 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/4] drm/v3d: Clean up the reservation object setup.
Date:   Thu,  8 Nov 2018 08:16:53 -0800
Message-Id: <20181108161654.19888-4-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108161654.19888-1-eric@anholt.net>
References: <20181108161654.19888-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extra to_v3d_bo() calls came from copying this from the vc4
driver, which stored the cma gem object in the structs.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index b88c96911453..d0dfdcbbd42c 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -214,10 +214,8 @@ v3d_attach_object_fences(struct v3d_exec_info *exec)
 	int i;
 
 	for (i = 0; i < exec->bo_count; i++) {
-		bo = to_v3d_bo(&exec->bo[i]->base);
-
 		/* XXX: Use shared fences for read-only objects. */
-		reservation_object_add_excl_fence(bo->resv, out_fence);
+		reservation_object_add_excl_fence(exec->bo[i]->resv, out_fence);
 	}
 }
 
@@ -228,11 +226,8 @@ v3d_unlock_bo_reservations(struct drm_device *dev,
 {
 	int i;
 
-	for (i = 0; i < exec->bo_count; i++) {
-		struct v3d_bo *bo = to_v3d_bo(&exec->bo[i]->base);
-
-		ww_mutex_unlock(&bo->resv->lock);
-	}
+	for (i = 0; i < exec->bo_count; i++)
+		ww_mutex_unlock(&exec->bo[i]->resv->lock);
 
 	ww_acquire_fini(acquire_ctx);
 }
@@ -251,13 +246,13 @@ v3d_lock_bo_reservations(struct drm_device *dev,
 {
 	int contended_lock = -1;
 	int i, ret;
-	struct v3d_bo *bo;
 
 	ww_acquire_init(acquire_ctx, &reservation_ww_class);
 
 retry:
 	if (contended_lock != -1) {
-		bo = to_v3d_bo(&exec->bo[contended_lock]->base);
+		struct v3d_bo *bo = exec->bo[contended_lock];
+
 		ret = ww_mutex_lock_slow_interruptible(&bo->resv->lock,
 						       acquire_ctx);
 		if (ret) {
@@ -270,19 +265,16 @@ v3d_lock_bo_reservations(struct drm_device *dev,
 		if (i == contended_lock)
 			continue;
 
-		bo = to_v3d_bo(&exec->bo[i]->base);
-
-		ret = ww_mutex_lock_interruptible(&bo->resv->lock, acquire_ctx);
+		ret = ww_mutex_lock_interruptible(&exec->bo[i]->resv->lock,
+						  acquire_ctx);
 		if (ret) {
 			int j;
 
-			for (j = 0; j < i; j++) {
-				bo = to_v3d_bo(&exec->bo[j]->base);
-				ww_mutex_unlock(&bo->resv->lock);
-			}
+			for (j = 0; j < i; j++)
+				ww_mutex_unlock(&exec->bo[j]->resv->lock);
 
 			if (contended_lock != -1 && contended_lock >= i) {
-				bo = to_v3d_bo(&exec->bo[contended_lock]->base);
+				struct v3d_bo *bo = exec->bo[contended_lock];
 
 				ww_mutex_unlock(&bo->resv->lock);
 			}
@@ -303,9 +295,7 @@ v3d_lock_bo_reservations(struct drm_device *dev,
 	 * before we commit the CL to the hardware.
 	 */
 	for (i = 0; i < exec->bo_count; i++) {
-		bo = to_v3d_bo(&exec->bo[i]->base);
-
-		ret = reservation_object_reserve_shared(bo->resv, 1);
+		ret = reservation_object_reserve_shared(exec->bo[i]->resv, 1);
 		if (ret) {
 			v3d_unlock_bo_reservations(dev, exec, acquire_ctx);
 			return ret;
-- 
2.19.1

