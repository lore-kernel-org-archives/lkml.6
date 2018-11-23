Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6643BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3804920820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3804920820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409104AbeKWUN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:13:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49214 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502645AbeKWUKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 12B1B20DC1; Fri, 23 Nov 2018 10:26:48 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6E7BB20DC4;
        Fri, 23 Nov 2018 10:26:29 +0100 (CET)
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
Subject: [PATCH v2 08/43] drm/fourcc: Add helper to check if a format uses a YUV colorspace
Date:   Fri, 23 Nov 2018 10:24:40 +0100
Message-Id: <20181123092515.2511-9-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new helper to check whether the format described by its
fourcc code uses a YUV colorspace, by returning the is_yuv entry for
the DRM info entry matching that format.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/drm_fourcc.c | 19 +++++++++++++++++++
 include/drm/drm_fourcc.h     |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index f523948c82b1..f85650c3463a 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -413,6 +413,25 @@ int drm_format_plane_height(int height, uint32_t format, int plane)
 }
 EXPORT_SYMBOL(drm_format_plane_height);
 
+/**
+ * drm_format_is_yuv - check that the format uses a YUV colorspace
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format uses a YUV colorspace.
+ */
+bool drm_format_is_yuv(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return info->is_yuv;
+}
+EXPORT_SYMBOL(drm_format_is_yuv);
+
 /**
  * drm_format_info_block_width - width in pixels of block.
  * @info: pixel format info
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index bcb389f04618..569b70483505 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -157,6 +157,7 @@ int drm_format_horz_chroma_subsampling(uint32_t format);
 int drm_format_vert_chroma_subsampling(uint32_t format);
 int drm_format_plane_width(int width, uint32_t format, int plane);
 int drm_format_plane_height(int height, uint32_t format, int plane);
+bool drm_format_is_yuv(uint32_t format);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
-- 
2.19.1

