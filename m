Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D18C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iTnr6UYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE57B20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeJXAPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:15:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33115 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeJXAPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:15:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id z2-v6so870548pgp.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3lvXaaEY5R/F0dznPRLXAqH2n34ZCnPFDUOB+iRgwM=;
        b=iTnr6UYVsIoWa/9U1/cxKRVTlP61bw/A7blbPeW9txXE/4aYxmUTnhhHSllDM+ds6R
         qAlXmWuCEGixsNkVFuRzXoskq0UCmXwm6/W8bzrB4uACgc1h3rfCAo2kzVmUxEe2qI6A
         K9lULq0o7B++akpf8bVtO0sg50gwt3iGU1KmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3lvXaaEY5R/F0dznPRLXAqH2n34ZCnPFDUOB+iRgwM=;
        b=lXUqbUpYFzYteARpht/TbQStIO0HniOCQdEJ4UQ9cMzK6Go4YPcXA9m0jENTyLA3O5
         nYrJ/41eFMtV0Knsw/85NWWuHSIcEDJnwXZWyWA7401CMfCnhLscvCzlE9sHAFF5Gmyj
         Y79IFvubcvbs/b0v9VHJxM5q/zgFzTGSemHzjAQ+j99Qru9jPNRhLsfZigXg6gGbECVO
         oF3y9FgdMKZGFF7nyz8ed9iGkEUL22kTseVwrR+E4Co/85JY+t5PzdX98RgSSGxdXsBf
         K6voahI4eB0vpA/VBIoRcWTbBL8TYZt6rwAm4FmRBcAJ5+DYYnA5tq1rA5G13OD3Nxwr
         iVgg==
X-Gm-Message-State: ABuFfojK7XuqzLL7PgCy+h07Lh5ZjBUAuCOgN/Jh7XU+e3vtMCpnzC1K
        LZNeQl/aATvSeFhzVC43JO+R7w==
X-Google-Smtp-Source: ACcGV613EAo6RhMG6M/4/ULzIQ/11ssY8rphLwn+chPHm9bfbBu+09eI6I2kCKaDSk/Rn4S4FZWoDg==
X-Received: by 2002:a62:d085:: with SMTP id p127-v6mr24325213pfg.202.1540309909705;
        Tue, 23 Oct 2018 08:51:49 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:51:49 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 09/15] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
Date:   Tue, 23 Oct 2018 21:20:29 +0530
Message-Id: <20181023155035.9101-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accordingly to BPI-M64-bsp DE DSI code Video start delay
can be computed by subtracting total vertical timing with
front porch timing and with adding 1 delay line for TCON.

Video start delay is computed in BPI-M64-bsp code as
linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c

u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
=> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
=> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
   - panel->lcd_y - (panel->lcd_vbp)
=> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
  			     - panel->lcd_y - panel->lcd_vbp
=> timmings->ver_front_porch

So, update the start delay computation accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Add detailed commit message

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8d154cf2e6d6..6bece492b1f7 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -358,7 +358,17 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	return mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
+	u32 vfp = mode->vsync_start - mode->vdisplay;
+	u32 start_delay;
+
+	start_delay = mode->vtotal - vfp + 1;
+	if (start_delay > mode->vtotal)
+		start_delay -= mode->vtotal;
+
+	if (!start_delay)
+		start_delay = 1;
+
+	return start_delay;
 }
 
 static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

