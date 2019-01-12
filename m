Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D89C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4809E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+iy02Ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfALTeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:34:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35661 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfALTdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so13093614lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjKbpYaaeJmSc6X5KV6yIBLsR3nMJMIiYs2qfLs+ds0=;
        b=D+iy02RiqKM85HJR7mqRrX9S+pjBqCRWMEGefgNyLjARM0Nr3JYx/WBuycEG4amF0S
         H+QR6wFpTBqaOFBvctrT95/jSujvlAJXoc3c5FMcVUNmrZsZYNUjBygxiESB5xBFvi2c
         J0IjqiltNl32bBOTBcFaii5qkvfPwX2Jpv5RuBPH18hCZB2Li1ptMEHbVVYRd7NDY2L7
         EmMDh9NKyJLxXRbtY1HcLvO0Ug375mVs9feQQ8PxHo4IZ8LsD04jFFCN3XvV1Bzt8NWm
         OEINkK4QovhORzbI7eWkJQtuvEAjKswVdHSQdWhexo1E70fBixDePHfQmBxhGKErXqIO
         ArpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=vjKbpYaaeJmSc6X5KV6yIBLsR3nMJMIiYs2qfLs+ds0=;
        b=eKGbNcpmiqz4TLzLQ0v1SlGjHG7durSExBYRCrjRz2drSqAIlbxpBBgolnTAOm69na
         Ui6I2QanpS8aKU7lzPGDHLwKrY0YFeJiojxtxnoBDtRdNXYzlLpHqUeC9CCS0tXXp7tm
         OoxPGgTgv4Iu+v+GVSv5dUzu9QhWe+0nPhkiRfxUC08Mr0iMDU+ar/yIzsARLNT9X39n
         iXKK+RY9/BvkklJiiGiJrC6z4nl7oP21B5FEl5JxJfI+SVwyUP4EXb54KGHgurnkC9PS
         0yc5RoTGcIo4svDMfjBVtQNMMrMZyFa7ZZHboLAeqxg84ijN6jWP4D3T3lfS+4K6FKyN
         wJ5Q==
X-Gm-Message-State: AJcUukd5tlz/zKulnuFVAoKpmttSiuV+Y0mecFgpj2ecidRNVTSDm5ss
        Tlo6QqXAHpgisG7cXgB7CI0=
X-Google-Smtp-Source: ALg8bN6dyEywFLwzKmQ35U/3dPBN1hhiGFCCkM+3SW9afg4fu9SRkDA59R4abQYiXOIk/deNbRAFqA==
X-Received: by 2002:a19:7919:: with SMTP id u25mr10099813lfc.18.1547321610247;
        Sat, 12 Jan 2019 11:33:30 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:29 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 3/8] drm/stm: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 12 Jan 2019 20:32:46 +0100
Message-Id: <20190112193251.20450-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190112193251.20450-1-sam@ravnborg.org>
References: <20190112193251.20450-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused drm/stm to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on arm and x86 allmodconfig

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Yannick Fertre <yannick.fertre@st.com>
Cc: Philippe Cornu <philippe.cornu@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/stm/drv.c  | 4 ++++
 drivers/gpu/drm/stm/ltdc.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8dec001b9d37..58bf8bae789c 100644
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
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "ltdc.h"
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661aa0ac..de29f4713140 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -10,18 +10,25 @@
 
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_vblank.h>
 
 #include <video/videomode.h>
 
-- 
2.12.0

