Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11902C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A3721A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A3721A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbeHFSDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:03:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFSDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:03:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 505FA263981
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
Subject: [PATCH] drm/rockchip: update cursors asynchronously through atomic.
Date:   Mon,  6 Aug 2018 17:53:39 +0200
Message-Id: <20180806155339.9473-1-enric.balletbo@collabora.com>
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
Hi,

This first version is slightly different from the RFC, note that I did
not maintain the Sean reviewed tag for that reason. With this version I
don't touch the atomic_update function and all is implemented in the
async_check/update functions. See the changelog for a list of changes.

The patch was tested on a Samsung Chromebook Plus in two ways.

 1. Running all igt kms_cursor_legacy and kms_atomic@plane_cursor_legacy
    tests and see that there is no regression after the patch.

 2. Running weston using the atomic API.

Best regards,
  Enric

Changes in v1:
- Rebased on top of drm-misc
- In async_check call drm_atomic_helper_check_plane_state to check that
  the desired plane is valid and update various bits of derived state
  (clipped coordinates etc.)
- In async_check allow to configure new scaling in the fast path.
- In async_update force to flush all registered PSR encoders.
- In async_update call atomic_update directly.
- In async_update call vop_cfg_done needed to set the vop registers and take effect.

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 53 +++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index e9f91278137d..dab70056ee73 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -811,10 +811,63 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
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
+	int ret;
+
+	if (plane != state->crtc->cursor)
+		return -EINVAL;
+
+	if (!plane->state)
+		return -EINVAL;
+
+	if (!plane->state->fb ||
+	    plane->state->fb != state->fb)
+		return -EINVAL;
+
+	ret = drm_atomic_helper_check_plane_state(plane->state,
+						  plane->crtc->state,
+						  min_scale, max_scale,
+						  true, true);
+	return ret;
+}
+
+static void vop_plane_atomic_async_update(struct drm_plane *plane,
+					  struct drm_plane_state *new_state)
+{
+	struct vop *vop = to_vop(plane->state->crtc);
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
+	if (vop->is_enabled) {
+		rockchip_drm_psr_flush_all(plane->dev);
+		vop_plane_atomic_update(plane, plane->state);
+		spin_lock(&vop->reg_lock);
+		vop_cfg_done(vop);
+		spin_unlock(&vop->reg_lock);
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
-- 
2.18.0

