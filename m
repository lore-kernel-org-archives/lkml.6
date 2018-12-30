Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B738FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8764D20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTVt+fM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeL3Rte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40364 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeL3RtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so22347049lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eCma5HCQv5NpqZQvrQIQPXNldhs2hE4OB3E1rHYiUvM=;
        b=QTVt+fM4CWnCDNj7kTTGiFDJm/iLZPxnGAlrvxmQJ1+X62Dx1wSZx4GgS4PpMqxMFs
         9Yc1aN93blIBKaNSejHHnaRJau24AD5LivAsShl5XZGzjROhGTP3r//O+oB8H2SdW0mc
         ah2MyE/rHiTypQbfF27mV86wb7MtelYNFsj6Ah3Gnd9MI9mIRzF88axjBO6aStNto0hQ
         fvGR/if9GWf9BvEENTEbd5CGGy35LeoBzifpmUcWYBOYSO3zNCVrX2KyCURomp4wF2NI
         2/R6ytmCfAlivmVzXGkHc4wg8g3t4egR7oT9fvBGc3pQvav9/4CvdYJXx+hQbJn6lYPq
         Kb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=eCma5HCQv5NpqZQvrQIQPXNldhs2hE4OB3E1rHYiUvM=;
        b=d0k9VI+snNINnPNNVOPxkgV+xjBhmR5k2/EW1bYcoLEJDPCZqw8TB2s6OaMu003QZ0
         xIYvWIMZGbravUZllrRDiy/yqsjUA3wOfaaGJInQ6nX0hIuUZxaIvAT3wuJ4hSOit91e
         KEFHHQNtdXsxrT3ayO3crGuitB6lmLT345/u1BDzaX3XHt3OuaobPwENL23o13V97ZO0
         info6eHVeZG9KiN/TvoEu3WfYibiVeHUbeJ4Y4gs/uZURaA1loFZnElutwfK2a4Jy4dh
         vcs9EHegZ4DbjCpxRXxyjsAlnu3f8Jh64z8J/F3ZLetesLajBC0OhCz+7A+O7HjNBOu/
         kRUQ==
X-Gm-Message-State: AJcUukc/rn2lolBUvSzVL7XyEE7LhkoS17SVxP9Co/3n3SQXyC3SwEbz
        7233PsB4ARkT7EFx/P3+7t8=
X-Google-Smtp-Source: AFSGD/WSWgG3e1kW/otWHZFXrzBTFaHOMwMjZxJPwH8icm+lh/hsTvzqOflvj8xLyMw4V0dlWh/STQ==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr19992129ljs.118.1546192149434;
        Sun, 30 Dec 2018 09:49:09 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:09 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>
Subject: [PATCH v2 12/14] drm/stm: do not reply on drmP.h from drm_gem_cma_helper.h
Date:   Sun, 30 Dec 2018 18:48:36 +0100
Message-Id: <20181230174838.32330-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drmP.h was the only header file in the past and a lot
of files rely on that drmP.h defines everything.
The goal is to one day to delete drmP.h and
as a step towards this it will no longer be included in the
headers files in include/drm/

To prepare stm/ for this add dependencies that
othwewise was pulled in by drmP.h from drm_gem_cma_helper.h

Sort the include list when we anyway modify it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Yannick Fertre <yannick.fertre@st.com>
Cc: Philippe Cornu <philippe.cornu@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/stm/drv.c  | 6 +++++-
 drivers/gpu/drm/stm/ltdc.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8dec001b9d37..9cd6228a18ad 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -9,15 +9,19 @@
  */
 
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/of_platform.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "ltdc.h"
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661aa0ac..5cce6c7f35d4 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -10,17 +10,24 @@
 
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
-#include <drm/drm_bridge.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_plane_helper.h>
 
 #include <video/videomode.h>
-- 
2.12.0

