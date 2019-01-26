Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB74C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1C218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bECp7QHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfAZM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:26:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41701 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAZMZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:25:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so10512630ljc.8;
        Sat, 26 Jan 2019 04:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OuJSbOXVxBR4EMcEW399DVMD4C+VWU5NXdUH5dxGtKU=;
        b=bECp7QHQYVrzWVWCLpUXidTEDzXWK0h2xfWulSxAUqDTdwrq9TzVgxnmFqgosN43ai
         pdKUsJblSDUxVyflROnmuwuaqAJAd9RKX6iZgnOPNv/vWa1QnKW9+/FLGw0gVNQVQFe7
         A9w6miYmyBJxKQkpW/+LF/egDG0SQ1mKvrwUdHHrgfVcArQk/Mmg1avsnix1NPwxCBFb
         4nJE7z0ZF5S1iqJ0lAHXS4LwAkp8AyMOZpx9sh6gSU7MAni9D3j+gunmxGJLz4qdfTaL
         eha9AKWvi6BXQ9raxRrn4padWbckxBkS+PzfCON/dw31gMTz8RU7XBTjIDHoljMQ8Cqr
         3gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OuJSbOXVxBR4EMcEW399DVMD4C+VWU5NXdUH5dxGtKU=;
        b=ry8CJo04iFk9rqzvtCtvtpzMKX+DCYNH4kD5KUaexTDXuMuPMoyOxWl712cqqHci2+
         u7hdAg1KNz45kUUOWZQeDak6dyOeqEMl2CYd60J18DPdlleaalzLGYSIWj9Qe53Q95RF
         kdfcugW5RZU/3dc0LXRSISHis2ZUwAYJls4+H8v4D54CH+wmqiXiGPnPFw2hnfcVQRFK
         FJD2zUCmnD629JbaENP0VgzMAOomIivxwrH2EANV8ybNPkXueWumhJTwQuyAQp5Te93m
         oigxTfoYLJzb9NfoBgSPAqVUaRaZgf8dehDcoZqAbA6nGgS3OJkwqiW2bwruvQz7UeUn
         ijSg==
X-Gm-Message-State: AJcUukfI5BN6O89duSmLavqDavvWibvT5aeaOcGuKLLZfOTEHYKy9iq3
        5RKN7mADpeBT4rNqjF3WYhY=
X-Google-Smtp-Source: ALg8bN40wNTz/L8BElvNZspOcsuY34MED5uo2glnS1CcaCswRLgIeui/xIqQIwMmNCGEyRweabKFBA==
X-Received: by 2002:a2e:8808:: with SMTP id x8-v6mr11445410ljh.190.1548505552730;
        Sat, 26 Jan 2019 04:25:52 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id j138sm2070288lfg.64.2019.01.26.04.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 04:25:52 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v6 3/5] drm/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 26 Jan 2019 13:25:25 +0100
Message-Id: <20190126122527.11647-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190126122527.11647-1-sam@ravnborg.org>
References: <20190126122527.11647-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused rcar-du to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on arm allmodconfig/allyesconfig.

v2:
- new patch. Changes like drm_probe_helper and other
  required several updates

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c  | 3 +++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 1 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 2 ++
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 2 ++
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c   | 1 +
 5 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 93ee0020c9b1..4d1e5098b70e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -9,14 +9,17 @@
 
 #include <linux/clk.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/sys_soc.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "rcar_du_crtc.h"
 #include "rcar_du_drv.h"
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index abd70d2931b0..75ab17af13a9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -20,6 +20,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_probe_helper.h>
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 663ab98d1f97..18d21bc1d265 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -10,10 +10,12 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
 #include <linux/of_graph.h>
 #include <linux/wait.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 321ac80b48d3..c6430027169f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -10,7 +10,9 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 76a39eee7c9c..0878accbd134 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -13,6 +13,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_vblank.h>
 
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
-- 
2.12.0

