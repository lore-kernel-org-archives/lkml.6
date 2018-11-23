Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C470EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906B120861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906B120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502787AbeKWUK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49429 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390556AbeKWUK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AAD6920E13; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1A5CC20EB0;
        Fri, 23 Nov 2018 10:26:35 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 29/43] drm/sun4i: Make pitch even for GEM dumb alloc as per hardware constraint
Date:   Fri, 23 Nov 2018 10:25:01 +0100
Message-Id: <20181123092515.2511-30-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our hardware requires the pitch to be an even number when using YUV
formats with the frontend. Implement a driver-specific callback for GEM
dumb allocation that sets the pitch accordingly.

Since only the bpp is passed (and not the format), we cannot really
distinguish if this alignment is really required. Since it doesn't hurt
to align the pitch anyway, always do it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index ef773d36baf0..ccdeae6299eb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -28,6 +28,16 @@
 #include "sun4i_tcon.h"
 #include "sun8i_tcon_top.h"
 
+static int drm_sun4i_gem_dumb_create(struct drm_file *file_priv,
+				     struct drm_device *drm,
+				     struct drm_mode_create_dumb *args)
+{
+	/* The hardware only allows even pitches for YUV buffers. */
+	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), 2);
+
+	return drm_gem_cma_dumb_create_internal(file_priv, drm, args);
+}
+
 DEFINE_DRM_GEM_CMA_FOPS(sun4i_drv_fops);
 
 static struct drm_driver sun4i_drv_driver = {
@@ -42,7 +52,7 @@ static struct drm_driver sun4i_drv_driver = {
 	.minor			= 0,
 
 	/* GEM Operations */
-	.dumb_create		= drm_gem_cma_dumb_create,
+	.dumb_create		= drm_sun4i_gem_dumb_create,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops		= &drm_gem_cma_vm_ops,
 
-- 
2.19.1

