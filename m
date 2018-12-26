Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418A5218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDVVABhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeLZVFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:05:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36594 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeLZVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:04:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so11520538lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zCdfpeU411KjlCS3g69cDsngrFR+hB9MgDrYPgqXhW8=;
        b=NDVVABhvdd4IG87leqqZDKgaf1J0u3K+99ACGhDDDcrxpNcLd/JuRZsQW0qMjcV32e
         aNoY1Fsb1CjJpDVXFpnEsBueTOvq2G2PctWewmiqnhx4OS4LVcUp3sJmPyUv6wsK9JQy
         vK5uunP5lzXXQvBxJ9EQ6gQqhG+oVFPuNMIqCpktMri9YEzWzEq8UFhccVPJZO01ixo5
         sadfHpSnv9N4SC9fDeKqrmEJlvW3x0/vafLoOFVSLOuLTl7R/xpDJgMB3Bh2khgeuphZ
         nR8vzGf8dZWYGurMQ3wxZxOYtmKMDaYdJ9Ykx0y4T0638FK5Q2cnfrU0EkoZmOW/A6aY
         y/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zCdfpeU411KjlCS3g69cDsngrFR+hB9MgDrYPgqXhW8=;
        b=ekh1RQQE/X+3/4BqCL9NUNwuMX/VwWN9gO/2f1U6TDE2DsKX5gCXx7Kwh0s2//ZnQA
         D5qiWcA8LvLhQELj+IpTAp6a43orAY3/yuXsZev5Wl9IdZpHHqG5+3QuZA0OpoyXhMrH
         8QRDNCI9P17RRvROXXrbsjjtybAutt62wu9ZzwXukDVYUuixfe9zunbyVxZsJbo9RIHN
         ybrlwDXIR4O8unjJN/YXjGcN7rQdcsBOzoIPwvy4BKsn92jr+8eApoPVTaGlD1JBd0Zd
         2FGOWrHf1dieTpXvCAPn02rbVRpZMwspT5f+728Zu44QL03HI+nUlvL5VUEYLLNhCSaf
         hgBA==
X-Gm-Message-State: AA+aEWakuGPIc7JQtbNLs0fy+KRUf5UFhtE3O3SWEjRQ1Iu1oG9olXpL
        tmQjW6UC0m5WFdIMSUHFYoo=
X-Google-Smtp-Source: AFSGD/VT1rsxLK6o7jZ01T070jfHR82iXEmXTEqDJQ+yYFWnParLcJiw2kpyTTtLyH3XVOOtg7B2vg==
X-Received: by 2002:a19:f204:: with SMTP id q4mr11291926lfh.133.1545858281126;
        Wed, 26 Dec 2018 13:04:41 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id g70-v6sm7768124ljg.92.2018.12.26.13.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:04:40 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v1 6/7] drm: remove include of drmP.h from drm_modeset_helper.h
Date:   Wed, 26 Dec 2018 22:03:52 +0100
Message-Id: <20181226210353.13993-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181226210215.GA27610@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix fallout in various files/drivers by adding missing include files.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/arc/arcpgu_sim.c     | 1 +
 drivers/gpu/drm/bridge/cdns-dsi.c    | 2 ++
 drivers/gpu/drm/drm_modeset_helper.c | 2 ++
 drivers/gpu/drm/rcar-du/rcar_lvds.c  | 1 +
 include/drm/drm_modeset_helper.h     | 2 --
 5 files changed, 6 insertions(+), 2 deletions(-)

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
index f1c24ab0ef09..680cb6a5978c 100644
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
index 173d7ad0b991..f1043458cbd8 100644
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
index efa337f03129..82ead67dfa36 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -23,8 +23,6 @@
 #ifndef __DRM_KMS_HELPER_H__
 #define __DRM_KMS_HELPER_H__
 
-#include <drm/drmP.h>
-
 void drm_helper_move_panel_connectors_to_head(struct drm_device *);
 
 void drm_helper_mode_fill_fb_struct(struct drm_device *dev,
-- 
2.12.0

