Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42963C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E935E27BFD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YaAc/OYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E935E27BFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936546AbeF2Sro (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:47:44 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46780 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753108AbeF2Srm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:47:42 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so4856522pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AcMqVjRKStjLXTAwpEo5puSp9OblLxkeTbGuKzoWNdc=;
        b=YaAc/OYqk13nvQMXc6BUFawai/gb7rVBRR/z5mUSxmDTwx0mgzz4Srpebf8FAo4euH
         YL8bZJ+0CWyIViKQ/uKeBM3Jnoyns9e/BGDwYFwLNLtOom20RC4DzaElTZYeKoqAj8UA
         FWRcSSYOHwm2S05ZiDdymKV71QVOpdFMP/YOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AcMqVjRKStjLXTAwpEo5puSp9OblLxkeTbGuKzoWNdc=;
        b=ehJJ3isUxVZS3r2oc/PvcqHxZWxcElGRZis/rlWSjrnrFkl0edb1qFYN2Jlauom5yv
         CjVuM3Uu4hOPTmWxWIQ42X5Rw67qn4q6KKUxzfhCpcoc8VH+DL909YqXG4/dQ6WWJHf1
         dZxWhxM45R0sSur+FcTElFeuklptsJeX9YvA/XzA+fTf5JkIJY5yHMQnPgJgZ1HkMSBQ
         WQvTgSUei97uNbmM4CfK+A4wfDiQqB+urAJOxq1WKbOmt6zchV+x4ahg7wEQyiktr/uO
         Xkb+/GD72U0Jab471ieqa/XHM/jTpWIn5Fw7fyleQ5m0liMfw7gbSz5YHXFlgW3746Df
         YDog==
X-Gm-Message-State: APt69E0SttxNxlV6ro8mjJoncb15Y2AvQwIcxzzvbexoaYnG4wM6aXCh
        Z3V1X+EtetDvskRvgeYog3Xynw==
X-Google-Smtp-Source: ADUXVKJiWapm6qdfvHRHoAPSI+yrL6QDQeNszGHEwNZLFQh2rfMJ9Fodv7rG1CIDrFFFKzwKYmaBLg==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr16286674pla.80.1530298061927;
        Fri, 29 Jun 2018 11:47:41 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t5-v6sm15418402pfh.32.2018.06.29.11.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:47:40 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:47:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: Remove VLA usage
Message-ID: <20180629184740.GA37415@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a kmalloc allocation and moves all the size calculations
to the start to do an allocation. If an upper bounds on the mode timing
calculations could be determined, a fixed stack size could be used instead.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 107 +++++++++++++++----------
 1 file changed, 64 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d4e7d16a2514..da9814f94d00 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/slab.h>
 
 #include <linux/phy/phy.h>
 
@@ -247,10 +248,8 @@ static u16 sun6i_dsi_crc_compute(u8 const *buffer, size_t len)
 	return crc_ccitt(0xffff, buffer, len);
 }
 
-static u16 sun6i_dsi_crc_repeat_compute(u8 pd, size_t len)
+static u16 sun6i_dsi_crc_repeat(u8 pd, u8 *buffer, size_t len)
 {
-	u8 buffer[len];
-
 	memset(buffer, pd, len);
 
 	return sun6i_dsi_crc_compute(buffer, len);
@@ -274,11 +273,11 @@ static u32 sun6i_dsi_build_blk0_pkt(u8 vc, u16 wc)
 					wc & 0xff, wc >> 8);
 }
 
-static u32 sun6i_dsi_build_blk1_pkt(u16 pd, size_t len)
+static u32 sun6i_dsi_build_blk1_pkt(u16 pd, u8 *buffer, size_t len)
 {
 	u32 val = SUN6I_DSI_BLK_PD(pd);
 
-	return val | SUN6I_DSI_BLK_PF(sun6i_dsi_crc_repeat_compute(pd, len));
+	return val | SUN6I_DSI_BLK_PF(sun6i_dsi_crc_repeat(pd, buffer, len));
 }
 
 static void sun6i_dsi_inst_abort(struct sun6i_dsi *dsi)
