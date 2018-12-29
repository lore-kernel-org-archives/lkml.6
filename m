Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7443C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDDD20828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+CjrBLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeL2Ndl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:33:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35077 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeL2Ndi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so19496765edx.2;
        Sat, 29 Dec 2018 05:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mcS8+aoLdp4kyMgJrmAjJ053Tw6APrfMo6WUP6Yn6CM=;
        b=C+CjrBLyhr0GNrtPwIQ1XXFJ6E0I6QBj66GKnm2RrE721gSbMeN8/H24vJVGsQpG07
         28kAyreQj7TEO6UAsAd/NJhcdVKk/aKyNqP1fCm3icFQVaFn8R/o85tYcvU22yec99pn
         J6YcEubxlH7mvMqR/0I0s2OsZQs2qYVxBVgFr1+0ybAGTUJolDBPt+0MboP12gZzT+Oo
         gftdzDV4NqRMb8bSET7KtfrAM0/vH88wpyoE5M2YUxAoKJ6RwHebyIUGnXRBIe0Oa7Sf
         xoBOFRGjGTCHn+Y0C0GvxVcikwk5alvM7XZbATpcGtL1w+JmaMdnRsjJE2LnU45D77r9
         JWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mcS8+aoLdp4kyMgJrmAjJ053Tw6APrfMo6WUP6Yn6CM=;
        b=aItfsSTbdYZxXA4zsym9uSR+4x+6yQSd50UAL3APlKD4JedGWrFD3l/ZDXBGAdTsNe
         gBbK1qJo7Ar2cbAmSaZ1jSu7TwYLm/NHG/KPhqt3D8t8m1sdjqZRBLvn5kFF9HJjfeE7
         SJvPyxXa4d5+9YaLThRIaq/viluE0K4hzdx0jmjtJvktiRAbphWaSVxnwwbeKjTd59f+
         AzhW6lSOrE4JioLcve1+eBrl3CtmqP3CNIogEVt7zz3tjPUvNCWMzd13tQssdXqkou7P
         XJF4YX0ibgG3Ll7cU2OwqgcrlC1t7w443jGnsemyqH7jrd0dk+ytfYzy4zHpMXiiJ6MI
         ibrQ==
X-Gm-Message-State: AA+aEWZUgynfltrU1lafRaPrYkDuU+0Sq1/oIKuDB5w0CKyqvYXLjYJd
        0JeziltccJu8H4gBKm1+yD8=
X-Google-Smtp-Source: AFSGD/XugqnCNm9nu8MVFuCA0RlDcROQzIuPb1LFjhVK6y0LXbcE1B33lsBJOJop1e5u2iLKeHF9GA==
X-Received: by 2002:a50:fe15:: with SMTP id f21mr24777867edt.116.1546090416160;
        Sat, 29 Dec 2018 05:33:36 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:35 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 3/7] drm: rockchip: vop: add rk3066 vop definitions
Date:   Sat, 29 Dec 2018 14:33:14 +0100
Message-Id: <20181229133318.18128-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yao <mark.yao@rock-chips.com>

This patch adds the rk3066 VOP definitions.

The VOP or LCD Controller serves as interface between
framebuffer memory and a display device (LCD panel or TV set).

This SOC has two symmetrical LCDC's for a dual panel application.

A LCDC has 5 display layers.
Only 3 are used here.

- Video layer 0 (Win0)
- Video layer 1 (Win1)
- OSD layer     (Win2)

Win0 and Win1 are exchangeable.
Maximum resolution is 1920x1080.

The LCDC0 output is connected to:
- LCDC0 IO (without IOMUX)
- HDMI TX video input

The LCDC1 output is connected to:
- LCDC1 IO (with IOMUX)
- HDMI TX video input

The HDMI TX input can switch between LCDC0 and LCDC1.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/rockchip/rockchip-vop.txt     |   1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        | 110 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |  53 ++++++++++
 3 files changed, 164 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
index b79e5769f..4f58c5a2d 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
@@ -10,6 +10,7 @@ Required properties:
 		"rockchip,rk3126-vop";
 		"rockchip,px30-vop-lit";
 		"rockchip,px30-vop-big";
+		"rockchip,rk3066-vop";
 		"rockchip,rk3188-vop";
 		"rockchip,rk3288-vop";
 		"rockchip,rk3368-vop";
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index a6db3cd55..2799c7e8e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -299,6 +299,114 @@ static const struct vop_data px30_vop_lit = {
 	.win_size = ARRAY_SIZE(px30_vop_lit_win_data),
 };
 
