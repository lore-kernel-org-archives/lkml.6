Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B154C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0FC20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2XLXpCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfAaT0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46447 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfAaT0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so3641586ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uBVnAYAnApmsJ7UXcEmwiSj6U9FGNO92PbYjzvVozv0=;
        b=m2XLXpCl5261vZX1a/g4uX1mV/xD6bcvMZmZA5BG9tcKoYuIJteJQImIFE1VkQ7Dwj
         Vc2wWfb0NMNXu33I2AL2x2sbC328If3mccd0h+8l1/wZ2pUY4HpysyghFO3qzpDFww5R
         qAbqbT1tH0TC16NVVDpQUhG8Mrqk3A/KEvxp4vvFVQBagM2O3fFxV9GHnTlvsox1WJqE
         QQDlNmb23Ua/oO3Lz5hMNDhqF3abXeV2SVHDvTYxRyKaDLEg4cofhigvg8IaypT+TVp5
         1w7ayWCiQuhx94Uagr0oj6l/XUcNUNkZUj/j7aKQq62+G6k5HfsUdB54MAnkLfw6X7wY
         i9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=uBVnAYAnApmsJ7UXcEmwiSj6U9FGNO92PbYjzvVozv0=;
        b=RlhNMap+v0sYRgGSZmOiWLbR8wl5q5psX0o2hxo/YcVtVqKEI5PUjRMjnxZb8Zj7G5
         BPbuKuUVJc1iaXMIj5MaRqHGznVvjCXLfDFxC1ThqXWZSu+kDFFFQAznW1wdVbUE47Ch
         eJxjywNouJVN7g6IL69C0urjf6S/WK8dE8BG3CeuWlduZBCcuxYqDlmWZlgDJR7pAE3L
         jzZic3XulhrrM8E9erU+jUg04VzKETDZwB6KMPZxwpbV46AA9gPbXy2SW0+wW8ZfwXcg
         TC3wFhCFoweCnG2XeADVbMXBs0Ozrd8c4FkjY+HqELfyZkREZZ4pimEDSJnByyX8GtiJ
         LBZg==
X-Gm-Message-State: AJcUukcvFeOqhAjRqfiBMhSyRw/klq+fAllFPFaQpwL5URJEfqSohon3
        wqvEOyrS9MGut+4VWFMlC/E=
X-Google-Smtp-Source: ALg8bN4wxj2xUZwxR/wxBuMbvDeJ73odwmwx8szr95nEls/z+fHEHHdzBctFpfnPencgKk46WaVp6g==
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr29100259ljp.12.1548962804335;
        Thu, 31 Jan 2019 11:26:44 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:43 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 10/19] drm/panel: lg: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:10 +0100
Message-Id: <20190131192619.9763-11-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce use of DRM_DEV* for logging.
This makes logging in the drm subsystem more consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-lg-lg4573.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-lg4573.c b/drivers/gpu/drm/panel/panel-lg-lg4573.c
index e63fba2761f4..9bbf6dde6b7d 100644
--- a/drivers/gpu/drm/panel/panel-lg-lg4573.c
+++ b/drivers/gpu/drm/panel/panel-lg-lg4573.c
@@ -18,6 +18,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -48,7 +49,7 @@ static int lg4573_spi_write_u16(struct lg4573 *ctx, u16 data)
 	u16 temp = cpu_to_be16(data);
 	struct spi_message msg;
 
-	dev_dbg(ctx->panel.dev, "writing data: %x\n", data);
+	DRM_DEV_DEBUG(ctx->panel.dev, "writing data: %x\n", data);
 	xfer.tx_buf = &temp;
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
@@ -115,7 +116,7 @@ static int lg4573_display_mode_settings(struct lg4573 *ctx)
 		0x7206, 0x720C, 0x7200, 0x7200,
 	};
 
-	dev_dbg(ctx->panel.dev, "transfer display mode settings\n");
+	DRM_DEV_DEBUG(ctx->panel.dev, "transfer display mode settings\n");
 	return lg4573_spi_write_u16_array(ctx, display_mode_settings,
 					  ARRAY_SIZE(display_mode_settings));
 }
@@ -131,7 +132,7 @@ static int lg4573_power_settings(struct lg4573 *ctx)
 		0x7263,
 	};
 
-	dev_dbg(ctx->panel.dev, "transfer power settings\n");
+	DRM_DEV_DEBUG(ctx->panel.dev, "transfer power settings\n");
 	return lg4573_spi_write_u16_array(ctx, power_settings,
 					  ARRAY_SIZE(power_settings));
 }
@@ -156,7 +157,7 @@ static int lg4573_gamma_settings(struct lg4573 *ctx)
 		0x7201, 0x7220, 0x7200, 0x7203,
 	};
 
-	dev_dbg(ctx->panel.dev, "transfer gamma settings\n");
+	DRM_DEV_DEBUG(ctx->panel.dev, "transfer gamma settings\n");
 	return lg4573_spi_write_u16_array(ctx, gamma_settings,
 					  ARRAY_SIZE(gamma_settings));
 }
@@ -165,7 +166,7 @@ static int lg4573_init(struct lg4573 *ctx)
 {
 	int ret;
 
-	dev_dbg(ctx->panel.dev, "initializing LCD\n");
+	DRM_DEV_DEBUG(ctx->panel.dev, "initializing LCD\n");
 
 	ret = lg4573_display_mode_settings(ctx);
 	if (ret)
@@ -219,9 +220,10 @@ static int lg4573_get_modes(struct drm_panel *panel)
 
 	mode = drm_mode_duplicate(panel->drm, &default_mode);
 	if (!mode) {
-		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			default_mode.vrefresh);
+		DRM_DEV_ERROR(panel->drm->dev,
+			      "failed to add mode %ux%ux@%u\n",
+			      default_mode.hdisplay, default_mode.vdisplay,
+			      default_mode.vrefresh);
 		return -ENOMEM;
 	}
 
@@ -258,7 +260,7 @@ static int lg4573_probe(struct spi_device *spi)
 
 	ret = spi_setup(spi);
 	if (ret < 0) {
-		dev_err(&spi->dev, "SPI setup failed: %d\n", ret);
+		DRM_DEV_ERROR(&spi->dev, "SPI setup failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.12.0

