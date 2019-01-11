Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6929C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A9C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfAKFiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbfAKFiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:38:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6242E7EBD5;
        Fri, 11 Jan 2019 05:38:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4660B5C219;
        Fri, 11 Jan 2019 05:37:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 169D19AB5; Fri, 11 Jan 2019 06:37:54 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 11/16] drm/bochs: drop unused gpu_addr arg from bochs_bo_pin()
Date:   Fri, 11 Jan 2019 06:37:47 +0100
Message-Id: <20190111053752.4004-12-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 11 Jan 2019 05:38:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's always NULL, so just remove it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs.h       |  2 +-
 drivers/gpu/drm/bochs/bochs_fbdev.c |  2 +-
 drivers/gpu/drm/bochs/bochs_kms.c   |  2 +-
 drivers/gpu/drm/bochs/bochs_mm.c    | 11 +----------
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 4dc1b6384e..d0d474e06f 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -142,7 +142,7 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 			   uint32_t handle, uint64_t *offset);
 
-int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr);
+int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
 int bochs_bo_unpin(struct bochs_bo *bo);
 
 /* bochs_kms.c */
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index d9f3d42999..92feb817ff 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -81,7 +81,7 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 	if (ret)
 		return ret;
 
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
+	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 	if (ret) {
 		DRM_ERROR("failed to pin fbcon\n");
 		ttm_bo_unreserve(&bo->bo);
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5b7e1a7c6b..f663c54185 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -101,7 +101,7 @@ static int bochs_plane_prepare_fb(struct drm_plane *plane,
 	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
 	if (ret)
 		return ret;
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
+	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 	ttm_bo_unreserve(&bo->bo);
 	return ret;
 }
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 0980411e41..5a0e092847 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -210,20 +210,13 @@ static void bochs_ttm_placement(struct bochs_bo *bo, int domain)
 	bo->placement.num_busy_placement = c;
 }
 
-static inline u64 bochs_bo_gpu_offset(struct bochs_bo *bo)
-{
-	return bo->bo.offset;
-}
-
-int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr)
+int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	int i, ret;
 
 	if (bo->pin_count) {
 		bo->pin_count++;
-		if (gpu_addr)
-			*gpu_addr = bochs_bo_gpu_offset(bo);
 		return 0;
 	}
 
@@ -235,8 +228,6 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr)
 		return ret;
 
 	bo->pin_count = 1;
-	if (gpu_addr)
-		*gpu_addr = bochs_bo_gpu_offset(bo);
 	return 0;
 }
 
-- 
2.9.3

