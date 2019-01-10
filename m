Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE80FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF512173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfAJI2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:28:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfAJI2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:28:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D3B5420B3;
        Thu, 10 Jan 2019 08:28:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22700600C3;
        Thu, 10 Jan 2019 08:28:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 956249C72; Thu, 10 Jan 2019 09:28:46 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/15] drm/bochs: atomic: use atomic page_flip helper
Date:   Thu, 10 Jan 2019 09:28:37 +0100
Message-Id: <20190110082845.3453-8-kraxel@redhat.com>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 10 Jan 2019 08:28:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion to atomic modesetting, step five.
Use atomic page_flip helper for crtc.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 646f897cb2..67c3674609 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -104,27 +104,6 @@ static void bochs_crtc_commit(struct drm_crtc *crtc)
 {
 }
 
-static int bochs_crtc_page_flip(struct drm_crtc *crtc,
-				struct drm_framebuffer *fb,
-				struct drm_pending_vblank_event *event,
-				uint32_t page_flip_flags,
-				struct drm_modeset_acquire_ctx *ctx)
-{
-	struct bochs_device *bochs =
-		container_of(crtc, struct bochs_device, crtc);
-	struct drm_framebuffer *old_fb = crtc->primary->fb;
-	unsigned long irqflags;
-
-	drm_atomic_set_fb_for_plane(crtc->primary->state, fb);
-	bochs_crtc_mode_set_base(crtc, 0, 0, old_fb);
-	if (event) {
-		spin_lock_irqsave(&bochs->dev->event_lock, irqflags);
-		drm_crtc_send_vblank_event(crtc, event);
-		spin_unlock_irqrestore(&bochs->dev->event_lock, irqflags);
-	}
-	return 0;
-}
-
 static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
 				     struct drm_crtc_state *old_crtc_state)
 {
@@ -152,7 +131,7 @@ static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
 static const struct drm_crtc_funcs bochs_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.destroy = drm_crtc_cleanup,
-	.page_flip = bochs_crtc_page_flip,
+	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-- 
2.9.3