+static const struct vop_scl_regs rk3066_win_scl = {
+	.scale_yrgb_x = VOP_REG(RK3066_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(RK3066_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
+	.scale_cbcr_x = VOP_REG(RK3066_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
+	.scale_cbcr_y = VOP_REG(RK3066_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
+};
+
+static const struct vop_win_phy rk3066_win0_data = {
+	.scl = &rk3066_win_scl,
+	.data_formats = formats_win_full,
+	.nformats = ARRAY_SIZE(formats_win_full),
+	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 0),
+	.format = VOP_REG(RK3066_SYS_CTRL0, 0x7, 4),
+	.rb_swap = VOP_REG(RK3066_SYS_CTRL0, 0x1, 19),
+	.act_info = VOP_REG(RK3066_WIN0_ACT_INFO, 0x1fff1fff, 0),
+	.dsp_info = VOP_REG(RK3066_WIN0_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3066_WIN0_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3066_WIN0_YRGB_MST0, 0xffffffff, 0),
+	.uv_mst = VOP_REG(RK3066_WIN0_CBR_MST0, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3066_WIN0_VIR, 0xffff, 0),
+	.uv_vir = VOP_REG(RK3066_WIN0_VIR, 0x1fff, 16),
+};
+
+static const struct vop_win_phy rk3066_win1_data = {
+	.scl = &rk3066_win_scl,
+	.data_formats = formats_win_full,
+	.nformats = ARRAY_SIZE(formats_win_full),
+	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 1),
+	.format = VOP_REG(RK3066_SYS_CTRL0, 0x7, 7),
+	.rb_swap = VOP_REG(RK3066_SYS_CTRL0, 0x1, 23),
+	.act_info = VOP_REG(RK3066_WIN1_ACT_INFO, 0x1fff1fff, 0),
+	.dsp_info = VOP_REG(RK3066_WIN1_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3066_WIN1_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3066_WIN1_YRGB_MST, 0xffffffff, 0),
+	.uv_mst = VOP_REG(RK3066_WIN1_CBR_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3066_WIN1_VIR, 0xffff, 0),
+	.uv_vir = VOP_REG(RK3066_WIN1_VIR, 0x1fff, 16),
+};
+
+static const struct vop_win_phy rk3066_win2_data = {
+	.data_formats = formats_win_lite,
+	.nformats = ARRAY_SIZE(formats_win_lite),
+	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 2),
+	.format = VOP_REG(RK3066_SYS_CTRL0, 0x7, 10),
+	.rb_swap = VOP_REG(RK3066_SYS_CTRL0, 0x1, 27),
+	.dsp_info = VOP_REG(RK3066_WIN2_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3066_WIN2_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3066_WIN2_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3066_WIN2_VIR, 0xffff, 0),
+};
+
+static const struct vop_modeset rk3066_modeset = {
+	.htotal_pw = VOP_REG(RK3066_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
+	.hact_st_end = VOP_REG(RK3066_DSP_HACT_ST_END, 0x1fff1fff, 0),
+	.vtotal_pw = VOP_REG(RK3066_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
+	.vact_st_end = VOP_REG(RK3066_DSP_VACT_ST_END, 0x1fff1fff, 0),
+};
+
+static const struct vop_output rk3066_output = {
+	.pin_pol = VOP_REG(RK3066_DSP_CTRL0, 0x7, 4),
+};
+
+static const struct vop_common rk3066_common = {
+	.standby = VOP_REG(RK3066_SYS_CTRL0, 0x1, 1),
+	.out_mode = VOP_REG(RK3066_DSP_CTRL0, 0xf, 0),
+	.cfg_done = VOP_REG(RK3066_REG_CFG_DONE, 0x1, 0),
+	.dsp_blank = VOP_REG(RK3066_DSP_CTRL1, 0x1, 24),
+};
+
+static const struct vop_win_data rk3066_vop_win_data[] = {
+	{ .base = 0x00, .phy = &rk3066_win0_data,
+	  .type = DRM_PLANE_TYPE_PRIMARY },
+	{ .base = 0x00, .phy = &rk3066_win1_data,
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &rk3066_win2_data,
+	  .type = DRM_PLANE_TYPE_CURSOR },
+};
+
+static const int rk3066_vop_intrs[] = {
+	/*
+	 * hs_start interrupt fires at frame-start, so serves
+	 * the same purpose as dsp_hold in the driver.
+	 */
+	DSP_HOLD_VALID_INTR,
+	FS_INTR,
+	LINE_FLAG_INTR,
+	BUS_ERROR_INTR,
+};
+
+static const struct vop_intr rk3066_intr = {
+	.intrs = rk3066_vop_intrs,
+	.nintrs = ARRAY_SIZE(rk3066_vop_intrs),
+	.line_flag_num[0] = VOP_REG(RK3066_INT_STATUS, 0xfff, 12),
+	.status = VOP_REG(RK3066_INT_STATUS, 0xf, 0),
+	.enable = VOP_REG(RK3066_INT_STATUS, 0xf, 4),
+	.clear = VOP_REG(RK3066_INT_STATUS, 0xf, 8),
+};
+
+static const struct vop_data rk3066_vop = {
+	.version = VOP_VERSION(2, 1),
+	.intr = &rk3066_intr,
+	.common = &rk3066_common,
+	.modeset = &rk3066_modeset,
+	.output = &rk3066_output,
+	.win = rk3066_vop_win_data,
+	.win_size = ARRAY_SIZE(rk3066_vop_win_data),
+};
+
 static const struct vop_scl_regs rk3188_win_scl = {
 	.scale_yrgb_x = VOP_REG(RK3188_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(RK3188_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
@@ -754,6 +862,8 @@ static const struct of_device_id vop_driver_dt_match[] = {
 	  .data = &px30_vop_big },
 	{ .compatible = "rockchip,px30-vop-lit",
 	  .data = &px30_vop_lit },
+	{ .compatible = "rockchip,rk3066-vop",
+	  .data = &rk3066_vop },
 	{ .compatible = "rockchip,rk3188-vop",
 	  .data = &rk3188_vop },
 	{ .compatible = "rockchip,rk3288-vop",
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index 7348c6835..d837d4a7d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -983,4 +983,57 @@
 #define RK3188_REG_CFG_DONE		0x90
 /* rk3188 register definition end */
 
+/* rk3066 register definition */
+#define RK3066_SYS_CTRL0		0x00
+#define RK3066_SYS_CTRL1		0x04
+#define RK3066_DSP_CTRL0		0x08
+#define RK3066_DSP_CTRL1		0x0c
+#define RK3066_INT_STATUS		0x10
+#define RK3066_MCU_CTRL			0x14
+#define RK3066_BLEND_CTRL		0x18
+#define RK3066_WIN0_COLOR_KEY_CTRL	0x1c
+#define RK3066_WIN1_COLOR_KEY_CTRL	0x20
+#define RK3066_WIN2_COLOR_KEY_CTRL	0x24
+#define RK3066_WIN0_YRGB_MST0		0x28
+#define RK3066_WIN0_CBR_MST0		0x2c
+#define RK3066_WIN0_YRGB_MST1		0x30
+#define RK3066_WIN0_CBR_MST1		0x34
+#define RK3066_WIN0_VIR			0x38
+#define RK3066_WIN0_ACT_INFO		0x3c
+#define RK3066_WIN0_DSP_INFO		0x40
+#define RK3066_WIN0_DSP_ST		0x44
+#define RK3066_WIN0_SCL_FACTOR_YRGB	0x48
+#define RK3066_WIN0_SCL_FACTOR_CBR	0x4c
+#define RK3066_WIN0_SCL_OFFSET		0x50
+#define RK3066_WIN1_YRGB_MST		0x54
+#define RK3066_WIN1_CBR_MST		0x58
+#define RK3066_WIN1_VIR			0x5c
+#define RK3066_WIN1_ACT_INFO		0x60
+#define RK3066_WIN1_DSP_INFO		0x64
+#define RK3066_WIN1_DSP_ST		0x68
+#define RK3066_WIN1_SCL_FACTOR_YRGB	0x6c
+#define RK3066_WIN1_SCL_FACTOR_CBR	0x70
+#define RK3066_WIN1_SCL_OFFSET		0x74
+#define RK3066_WIN2_MST			0x78
+#define RK3066_WIN2_VIR			0x7c
+#define RK3066_WIN2_DSP_INFO		0x80
+#define RK3066_WIN2_DSP_ST		0x84
+#define RK3066_HWC_MST			0x88
+#define RK3066_HWC_DSP_ST		0x8c
+#define RK3066_HWC_COLOR_LUT0		0x90
+#define RK3066_HWC_COLOR_LUT1		0x94
+#define RK3066_HWC_COLOR_LUT2		0x98
+#define RK3066_DSP_HTOTAL_HS_END	0x9c
+#define RK3066_DSP_HACT_ST_END		0xa0
+#define RK3066_DSP_VTOTAL_VS_END	0xa4
+#define RK3066_DSP_VACT_ST_END		0xa8
+#define RK3066_DSP_VS_ST_END_F1		0xac
+#define RK3066_DSP_VACT_ST_END_F1	0xb0
+#define RK3066_REG_CFG_DONE		0xc0
+#define RK3066_MCU_BYPASS_WPORT		0x100
+#define RK3066_MCU_BYPASS_RPORT		0x200
+#define RK3066_WIN2_LUT_ADDR		0x400
+#define RK3066_DSP_LUT_ADDR		0x800
+/* rk3066 register definition end */
+
 #endif /* _ROCKCHIP_VOP_REG_H */
-- 
2.11.0

