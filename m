Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB6C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44872086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSOkCdfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfASIkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:40:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47025 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfASIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:40:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id y14so12152756lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82s1yv64NCHQfWv7cYkKneBGqUIi0pb0Kmg7915Ruho=;
        b=hSOkCdfxdI5thMvKEn7fEbuFjpivaSYQIq2eaFkFpeNUgAbB+5DZ1vv+ivoyScTsAh
         1ySxE1ur4BsEEBmqR61Fm57pEfWwhHGwjPsa7wY+6Rane2dNJiHf1RbtPIbsXOO0VDdt
         beoWBDQNe2tUIqmE+12z2uTWcL9wbXVmQnonZuR5TUqYOvso6cha13qbj969VxIqRvH+
         XQBJgVMJcktQ15Cgq46Szs/28HKtyADBJhhwSqmSW82/3+RkIpqtTeqQ7oYLGdwla/hY
         15SMtli40gLd6jBpsK4lix3nbIV8nNtO4PyVJFJZ1lD6xL1KqW94VvKTXLvMAcn+y3Du
         MBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=82s1yv64NCHQfWv7cYkKneBGqUIi0pb0Kmg7915Ruho=;
        b=FgkA30Ylt2ga+WTbtTIKSj1+UdjFuyrupzdg8LzZgdTn/L2uNuulwXzlxNbs+l/pbO
         TYVwhMOz56piq/8QT6Xmf3KQWmfvFiPvKb+yDC/O1U1LdnseDmfWvBDQAMdQN2T0Orw8
         jyqI+QVKrwSIFFBcpvKg8WKjw14US0A+Q0osvZpEonpP7yAGrzREdqfB5hwbEy+qA6SP
         YB0DFCD0xuc1NGWlaFzbhnKC+j0ZxTtJ9e7Ac+SmqweVI4eVHNutZ7T+lUWCbkgIEQSp
         SDUdRMvyLoZkFl7eF7ohF8CggBQYwQSZ2TMOwcwAmKfty6v9yqQu0Af1xNqzfreKqkVg
         ZU/g==
X-Gm-Message-State: AJcUukcGpv+j/HdG2D3rrfBA/9702RGAceCbT0ucNN2WRfZqlqQsLVxD
        o5qsO1pqtehxi+4vkdM8Y8c=
X-Google-Smtp-Source: ALg8bN6g9oURBfG1KdJSW381tnQ2O+mHnOAH5e6PszPsndivwimkc2Ft1Fc14jCmyQY+46XfOriHwg==
X-Received: by 2002:a19:1019:: with SMTP id f25mr14108906lfi.54.1547887239582;
        Sat, 19 Jan 2019 00:40:39 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id p23sm1187109lfh.47.2019.01.19.00.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:40:39 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] drm/stm: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 19 Jan 2019 09:40:09 +0100
Message-Id: <20190119084014.5355-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119084014.5355-1-sam@ravnborg.org>
References: <20190119084014.5355-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused drm/stm to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on arm and x86 allmodconfig

v2:
- sort list of include files

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Yannick Fertre <yannick.fertre@st.com>
Cc: Philippe Cornu <philippe.cornu@st.com>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/stm/drv.c  | 6 +++++-
 drivers/gpu/drm/stm/ltdc.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8dec001b9d37..d83db27a9aa9 100644
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
-#include <drm/drm_fb_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "ltdc.h"
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661aa0ac..10c8446fd421 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -10,18 +10,25 @@
 
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
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_vblank.h>
 
 #include <video/videomode.h>
 
-- 
2.12.0

