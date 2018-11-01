Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B4C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5788B20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5788B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeKBFF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:05:57 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:45940 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbeKBFF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:05:57 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id DFAE7BFDEA;
        Thu,  1 Nov 2018 21:01:30 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 74361C106F; Thu,  1 Nov 2018 21:01:30 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 35D89C1057;
        Thu,  1 Nov 2018 21:00:34 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 2/7] drm/sun4i: tcon: Support an active-low DE signal with RGB interface
Date:   Thu,  1 Nov 2018 21:00:40 +0100
Message-Id: <20181101200045.6078-3-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some panels need an active-low data enable (DE) signal for the RGB
interface. This requires flipping a bit in the TCON0 polarity register
when setting up the mode for the RGB interface.

Match the associated bus flag and use it to set the polarity inversion
bit for the DE signal when required.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 7 ++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 262ffb6b0f82..0420f5c978b9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -543,6 +543,9 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	if (display_info.bus_flags & DRM_BUS_FLAG_DE_LOW)
+		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
+
 	/*
 	 * On A20 and similar SoCs, the only way to achieve Positive Edge
 	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
@@ -565,7 +568,9 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 		clk_set_phase(tcon->dclk, 0);
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
 			   val);
 
 	/* Map output pins to channel 0 */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 3d492c8be1fc..b5214d71610f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -116,6 +116,7 @@
 
 #define SUN4I_TCON0_IO_POL_REG			0x88
 #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
+#define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
 #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
 #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
 
-- 
2.19.1

