Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DDFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509720684
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ceOdo43z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C509720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbeKQCxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:53:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38639 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbeKQCxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:53:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so10824692pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dP1vOMxWacxYs/v4J30IWXfhdx6NrRFGWFTZApmbYU=;
        b=ceOdo43zYnOrKMIPGlQ0esry5bfUFVF/Df0JtUOTVyXLGqWqUOl8lLG8JkXOZBBHrq
         Nf8/CG3ROgbIKq96C4PGcDlEiQK2tueHHSWEaQ+ulSv/wyQelWgUMGoZX3Js/MdszQid
         mF3lY/cxlqNQ6ydcU2UIQGoqtDY5qT48hu1Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dP1vOMxWacxYs/v4J30IWXfhdx6NrRFGWFTZApmbYU=;
        b=RLWa0k2YWnqqEgmbYdxdrtpRTgXa5a1cfXb1I8KuoxUxtcP5lUJsOyz7ksbGmqtmwy
         YxdBVz5rvG3hASVPUmjmqgsZeIooalkFokI25iV4IzNuUrgecqG0FBkGUq4ka4qsn7uN
         rIw/dE3PUl6lmir9yu+8vXQaCkWXeaJdU6psQ8O8Bly5ffJV1+yeDD9CytF9fS1af4jl
         dNl4ULZyw8J2yeEAowN7oTwyNwyRagEn4IreO2eu/QI5MAMt0n1OYqc0Ecb7SkvB8zQh
         EW6EWbUICHPKzTmjASQ93y61XoTFrNkNj058/q3yCC7TR+67cKv8FiCKaPuG+lTH2MHF
         +zsg==
X-Gm-Message-State: AGRZ1gJmBkm5viPbtU1QSDSQEFZrwKmDrtwJDC2cIZl6qYSHS7F/C+Xc
        RaqBt9Yb7GKaYHzUlaEuSE6kyw==
X-Google-Smtp-Source: AJdET5fGMWD5aEfG7Y4fJEE/G61lDZAjtMka0fozTIEeQN7ArhkBpjGNCtk5ziVjpVLkiBjLbIJTAQ==
X-Received: by 2002:a63:1412:: with SMTP id u18mr10422416pgl.247.1542386400202;
        Fri, 16 Nov 2018 08:40:00 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:39:59 -0800 (PST)
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Date:   Fri, 16 Nov 2018 22:09:07 +0530
Message-Id: <20181116163916.29621-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Burst mode display timings are different from convectional
video mode so update the horizontal and vertical timings.

Reference code taken from BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hsa  = 0;
dsi_hbp  = 0;
dsi_hact = x*dsi_pixel_bits[format]/8;
dsi_hblk = dsi_hact;
dsi_hfp  = 0;
dsi_vblk = 0;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 128 +++++++++++++++----------
 1 file changed, 80 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 3ac002c4d8b3..efd08bfd0cb8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -153,6 +153,14 @@
 
 #define SUN6I_DSI_CMD_TX_REG(n)		(0x300 + (n) * 0x04)
 
+struct sun6i_dsi_timings {
+	u16 hsa;
+	u16 hbp;
+	u16 hblk;
+	u16 hfp;
+	u16 vblk;
+};
+
 enum sun6i_dsi_start_inst {
 	DSI_START_LPRX,
 	DSI_START_LPTX,
@@ -379,6 +387,60 @@ static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
 	return vblk;
 }
 
+static void sun6i_dsi_get_timings(struct sun6i_dsi *dsi,
+				  struct drm_display_mode *mode,
+				  struct sun6i_dsi_timings *timings)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	u16 hsa, hbp, hblk, hfp, vblk;
+
+	/*
+	 * A sync period is composed of a blanking packet (4 bytes +
+	 * payload + 2 bytes) and a sync event packet (4 bytes).
+	 * Its minimal size is therefore 10 bytes
+	 */
+#define HSA_PACKET_OVERHEAD	10
+	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
+		  (mode->hsync_end - mode->hsync_start) * Bpp -
+		  HSA_PACKET_OVERHEAD);
+
+	/*
+	 * The backporch is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define HBP_PACKET_OVERHEAD	6
+	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
+
+	/*
+	 * hblk seems to be the line + porches length.
+	 * The blank is set using a blanking packet (4 bytes + 4 bytes
+	 * + payload + 2 bytes). So minimal size is 10 bytes
+	 */
+#define HBLK_PACKET_OVERHEAD	10
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
+		   Bpp - HBLK_PACKET_OVERHEAD);
+
+	/*
+	 * The frontporch is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define HFP_PACKET_OVERHEAD	6
+	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
+		  (mode->hsync_start - mode->hdisplay) * Bpp -
+		  HFP_PACKET_OVERHEAD);
+
+	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
+
+	timings->hsa = hsa;
+	timings->hbp = hbp;
+	timings->hblk = hblk;
+	timings->hfp = hfp;
+	timings->vblk = vblk;
+}
+
 static u16 sun6i_dsi_setup_inst_delay(struct sun6i_dsi *dsi,
 				      struct drm_display_mode *mode)
 {
@@ -506,52 +568,22 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 {
 	struct mipi_dsi_device *device = dsi->device;
 	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
-	u16 hbp, hfp, hsa, hblk, vblk;
+	struct sun6i_dsi_timings timings;
 	size_t bytes;
 	u8 *buffer;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
-	/*
-	 * A sync period is composed of a blanking packet (4 bytes +
-	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
-	 * minimal size is therefore 10 bytes
-	 */
-#define HSA_PACKET_OVERHEAD	10
-	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
-		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
+	memset(&timings, 0, sizeof(timings));
 
-	/*
-	 * The backporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
-#define HBP_PACKET_OVERHEAD	6
-	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
-
-	/*
-	 * The frontporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
-#define HFP_PACKET_OVERHEAD	6
-	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp -
-		  HFP_PACKET_OVERHEAD);
-
-	/*
-	 * hblk seems to be the line + porches length.
-	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
-	 * payload + 2 bytes). So minimal size is 10 bytes
-	 */
-#define HBLK_PACKET_OVERHEAD	10
-	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
-		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
-		   Bpp - HBLK_PACKET_OVERHEAD);
-
-	vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		timings.hblk = (mode->hdisplay * Bpp);
+	else
+		sun6i_dsi_get_timings(dsi, mode, &timings);
 
 	/* How many bytes do we need to send all payloads? */
-	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
+	bytes = max_t(size_t, max(max(timings.hfp, timings.hblk),
+		      max(timings.hsa, timings.hbp)), timings.vblk);
 	buffer = kmalloc(bytes, GFP_KERNEL);
 	if (WARN_ON(!buffer))
 		return;
@@ -590,33 +622,33 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/* sync */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HSA0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hsa));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hsa));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HSA1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hsa));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hsa));
 
 	/* backporch */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBP0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hbp));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hbp));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBP1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hbp));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hbp));
 
 	/* frontporch */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HFP0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hfp));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hfp));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HFP1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hfp));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hfp));
 
 	/* hblk */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBLK0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, hblk));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.hblk));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBLK1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, hblk));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.hblk));
 
 	/* vblk */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_VBLK0_REG,
-		     sun6i_dsi_build_blk0_pkt(device->channel, vblk));
+		     sun6i_dsi_build_blk0_pkt(device->channel, timings.vblk));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_VBLK1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, buffer, vblk));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, timings.vblk));
 
 	kfree(buffer);
 }
-- 
2.18.0.321.gffc6fa0e3

