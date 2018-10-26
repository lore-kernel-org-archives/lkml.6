Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB90C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766A620868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cc1ITzOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766A620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJZXWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37373 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJZXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh10-v6so627530plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygp+3SnprJhnbmLUgRdGawXUPjC/BTULTbCFbZ067cc=;
        b=cc1ITzOq6renkXS39VEzpzI9qforSXwKRu53A3Jcd2aCV7FRFjv31cecPUaNvVxUoL
         vb93mpt2cy4W48WhC3IIdA1VhwXjL11I7qAOmITITn5nM8BLtMby3xvQ4GVbMg1hPp4g
         I71GuCE7HLRpkqcMqlpl34E9OTCvPCgTWLQhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygp+3SnprJhnbmLUgRdGawXUPjC/BTULTbCFbZ067cc=;
        b=CQOlyP4pNgMtNbZE3A3bvaed4RJ0GqUJHB/pzQOHLzP4Cq3oNeq9dEGA/ZFzeNL1e9
         a7nhS+2Gsu0OiNORT8yamwN+EXyrMsOhAu7fIoW7t61ox5g+xWusxbpig8R23Y6iUi+1
         diTqKGqyayKxYR69QXhUkCALQt0yrlxvm+nsvhmDCsLksSjE5sQ9YVXViYbhXi9eitcM
         DbY3p0yu4/yZjPbm3zHX2aDic/CXY9AQwjVYmxlVSxgYLayztXnZo00/ftDR0KJyAZ1a
         Sqvsve2JMRh1PCQ+38vGJbzfUNRVi1DdH+oxuhtIeEMzHYRhdWgRx6fN0K1j7LyHU3Zt
         Fxtg==
X-Gm-Message-State: AGRZ1gIvprXC7j9lMLnvD5mhqQvFG/db5SJrnnzXRNNy5zbfSHe4f7C4
        /moK9xt13LwcZaGgWmpxQ/9ZIQ==
X-Google-Smtp-Source: AJdET5f7igh1BKVvkMSAzIy+VfsF+TBLbwiw5FU55gW9N+8bQAN/icqoyRMN9cvvaQDvln/5hpjAyw==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5-v6mr3889262plr.100.1540565103086;
        Fri, 26 Oct 2018 07:45:03 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:45:02 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
Subject: [PATCH v3 09/25] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
Date:   Fri, 26 Oct 2018 20:13:28 +0530
Message-Id: <20181026144344.27778-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video start delay can be computed by subtracting total vertical
timing with front porch timing and with adding 1 delay line for TCON.

BSP code form BPI-M64-bsp is computing video start delay as
(in linux-sunxi/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
=> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
=> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
   - panel->lcd_y - (panel->lcd_vbp)
=> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
  			     - panel->lcd_y - panel->lcd_vbp
=> timmings->ver_front_porch

So, update the start delay computation accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Fixed proper commit message
- add tested credit
Changes for v2:
- none

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

