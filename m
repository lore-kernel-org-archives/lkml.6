Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B6CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D967A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lvquzrG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D967A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeLJQTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:19:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44347 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbeLJQR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:17:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so11056526wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxNgORGPoSCn3Oq9HEn9GoMFiwahxDYqmWRf1K3P8O8=;
        b=lvquzrG04DT0Y6bsbtOA+ZLoIGEvklE7XkuYHVBq0nhUBrl4xHRjAy8d0aNGFU11ux
         klqCRmNcoo8g0irOhc48Z5qjccbNYyTYTskDA+JQVBI+9QZNSbDjKPspgWEGimdGDFy2
         slUsatULEvlKJQKiznvGc7Vbpq4fseqW3Fup4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxNgORGPoSCn3Oq9HEn9GoMFiwahxDYqmWRf1K3P8O8=;
        b=URmklK/KoV57RpPeMh5mcBZqvdKv46p+AfujG1b9G4KjyhBbFd7jS47/ewgITBJceE
         f1609xOEViEgclKaHFj2a03UU8ZYS3A1Kp7ZSBVRheSB+YWHp/QpG+IVDVvUnIVxp7BX
         Qt5kJYQCCNkX9HbJEBy3vU3/cc5iBGnO6xXN6TdOnR1vRptF7EORJeFqf9VMiH/1HAnc
         /8TZI8r081evNp6Q615xYEgzHqoJfQn/mRv/vXRWDqNINUt2Vhy5ZdFxEFARhbRa59I6
         jR/7gfDAVB9NZWtmbhouqWQ7lTf1qiS2soHv6s6pmNr01/8V3ymxJQ7FFqJp23WtN+0K
         elnA==
X-Gm-Message-State: AA+aEWY4UwX7/Qxz9ro/nyf6Y+eY57XaQt039YkRppznQjq+RSjVGIg/
        2t/XcRwiZ7N0u3T8a1U6gjWCeQ==
X-Google-Smtp-Source: AFSGD/WKoXN5Q1BGK+/QFKiIqyuJtSy532LcvwxbVFqOOwq141q0U/0oZ2d0GXXsJfPAZD8eAJY75Q==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr10124004wrs.75.1544458676335;
        Mon, 10 Dec 2018 08:17:56 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:55 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
Date:   Mon, 10 Dec 2018 21:47:19 +0530
Message-Id: <20181210161729.29720-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video start delay can be computed by subtracting total vertical
timing with front porch timing and with adding 1 delay line for TCON.

BSP code form BPI-M64-bsp is computing video start delay as
(from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

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
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c9b0222ebcd4..cb41fea4f3ee 100644
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

