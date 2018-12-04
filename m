Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C366C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD6C206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD6C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLDOXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:23:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33272 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeLDOXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:14 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E626220784; Tue,  4 Dec 2018 15:23:09 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id B7A6220A5B;
        Tue,  4 Dec 2018 15:22:39 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 04/21] drm/sun4i: frontend: Pass DRM format info to input mode helper
Date:   Tue,  4 Dec 2018 15:22:01 +0100
Message-Id: <20181204142218.16284-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper returning the input mode needs to know the number of planes
for the provided format. Passing the fourcc requires iterating through
the format info list in order to return the number of planes.

Pass the DRM format info structure directly instead, since it's
available to the caller. Also rename the input format in the caller
function to keep things consistent.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 1a7ebc45747e..c436fa97928f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -116,9 +116,11 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 	}
 }
 
-static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
+static int
+sun4i_frontend_drm_format_to_input_mode(const struct drm_format_info *format,
+					u32 *val)
 {
-	if (drm_format_num_planes(fmt) == 1)
+	if (format->num_planes == 1)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED;
 	else
 		return -EINVAL;
@@ -183,12 +185,13 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	uint32_t format = fb->format->format;
+	const struct drm_format_info *format = fb->format;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
 	int ret;
 
-	ret = sun4i_frontend_drm_format_to_input_fmt(format, &in_fmt_val);
+	ret = sun4i_frontend_drm_format_to_input_fmt(format->format,
+						     &in_fmt_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid input format\n");
 		return ret;
@@ -200,7 +203,8 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 		return ret;
 	}
 
-	ret = sun4i_frontend_drm_format_to_input_sequence(format, &in_ps_val);
+	ret = sun4i_frontend_drm_format_to_input_sequence(format->format,
+							  &in_ps_val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid pixel sequence\n");
 		return ret;
-- 
2.19.2

