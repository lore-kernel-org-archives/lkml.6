Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C3CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBE120861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBE120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405353AbeKWUN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:13:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49187 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502643AbeKWUKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C8825215DD; Fri, 23 Nov 2018 10:26:47 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id E22B620DBF;
        Fri, 23 Nov 2018 10:26:28 +0100 (CET)
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
Subject: [PATCH v2 06/43] drm/sun4i: backend: Refine the logic behind using the frontend
Date:   Fri, 23 Nov 2018 10:24:38 +0100
Message-Id: <20181123092515.2511-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking that scaling is in use is not sufficient as a condition to
decide to use the frontend.

Since not all layer formats are supported by the frontend, we need to
check for that support first. Then, the frontend must only be enabled
if the backend doesn't support the format or that scaling is required.

Signed-off-by:Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 7dd24eb03f89..735fea7ead0b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -449,16 +449,32 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(state->plane);
 	struct sun4i_backend *backend = layer->backend;
+	uint32_t format = state->fb->format->format;
 
 	if (IS_ERR(backend->frontend))
 		return false;
 
+	if (!sun4i_frontend_format_is_supported(format))
+		return false;
+
+	if (!sun4i_backend_format_is_supported(format))
+		return true;
+
 	/*
 	 * TODO: The backend alone allows 2x and 4x integer scaling, including
 	 * support for an alpha component (which the frontend doesn't support).
-	 * Use the backend directly instead of the frontend in this case.
+	 * Use the backend directly instead of the frontend in this case, with
+	 * another test to return false.
+	 */
+
+	if (sun4i_backend_plane_uses_scaler(state))
+		return true;
+
+	/*
+	 * Here the format is supported by both the frontend and the backend
+	 * and no frontend scaling is required, so use the backend directly.
 	 */
-	return sun4i_backend_plane_uses_scaler(state);
+	return false;
 }
 
 static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
-- 
2.19.1

