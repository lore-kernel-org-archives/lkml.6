Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB75C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C202086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C202086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeKTFdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:33:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKTFdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:33:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 81D7E2795FF
From:   Helen Koike <helen.koike@collabora.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [PATCH v3] drm/rockchip: update cursors asynchronously through atomic.
Date:   Mon, 19 Nov 2018 17:08:05 -0200
Message-Id: <20181119190805.19139-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Add support to async updates of cursors by using the new atomic
interface for that.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
[updated for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

This is the third version of the async-plane update suport to the
Rockchip driver.

I tested running igt kms_cursor_legacy and kms_atomic tests using a 96Boards Ficus.

Note that before the patch, the following igt tests failed:

        basic-flip-before-cursor-atomic
        basic-flip-before-cursor-legacy
        cursor-vs-flip-atomic
        cursor-vs-flip-legacy
        cursor-vs-flip-toggle
        flip-vs-cursor-atomic
        flip-vs-cursor-busy-crc-atomic
        flip-vs-cursor-busy-crc-legacy
        flip-vs-cursor-crc-atomic
        flip-vs-cursor-crc-legacy
        flip-vs-cursor-legacy

Full log: https://people.collabora.com/~koike/results-4.20/html/

Now with the patch applied the following were fixed:
        basic-flip-before-cursor-atomic
        basic-flip-before-cursor-legacy
        flip-vs-cursor-atomic
        flip-vs-cursor-legacy

Full log: https://people.collabora.com/~koike/results-4.20-async/html/

Tomasz, as you mentined in v2 about waiting the hardware before updating
the framebuffer, now I call the loop you pointed out in the async path,
was that what you had in mind? Or do you think I would make sense to
call the vop_crtc_atomic_flush() instead of just exposing that loop?

Thanks
Helen

Changes in v3:
- Rebased on top of drm-misc
- Fix missing include in rockchip_drm_vop.c
- New function vop_crtc_atomic_commit_flush

Changes in v2:
- v2: https://patchwork.freedesktop.org/patch/254180/
- Change the framebuffer as well to cover jumpy cursor when hovering
  text boxes or hyperlink. (Tomasz)
- Use the PSR inhibit mechanism when accessing VOP hardware instead of
  PSR flushing (Tomasz)

Changes in v1:
- Rebased on top of drm-misc
- In async_check call drm_atomic_helper_check_plane_state to check that
  the desired plane is valid and update various bits of derived state
  (clipped coordinates etc.)
- In async_check allow to configure new scaling in the fast path.
- In async_update force to flush all registered PSR encoders.
- In async_update call atomic_update directly.
- In async_update call vop_cfg_done needed to set the vop registers and take effect.

 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  36 -------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c |  37 +++++++
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h |   3 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 108 +++++++++++++++++---
 4 files changed, 131 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index ea18cb2a76c0..08bec50d9c5d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -127,42 +127,6 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	return ERR_PTR(ret);
 }
 
-static void
-rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
-{
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *crtc_state;
-	struct drm_encoder *encoder;
-	u32 encoder_mask = 0;
-	int i;
-
-	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
-		encoder_mask |= crtc_state->encoder_mask;
-		encoder_mask |= crtc->state->encoder_mask;
-	}
-
-	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
-		rockchip_drm_psr_inhibit_get(encoder);
-}
-
-static void
-rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
-{
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *crtc_state;
-	struct drm_encoder *encoder;
-	u32 encoder_mask = 0;
-	int i;
-
-	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
-		encoder_mask |= crtc_state->encoder_mask;
-		encoder_mask |= crtc->state->encoder_mask;
-	}
-
-	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
-		rockchip_drm_psr_inhibit_put(encoder);
-}
-
 static void
 rockchip_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 01ff3c858875..22a70ab6e214 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -13,6 +13,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
 
 #include "rockchip_drm_drv.h"
@@ -109,6 +110,42 @@ int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder)
 }
 EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put);
 
