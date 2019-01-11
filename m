Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D1920675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfAKFiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfAKFh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:37:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22A9F92A57;
        Fri, 11 Jan 2019 05:37:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA888600C3;
        Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8D6399AD9; Fri, 11 Jan 2019 06:37:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/16] drm/bochs: atomic: use atomic page_flip helper
Date:   Fri, 11 Jan 2019 06:37:43 +0100
Message-Id: <20190111053752.4004-8-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 11 Jan 2019 05:37:58 +0000 (UTC)
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

