Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A7CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4BA21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4BA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeJRPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:34:33 -0400
Received: from hermes.aosc.io ([199.195.250.187]:49652 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbeJRPec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:34:32 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 260B215D3E0;
        Thu, 18 Oct 2018 07:34:47 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to dot clock frequency check
Date:   Thu, 18 Oct 2018 15:33:27 +0800
Message-Id: <20181018073327.64942-10-icenowy@aosc.io>
In-Reply-To: <20181018073327.64942-1-icenowy@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The panels shipped with Allwinner devices are very "generic", i.e.
they do not have model numbers or reliable sources of information
for the timings (that we know of) other than the fex files shipped
on them. The dot clock frequency provided in the fex files have all
been rounded to the nearest MHz, as that is the unit used in them.

We were using the simple panel "urt,umsh-8596md-t" as a substitute
for the A13 Q8 tablets in the absence of a specific model for what
may be many different but otherwise timing compatible panels. This
was usable without any visual artifacts or side effects, until the
dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
rgb: Validate the clock rate").

The reason this check fails is because the dotclock frequency for
this model is 33.26 MHz, which is not achievable with our dot clock
hardware, and the rate returned by clk_round_rate deviates slightly,
causing the driver to reject the display mode.

The LCD panels have some tolerance on the dot clock frequency, even
if it's not specified in their datasheets.

This patch adds a 5% tolerence to the dot clock check.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index bf068da6b12e..23bdc449eacc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -92,13 +92,14 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 
 	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
 
+	/* Check against a 5% tolerance for the dot clock */
 	tcon->dclk_min_div = 6;
 	tcon->dclk_max_div = 127;
 	rounded_rate = clk_round_rate(tcon->dclk, rate);
-	if (rounded_rate < rate)
+	if (rounded_rate < rate * 19 / 20 )
 		return MODE_CLOCK_LOW;
 
-	if (rounded_rate > rate)
+	if (rounded_rate > rate * 21 / 20)
 		return MODE_CLOCK_HIGH;
 
 	DRM_DEBUG_DRIVER("Clock rate OK\n");
-- 
2.18.1

