Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F4EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0DD20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPs5JqwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeL3Rtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40356 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeL3RtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so17298155lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=rsqg6VO4Q8c9jUSGJHvew3cVal4OPEurWyEvoMbmpIE=;
        b=DPs5JqwXiC0elMWhgWYImhzBIXfnVPuByVl0yOc2UUOiaM5zh/jrsYxBbdBehlU/Vf
         OwUoa/wbOT3JuWQpYonDG0ifgqQW6GqtxvZL47hFEpbIn69j3xW7TO01kJA8Jz6BALP+
         pWMhm/BU2bpqLwm1T2whAbsyYszfTggxoT7CH5rltWarWWtWhkriNIP/zB5siQLpNBk1
         8YHqHQtn+NpUvDbLTqF7F3NEi1NrfDjLABWpQaxCim78i857xrhdUZLYqQQTUXWdA69j
         xHmyTVNgf8T3Di3zGyTz9hXNdOZLwLCe30pthClGxRPiQosPm1OK0zQAcmOo2fGh5Sbx
         GgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=rsqg6VO4Q8c9jUSGJHvew3cVal4OPEurWyEvoMbmpIE=;
        b=Er2VsNOMbpsImQNRC+JIoEisxHQ5FV1Cqzbd2DQtLA8tAUb4zxKTuHaTHWTrrYe+ci
         kfj7InDaV6qlJmVlbcoF5njFLamKpXacxKddCej2fzZfwt56j1T2EZkdyeziULOp2FoU
         bdFZFbFELBG01R8d7AGjPCgqvdAMtOyZP6Oe2uk+EBJeolMlAWCkUXgvpCFQNu8FLN3g
         vWbQm1GkHAuVSrnJHaeBzklUds1PM+GV1W4Z0Q9orkYWX5WUB9/flUesnnbQ6DlXKw9g
         NfFc6YbJCPqMEPen6DV7DgbJ6zodJod/G5fPdz8qL2wc26GlWr1BRwugPzHzMNQBsTBN
         3S+Q==
X-Gm-Message-State: AA+aEWZcaG/0xzTFwqcHVtdd5w80w/ZQecQX75owZJhRtoVy1IiC07Rq
        fymG801q6GBlgfdTIh/pdGE=
X-Google-Smtp-Source: AFSGD/V4vhTh5pA3YoRTHfWTPP5JibkHLRgDHqxytDGaXX7AX6jdxwwgoJ9VsbdyIlDpjXWfVKIcQw==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr17007960lfm.81.1546192145307;
        Sun, 30 Dec 2018 09:49:05 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:04 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 08/14] drm: remove include of drmP.h from bridge/dw_hdmi.h
Date:   Sun, 30 Dec 2018 18:48:32 +0100
Message-Id: <20181230174838.32330-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
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

