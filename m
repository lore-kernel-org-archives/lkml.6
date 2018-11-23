Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09862C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E2120820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E2120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502596AbeKWUNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:13:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49334 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393938AbeKWUK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 23D3F20DE5; Fri, 23 Nov 2018 10:26:58 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id A8AD320DED;
        Fri, 23 Nov 2018 10:26:32 +0100 (CET)
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
Subject: [PATCH v2 20/43] drm/sun4i: frontend: Determine input format based on colorspace
Date:   Fri, 23 Nov 2018 10:24:52 +0100
Message-Id: <20181123092515.2511-21-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
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
Thus, we can use the associated common DRM helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index a16697b0eac5..7a8efbd516ac 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -106,14 +106,12 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 
 static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
-	switch (fmt) {
-	case DRM_FORMAT_XRGB8888:
+	if (!drm_format_is_yuv(fmt))
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
 
 static int sun4i_frontend_drm_format_to_input_mode(uint32_t fmt, u32 *val)
-- 
2.19.1

