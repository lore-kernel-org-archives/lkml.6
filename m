Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CC320672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S6PS8uPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CC320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeLJQSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53683 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbeLJQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so11505574wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaE2bcL6r+p/M15eQzTefkij1Q0qgITroLCaQhT54ts=;
        b=S6PS8uPD8o5uagR8UnFFV5omwXh05Mz44ipN7Z9aiXIlDLaDRYzk2Jj/QB6wdZGifY
         UfH6mmYsN3/xenatx9Yp6xZ6SrIX2kOaNglIrA4UwTpP6kGP3k/6TrHj05Ho1hEiBJLg
         KEwN29zz3nVhYewi3bpIULmuRTEgscTShjO4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaE2bcL6r+p/M15eQzTefkij1Q0qgITroLCaQhT54ts=;
        b=jRccAbI14MzXSf2zBcj22KPOEQgJs3PTkBaQIDBy/aKAHUlh5xGi2zKX1tzxkuzveQ
         gfuG1jfx4axBnHG1AggakmvHo30ydEv1Hr7hQSSC1/VapidSWcDhNw3Ilcnk3fgz+G59
         CCFoz7djwXIfWF235BK9ZIDNom/ys9Zt9u8/CKTGYoW1rH4mR7Ccolzw4qgdNS/NoNTu
         o4tipKRrdH4vQ2g6Q01FOr8K+Y6aBVgil2onOet3ovfv7PJLUdJ8JJ57PxFk9+SBFu/I
         wLYQSejc43IFdiySrHlGGAeMyzXk5O8pRoHQlW2sAHlwKebIynxaPyIGehi6YmsBuOfu
         gW6A==
X-Gm-Message-State: AA+aEWanyBJ7Lmwi4DBSWBRE97Wqx6RllZn4twdXKMspW9NrePZnQ9Km
        2bcyIfcePLBQaQHqv7cpFW7Kjw==
X-Google-Smtp-Source: AFSGD/VZAupYbQ9LuzdN+x/pfuCVOroCGUxCmBhiF84wmW8VVo6bObaVkTtxkS+buZnlKVFmY0nK5g==
X-Received: by 2002:a1c:9dcc:: with SMTP id g195mr10789931wme.153.1544458684950;
        Mon, 10 Dec 2018 08:18:04 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:04 -0800 (PST)
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
Subject: [PATCH v5 12/17] drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
Date:   Mon, 10 Dec 2018 21:47:24 +0530
Message-Id: <20181210161729.29720-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike hblk, the vblk timings should follow an equation to compute
the desired value for lane 4 devices and rest of devices it would be 0.

BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
(from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
dsi_vblk = (lane-tmp%lane);

So, update the vblk timing calculation accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 29 +++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d8947be92f9d..cbcef7bf7681 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -355,6 +355,27 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_INST_JUMP_CFG_NUM(1));
 };
 
+static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode, u16 hblk)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	int tmp;
+
+	if (device->lanes != 4)
+		return 0;
+
+	/*
+	 * The vertical blank is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define VBLK_PACKET_OVERHEAD	6
+	tmp = (mode->htotal * Bpp) * mode->vtotal -
+	      (hblk + VBLK_PACKET_OVERHEAD);
+
+	return (device->lanes - tmp % device->lanes);
+}
+
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
@@ -503,13 +524,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
 		   Bpp - HBLK_PACKET_OVERHEAD);
 
-	/*
-	 * And I'm not entirely sure what vblk is about. The driver in
-	 * Allwinner BSP is using a rather convoluted calculation
-	 * there only for 4 lanes. However, using 0 (the !4 lanes
-	 * case) even with a 4 lanes screen seems to work...
-	 */
-	vblk = 0;
+	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
-- 
2.18.0.321.gffc6fa0e3

