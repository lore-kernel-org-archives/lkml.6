Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F74320847
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oP4oHcl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F74320847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeKCTUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:20:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38571 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeKCTUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:20:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id p7-v6so2140577plk.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItiKdY/aqQ72CaiAvq/zBxi6LN6Pf1wyAwPGh/IMHHQ=;
        b=oP4oHcl3zRwyD7AEbNu3WwJ/L5SL4JweeBHJviTFRgDzWF2QjkMl7dsUpMId3phf1R
         9QCZ1l7pWSW3UK//1MAgXzqYzZyUN6+QhJ4LPyckL5dG5QO3aSTTkUN+e2PDf1rR05AO
         tVgA3tYbD984GBtlvujRlQJhOiLIhMA5H3NzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItiKdY/aqQ72CaiAvq/zBxi6LN6Pf1wyAwPGh/IMHHQ=;
        b=okcl7gu0X0sQjT89G5mGWx3dZfG1Z0bufYx10Qe8dtgGPgW9mprcidShPvK7FhPDCc
         yoNi6CBQJFEiEDJLI6ILZR/2KfH5hG41XfKVdKyxPqrxup8oVDVvGYKdkUqTRtz3YjZA
         dYQhXpbfz4dwwvDEi2/UA66+U4Y40bJZjwUPr+tVtKPXsXmdVl5prpprqffYnUKpVWZ6
         tfo5+a5cBclF0kpCrMJ9k7xams9YW8MRs1EyozJZct50DNhsAYEzw3fDhVaVT0xmq1UE
         /r3QvuQiJPOSMEFQfbAhzAvqCbCJ1vIWl9rAIJK/nopWFLVL3Zr2SThdfizZxx7oo2Z5
         6ijw==
X-Gm-Message-State: AGRZ1gJbQGEVSzYpYeB39IzM1pxIezCG0Xg/IJ9bLhbAd/ZzUHLHFltB
        g+wcTyV4haPDqhWBMSEiOWaKoQ==
X-Google-Smtp-Source: AJdET5dxiNozwBzE8xGf4Wfx+GgIdBkafQgF7rhrQSqStOEiVgqWI00de4qC41PL68yFC/tWW3INXA==
X-Received: by 2002:a17:902:f097:: with SMTP id go23mr14566114plb.328.1541239769647;
        Sat, 03 Nov 2018 03:09:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:09:29 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 01/10] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction delay
Date:   Sat,  3 Nov 2018 15:38:51 +0530
Message-Id: <20181103100900.30313-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop N1 instruction delay for burst mode lcd panel are
computed as per BSP code.

Reference code is available in BSP
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
(panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
=> (((mode->htotal - mode->hdisplay) * 150) / ((mode->clock / 1000) * 8)) - 50;

So use the similar computation for loop N1 delay.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 86430efd9054..da152c21ec62 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -394,7 +394,14 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
-	u16 delay = 50 - 1;
+	struct mipi_dsi_device *device = dsi->device;
+	u16 delay;
+
+	if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST)
+		delay = (((mode->htotal - mode->hdisplay) * 150) /
+			((mode->clock / 1000) * 8)) - 50;
+	else
+		delay = 50 - 1;
 
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
-- 
2.18.0.321.gffc6fa0e3

