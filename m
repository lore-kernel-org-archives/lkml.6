Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AD6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB7A20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8rUGnym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfAaT10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46449 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbfAaT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so3641715ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMX9PItUPMiQMxjRMyjWjmGwMlCh2Fm0sCIzyKUAS4U=;
        b=X8rUGnymKqKmgKxfEoEt/PajSFAea8zBcQUh2t1Zm7WGSTGL2FNy3y8iERgD7oxhNe
         EIysk0+x72Ibp7p1/ZF7rOMbmCw+1r7lBD5jFfdYoOqVQTLxGpZsXsbJ/Bat4evfuBki
         BUwVWj2PqiYjlfgS5K4IzYrOjgVoxDk9On08f6Nx2ky5UkUBgUSANsMDT+lh75TzWBXU
         qtrUcTaU1utvCIMveS5ozhmKP4nvtuWFqWjxoFj8+UPSjBk5LRbqPxXMEDUp3X8+S4AG
         iBg5XSJm4/77u1UkbeW22pIbLBHH3+j7TVUKeHmrE1tGyukHct0+AY1aD5ALs1N8m/Xa
         PYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kMX9PItUPMiQMxjRMyjWjmGwMlCh2Fm0sCIzyKUAS4U=;
        b=efqbxLgZW92rgCYJTjm/sT21vM5kUMwKFgGluuWZDGZHz/UNa0SaKPOE5RlD/69GUc
         Q7cHWsGpOb7eDmyTBi0poMooLXEdHP/d8+JTZs0Xb4KanHx9Is2W79UobUpZ4DlYA0WU
         QTAl3AGtf6Wf71SjPjP0lMsP3icm3obhZn53QXqNfrFwj7NOKproyx5GDySBaWiWpepW
         fzcj+AmibrOa6RG1DJ0ZPU/aReftNgS1OhPXaerLFmp8u5Ow7y49Hhx3PntZkzxppIFy
         1gSXZXoDBv3nTatDR3iBu963bETd9c00alpn4SNcaBB2QJpsq8ZllY+9lLHldFHibFPc
         jjiA==
X-Gm-Message-State: AJcUukcj3iH3nJy2TqWan9HvcKkZtivKlMofUaOL9km5Gc5CYpHtpSHl
        XLFx3/2BCac1ZB2pgqI6JC0=
X-Google-Smtp-Source: ALg8bN6c+Y7wW4TSpHn36kae9r4f7NmHSm9JSf8D1HNHqy1pO8aBjxot+1ecHYeee+GIbhOad4mCIg==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr27767798lji.167.1548962807398;
        Thu, 31 Jan 2019 11:26:47 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:46 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 13/19] drm/panel: orisetech: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:13 +0100
Message-Id: <20190131192619.9763-14-sam@ravnborg.org>
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
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 5bacf3f2da05..e7920ae018bd 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -431,14 +431,14 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 
 	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
-		dev_err(dev, "cannot get reset-gpio\n");
+		DRM_DEV_ERROR(dev, "cannot get reset-gpio\n");
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
 	ctx->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(ctx->supply)) {
 		ret = PTR_ERR(ctx->supply);
-		dev_err(dev, "failed to request regulator: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to request regulator: %d\n", ret);
 		return ret;
 	}
 
@@ -461,7 +461,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 						     NULL);
 	if (IS_ERR(ctx->bl_dev)) {
 		ret = PTR_ERR(ctx->bl_dev);
-		dev_err(dev, "failed to register backlight: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to register backlight: %d\n", ret);
 		return ret;
 	}
 
@@ -474,7 +474,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		dev_err(dev, "mipi_dsi_attach failed. Is host ready?\n");
+		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?\n");
 		drm_panel_remove(&ctx->panel);
 		backlight_device_unregister(ctx->bl_dev);
 		return ret;
-- 
2.12.0

