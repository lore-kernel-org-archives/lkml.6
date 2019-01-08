Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD4D2064C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxO2935n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfAHT5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:57:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39235 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbfAHT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so3828958lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsqg6VO4Q8c9jUSGJHvew3cVal4OPEurWyEvoMbmpIE=;
        b=BxO2935nF4gOEyMi6UdMdzAWMvg0uWNTZKsiWnbl3Z0gbOjFt2OQ3juFlToef1TjnL
         fpsm6VbkuvqQ/ZQC6bNeU616TeoqoUoR/QO8PjZ3xGjlwKoa3Z3N8MDH3IKacfzCcqNY
         wsZEtE2QKcJUXP8fZkvpJi/PnPaEn5w55z5WUxa8dut1Hg7LrJd13ESFgLDp3mj4HRC7
         XGjiWvYSqloP7YBjB7HNU8FY1U/WkQfYqTbhIuFFI8IFa9kuw8l8ilEJAeCf9hJM7jIl
         jMtdIsIV9VAaF2acF/6/gLmcbAQuqBYfbpDILmZd70r96GHhQuoD463YMF1RO5Wi1tn0
         tNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=rsqg6VO4Q8c9jUSGJHvew3cVal4OPEurWyEvoMbmpIE=;
        b=rDH/NDnVcqdLQ/6+uBnMmEwT4vxIMuB91tkFyouiqZXgHR5HTK6Ft4IjVzEb0PHzwv
         LMg/exFzJeK6n/bl0fuoNc9PAkcec3gFHN9D8GWtt9oNTW/73CFkdITCyf9106eGSnc7
         s/QaMTtxJCjFARE4iYPJLPIQXt8ME/i0subyDIQtk7x+iO3u23P9sTVqhm7mRU6GT9WF
         NIRGVvnCE0MLBCEaCjhWurnRzmFLATIn5q+vipQDX4RmDM+gle2NusOex/LQANpZo7qD
         jWFCM4fZCZXqqVALH1dHJ1C2K+tIkhGA5PzmQ1KH/kl58xxgvjmauRrI2fZHe87QpX+Q
         Q7yw==
X-Gm-Message-State: AJcUukdg8OvxSLUTwIGjK7EB5kpTAR4tqObo8GoZQ/3HBqetJsWF0rRy
        W21TlJ2h2KpG+LfihLXQd7w=
X-Google-Smtp-Source: ALg8bN50hmVl6uda0cbNwKUDtuBqSvzOmrlkAWuZUaxw09BicImmgTcEaOliMwqzlKPyW7Ch16VCNA==
X-Received: by 2002:a19:660a:: with SMTP id a10mr1917175lfc.146.1546975797149;
        Tue, 08 Jan 2019 11:29:57 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:56 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 06/12] drm: remove include of drmP.h from bridge/dw_hdmi.h
Date:   Tue,  8 Jan 2019 20:29:33 +0100
Message-Id: <20190108192939.15255-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drmP.h is an relic from the days when there was a single header file.
To enable the removal of drmP.h from all users drop include
of drmP.h from bridge/dw_hdmi.h.

A few files relied on the file included in drmP.h - add explicit
include statements or forward declarations to these files.
Build tested with arm and x86.

v2:
- prefer forward declarations when possible (Laurent Pinchart)
- sort include files (Laurent Pinchart)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 4 ++++
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c              | 1 +
 include/drm/bridge/dw_hdmi.h                        | 6 ++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 2228689d9a5e..5cbb71a866d5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -5,6 +5,10 @@
  * Copyright (c) 2017 Renesas Solutions Corp.
  * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+
 #include <drm/bridge/dw_hdmi.h>
 
 #include <sound/hdmi-codec.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
index 75490a3e0a2a..790d499daa10 100644
--- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
@@ -7,6 +7,7 @@
  * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 9c56412bb2cf..9f93895dde88 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -10,9 +10,11 @@
 #ifndef __DW_HDMI__
 #define __DW_HDMI__
 
-#include <drm/drmP.h>
-
+struct drm_connector;
+struct drm_display_mode;
+struct drm_encoder;
 struct dw_hdmi;
+struct platform_device;
 
 /**
  * DOC: Supported input formats and encodings
-- 
2.12.0

