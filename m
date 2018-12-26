Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5163C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69224218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODRZNU2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeLZVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:05:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37482 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeLZVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:04:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so11506018lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LyFc1oARtVClcqvhhd+ct+UtuZdtD0NQu3OXVIuq2/o=;
        b=ODRZNU2DrXe7oYaXqzEnIXFwL236GRf6qXBhkfo6aEHwGcqYlvoIkabLV3k+5eY6xr
         hXpM3tU7uR9jN80p4IVdZ3H+wefWNJPd2yeZdEI6CiJXiVBYx3Nup49EqeRHtEZvck5V
         iXLBtiP5Cv6Pq7UrsMTaWRRTdLZMoSNdP3JhCaV01ZtZWW9BaoGhJrAtcA3whQVciRx9
         NgNZnTxSaiK+KzkDeHyDBv5LP12OmR0475PMezG51fbcwP9abfCHhI4r6SHu39K4NtFD
         sO4f+NPRlBUZffRaqsUDiI0o7eEpluuz4CcO3ys4Yi0fCo/eeEInnCKAgiIwjRMOQYZI
         J3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LyFc1oARtVClcqvhhd+ct+UtuZdtD0NQu3OXVIuq2/o=;
        b=Q0KrBy3z1udscVSHI+F3oHG/JLVlvr0+IuvGaXETOtRRGVgK4B7YuMR0CrXXHbjUAm
         j70M7YeaQm4zcws/eBO/FXW1tDH7wMBvrcrr3iMU++RmeLSxnyxF+ynHLPvQPDkjqZuH
         mveSbW0eBuxGQABI7NQ9Ou8UZ+Ttc9zTkhRC4gj6Qd2UQ68fttwB0xPHIk0AbI4FIrSa
         Vxl3iGTtHbkIIpMeWY6RdPKfvAgVPde+81VgEmWJxMUHanN5Bw39p9+clf9fnryrDeBN
         z/sRjx8uAhM1NWExsha4mTHEMn2pyPlXpFkcAiW1SgTQrhEvBP4nfvgxjjrsd9ARay4S
         nvow==
X-Gm-Message-State: AA+aEWafZb7QdFyi/4uLSMbKOLebQp/mfiOIc8lK6xZCHCeM3arRQEQk
        5hHjJwyYJVl3UD8V6QGoIo0=
X-Google-Smtp-Source: AFSGD/WayY2Mk0sYgWafa7lBc2a0OrEhUbvwzh8jh3qUyh7jgGPQovJghIX6EKy253RVUXZPIUJW2A==
X-Received: by 2002:a19:d8d8:: with SMTP id r85mr10477915lfi.92.1545858282278;
        Wed, 26 Dec 2018 13:04:42 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id g70-v6sm7768124ljg.92.2018.12.26.13.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:04:41 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>
Subject: [PATCH v1 7/7] drm: remove include of drmP.h from drm_gem_cma_helper.h
Date:   Wed, 26 Dec 2018 22:03:53 +0100
Message-Id: <20181226210353.13993-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181226210215.GA27610@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix fallout in various files/drivers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Yannick Fertre <yannick.fertre@st.com>
Cc: Philippe Cornu <philippe.cornu@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: David Lechner <david@lechnology.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/arc/arcpgu_crtc.c              | 2 ++
 drivers/gpu/drm/arc/arcpgu_drv.c               | 6 ++++++
 drivers/gpu/drm/stm/drv.c                      | 3 +++
 drivers/gpu/drm/stm/ltdc.c                     | 9 ++++++++-
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c    | 1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c | 2 ++
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c    | 1 +
 drivers/gpu/drm/tinydrm/ili9225.c              | 1 +
 drivers/gpu/drm/tinydrm/mipi-dbi.c             | 3 +++
 include/drm/drm_file.h                         | 1 +
 include/drm/drm_gem_cma_helper.h               | 5 ++++-
 include/drm/tinydrm/tinydrm.h                  | 1 +
 12 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index 965cda48dc13..41e8bbfe2806 100644
--- a/drivers/gpu/drm/arc/arcpgu_crtc.c
+++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
@@ -16,8 +16,10 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_plane_helper.h>
 #include <linux/clk.h>
 #include <linux/platform_data/simplefb.h>
diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index f067de4e1e82..cca897341921 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -16,11 +16,17 @@
 
 #include <linux/clk.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 
 #include "arcpgu.h"
 #include "arcpgu_regs.h"
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index f2021b23554d..6d41b0fb165f 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -9,12 +9,15 @@
  */
 
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/of_platform.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 808d9fb627e9..8f6249368450 100644
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
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
index 255341ee4eb9..cc4f4c6a6cb4 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
@@ -15,6 +15,7 @@
 #include <drm/tinydrm/tinydrm.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
+#include <linux/module.h>
 
 /**
  * DOC: overview
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
index dcd390163a4a..d4ec6bcc39b2 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
@@ -9,10 +9,12 @@
 
 #include <linux/backlight.h>
 #include <linux/dma-buf.h>
+#include <linux/moduleparam.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
 #include <linux/swab.h>
 
+#include <drm/drm_fourcc.h>
 #include <drm/tinydrm/tinydrm.h>
 #include <drm/tinydrm/tinydrm-helpers.h>
 
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
index 7e8e24d0b7a7..652b596070e6 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
@@ -11,6 +11,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_vblank.h>
 #include <drm/tinydrm/tinydrm.h>
 
 struct tinydrm_connector {
diff --git a/drivers/gpu/drm/tinydrm/ili9225.c b/drivers/gpu/drm/tinydrm/ili9225.c
index 455fefe012f5..fbd94fe8b36f 100644
--- a/drivers/gpu/drm/tinydrm/ili9225.c
+++ b/drivers/gpu/drm/tinydrm/ili9225.c
@@ -21,6 +21,7 @@
 #include <video/mipi_display.h>
 
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/tinydrm/mipi-dbi.h>
 #include <drm/tinydrm/tinydrm-helpers.h>
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index cb3441e51d5f..c61f5539e58e 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -9,10 +9,13 @@
  * (at your option) any later version.
  */
 
+#include <drm/drm_file.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/tinydrm/mipi-dbi.h>
 #include <drm/tinydrm/tinydrm-helpers.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 26485acc51d7..931b072d0aa9 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -30,6 +30,7 @@
 #ifndef _DRM_FILE_H_
 #define _DRM_FILE_H_
 
+#include <linux/idr.h>
 #include <linux/types.h>
 #include <linux/completion.h>
 
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 19777145cf8e..83907bd1cf53 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -2,9 +2,12 @@
 #ifndef __DRM_GEM_CMA_HELPER_H__
 #define __DRM_GEM_CMA_HELPER_H__
 
-#include <drm/drmP.h>
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_gem.h>
 
+struct drm_mode_create_dumb;
+
 /**
  * struct drm_gem_cma_object - GEM object backed by CMA memory allocations
  * @base: base GEM object
diff --git a/include/drm/tinydrm/tinydrm.h b/include/drm/tinydrm/tinydrm.h
index fe9827d0ca8a..449fdc4de7d3 100644
--- a/include/drm/tinydrm/tinydrm.h
+++ b/include/drm/tinydrm/tinydrm.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_TINYDRM_H
 #define __LINUX_TINYDRM_H
 
+#include <drm/drm_drv.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_simple_kms_helper.h>
-- 
2.12.0

