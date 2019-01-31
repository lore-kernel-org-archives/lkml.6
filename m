Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875C0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaN4JYnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfAaT0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34227 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfAaT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so3252525lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oj6oOgCKzJ2N+qTpx3fibHKC8CyReqx+5nadi7iOj1E=;
        b=IaN4JYnVaz5C2nfd6SudPZ0exOlyNSIEt+SdKhzbom8HaC3Q2ooGI5RgdOyhLH1qc/
         nerg0YRjx5GkdCKlTctqyRXz4tOlEkvkjZFf7K6c1N75++m0XujSXP+xh1JyUXi3m++W
         YF+k862BPd7DzJrfENun5NKiUvbMbpxzJlwM1JiJ9TxD94y95VNiyREFzrAUPz1iD7y+
         z9e1p6umL951L0Aa6eB8Dj8CxG26ovVL/nC7aSyl6lvmmuo1xRk/RjR030Z0CItURowT
         +NHKKAWGwbyWNJtzGNeG+WGpJ9DTSzSXnj+Pz1ukYdb52iSNEvgcofhPGcx8MYRV1jS/
         lN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=oj6oOgCKzJ2N+qTpx3fibHKC8CyReqx+5nadi7iOj1E=;
        b=eot8kNZObVbEAkdrrYILLdYubdXLXv62yKLosPgi43HvEmDCr+ih/21Lr94YCMzOhv
         VpanPwAoa5SqXz92vAM4JU9YP/Z54jlPPjhGpW3tmTP1ltU0BaKmwrCSanwRLCmzEnMJ
         7R/qjL7eywwYIrbYG3gpw17abaHNZqIHcHsRWJJJP8MES1FwJmKy+H88rwrPYB8hTXtW
         nAr+R4uOrCLsZ24uLY9DldhfA+wbQBGUBd/nv81Xv4aBc+/p8ngN1gQPfxD3pmlYX39H
         c6rkxMTWdA2HHQfIJeedK6Ts+yc3JolkJHHK4+K2xrZ1LfveIPh/1M6OFrV+Qv5Ji5vk
         ITfw==
X-Gm-Message-State: AJcUukfAcIi3yNlDh0l50bcrlBhcKj7akEfg3XsUFpZOyrp+NmrDuHVC
        tSogGZQuMC+i5CjD/MU9MeE=
X-Google-Smtp-Source: ALg8bN5AQ4Iz1Ugvb9zO3SeiSPDc5MNhTpLYAs1babjlPLfUIvtuSXJfs82peRe2gzaBR1Jucv0BVA==
X-Received: by 2002:a19:7018:: with SMTP id h24mr27916364lfc.162.1548962797521;
        Thu, 31 Jan 2019 11:26:37 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:37 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 03/19] drm/panel: samsung: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:03 +0100
Message-Id: <20190131192619.9763-4-sam@ravnborg.org>
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
 drivers/gpu/drm/panel/panel-samsung-ld9040.c     | 12 +++++------
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c    | 15 +++++++-------
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c |  8 ++++----
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c    | 26 +++++++++++++-----------
 4 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index 7d27b79d0b2a..fec639c19d74 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -149,7 +149,7 @@ static void ld9040_dcs_write(struct ld9040 *ctx, const u8 *data, size_t len)
 	if (ctx->error < 0 || len == 0)
 		return;
 
