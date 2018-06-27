Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB15C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0330A2508E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0330A2508E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965891AbeF0VO5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:14:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55864 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965801AbeF0VOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:14:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 83AB1263BFB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [RFC RESEND PATCH] drm/rockchip: update cursors asynchronously through atomic.
Date:   Wed, 27 Jun 2018 23:14:47 +0200
Message-Id: <20180627211447.20927-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to async updates of cursors by using the new atomic
interface for that.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
I am sending this as RFC because I still don't have a deep knowledge of
the hw and I am not sure if the vop_plane_update function can be reused
in both cases, atomic_updates and atomic_async_updates. I think that
someone with more knowledge should take a look. The patch was tested on
a Samsung Chromebook Plus in two ways.

1. Running all igt kms_cursor_legacy and kms_atomic@plane_cursor_legacy
tests and see that there is no regression after the patch.

2. Running weston using the atomic API.

Best regards,
  Enric

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 80 ++++++++++++++++-----
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 53d4afe15278..1eb6bda924af 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -688,8 +688,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 	spin_unlock(&vop->reg_lock);
 }
 
-static void vop_plane_atomic_update(struct drm_plane *plane,
-		struct drm_plane_state *old_state)
+static void vop_plane_update(struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_crtc *crtc = state->crtc;
@@ -710,20 +709,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	bool rb_swap;
 	int format;
 
-	/*
-	 * can't update plane when vop is disabled.
-	 */
-	if (WARN_ON(!crtc))
-		return;
-
-	if (WARN_ON(!vop->is_enabled))
-		return;
-
-	if (!state->visible) {
-		vop_plane_atomic_disable(plane, old_state);
-		return;
-	}
-
 	obj = rockchip_fb_get_gem_obj(fb, 0);
 	rk_obj = to_rockchip_obj(obj);
 
@@ -794,10 +779,73 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	spin_unlock(&vop->reg_lock);
 }
 
+static void vop_plane_atomic_update(struct drm_plane *plane,
+				    struct drm_plane_state *old_state)
+{
+	struct drm_plane_state *state = plane->state;
+	struct vop *vop = to_vop(state->crtc);
+
+	/*
+	 * can't update plane when vop is disabled.
+	 */
+	if (WARN_ON(!state->crtc))
+		return;
+
+	if (WARN_ON(!vop->is_enabled))
+		return;
+
+	if (!state->visible) {
+		vop_plane_atomic_disable(plane, old_state);
+		return;
+	}
+
+	vop_plane_update(plane);
+}
+
+static int vop_plane_atomic_async_check(struct drm_plane *plane,
+					struct drm_plane_state *state)
+{
+	struct drm_crtc_state *crtc_state;
+
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+							state->crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
+	if (!crtc_state->active)
+		return -EINVAL;
+
+	if (plane->state->crtc != state->crtc ||
+	    plane->state->src_w != state->src_w ||
+	    plane->state->src_h != state->src_h ||
+	    plane->state->crtc_w != state->crtc_w ||
+	    plane->state->crtc_h != state->crtc_h ||
+	    !plane->state->fb ||
+	    plane->state->fb != state->fb)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void vop_plane_atomic_async_update(struct drm_plane *plane,
+					  struct drm_plane_state *new_state)
+{
+	plane->state->src_x = new_state->src_x;
+	plane->state->src_y = new_state->src_y;
+	plane->state->crtc_x = new_state->crtc_x;
+	plane->state->crtc_y = new_state->crtc_y;
+	plane->state->fb = new_state->fb;
+	*plane->state = *new_state;
+
+	vop_plane_update(plane);
+}
+
 static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_check = vop_plane_atomic_check,
 	.atomic_update = vop_plane_atomic_update,
 	.atomic_disable = vop_plane_atomic_disable,
+	.atomic_async_check = vop_plane_atomic_async_check,
+	.atomic_async_update = vop_plane_atomic_async_update,
 };
 
 static const struct drm_plane_funcs vop_plane_funcs = {
-- 
2.18.0

