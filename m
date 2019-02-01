Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4459C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7DF21904
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FwxziL6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfBAPmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:42:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44801 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfBAPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:42:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so6137519lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cX9BCqEMHQCHAsrFYobLewx1bc2r/y4XH0JrehpkNwQ=;
        b=FwxziL6YDddDrG61jfPHgvFaJd87cBPOW3CRbYGHFBfDrM1oRDhq4vhEY1PJJ/UYyJ
         bkPn8082W9QCvBDVGV5vOfvJ5Er9NngoWGLfoyUd2Lp5VPWw2fWm8X0SORDRauRjEpsp
         YUDKEyrN0SHFzni0QlMzJilLjLpgN2FCd/v4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cX9BCqEMHQCHAsrFYobLewx1bc2r/y4XH0JrehpkNwQ=;
        b=BhZtZMbphwc7nk++fNqOLn6lEqD32+efR+5Ctb5Awxj/OYtiw6Sl/Rawc3TXhjXJ5+
         L0OOm1pV/jFDWnWXVgOczRXEOrEqTTHyr+eRJysJghpLezIKXUZVEFphJxdW4CR3Cw35
         KsOUglN7AumgJj4/PWf9hShxvScsRkNsvGUxBZ8TkDCtDbvyR/CwMneg3VJNjim5jAD8
         U9CLUhkPz9RzJoKp1DJK/IKCv9Zv8EVAV/dqwDHrF7RhgJGXfG7WHJ4bi2x9O+eKJsU5
         H7IsujAiWISHkkAqLHxZWVxhmYHCj8BJUNo2IMLpmj8t/spdJYCMQRqztrSItxuyXiSf
         8HFg==
X-Gm-Message-State: AJcUukf+ln0EMmMNRBFl5komf3/gEmKba8ZJZ3iVar9WxBpuefUGHOVh
        KXsIU7BtwGUz0yemqr4fq76Lzw==
X-Google-Smtp-Source: ALg8bN6kVB2Bdfh3cgksQB9MNbY1YwvZ83JikXHWf0FItNqeYebHwStbdzp+0p0qdcqDmysVQ2dxag==
X-Received: by 2002:a2e:4c0a:: with SMTP id z10-v6mr31858340lja.85.1549035765991;
        Fri, 01 Feb 2019 07:42:45 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:42:45 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 01/23] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction delay
Date:   Fri,  1 Feb 2019 21:12:10 +0530
Message-Id: <20190201154232.10505-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop N1 instruction delay varies between burst and non-burst video modes.

1) for burst mode panels it is computed based on the panel pixel clock
   along with horizontal sync and porch timings.
2) for non-burst mode panels, it is same as existing (50 - 1)

Reference code is available in BSP (from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
(panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
=> (((mode->htotal - mode->hdisplay) * 150) /
     ((mode->clock / 1000) * 8)) - 50;

This patch add loop N1 computation for burst mode by simplifying
existing code to support all possible modes.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e3b34a345546..a5fcee750bee 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -354,6 +354,24 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	u32 hsync_porch, dclk;
+	u16 delay;
+
+	hsync_porch = (mode->htotal - mode->hdisplay);
+	dclk = (mode->clock / 1000);
+
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		delay = ((hsync_porch * 150) / (dclk * 8)) - 50;
+	else
+		delay = 50 - 1;
+
+	return delay;
+}
+
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
@@ -383,7 +401,7 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
-	u16 delay = 50 - 1;
+	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
-- 
2.18.0.321.gffc6fa0e3

