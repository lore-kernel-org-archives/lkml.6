Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8938BC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E72084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfAYDXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:23:21 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59318 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfAYDXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:23:18 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 3FC2B5FD57; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] drm/sun4i: layer: Assign backend pointer before calling DRM helpers
Date:   Fri, 25 Jan 2019 11:23:07 +0800
Message-Id: <20190125032314.20915-5-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We might want to use the backend pointer from DRM callbacks that get
called within drm_universal_plane_init(), such as the
.format_mod_supported callback.

Move the assignment of the layer's backend pointer to right after the
structure is allocated.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index c5a999ca1d72..95d4aaa51a5c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -182,6 +182,8 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
+	layer->backend = backend;
+
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun4i_backend_layer_funcs,
@@ -195,7 +197,6 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 
 	drm_plane_helper_add(&layer->plane,
 			     &sun4i_backend_layer_helper_funcs);
-	layer->backend = backend;
 
 	drm_plane_create_alpha_property(&layer->plane);
 	drm_plane_create_zpos_property(&layer->plane, 0, 0,
-- 
2.20.1

