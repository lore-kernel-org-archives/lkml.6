Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236DF20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236DF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeLDOZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:25:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33229 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeLDOXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C22BB20A58; Tue,  4 Dec 2018 15:22:59 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3E11F20A59;
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
Subject: [PATCH v3 02/21] drm/fourcc: Add format info helpers for checking YUV sub-sampling
Date:   Tue,  4 Dec 2018 15:21:59 +0100
Message-Id: <20181204142218.16284-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
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
2.19.2

