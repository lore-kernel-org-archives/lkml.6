Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8A92083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEXoCUZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfBUSS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:18:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35884 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUSS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:18:27 -0500
Received: by mail-io1-f68.google.com with SMTP id r136so2833535iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l4JzspAMbHcJHsJJu0IBWT2hWCxWq0IAOWVVhMcjpYg=;
        b=IEXoCUZHO6g7weGrhLaXzXe/0VB1EnaM9AJ/bXaQH8ZVmADP6HM9/LQaQ29I545hWz
         NQBWABSPInNPxo0Dl+Lo4GJWY/6XMFlOMElQkHrMDaLjaLwcRc6s0/3uVUl7VEXgg/ue
         oxbbM3yTK2bZmNDvb6Teisr4/UuQooFq+ugzzzvUYZgyqPEhv6Al40S1JuzdcegTJqrk
         uwPKmTV2jdyOENlS8XFLSEFZOwCjuWBBfxNbGYwQnlPvVgHVo57PpVLscJZRWDM5WvK6
         HpyVmCjYjVlWKqyopjDANByXgcj2oXxuIDrD28Rvu57DY6ix83bP4ayFEok3iP1Rt9m4
         pTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l4JzspAMbHcJHsJJu0IBWT2hWCxWq0IAOWVVhMcjpYg=;
        b=nR+XpgDS2g4cbwBP1ERPHewKqNUKxe1xwSCrXBGMqa1kaO5CmTc7i/lKAPsCyDUzar
         9KkOIQDx+npcLzJj6PiEl7FDYfuJO5EdYOpGL0q+nJadKGoazVJZBb2WdluYTF+RFOj9
         38ltuW1RfalJnY8FKNW/qgDqMLoLQ2+rvwKEocwaQ2g0DkpVeXPLMhwPYwwmU70dcXIR
         56ZwVvXa2dH8dKB9dVk3C8/gdPqecFMvhHVsYmWfybWrtAFqf/GojbO/SDLM4iXmwlfE
         cp1lPdIB0v67e87QyGkzt3lsHfWUz0XrOKcCpiD8z96LLGXBi0+chmWkwGRO44KxE23E
         baTQ==
X-Gm-Message-State: AHQUAuabEZ3huX1MrsKPJiiZIJufQcWnwDysl+ZV2G31rsPUkf+GLSVN
        i5kab7W6Kia5/8+6geNcbis=
X-Google-Smtp-Source: AHgI3IbFGG72QMoSp/PtKt4YcWP5OH8bs/A2zu1DzniZrq0h5/kQIbK9N98agpwb2OSDuBwIRAF7Dw==
X-Received: by 2002:a02:3b6f:: with SMTP id i47mr10972762jaf.39.1550773106932;
        Thu, 21 Feb 2019 10:18:26 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id s26sm3006284iol.41.2019.02.21.10.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 10:18:26 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider calculation
Date:   Thu, 21 Feb 2019 13:18:13 -0500
Message-Id: <20190221181814.24829-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My cpu dai driving the tda998x in master mode outputs
SNDRV_PCM_FORMAT_S24_LE, i2s left justified, two channels:

	[SNDRV_PCM_FORMAT_S24_LE] = {
		.width = 24, .phys = 32, .le = 1, .signd = 1,
		.silence = {},
	},

This format has a sample width of 24 bits, but a physical
size of 32 bits per channel. The redundant bits are padded
with zeros. This gives a total frame width of 64 bits.
According to the tda19988 datasheet, this format is supported:

"Audio samples with a precision better than 24-bit are
truncated to 24-bit. [...] If the input clock has a
frequency of 64fs and is left justified or Philips,
the audio word is truncated to 24-bit format and other
bits padded with zeros."
(tda19988 product datasheet Rev. 3 - 21 July 2011)

However, supplying this format to the chip results in distorted
audio. I noticed that the audio problem disappears when the
CTS_N pre-divider is calculated from the physical width, _not_
the sample width.

This patch adjusts the CTS_N calculation so that the audio
distortion goes away.

Caveats:
- I am only capable of generating audio with a frame width of
  64fs. So I cannot test if 32fs or 48fs audio formats still
  work. Such as S16_LE or S20_LE.
- I have no access to a datasheet which accurately describes
  the CTS_N register. So I cannot check if my assumption is
  correct.

Tested with an imx6 ssi.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 ++--
 include/drm/i2c/tda998x.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index a7c39f39793f..ba9f55176e1b 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -893,7 +893,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP_I2S;
 		clksel_fs = AIP_CLKSEL_FS_ACLK;
-		switch (params->sample_width) {
+		switch (params->physical_width) {
 		case 16:
 			cts_n = CTS_N_M(3) | CTS_N_K(1);
 			break;
@@ -982,7 +982,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 	int i, ret;
 	struct tda998x_audio_params audio = {
-		.sample_width = params->sample_width,
+		.physical_width = params->physical_width,
 		.sample_rate = params->sample_rate,
 		.cea = params->cea,
 	};
diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
index 3cb25ccbe5e6..7e9fddcc4ddd 100644
--- a/include/drm/i2c/tda998x.h
+++ b/include/drm/i2c/tda998x.h
@@ -14,7 +14,7 @@ enum {
 struct tda998x_audio_params {
 	u8 config;
 	u8 format;
-	unsigned sample_width;
+	unsigned int physical_width;
 	unsigned sample_rate;
 	struct hdmi_audio_infoframe cea;
 	u8 status[5];
-- 
2.17.1

