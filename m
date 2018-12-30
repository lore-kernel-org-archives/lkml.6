Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E62FC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5353920861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6PU+6vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeL3RtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44653 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeL3RtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so17301842lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=4E+CRC/Vb1YBvB774DuOXRpJUYqdKQe5t91V4N0keqM=;
        b=i6PU+6vcvbSFAa43G+ZvLzrqnzh5Vf7BwcjDi/wK36dlJaLgwHGZGMLIiCJS9677qS
         PPkGpLvMICDf/G6Dc1ilkSJy/N7t30G5YWL/yYAbObgJlfH1Gph/r+j8LlV8d66Ywnxs
         VvOQNJLf/xqZYj3sEfwhcwQbOrWyzBHe7sw+GrQHH9K1p29wbseuVzguwdhKm2XAMB0V
         MYD3devQeEQM3XNNrMkLqGNIRIogyWLrydbekRrx1Ze9dnNbsYd/oQgPhg9iEJPDllXJ
         KOorLIaVNcnsYxNu/CzBPZBxoNnTcBgnd0LkIBmBbTuY5PXMHSP7kjNN8q/6i/2tspdo
         Zkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=4E+CRC/Vb1YBvB774DuOXRpJUYqdKQe5t91V4N0keqM=;
        b=NHXSViQmI2TYzERhYVYgkO4tYNMuQ9nXfd6esFw6Jy+J0DtbMLfkTotvm3LfIf2buc
         5G/Ga1k6Dk2BEg96CKM2tg0TDUHZ999C1rS1Cmi77VxmWLjQFbcigPBkOVqg4q4oIFk8
         bp/2/7ovPWgcJY/V4+ExRHtXzI0xzLLAkHYseaD0wjjOiw48+BGoy2sd+nYBAF3Iy4Cg
         XXNahYZ1T4BZipTRrbbBZtPtRbRQH9t0DYLWkulZPxDKHAOPdvXypju8SqB6Rxi/ZeK2
         SU4g/17NjTlmgoDRJ/G2PnjcrW4hg+TTBotXeIo2bovDFhk00pXEkxwNoRpkd2C0cL83
         BEAQ==
X-Gm-Message-State: AA+aEWZgtmyEZXZfL4Zxx7SuP51Mg6r/FaHlHz/lRNuYTI+0ec+ftehL
        dBOaT9fy/wv0lIqpJdkPq/M=
X-Google-Smtp-Source: AFSGD/VxNz6Dh1amyqnZXFLMwAP3/t125Up6TTWgAnferqJMBdC8tk80NeyWHhO2CEqTB9WnW3M/cA==
X-Received: by 2002:a19:f204:: with SMTP id q4mr18621487lfh.133.1546192147339;
        Sun, 30 Dec 2018 09:49:07 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:06 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v2 10/14] drm: remove include of drmP.h from drm_modeset_helper.h
Date:   Sun, 30 Dec 2018 18:48:34 +0100
Message-Id: <20181230174838.32330-11-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
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