+void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_get(encoder);
+}
+EXPORT_SYMBOL(rockchip_drm_psr_inhibit_get_state);
+
+void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	u32 encoder_mask = 0;
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		encoder_mask |= crtc_state->encoder_mask;
+		encoder_mask |= crtc->state->encoder_mask;
+	}
+
+	drm_for_each_encoder_mask(encoder, state->dev, encoder_mask)
+		rockchip_drm_psr_inhibit_put(encoder);
+}
+EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put_state);
+
 /**
  * rockchip_drm_psr_inhibit_get - acquire PSR inhibit on given encoder
  * @encoder: encoder to obtain the PSR encoder
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index 860c62494496..25350ba3237b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -20,6 +20,9 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev);
 int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
 int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
 
+void rockchip_drm_psr_inhibit_get_state(struct drm_atomic_state *state);
+void rockchip_drm_psr_inhibit_put_state(struct drm_atomic_state *state);
+
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			int (*psr_set)(struct drm_encoder *, bool enable));
 void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fb70fb486fbf..176d6e8207ed 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -15,6 +15,7 @@
 #include <drm/drm.h>
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_flip_work.h>
@@ -819,10 +820,99 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	spin_unlock(&vop->reg_lock);
 }
 
+static int vop_plane_atomic_async_check(struct drm_plane *plane,
+					struct drm_plane_state *state)
+{
+	struct vop_win *vop_win = to_vop_win(plane);
+	const struct vop_win_data *win = vop_win->data;
+	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
+					DRM_PLANE_HELPER_NO_SCALING;
+	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
+					DRM_PLANE_HELPER_NO_SCALING;
+	struct drm_crtc_state *crtc_state;
+	int ret;
+
+	if (plane != state->crtc->cursor)
+		return -EINVAL;
+
+	if (!plane->state)
+		return -EINVAL;
+
+	if (!plane->state->fb)
+		return -EINVAL;
+
+	if (state->state)
+		crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+								state->crtc);
+	else /* Special case for asynchronous cursor updates. */
+		crtc_state = plane->crtc->state;
+
+	ret = drm_atomic_helper_check_plane_state(plane->state,
+						  crtc_state,
+						  min_scale, max_scale,
+						  true, true);
+	return ret;
+}
+
+static void vop_crtc_atomic_commit_flush(struct drm_crtc *crtc,
+					 struct drm_crtc_state *old_crtc_state)
+{
+	struct drm_atomic_state *old_state = old_crtc_state->state;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct vop *vop = to_vop(crtc);
+	struct drm_plane *plane;
+	int i;
+
+	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state,
+				       new_plane_state, i) {
+		if (!old_plane_state->fb)
+			continue;
+
+		if (old_plane_state->fb == new_plane_state->fb)
+			continue;
+
+		drm_framebuffer_get(old_plane_state->fb);
+		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
+		drm_flip_work_queue(&vop->fb_unref_work, old_plane_state->fb);
+		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
+	}
+}
+
+static void vop_plane_atomic_async_update(struct drm_plane *plane,
+					  struct drm_plane_state *new_state)
+{
+	struct vop *vop = to_vop(plane->state->crtc);
+
+	if (vop->crtc.state->state)
+		vop_crtc_atomic_commit_flush(&vop->crtc, vop->crtc.state);
+
+	plane->state->crtc_x = new_state->crtc_x;
+	plane->state->crtc_y = new_state->crtc_y;
+	plane->state->crtc_h = new_state->crtc_h;
+	plane->state->crtc_w = new_state->crtc_w;
+	plane->state->src_x = new_state->src_x;
+	plane->state->src_y = new_state->src_y;
+	plane->state->src_h = new_state->src_h;
+	plane->state->src_w = new_state->src_w;
+
+	drm_atomic_set_fb_for_plane(plane->state, new_state->fb);
+
+	if (vop->is_enabled) {
+		rockchip_drm_psr_inhibit_get_state(new_state->state);
+		vop_plane_atomic_update(plane, plane->state);
+		spin_lock(&vop->reg_lock);
+		vop_cfg_done(vop);
+		spin_unlock(&vop->reg_lock);
+		rockchip_drm_psr_inhibit_put_state(new_state->state);
+	}
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
@@ -1010,11 +1100,7 @@ static void vop_wait_for_irq_handler(struct vop *vop)
 static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
-	struct drm_atomic_state *old_state = old_crtc_state->state;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct vop *vop = to_vop(crtc);
-	struct drm_plane *plane;
-	int i;
 
 	if (WARN_ON(!vop->is_enabled))
 		return;
@@ -1042,19 +1128,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state,
-				       new_plane_state, i) {
-		if (!old_plane_state->fb)
-			continue;
-
-		if (old_plane_state->fb == new_plane_state->fb)
-			continue;
-
-		drm_framebuffer_get(old_plane_state->fb);
-		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
-		drm_flip_work_queue(&vop->fb_unref_work, old_plane_state->fb);
-		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
-	}
+	vop_crtc_atomic_commit_flush(crtc, old_crtc_state);
 }
 
 static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
-- 
2.19.1

