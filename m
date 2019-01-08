Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5204E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXUGhLiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfAHT4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:56:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45586 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfAHTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so4381381ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4E+CRC/Vb1YBvB774DuOXRpJUYqdKQe5t91V4N0keqM=;
        b=LXUGhLiHF6yjUr2Kc8tqqWgG1Wt3uoNJwZV3j6HgRJ+hlsZOOpUR18EnAdLJeNVOZ2
         vWMMs0LOvRkSLsCzcW1tvI6bARVyaFlB3abUNjaZeW/OcTe1MVUZY++fqSqAtvWHXPkA
         M+b6SPVjA+y9Ae1k0c8Qez80vbLjE/KaQ1AVlwKxEocBdwg+aoW+4y/uZwuPrcjYC2vu
         ZuyRfizqrCsg8TBtr1yGuNKFk63brAnLc+TrdxnMEOJ6VDJRtIkygM5eXmXpGEe8JCh0
         lCJHG4BCNfTJVpabNf2xH9iorZDtagBV5UeIn4SQJLw00ri9788Jg79or6aUWvV1WMhH
         GCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4E+CRC/Vb1YBvB774DuOXRpJUYqdKQe5t91V4N0keqM=;
        b=IKLNPqQropXmejbgAeKFWJdJAm+EXF3lOx0AtzzHfL1b4VijCBRouUfdW031vBwkrj
         P93S7MPuHGLQiZ5K4pAHw1Xl5G8yBjXoeKX5aHXrGx9cJnSsU+e31fesvYmth3U3469A
         nHv3yz6d0CtNQvsrtySutvLk4kCO/JRwHChiVq/43fxguutEjucNAiFObCR8KFBN4a2M
         hOu/NTGkmoO/yGrqwTjbRDphtJt6ohWGajB0NV8P/jseiA869FfTQ9EqQOi1RZ3plcx+
         UeHY8Wouq0StiJRQ55y2ZtyJNphfsdLqd3mttKy/LI1XWPN0wgUvfOq9eNzjqKDKkG2u
         04Wg==
X-Gm-Message-State: AJcUukfOEBMGu1SOLiaALI8iOVLgRGXftU9Nz4vhqZxKxbu/IgGh8VBV
        eMHDKBmsdujmk29wZgw+DVg=
X-Google-Smtp-Source: ALg8bN6Sz9ejynb3IjR/B/eLPLCoxIozXkiylHTiMOe9oFrcnLjg60ang+aeuPcQdTHZqIks4wNe2Q==
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr1978936lji.60.1546975799298;
        Tue, 08 Jan 2019 11:29:59 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:58 -0800 (PST)
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
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 08/12] drm: remove include of drmP.h from drm_modeset_helper.h
Date:   Tue,  8 Jan 2019 20:29:35 +0100
Message-Id: <20190108192939.15255-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drmP.h is an relic from the days when there was a single header file.
To enable the removal of drmP.h from all users drop include
of drmP.h from drm_modeset_helper.h.

A few files relied on the file included in drmP.h - add explicit
include statements to these files.
Build tested with arm and x86.

v2:
- Add forward declarations to drm_modeset_helper.h (Laurent Pinchart)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/arc/arcpgu_sim.c     | 1 +
 drivers/gpu/drm/bridge/cdns-dsi.c    | 2 ++
 drivers/gpu/drm/drm_modeset_helper.c | 2 ++
 drivers/gpu/drm/rcar-du/rcar_lvds.c  | 1 +
 include/drm/drm_modeset_helper.h     | 6 +++++-
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_sim.c b/drivers/gpu/drm/arc/arcpgu_sim.c
index 68629e614990..3b7556f62230 100644
--- a/drivers/gpu/drm/arc/arcpgu_sim.c
+++ b/drivers/gpu/drm/arc/arcpgu_sim.c
@@ -14,6 +14,7 @@
  *
  */
 
+#include <drm/drm_device.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic_helper.h>
 
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index ce9496d13986..4b73d0969468 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -8,11 +8,13 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <video/mipi_display.h>
 
 #include <linux/clk.h>
+#include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index 9150fa385bba..9bc1ef788c77 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -23,8 +23,10 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_print.h>
 
 /**
  * DOC: aux kms helpers
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 534a128a869d..8010ed702509 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index efa337f03129..995fd981cab0 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -23,7 +23,11 @@
 #ifndef __DRM_KMS_HELPER_H__
 #define __DRM_KMS_HELPER_H__
 
-#include <drm/drmP.h>
+struct drm_crtc;
+struct drm_crtc_funcs;
+struct drm_device;
+struct drm_framebuffer;
+struct drm_mode_fb_cmd2;
 
 void drm_helper_move_panel_connectors_to_head(struct drm_device *);
 
-- 
2.12.0

