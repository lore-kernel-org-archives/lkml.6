Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD505C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0D20864
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE0D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502627AbeKWUKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49153 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390496AbeKWUKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:06 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34AA820F84; Fri, 23 Nov 2018 10:26:38 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id D41F9207B0;
        Fri, 23 Nov 2018 10:26:27 +0100 (CET)
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
Subject: [PATCH v2 02/43] drm/sun4i: frontend: Replace ARGB with XRGB as supported format
Date:   Fri, 23 Nov 2018 10:24:34 +0100
Message-Id: <20181123092515.2511-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frontend documentation (for the A33) mentions that ARGB is supported
as output, but with the alpha component always set to 0xff. In practice,
this means that the alpha component cannot be preserved when going
through the frontend. Since the information is lost, ARGB is not
properly supported.

As a result, expose the matching format supported by the frontend (both
for input and output) as XRGB instead of ARGB.

Since ARGB was the selected format for connecting the frontend to the
backend, change it to XRGB to reflect this as well.

The A31 and A80 SoCs apparently have a bit to enable proper alpha,
but this is not supported at this point (see the comment already in the
code).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 +--
 drivers/gpu/drm/sun4i/sun4i_layer.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index ddf6cfa6dd23..3ea925584891 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -107,7 +107,7 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
-	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB8888:
 		*val = 5;
 		return 0;
 
@@ -120,7 +120,6 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-	case DRM_FORMAT_ARGB8888:
 		*val = 2;
 		return 0;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index e0e37c2f1721..50bb16566f03 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -99,9 +99,9 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 		sun4i_frontend_update_coord(frontend, plane);
 		sun4i_frontend_update_buffer(frontend, plane);
 		sun4i_frontend_update_formats(frontend, plane,
-					      DRM_FORMAT_ARGB8888);
+					      DRM_FORMAT_XRGB8888);
 		sun4i_backend_update_layer_frontend(backend, layer->id,
-						    DRM_FORMAT_ARGB8888);
+						    DRM_FORMAT_XRGB8888);
 		sun4i_frontend_enable(frontend);
 	} else {
 		sun4i_backend_update_layer_formats(backend, layer->id, plane);
-- 
2.19.1