-	dev_dbg(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
+	DRM_DEV_DEBUG(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
 	ret = ld9040_spi_write_word(ctx, *data);
 
 	while (!ret && --len) {
@@ -158,8 +158,8 @@ static void ld9040_dcs_write(struct ld9040 *ctx, const u8 *data, size_t len)
 	}
 
 	if (ret) {
-		dev_err(ctx->dev, "error %d writing dcs seq: %*ph\n", ret,
-			(int)len, data);
+		DRM_DEV_ERROR(ctx->dev, "error %d writing dcs seq: %*ph\n",
+			      ret, (int)len, data);
 		ctx->error = ret;
 	}
 
@@ -342,15 +342,15 @@ static int ld9040_probe(struct spi_device *spi)
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset-gpios %ld\n",
-			PTR_ERR(ctx->reset_gpio));
+		DRM_DEV_ERROR(dev, "cannot get reset-gpios %ld\n",
+			      PTR_ERR(ctx->reset_gpio));
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
 	spi->bits_per_word = 9;
 	ret = spi_setup(spi);
 	if (ret < 0) {
-		dev_err(dev, "spi setup failed.\n");
+		DRM_DEV_ERROR(dev, "spi setup failed.\n");
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
index 813afee82ec9..e2f2ee252409 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
@@ -458,7 +458,8 @@ static int s6e3ha2_set_brightness(struct backlight_device *bl_dev)
 
 	if (brightness < S6E3HA2_MIN_BRIGHTNESS ||
 		brightness > bl_dev->props.max_brightness) {
-		dev_err(ctx->dev, "Invalid brightness: %u\n", brightness);
+		DRM_DEV_ERROR(ctx->dev, "Invalid brightness: %u\n",
+			      brightness);
 		return -EINVAL;
 	}
 
@@ -706,28 +707,28 @@ static int s6e3ha2_probe(struct mipi_dsi_device *dsi)
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
 				      ctx->supplies);
 	if (ret < 0) {
-		dev_err(dev, "failed to get regulators: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to get regulators: %d\n", ret);
 		return ret;
 	}
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset-gpios %ld\n",
-			PTR_ERR(ctx->reset_gpio));
+		DRM_DEV_ERROR(dev, "cannot get reset-gpios %ld\n",
+			      PTR_ERR(ctx->reset_gpio));
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
 	ctx->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->enable_gpio)) {
-		dev_err(dev, "cannot get enable-gpios %ld\n",
-			PTR_ERR(ctx->enable_gpio));
+		DRM_DEV_ERROR(dev, "cannot get enable-gpios %ld\n",
+			      PTR_ERR(ctx->enable_gpio));
 		return PTR_ERR(ctx->enable_gpio);
 	}
 
 	ctx->bl_dev = backlight_device_register("s6e3ha2", dev, ctx,
 						&s6e3ha2_bl_ops, NULL);
 	if (IS_ERR(ctx->bl_dev)) {
-		dev_err(dev, "failed to register backlight device\n");
+		DRM_DEV_ERROR(dev, "failed to register backlight device\n");
 		return PTR_ERR(ctx->bl_dev);
 	}
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
index f1c8000e0386..dd50f4089923 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
@@ -458,14 +458,14 @@ static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
 				      ctx->supplies);
 	if (ret < 0) {
-		dev_err(dev, "failed to get regulators: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to get regulators: %d\n", ret);
 		return ret;
 	}
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset-gpio: %ld\n",
-				PTR_ERR(ctx->reset_gpio));
+		DRM_DEV_ERROR(dev, "cannot get reset-gpio: %ld\n",
+			      PTR_ERR(ctx->reset_gpio));
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
@@ -476,7 +476,7 @@ static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
 	ctx->bl_dev = backlight_device_register("s6e63j0x03", dev, ctx,
 						&s6e63j0x03_bl_ops, NULL);
 	if (IS_ERR(ctx->bl_dev)) {
-		dev_err(dev, "failed to register backlight device\n");
+		DRM_DEV_ERROR(dev, "failed to register backlight device\n");
 		return PTR_ERR(ctx->bl_dev);
 	}
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index b252d23f386f..e3e0766c3a17 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -147,8 +147,8 @@ static void s6e8aa0_dcs_write(struct s6e8aa0 *ctx, const void *data, size_t len)
 
 	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
 	if (ret < 0) {
-		dev_err(ctx->dev, "error %zd writing dcs seq: %*ph\n", ret,
-			(int)len, data);
+		DRM_DEV_ERROR(ctx->dev, "error %zd writing dcs seq: %*ph\n",
+			      ret, (int)len, data);
 		ctx->error = ret;
 	}
 }
@@ -163,7 +163,8 @@ static int s6e8aa0_dcs_read(struct s6e8aa0 *ctx, u8 cmd, void *data, size_t len)
 
 	ret = mipi_dsi_dcs_read(dsi, cmd, data, len);
 	if (ret < 0) {
-		dev_err(ctx->dev, "error %d reading dcs seq(%#x)\n", ret, cmd);
+		DRM_DEV_ERROR(ctx->dev, "error %d reading dcs seq(%#x)\n",
+			      ret, cmd);
 		ctx->error = ret;
 	}
 
@@ -814,9 +815,9 @@ static void s6e8aa0_set_maximum_return_packet_size(struct s6e8aa0 *ctx,
 
 	ret = mipi_dsi_set_maximum_return_packet_size(dsi, size);
 	if (ret < 0) {
-		dev_err(ctx->dev,
-			"error %d setting maximum return packet size to %d\n",
-			ret, size);
+		DRM_DEV_ERROR(ctx->dev,
+			      "error %d setting maximum return packet size to %d\n",
+			      ret, size);
 		ctx->error = ret;
 	}
 }
@@ -825,22 +826,23 @@ static void s6e8aa0_read_mtp_id(struct s6e8aa0 *ctx)
 {
 	u8 id[3];
 	int ret, i;
+	struct device *dev = ctx->dev;
 
 	ret = s6e8aa0_dcs_read(ctx, 0xd1, id, ARRAY_SIZE(id));
 	if (ret < 0 || ret < ARRAY_SIZE(id) || id[0] == 0x00) {
-		dev_err(ctx->dev, "read id failed\n");
+		DRM_DEV_ERROR(dev, "read id failed\n");
 		ctx->error = -EIO;
 		return;
 	}
 
-	dev_info(ctx->dev, "ID: 0x%2x, 0x%2x, 0x%2x\n", id[0], id[1], id[2]);
+	DRM_DEV_INFO(dev, "ID: 0x%2x, 0x%2x, 0x%2x\n", id[0], id[1], id[2]);
 
 	for (i = 0; i < ARRAY_SIZE(s6e8aa0_variants); ++i) {
 		if (id[1] == s6e8aa0_variants[i].version)
 			break;
 	}
 	if (i >= ARRAY_SIZE(s6e8aa0_variants)) {
-		dev_err(ctx->dev, "unsupported display version %d\n", id[1]);
+		DRM_DEV_ERROR(dev, "unsupported display version %d\n", id[1]);
 		ctx->error = -EINVAL;
 		return;
 	}
@@ -1007,14 +1009,14 @@ static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
 				      ctx->supplies);
 	if (ret < 0) {
-		dev_err(dev, "failed to get regulators: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to get regulators: %d\n", ret);
 		return ret;
 	}
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset-gpios %ld\n",
-			PTR_ERR(ctx->reset_gpio));
+		DRM_DEV_ERROR(dev, "cannot get reset-gpios %ld\n",
+			      PTR_ERR(ctx->reset_gpio));
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
-- 
2.12.0

