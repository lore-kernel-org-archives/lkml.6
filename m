Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E1BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BA92054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfAROpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:45:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45764 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfAROnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:43:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 67A0020955; Fri, 18 Jan 2019 15:43:49 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1CF60206A7;
        Fri, 18 Jan 2019 15:43:49 +0100 (CET)
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
Subject: [PATCH v5 02/23] drm/fourcc: Add format info helpers for checking YUV sub-sampling
Date:   Fri, 18 Jan 2019 15:43:07 +0100
Message-Id: <20190118144328.20649-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
References: <20190118144328.20649-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display engine drivers often need to distinguish between different types of
YUV sub-sampling. This introduces helpers to check for common sub-sampling
ratios in their commonly-used denomination from the DRM format info.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/drm/drm_fourcc.h | 75 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 01cd353d9302..b3d9d88ab290 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -185,6 +185,81 @@ drm_format_info_is_yuv_planar(const struct drm_format_info *info)
 	return info->is_yuv && info->num_planes == 3;
 }
 
+/**
+ * drm_format_info_is_yuv_sampling_410 - check that the format info matches a
+ * YUV format with 4:1:0 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:1:0
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_410(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 4 && info->vsub == 4;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_411 - check that the format info matches a
+ * YUV format with 4:1:1 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:1:1
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_411(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 4 && info->vsub == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_420 - check that the format info matches a
+ * YUV format with 4:2:0 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:2:0
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_420(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 2 && info->vsub == 2;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_422 - check that the format info matches a
+ * YUV format with 4:2:2 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:2:2
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_422(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 2 && info->vsub == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_sampling_444 - check that the format info matches a
+ * YUV format with 4:4:4 sub-sampling
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a YUV format with 4:4:4
+ * sub-sampling.
+ */
+static inline bool
+drm_format_info_is_yuv_sampling_444(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->hsub == 1 && info->vsub == 1;
+}
+
 const struct drm_format_info *__drm_format_info(u32 format);
 const struct drm_format_info *drm_format_info(u32 format);
 const struct drm_format_info *
-- 
2.20.1

