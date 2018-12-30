Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E240BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21B120861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTE2j4fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeL3Rtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:35 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36784 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbeL3RtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so17332919lfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SgrrjuoGTy1EqHP7pAvYoAmmepSCbBgSenwuzQIOABg=;
        b=vTE2j4fpxcfvBbt3E6v2q6kIlZSwKNUrrTdSnyd3AH9gYyoZwIk/zGTXwCbUgqfbFH
         q8glQjzmApcSF8QqlFDApEszbmX8vVvoCUf4+ZMLKw9+F+SSAB2fk7bLaAWIyvaoZTna
         HQnJCiMRjMgtWjx65QNK78mnBn3+/OOFGoRSjp4LZjifub32McvSuHihmy0YxRaCP8sG
         A+QWtsJ0zugUUgvvxLD+YRV178H03+TbI+k+CPFBEoYStrEMKcSkkUBRCS7/c47n5u6r
         hYLXrDHLI25q7dvsIuRHeyPAmXJqBUWlEuTYJvh0xeCnSC6+Ylz4WPKTfiFSEwU4G0a8
         qSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SgrrjuoGTy1EqHP7pAvYoAmmepSCbBgSenwuzQIOABg=;
        b=o3wqXtLu64ETLmx1TQo+NwLCAHPDWuSlUxhjWnLarAAEGK/ma8QucXxkmRTKItEYlK
         N06/UEkYkOvqERDb8ErDnqHlrG2n8r/Nzb0XKNz2EmbUMpMk4KIlJ2I5Zs4P9G6qeq/D
         l7QizOnxtPDoqthQvTcFuFKVn6rrbGoMrKvNvI9n065S9ztGQHS2kusVY6BRIjv64sxZ
         uABPcyoDxr1Vl+Nh4XZ9mbdScmWMtI/JfTXi9w+AbdEJVDk37f4NfrkbzjYDx40Ocvds
         W/mb1baVGw7sjGD7/ySY47bj/WZyidtnhDSQ2aZO75ur4yxpkAi/xrnH+iKwrTzyAMo+
         lo/Q==
X-Gm-Message-State: AA+aEWYrTFgQ9UNCUGzyJmGdPeZYA20+lg0sCFzYO6SW8pMTtM3Rp5rb
        fU6SUbtdSqn6VJHuj/eVydI=
X-Google-Smtp-Source: AFSGD/WF2sx/OHmKrzkNk1i3lpHq4tFFuvyD/f4NcUXj18+stjtkeoJsrJOGpR7nLTJaKIt+DVwSjA==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr16795546lff.141.1546192148328;
        Sun, 30 Dec 2018 09:49:08 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:07 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>
Subject: [PATCH v2 11/14] drm/arc: do not reply on drmP.h from drm_gem_cma_helper.h
Date:   Sun, 30 Dec 2018 18:48:35 +0100
Message-Id: <20181230174838.32330-12-sam@ravnborg.org>
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

To prepare arc/ for this add dependencies that
othwewise was pulled in by drmP.h from drm_gem_cma_helper.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
---
 drivers/gpu/drm/arc/arcpgu_crtc.c | 2 ++
 drivers/gpu/drm/arc/arcpgu_drv.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index 62f51f70606d..155ab177ce0b 100644
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
index 206a76abf771..39a79f5718c4 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -16,12 +16,18 @@
 
 #include <linux/clk.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 
 #include "arcpgu.h"
 #include "arcpgu_regs.h"
-- 
2.12.0

