Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760C120675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfAKFii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbfAKFiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:38:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49CEE2D0FC2;
        Fri, 11 Jan 2019 05:38:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4795160BE8;
        Fri, 11 Jan 2019 05:37:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 412F893E7; Fri, 11 Jan 2019 06:37:54 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 12/16] drm/bochs: move ttm_bo_(un)reserve calls into bochs_bo_{pin,unpin}
Date:   Fri, 11 Jan 2019 06:37:48 +0100
Message-Id: <20190111053752.4004-13-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Jan 2019 05:38:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c |  8 --------
 drivers/gpu/drm/bochs/bochs_kms.c   | 14 +-------------
 drivers/gpu/drm/bochs/bochs_mm.c    |  8 ++++++++
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 92feb817ff..ccf783b038 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -77,14 +77,9 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 
 	bo = gem_to_bochs_bo(gobj);
 
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-
 	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 	if (ret) {
 		DRM_ERROR("failed to pin fbcon\n");
-		ttm_bo_unreserve(&bo->bo);
 		return ret;
 	}
 
@@ -92,12 +87,9 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 			  &bo->kmap);
 	if (ret) {
 		DRM_ERROR("failed to kmap fbcon\n");
-		ttm_bo_unreserve(&bo->bo);
 		return ret;
 	}
 
-	ttm_bo_unreserve(&bo->bo);
-
 	/* init fb device */
 	info = drm_fb_helper_alloc_fbi(helper);
 	if (IS_ERR(info)) {
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f663c54185..fc856a02a2 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -92,34 +92,22 @@ static int bochs_plane_prepare_fb(struct drm_plane *plane,
 				struct drm_plane_state *new_state)
 {
 	struct bochs_bo *bo;
-	int ret;
 
 	if (!new_state->fb)
 		return 0;
 	bo = gem_to_bochs_bo(new_state->fb->obj[0]);
-
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
-	ttm_bo_unreserve(&bo->bo);
-	return ret;
+	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 }
 
 static void bochs_plane_cleanup_fb(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
 	struct bochs_bo *bo;
-	int ret;
 
 	if (!old_state->fb)
 		return;
 	bo = gem_to_bochs_bo(old_state->fb->obj[0]);
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return;
 	bochs_bo_unpin(bo);
-	ttm_bo_unreserve(&bo->bo);
 }
 
 static const struct drm_plane_helper_funcs bochs_plane_helper_funcs = {
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 5a0e092847..fcbf35456d 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -223,7 +223,11 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
 	bochs_ttm_placement(bo, pl_flag);
 	for (i = 0; i < bo->placement.num_placement; i++)
 		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return ret;
 	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
+	ttm_bo_unreserve(&bo->bo);
 	if (ret)
 		return ret;
 
@@ -247,7 +251,11 @@ int bochs_bo_unpin(struct bochs_bo *bo)
 
 	for (i = 0; i < bo->placement.num_placement; i++)
 		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return ret;
 	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
+	ttm_bo_unreserve(&bo->bo);
 	if (ret)
 		return ret;
 
-- 
2.9.3

