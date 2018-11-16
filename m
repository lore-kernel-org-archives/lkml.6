Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7DEC04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7634F20684
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JqGzCIoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7634F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbeKQCxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:53:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45233 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbeKQCxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:53:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so6809817plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQWYOyjdRmGs9UhZs6bBgbQ0IL6akLwNeZEkqRrFzQQ=;
        b=JqGzCIoFyPGvPhj/7yVhIdSIJM9/6pIgB2WfsDcwm0YEUsFfpQ2o0uL5x1pLewAvoD
         AQry88+ddoeIdHts+ZsCdpOR7T1ax6UfJS9bZau8xCb6D/Ho1KlxmaAkWnKPj1X+sY6/
         WPHgI8U4FwSjx5KUDn2pvhExjgQ+XRwT3fKKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQWYOyjdRmGs9UhZs6bBgbQ0IL6akLwNeZEkqRrFzQQ=;
        b=fxEexa/u/9BbiggCJ/xAds8srRtQNVA2tbT9g4ReB3G3GrbbUX8Lptc+VI8ATInmat
         bWn1jhXjgxso11MtfN1QO2ioaY/vcA5u7/g//XajKKoo4dUbKTVAgEhryyWnnZB2HwWe
         sYnTR3e4qMD07E+0ySEdaNUl5acr8K3kcyDKgI9oG6c9ce2PyF123VZNk1EwVnJ9r1Cs
         6Nu4c8OzTgi2ZZH+L7iLWp43+spQ+Zuyw4a6LQqYXvnrv2zINMoxR5CGEdZCHX+suRyE
         OKytnE2uTg7SHJ8RgSEAPwN9/ggOlFZYv5O40oRcbcQfQxhtfgeQTjeq8qUPyvzAWnzN
         1Kgg==
X-Gm-Message-State: AGRZ1gKCYdOKgLmOba6XKD1q717ApOnGt13SxBV7yh06X3n45u6/LJsy
        23S2WPQzRRCTnoPSu9lR7XKOYw==
X-Google-Smtp-Source: AJdET5cJl6/+xSmjk5mp7v3sI+9nYFc1w0XeY5fZhf9YNXpRVnC38Q2TJoyWRsAPtM3SsC+RGhl3Cg==
X-Received: by 2002:a17:902:4025:: with SMTP id b34-v6mr11739165pld.318.1542386437932;
        Fri, 16 Nov 2018 08:40:37 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:40:37 -0800 (PST)
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
Subject: [PATCH v2 08/12] drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
Date:   Fri, 16 Nov 2018 22:09:12 +0530
Message-Id: <20181116163916.29621-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 4-lane, burst mode panels would need to enable 2byte trail_fill
along with filling trail_env in dsi base control register.

Similar reference code avialable in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 0182408f8932..22d2987c3298 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -34,6 +34,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -559,6 +561,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	/* enable burst mode */
 	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
 	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	if (device->lanes == 4) {
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL;
+	}
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
-- 
2.18.0.321.gffc6fa0e3

