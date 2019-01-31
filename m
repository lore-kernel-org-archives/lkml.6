Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396DAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D463218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRN5exDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfAaT04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40699 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbfAaT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so3220999lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mreaSKGxaP0QZfc6P9JdABAXI216xRGYqk5pooAHFGM=;
        b=bRN5exDaUvjkAKimi+lJqftW+Wh436GUzUoZIB+Sqy1atEJtqUN+PJx2sD0r7ELYzW
         7fS/86ci2hpz9rDaBriTFioSu1l8AfWsiZ27/DoUROssR0hXBM1UdeyK7fOHNokYgYsE
         80Uq/qZVqBjrZXQ0BiH/yKL5sf9CtSvaG0WhWqZ9ckP4Q+LicY4IwvyRG1qoqkcVWiUQ
         HFVpG7lK/jo8D0wbEZD3zp2j/pBwi8mH9SN65nofig60oYnSSCgvQM34Q4H7etJ7ycHK
         h9A8xUS5MFfR7jTp7YC3T94XWxIPq75BIFl7BnoEdtYzhrYOMWfDfV5mBDMkMPkv0f60
         /r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mreaSKGxaP0QZfc6P9JdABAXI216xRGYqk5pooAHFGM=;
        b=Z6GjrzgrwdabFWLoEknPVOrjNfLUqDNdz6LBkGsIUTy2CJ9GRutIU9uCoyOMP4FnbJ
         huxMDEV9TgLT4pq/hieJm5DUO5j87oYoie2kzCcxCUWXa3iwmBwWmbEVGdvaLVuvQFGa
         vHP0gccc7M58mKiomNk2lsW/TFFLqpHIMpnMqFzOIR853FqvOM6RNiy6NIO4bNgcY7Vx
         ceeZMaCkDJZbASJlm3EzukqizKP60b9wjb0SessLa7xJpXrCMBbYmcq9xLZS0kiGaX0e
         LAkXYePpyvQ5v57LcIkQ5jnkJyV2+2hQtoM5obqHSat4e8FtGlolHWzcKKAayRXd/Ckq
         bV7Q==
X-Gm-Message-State: AJcUukewEbfCxrw37FpXt9BlUQ8p/BT35Q5+A8d9HiUlU+71+AyplbG9
        Q+scmAidR8l1DiXFNyEgAFo=
X-Google-Smtp-Source: ALg8bN4AnlgQMCB1hL7KGMdFaPDNXx6Kv4zALohVBJsf9K+6SC+hlp9oONgstt00DGUdaXfFV5+odg==
X-Received: by 2002:a19:5349:: with SMTP id h70mr27664455lfb.50.1548962810241;
        Thu, 31 Jan 2019 11:26:50 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:49 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 16/19] drm/panel: raydium: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:16 +0100
Message-Id: <20190131192619.9763-17-sam@ravnborg.org>
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
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index e05e3f950855..bbf3f51c8a3a 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -379,14 +379,14 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
 		ret = PTR_ERR(ctx->reset_gpio);
-		dev_err(dev, "cannot get reset GPIO: %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot get reset GPIO: %d\n", ret);
 		return ret;
 	}
 
 	ctx->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(ctx->supply)) {
 		ret = PTR_ERR(ctx->supply);
-		dev_err(dev, "cannot get regulator: %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot get regulator: %d\n", ret);
 		return ret;
 	}
 
@@ -411,7 +411,7 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		dev_err(dev, "mipi_dsi_attach() failed: %d\n", ret);
+		DRM_DEV_ERROR(dev, "mipi_dsi_attach() failed: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
-- 
2.12.0

