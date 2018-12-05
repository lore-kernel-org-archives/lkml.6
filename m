Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C940C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3050820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeLEIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:39:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36190 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeLEIhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:37:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BFA8520E34; Wed,  5 Dec 2018 09:37:45 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3104420A44;
        Wed,  5 Dec 2018 09:37:26 +0100 (CET)
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
Subject: [PATCH v4 04/22] drm/sun4i: frontend: Pass DRM format info to input format helpers
Date:   Wed,  5 Dec 2018 09:36:45 +0100
Message-Id: <20181205083703.21488-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper returning the input mode needs to know the number of planes
for the provided format. Passing the fourcc requires iterating through
the format info list in order to return the number of planes.

Pass the DRM format info structure directly instead to all helpers
related to configuring the input format, since it's available to the
caller. Also rename the input format in the caller function to keep
things consistent.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 1a7ebc45747e..dd5af3019099 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -104,9 +104,11 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 }
 EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
-static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
+static int
+sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
+				       u32 *val)
 {
-	switch (fmt) {
+	switch (format->format) {
 	case DRM_FORMAT_XRGB8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
 		return 0;
@@ -116,9 +118,11 @@ static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
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
@@ -126,9 +130,11 @@ static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
 	return 0;
 }
 
-static int sun4i_frontend_drm_format_to_input_sequence(uint32_t fmt, u32 *val)
+static int
+sun4i_frontend_drm_format_to_input_sequence(const struct drm_format_info *format,
+					    u32 *val)
 {
-	switch (fmt) {
+	switch (format->format) {
 	case DRM_FORMAT_BGRX8888:
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_PS_BGRX;
 		return 0;
@@ -183,7 +189,7 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	uint32_t format = fb->format->format;
+	const struct drm_format_info *format = fb->format;
 	u32 out_fmt_val;
 	u32 in_fmt_val, in_mod_val, in_ps_val;
 	int ret;
-- 
2.19.2

