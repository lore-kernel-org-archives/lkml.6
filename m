Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F782C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139A221708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139A221708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeHHNcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:32:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbeHHNcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:32:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E89640216E6;
        Wed,  8 Aug 2018 11:13:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E78101007090;
        Wed,  8 Aug 2018 11:13:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3A11016E2B; Wed,  8 Aug 2018 13:13:18 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/cirrus: flip default from 24bpp to 16bpp
Date:   Wed,  8 Aug 2018 13:13:11 +0200
Message-Id: <20180808111311.30311-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 11:13:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 11:13:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with 24bpp is that it is a rather unusual depth these days,
cirrus is pretty much the only relevant device still using that, and it
is a endless source of issues.  Wayland doesn't support it at all.  Bugs
in Xorg keep showing up.

Typically either 32bpp or 16bpp are used.  Using 32bpp would limit the
resolution to 800x600 due to hardware constrains.  So lets go with 16bpp.

Also use the default depth for the framebuffer console and
mode_info->preferred_depth.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.c   | 4 ++--
 drivers/gpu/drm/cirrus/cirrus_fbdev.c | 3 +--
 drivers/gpu/drm/cirrus/cirrus_mode.c  | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
index 69c4e352dd..b4f7be056c 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
@@ -16,11 +16,11 @@
 #include "cirrus_drv.h"
 
 int cirrus_modeset = -1;
-int cirrus_bpp = 24;
+int cirrus_bpp = 16;
 
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, cirrus_modeset, int, 0400);
-MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:24)");
+MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:16)");
 module_param_named(bpp, cirrus_bpp, int, 0400);
 
 /*
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 32fbfba2c6..b329a54290 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -271,7 +271,6 @@ int cirrus_fbdev_init(struct cirrus_device *cdev)
 {
 	struct cirrus_fbdev *gfbdev;
 	int ret;
-	int bpp_sel = 24;
 
 	/*bpp_sel = 8;*/
 	gfbdev = kzalloc(sizeof(struct cirrus_fbdev), GFP_KERNEL);
@@ -296,7 +295,7 @@ int cirrus_fbdev_init(struct cirrus_device *cdev)
 	/* disable all the possible outputs/crtcs before entering KMS mode */
 	drm_helper_disable_unused_functions(cdev->dev);
 
-	return drm_fb_helper_initial_config(&gfbdev->helper, bpp_sel);
+	return drm_fb_helper_initial_config(&gfbdev->helper, cirrus_bpp);
 }
 
 void cirrus_fbdev_fini(struct cirrus_device *cdev)
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index c91b9b054e..91128b1d8d 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -518,7 +518,7 @@ int cirrus_modeset_init(struct cirrus_device *cdev)
 	cdev->dev->mode_config.max_height = CIRRUS_MAX_FB_HEIGHT;
 
 	cdev->dev->mode_config.fb_base = cdev->mc.vram_base;
-	cdev->dev->mode_config.preferred_depth = 24;
+	cdev->dev->mode_config.preferred_depth = cirrus_bpp;
 	/* don't prefer a shadow on virt GPU */
 	cdev->dev->mode_config.prefer_shadow = 0;
 
-- 
2.9.3

