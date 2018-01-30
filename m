Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeA3UdQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:33:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeA3U35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:57 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 34/43] drm/rockchip: pre dither down when output bpc is 8bit
Date: Tue, 30 Jan 2018 21:29:04 +0100
Message-Id: <20180130202913.28724-35-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
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
index bf4b1a2f3fa4..4abb9d72d814 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -937,6 +937,12 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
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
2.14.1
