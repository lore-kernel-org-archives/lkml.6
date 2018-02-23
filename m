Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeBWNUQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:20:16 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39620 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeBWNUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:20:12 -0500
X-Google-Smtp-Source: AG47ELsQV7o7MqjYVk0MxHuYTQQX1ijTbI+K1/ZOEAq+u1sODQOlMtZSMpGaOcNwxAhROipctg0L1Q==
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <seanpaul@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC 3/4] drm/msm/mdp5: add config for writeback pipes
Date: Fri, 23 Feb 2018 08:17:53 -0500
Message-Id: <20180223131758.18362-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180223131758.18362-1-robdclark@gmail.com>
References: <20180223131758.18362-1-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note there seems to be a slight disagreement between public 8x16 HRD
(which claims WB2 has offset of 0x65000, relative to start of MDP), and
reality (which claims WB2 has offset of 0x64800).  I sided with reality.

There should also be a WB0 attached to LM0 (which routes to DSI
interface).  It isn't clear if this can be used at the same time as
output to DSI, which would be hugely useful.  I was unable to get this
to work (with HDMI bridge chip on db410c, so DSI in video mode).

This will be needed to implement writeback support, but also useful
to remove a manual hack to the generated headers (since rnndb register
docs for WB had been merged long ago).

Also fixes LM3 offset.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h |  2 --
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 17 +++++++++++------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.h | 11 +++++++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  1 +
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h
index d9c10e02ee41..bebcbabb1fe4 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h
@@ -1391,13 +1391,11 @@ static inline uint32_t REG_MDP5_PP_FBC_LOSSY_MODE(uint32_t i0) { return 0x000000
 static inline uint32_t __offset_WB(uint32_t idx)
 {
 	switch (idx) {
-#if 0  /* TEMPORARY until patch that adds wb.base[] is merged */
 		case 0: return (mdp5_cfg->wb.base[0]);
 		case 1: return (mdp5_cfg->wb.base[1]);
 		case 2: return (mdp5_cfg->wb.base[2]);
 		case 3: return (mdp5_cfg->wb.base[3]);
 		case 4: return (mdp5_cfg->wb.base[4]);
-#endif
 		default: return INVALID_IDX(idx);
 	}
 }
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
index 824067d2d427..f92e68cdeeef 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
@@ -300,8 +300,8 @@ const struct mdp5_cfg_hw msm8x16_config = {
 		},
 	},
 	.ctl = {
-		.count = 5,
-		.base = { 0x01000, 0x01200, 0x01400, 0x01600, 0x01800 },
+		.count = 3,
+		.base = { 0x01000, 0x01200, 0x01400 },
 		.flush_hw_mask = 0x4003ffff,
 	},
 	.pipe_vig = {
@@ -324,7 +324,7 @@ const struct mdp5_cfg_hw msm8x16_config = {
 	},
 	.lm = {
 		.count = 2, /* LM0 and LM3 */
-		.base = { 0x44000, 0x47000 },
+		.base = { [0] = 0x44000, [3] = 0x47000 },
 		.instances = {
 				{ .id = 0, .pp = 0, .dspp = 0,
 				  .caps = MDP_LM_CAP_DISPLAY, },
@@ -338,12 +338,17 @@ const struct mdp5_cfg_hw msm8x16_config = {
 	.dspp = {
 		.count = 1,
 		.base = { 0x54000 },
-
+	},
+	.wb = {
+		.count = 1,
+		.base = { [0] = 0x64000, [2] = 0x64800 },
+		.instances = {
+			{ .id = 2, .lm = 3 },
+		},
 	},
 	.intf = {
-		.base = { 0x00000, 0x6a800 },
+		.base = { 0x6a000, 0x6a800, 0x6b000, 0x6b800 },
 		.connect = {
-			[0] = INTF_DISABLED,
 			[1] = INTF_DSI,
 		},
 	},
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.h
index 75910d0f2f4c..2e529fb2f9ee 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.h
@@ -77,6 +77,16 @@ struct mdp5_mdp_block {
 	uint32_t caps;			/* MDP capabilities: MDP_CAP_xxx bits */
 };
 
+struct mdp5_wb_instance {
+	int id;
+	int lm;
+};
+
+struct mdp5_wb_block {
+	MDP5_SUB_BLOCK_DEFINITION;
+	struct mdp5_wb_instance instances[MAX_BASES];
+};
+
 #define MDP5_INTF_NUM_MAX	5
 
 struct mdp5_intf_block {
@@ -100,6 +110,7 @@ struct mdp5_cfg_hw {
 	struct mdp5_sub_block pp;
 	struct mdp5_sub_block dsc;
 	struct mdp5_sub_block cdm;
+	struct mdp5_wb_block wb;
 	struct mdp5_intf_block intf;
 
 	uint32_t max_clk;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 6d8e3a9a6fc0..1f44d8f15ce1 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -652,6 +652,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
 	pm_runtime_get_sync(&pdev->dev);
 	for (i = 0; i < MDP5_INTF_NUM_MAX; i++) {
 		if (mdp5_cfg_intf_is_virtual(config->hw->intf.connect[i]) ||
+		    (config->hw->intf.connect[i] == INTF_DISABLED) ||
 		    !config->hw->intf.base[i])
 			continue;
 		mdp5_write(mdp5_kms, REG_MDP5_INTF_TIMING_ENGINE_EN(i), 0);
-- 
2.14.3
