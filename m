Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D83C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801C220820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801C220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502708AbeKWUKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49278 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393935AbeKWUKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D8E2C20DD8; Fri, 23 Nov 2018 10:26:48 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 199DB20DD9;
        Fri, 23 Nov 2018 10:26:31 +0100 (CET)
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
Subject: [PATCH v2 14/43] drm/sun4i: backend: Avoid counting YUV planes that use the frontend
Date:   Fri, 23 Nov 2018 10:24:46 +0100
Message-Id: <20181123092515.2511-15-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our hardware has a limited number of YUV planes (usually 1) that can be
supported using the backend only. However, YUV planes can also be
supported by the frontend and must then not be counted when checking for
that limitation.

Only count the YUV plane when the frontend is not used.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 30d7bc76c0af..a39d8b75d76a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -543,6 +543,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 			DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
 					 plane->index);
 			num_frontend_planes++;
+		} else {
+			if (fb->format->is_yuv) {
+				DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
+				num_yuv_planes++;
+			}
 		}
 
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
@@ -551,11 +556,6 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
 			num_alpha_planes++;
 
-		if (fb->format->is_yuv) {
-			DRM_DEBUG_DRIVER("Plane FB format is YUV\n");
-			num_yuv_planes++;
-		}
-
 		DRM_DEBUG_DRIVER("Plane zpos is %d\n",
 				 plane_state->normalized_zpos);
 
-- 
2.19.1

