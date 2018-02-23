Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeBWGXS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:23:18 -0500
Received: from regular1.263xmail.com ([211.150.99.135]:57087 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeBWGXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:23:17 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <ebfaba9c810f32834e8ec58a85fb4c1b>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: seanpaul@chromium.org, dcastagna@google.com, hoegsberg@google.com,
        heiko@sntech.de, tfiga@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/rockchip: vop: Init vskiplines in scl_vop_cal_scale()
Date: Fri, 23 Feb 2018 14:22:50 +0800
Message-Id: <20180223062250.10470-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are calling scl_vop_cal_scale() to get vskiplines for yrgb
and cbcr. So the cbcr's vskiplines might be an unexpected value if the
second scl_vop_cal_scale() didn't update it.

Init vskiplines in scl_vop_cal_scale() to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 7715853ef90a..9b03c51903ab 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -259,6 +259,9 @@ static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
 {
 	uint16_t val = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
 
+	if (vskiplines)
+		*vskiplines = 0;
+
 	if (is_horizontal) {
 		if (mode == SCALE_UP)
 			val = GET_SCL_FT_BIC(src, dst);
@@ -299,7 +302,7 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint16_t vsu_mode;
 	uint16_t lb_mode;
 	uint32_t val;
-	int vskiplines = 0;
+	int vskiplines;
 
 	if (dst_w > 3840) {
 		DRM_DEV_ERROR(vop->dev, "Maximum dst width (3840) exceeded\n");
-- 
2.11.0
