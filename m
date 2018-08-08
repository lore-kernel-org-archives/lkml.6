Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E93EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA8F216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA8F216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHHLZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:25:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHHLZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FC0B81663D5;
        Wed,  8 Aug 2018 09:07:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-132.ams2.redhat.com [10.36.116.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2593C20180F4;
        Wed,  8 Aug 2018 09:07:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 717CE16E2C; Wed,  8 Aug 2018 11:07:09 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/cirrus: flip default from 24bpp to 16bpp
Date:   Wed,  8 Aug 2018 11:06:58 +0200
Message-Id: <20180808090658.30224-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 08 Aug 2018 09:07:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 08 Aug 2018 09:07:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
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

Also use the default depth for the framebuffer console.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.c   | 4 ++--
 drivers/gpu/drm/cirrus/cirrus_fbdev.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

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
-- 
2.9.3

