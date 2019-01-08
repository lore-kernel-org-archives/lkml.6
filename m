Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4410FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4D320850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfAHLZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:25:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61863 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbfAHLZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:25:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02AACD56EB;
        Tue,  8 Jan 2019 11:25:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com [10.36.116.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E9635C237;
        Tue,  8 Jan 2019 11:25:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CA9015EE1; Tue,  8 Jan 2019 12:25:20 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/15] drm/bochs: remove old bochs_crtc_* functions
Date:   Tue,  8 Jan 2019 12:25:13 +0100
Message-Id: <20190108112519.27473-10-kraxel@redhat.com>
In-Reply-To: <20190108112519.27473-1-kraxel@redhat.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 08 Jan 2019 11:25:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the old, now unused crtc callbacks.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 81 ---------------------------------------
 1 file changed, 81 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f39e291245..85ada2d097 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -20,74 +20,6 @@ MODULE_PARM_DESC(defy, "default y resolution");
 
 /* ---------------------------------------------------------------------- */
 
-static void bochs_crtc_dpms(struct drm_crtc *crtc, int mode)
-{
-	switch (mode) {
-	case DRM_MODE_DPMS_ON:
-	case DRM_MODE_DPMS_STANDBY:
-	case DRM_MODE_DPMS_SUSPEND:
-	case DRM_MODE_DPMS_OFF:
-	default:
-		return;
-	}
-}
-
-static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
-				    struct drm_framebuffer *old_fb)
-{
-	struct bochs_device *bochs =
-		container_of(crtc, struct bochs_device, crtc);
-	struct bochs_bo *bo;
-	u64 gpu_addr = 0;
-	int ret;
-
-	if (old_fb) {
-		bo = gem_to_bochs_bo(old_fb->obj[0]);
-		ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-		if (ret) {
-			DRM_ERROR("failed to reserve old_fb bo\n");
-		} else {
-			bochs_bo_unpin(bo);
-			ttm_bo_unreserve(&bo->bo);
-		}
-	}
-
-	if (WARN_ON(crtc->primary->fb == NULL))
-		return -EINVAL;
-
-	bo = gem_to_bochs_bo(crtc->primary->fb->obj[0]);
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, &gpu_addr);
-	if (ret) {
-		ttm_bo_unreserve(&bo->bo);
-		return ret;
-	}
-
-	ttm_bo_unreserve(&bo->bo);
-	bochs_hw_setbase(bochs, x, y, gpu_addr);
-	return 0;
-}
-
-static int bochs_crtc_mode_set(struct drm_crtc *crtc,
-			       struct drm_display_mode *mode,
-			       struct drm_display_mode *adjusted_mode,
-			       int x, int y, struct drm_framebuffer *old_fb)
-{
-	struct bochs_device *bochs =
-		container_of(crtc, struct bochs_device, crtc);
-
-	if (WARN_ON(crtc->primary->fb == NULL))
-		return -EINVAL;
-
-	bochs_hw_setmode(bochs, mode);
-	bochs_hw_setformat(bochs, crtc->primary->fb->format);
-	bochs_crtc_mode_set_base(crtc, x, y, old_fb);
-	return 0;
-}
-
 static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct bochs_device *bochs =
@@ -96,14 +28,6 @@ static void bochs_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	bochs_hw_setmode(bochs, &crtc->mode);
 }
 
-static void bochs_crtc_prepare(struct drm_crtc *crtc)
-{
-}
-
-static void bochs_crtc_commit(struct drm_crtc *crtc)
-{
-}
-
 static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
 				     struct drm_crtc_state *old_crtc_state)
 {
@@ -138,12 +62,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
 };
 
 static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
-	.dpms = bochs_crtc_dpms,
-	.mode_set = bochs_crtc_mode_set,
-	.mode_set_base = bochs_crtc_mode_set_base,
 	.mode_set_nofb = bochs_crtc_mode_set_nofb,
-	.prepare = bochs_crtc_prepare,
-	.commit = bochs_crtc_commit,
 	.atomic_enable = bochs_crtc_atomic_enable,
 	.atomic_flush = bochs_crtc_atomic_flush,
 };
-- 
2.9.3

