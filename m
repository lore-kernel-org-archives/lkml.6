Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDA121850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbeLXM0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:26:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60522 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbeLXM0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:26:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 23A5D20A46; Mon, 24 Dec 2018 13:26:23 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id DBC8B206F9;
        Mon, 24 Dec 2018 13:26:12 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/vc4: Allow fb modifiers early enough to fill IN_FORMATS property
Date:   Mon, 24 Dec 2018 13:25:51 +0100
Message-Id: <20181224122551.9912-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KMS mode_config elements are currently configured in vc4_kms_load,
that is called after all components are binded (component_bind_all).
However, the CRTC component (for the Pixel Valve) needs to access the
allow_fb_modifiers element at bind time, when initializing its planes
through drm_universal_plane_init.

This helpers checks allow_fb_modifiers to decide whether to fill the
IN_FORMATS property. Because allow_fb_modifiers is still set to false
at this point, the property is never filled and userspace cannot
retrieve the combination of supported formats and modifiers.

Fix this by setting allow_fb_modifiers right after calling
drm_mode_config_init (which initializes the structure), before binding
the components of the driver.

Fixes: 423ad7b3cbd1 ("drm/vc4: Advertise supported modifiers for planes")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 1 +
 drivers/gpu/drm/vc4/vc4_kms.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 7195a0bcceb3..5c24f80dd34e 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -273,6 +273,7 @@ static int vc4_drm_bind(struct device *dev)
 		goto dev_put;
 
 	drm_mode_config_init(drm);
+	drm->mode_config.allow_fb_modifiers = true;
 
 	vc4_gem_init(drm);
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index b0cbb869f659..b70931fd8cf0 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -530,7 +530,6 @@ int vc4_kms_load(struct drm_device *dev)
 	dev->mode_config.funcs = &vc4_mode_funcs;
 	dev->mode_config.preferred_depth = 24;
 	dev->mode_config.async_page_flip = true;
-	dev->mode_config.allow_fb_modifiers = true;
 
 	drm_modeset_lock_init(&vc4->ctm_state_lock);
 
-- 
2.20.1