@@ -452,6 +451,54 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	struct mipi_dsi_device *device = dsi->device;
 	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
 	u16 hbp, hfp, hsa, hblk, vblk;
+	size_t bytes;
+	u8 *buffer;
+
+	/* Do all timing calculations up front to allocate buffer space */
+
+	/*
+	 * A sync period is composed of a blanking packet (4 bytes +
+	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
+	 * minimal size is therefore 10 bytes
+	 */
+#define HSA_PACKET_OVERHEAD	10
+	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
+		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
+
+	/*
+	 * The backporch is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define HBP_PACKET_OVERHEAD	6
+	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
+
+	/*
+	 * The frontporch is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define HFP_PACKET_OVERHEAD	6
+	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
+		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+
+	/*
+	 * hblk seems to be the line + porches length.
+	 */
+	hblk = mode->htotal * Bpp - hsa;
+
+	/*
+	 * And I'm not entirely sure what vblk is about. The driver in
+	 * Allwinner BSP is using a rather convoluted calculation
+	 * there only for 4 lanes. However, using 0 (the !4 lanes
+	 * case) even with a 4 lanes screen seems to work...
+	 */
+	vblk = 0;
+
+	/* How many bytes do we need to send all payloads? */
+	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
+	buffer = kmalloc(bytes, GFP_KERNEL);
+	if (WARN_ON(!buffer))
+		return;
 
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
 
@@ -485,63 +532,37 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_BASIC_SIZE1_VACT(mode->vdisplay) |
 		     SUN6I_DSI_BASIC_SIZE1_VT(mode->vtotal));
 
-	/*
-	 * A sync period is composed of a blanking packet (4 bytes +
-	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
-	 * minimal size is therefore 10 bytes
-	 */
-#define HSA_PACKET_OVERHEAD	10
-	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
-		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
+	/* sync */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HSA0_REG,
 		     sun6i_dsi_build_blk0_pkt(device->channel, hsa));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HSA1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, hsa));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, hsa));
 
-	/*
-	 * The backporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
-#define HBP_PACKET_OVERHEAD	6
-	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
+	/* backporch */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBP0_REG,
 		     sun6i_dsi_build_blk0_pkt(device->channel, hbp));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBP1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, hbp));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, hbp));
 
-	/*
-	 * The frontporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
-#define HFP_PACKET_OVERHEAD	6
-	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+	/* frontporch */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HFP0_REG,
 		     sun6i_dsi_build_blk0_pkt(device->channel, hfp));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HFP1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, hfp));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, hfp));
 
-	/*
-	 * hblk seems to be the line + porches length.
-	 */
-	hblk = mode->htotal * Bpp - hsa;
+	/* hblk */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBLK0_REG,
 		     sun6i_dsi_build_blk0_pkt(device->channel, hblk));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_HBLK1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, hblk));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, hblk));
 
-	/*
-	 * And I'm not entirely sure what vblk is about. The driver in
-	 * Allwinner BSP is using a rather convoluted calculation
-	 * there only for 4 lanes. However, using 0 (the !4 lanes
-	 * case) even with a 4 lanes screen seems to work...
-	 */
-	vblk = 0;
+	/* vblk */
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_VBLK0_REG,
 		     sun6i_dsi_build_blk0_pkt(device->channel, vblk));
 	regmap_write(dsi->regs, SUN6I_DSI_BLK_VBLK1_REG,
-		     sun6i_dsi_build_blk1_pkt(0, vblk));
+		     sun6i_dsi_build_blk1_pkt(0, buffer, vblk));
+
+	kfree(buffer);
 }
 
 static int sun6i_dsi_start(struct sun6i_dsi *dsi,
-- 
2.17.1


-- 
Kees Cook
Pixel Security
