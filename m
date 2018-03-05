Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeCEWZD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:25:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37758 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeCEWY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:57 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Mark Yao <mark.yao@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 29/38] drm/rockchip: pre dither down when output bpc is 8bit
Date: Mon,  5 Mar 2018 23:23:21 +0100
Message-Id: <20180305222324.5872-30-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yao <mark.yao@rock-chips.com>

Some encoder have a crc verification check, crc check fail if
input and output data is not equal.

That means encoder input and output need use same color depth,
vop can output 10bit data to encoder, but some panel only support
8bit depth, that would make crc check die.

So pre dither down vop data to 8bit if panel's bpc is 8.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
[seanpaul resolved conflict in rockchip_drm_vop.c]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     | 1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     | 6 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h     | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c     | 1 +
 5 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 8c884f9ce713..b3f46ed24cdc 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -218,6 +218,7 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_connector_state *conn_state)
 {
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct drm_display_info *di = &conn_state->connector->display_info;
 
 	/*
 	 * The hardware IC designed that VOP must output the RGB10 video
@@ -229,6 +230,7 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 
 	s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
 	s->output_type = DRM_MODE_CONNECTOR_eDP;
+	s->output_bpc = di->bpc;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 9c064a40458b..3a6ebfc26036 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -36,6 +36,7 @@ struct rockchip_crtc_state {
 	struct drm_crtc_state base;
 	int output_type;
 	int output_mode;
+	int output_bpc;
 };
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 184f980679af..42562ab04bde 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -928,6 +928,12 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA &&
 	    !(vop_data->feature & VOP_FEATURE_OUTPUT_RGB10))
 		s->output_mode = ROCKCHIP_OUT_MODE_P888;
+
+	if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc == 8)
+		VOP_REG_SET(vop, common, pre_dither_down, 1);
+	else
+		VOP_REG_SET(vop, common, pre_dither_down, 0);
+
 	VOP_REG_SET(vop, common, out_mode, s->output_mode);
 
 	VOP_REG_SET(vop, modeset, htotal_pw, (htotal << 16) | hsync_len);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 56bbd2e2a8ef..084acdd0019a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -67,6 +67,7 @@ struct vop_common {
 	struct vop_reg cfg_done;
 	struct vop_reg dsp_blank;
 	struct vop_reg data_blank;
+	struct vop_reg pre_dither_down;
 	struct vop_reg dither_down;
 	struct vop_reg dither_up;
 	struct vop_reg gate_en;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 2e4eea3459fe..08023d3ecb76 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -264,6 +264,7 @@ static const struct vop_common rk3288_common = {
 	.standby = VOP_REG_SYNC(RK3288_SYS_CTRL, 0x1, 22),
 	.gate_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 23),
 	.mmu_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 20),
+	.pre_dither_down = VOP_REG(RK3288_DSP_CTRL1, 0x1, 1),
 	.dither_down = VOP_REG(RK3288_DSP_CTRL1, 0xf, 1),
 	.dither_up = VOP_REG(RK3288_DSP_CTRL1, 0x1, 6),
 	.data_blank = VOP_REG(RK3288_DSP_CTRL0, 0x1, 19),
-- 
2.16.1
