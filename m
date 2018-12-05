Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED76C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C96206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C96206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeLEIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:39:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36214 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbeLEIhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:37:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EF6182087D; Wed,  5 Dec 2018 09:37:45 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id AB15520A59;
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
Subject: [PATCH v4 06/22] drm/sun4i: Move the BT.601 CSC coefficients to the frontend
Date:   Wed,  5 Dec 2018 09:36:47 +0100
Message-Id: <20181205083703.21488-7-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the backend and the frontend need the BT.601 CSC coefficients for
YUV to RGB conversion. Since the backend has a dependency on the
frontend (and not the other way round), move the coefficients there
so that both can access them without having to duplicate them.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 22 ----------------------
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index bbadc2ab9f4d..892197f52557 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -45,28 +45,6 @@ static const u32 sunxi_rgb2yuv_coef[12] = {
 	0x000001c1, 0x00003e88, 0x00003fb8, 0x00000808
 };
 
-/*
- * These coefficients are taken from the A33 BSP from Allwinner.
- *
- * The first three values of each row are coded as 13-bit signed fixed-point
- * numbers, with 10 bits for the fractional part. The fourth value is a
- * constant coded as a 14-bit signed fixed-point number with 4 bits for the
- * fractional part.
- *
- * The values in table order give the following colorspace translation:
- * G = 1.164 * Y - 0.391 * U - 0.813 * V + 135
- * R = 1.164 * Y + 1.596 * V - 222
- * B = 1.164 * Y + 2.018 * U + 276
- *
- * This seems to be a conversion from Y[16:235] UV[16:240] to RGB[0:255],
- * following the BT601 spec.
- */
-static const u32 sunxi_bt601_yuv2rgb_coef[12] = {
-	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
-	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
-	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
-};
-
 static void sun4i_backend_apply_color_correction(struct sunxi_engine *engine)
 {
 	int i;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 7c7a5ea0cf58..045013efdc57 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -48,6 +48,29 @@ static const u32 sun4i_frontend_horz_coef[64] = {
 	0x03ff0000, 0x0000fd41, 0x01ff0000, 0x0000fe42,
 };
 
+/*
+ * These coefficients are taken from the A33 BSP from Allwinner.
+ *
+ * The first three values of each row are coded as 13-bit signed fixed-point
+ * numbers, with 10 bits for the fractional part. The fourth value is a
+ * constant coded as a 14-bit signed fixed-point number with 4 bits for the
+ * fractional part.
+ *
+ * The values in table order give the following colorspace translation:
+ * G = 1.164 * Y - 0.391 * U - 0.813 * V + 135
+ * R = 1.164 * Y + 1.596 * V - 222
+ * B = 1.164 * Y + 2.018 * U + 276
+ *
+ * This seems to be a conversion from Y[16:235] UV[16:240] to RGB[0:255],
+ * following the BT601 spec.
+ */
+const u32 sunxi_bt601_yuv2rgb_coef[12] = {
+	0x000004a7, 0x00001e6f, 0x00001cbf, 0x00000877,
+	0x000004a7, 0x00000000, 0x00000662, 0x00003211,
+	0x000004a7, 0x00000812, 0x00000000, 0x00002eb1,
+};
+EXPORT_SYMBOL(sunxi_bt601_yuv2rgb_coef);
+
 static void sun4i_frontend_scaler_init(struct sun4i_frontend *frontend)
 {
 	int i;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index ad146e8d8d70..3df2bd8a7a95 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -86,6 +86,7 @@ struct sun4i_frontend {
 };
 
 extern const struct of_device_id sun4i_frontend_of_table[];
+extern const u32 sunxi_bt601_yuv2rgb_coef[12];
 
 int sun4i_frontend_init(struct sun4i_frontend *frontend);
 void sun4i_frontend_exit(struct sun4i_frontend *frontend);
-- 
2.19.2

