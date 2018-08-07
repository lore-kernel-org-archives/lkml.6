Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597A7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C5E214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C5E214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390467AbeHGV4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:56:19 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:39950 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390010AbeHGV4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:56:19 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 2271CBFAEF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 21:40:24 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 24E3FC0ED8; Tue,  7 Aug 2018 21:40:23 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 72150BFB30;
        Tue,  7 Aug 2018 21:39:40 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] drm/sun4i: Avoid failing to init fbdev without any connector
Date:   Tue,  7 Aug 2018 21:39:19 +0200
Message-Id: <20180807193919.4800-1-contact@paulk.fr>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing and registering fbdev requires at least one DRM connector
and will fail otherwise. In order to support headless setups (for
instance for GPU rendering with the GBM backend, where a DRI card node
is required to provide GEM memory reservation), add a check on the
number of registered connectors before initializing fbdev.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index 5f29850ef8ac..19a265e4a93a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -49,6 +49,8 @@ static struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers = {
 
 int sun4i_framebuffer_init(struct drm_device *drm)
 {
+	int ret;
+
 	drm_mode_config_reset(drm);
 
 	drm->mode_config.max_width = 8192;
@@ -57,7 +59,13 @@ int sun4i_framebuffer_init(struct drm_device *drm)
 	drm->mode_config.funcs = &sun4i_de_mode_config_funcs;
 	drm->mode_config.helper_private = &sun4i_de_mode_config_helpers;
 
-	return drm_fb_cma_fbdev_init(drm, 32, 0);
+	if (drm->mode_config.num_connector > 0) {
+		ret = drm_fb_cma_fbdev_init(drm, 32, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 void sun4i_framebuffer_free(struct drm_device *drm)
-- 
2.18.0

