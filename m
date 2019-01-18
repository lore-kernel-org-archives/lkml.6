Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6904CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7720883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfAROvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:51:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47903 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfAROvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:51:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7588A20BA8; Fri, 18 Jan 2019 15:51:42 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 24EB120955;
        Fri, 18 Jan 2019 15:51:42 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH RESEND v5 05/23] drm/sun4i: frontend: Determine input format based on colorspace
Date:   Fri, 18 Jan 2019 15:51:15 +0100
Message-Id: <20190118145133.21281-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all the RGB input formats have the same value for the DATA_FMT
field of the INPUT_FMT register, we can group them when the format is
known to be RGB. Here, we assume that a non-YUV format is RGB, because
the hardware does not support any other colorspace than RGB and YUV.

Use the DRM format info structure to check whether the format uses a
YUV colorspace.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index dd5af3019099..7c7a5ea0cf58 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -108,14 +108,12 @@ static int
 sun4i_frontend_drm_format_to_input_fmt(const struct drm_format_info *format,
 				       u32 *val)
 {
-	switch (format->format) {
-	case DRM_FORMAT_XRGB8888:
+	if (!format->is_yuv)
 		*val = SUN4I_FRONTEND_INPUT_FMT_DATA_FMT_RGB;
-		return 0;
-
-	default:
+	else
 		return -EINVAL;
-	}
+
+	return 0;
 }
 
 static int
-- 
2.20.1

