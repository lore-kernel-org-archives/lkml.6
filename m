Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC564C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CF120658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CF120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeIEKdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:33:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbeIEKdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:33:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5159E4023351;
        Wed,  5 Sep 2018 06:04:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9554B2156889;
        Wed,  5 Sep 2018 06:04:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0E0AA17444; Wed,  5 Sep 2018 08:04:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS)
Subject: [PATCH v2 1/6] drm: replace DRIVER_PREFER_XBGR_30BPP driver flag with mode_config quirk
Date:   Wed,  5 Sep 2018 08:04:40 +0200
Message-Id: <20180905060445.15008-2-kraxel@redhat.com>
In-Reply-To: <20180905060445.15008-1-kraxel@redhat.com>
References: <20180905060445.15008-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 06:04:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 06:04:49 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_drv.h                   | 1 -
 include/drm/drm_mode_config.h           | 1 +
 drivers/gpu/drm/drm_framebuffer.c       | 4 ++--
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 46a8009784..23b9678137 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -56,7 +56,6 @@ struct drm_printer;
 #define DRIVER_ATOMIC			0x10000
 #define DRIVER_KMS_LEGACY_CONTEXT	0x20000
 #define DRIVER_SYNCOBJ                  0x40000
-#define DRIVER_PREFER_XBGR_30BPP        0x80000
 
 /**
  * struct drm_driver - DRM driver structure
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index a0b202e1d6..5d29f4ba6f 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -809,6 +809,7 @@ struct drm_mode_config {
 
 	/* dumb ioctl parameters */
 	uint32_t preferred_depth, prefer_shadow;
+	bool quirk_addfb_prefer_xbgr_30bpp;
 
 	/**
 	 * @async_page_flip: Does this device support async flips on the primary
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 781af1d42d..17b7b8944d 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -120,8 +120,8 @@ int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
 	r.pixel_format = drm_mode_legacy_fb_format(or->bpp, or->depth);
 	r.handles[0] = or->handle;
 
-	if (r.pixel_format == DRM_FORMAT_XRGB2101010 &&
-	    dev->driver->driver_features & DRIVER_PREFER_XBGR_30BPP)
+	if (dev->mode_config.quirk_addfb_prefer_xbgr_30bpp &&
+	    r.pixel_format == DRM_FORMAT_XRGB2101010)
 		r.pixel_format = DRM_FORMAT_XBGR2101010;
 
 	ret = drm_mode_addfb2(dev, &r, file_priv);
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 8412119bd9..a9bb656058 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2174,7 +2174,7 @@ nv50_display_create(struct drm_device *dev)
 	nouveau_display(dev)->fini = nv50_display_fini;
 	disp->disp = &nouveau_display(dev)->disp;
 	dev->mode_config.funcs = &nv50_disp_func;
-	dev->driver->driver_features |= DRIVER_PREFER_XBGR_30BPP;
+	dev->mode_config.quirk_addfb_prefer_xbgr_30bpp = true;
 
 	/* small shared memory area we use for notifiers and semaphores */
 	ret = nouveau_bo_new(&drm->client, 4096, 0x1000, TTM_PL_FLAG_VRAM,
-- 
2.9.3

