Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2752FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF74206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF74206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeLDOXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:23:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33219 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLDOXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:03 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C069720E31; Tue,  4 Dec 2018 15:22:59 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0153B20A58;
        Tue,  4 Dec 2018 15:22:38 +0100 (CET)
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
Subject: [PATCH v3 01/21] drm/fourcc: Add format info helpers for checking YUV planes disposition
Date:   Tue,  4 Dec 2018 15:21:58 +0100
Message-Id: <20181204142218.16284-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is often useful to check whether the DRM format info retrieved from
the DRM framebuffer matches a specific YUV planes disposition.

This introduces helpers to quickly check that a provided format info
matches a YUV format with a specific disposition, in commonly-used
terminology.

The intent of providing helpers taking the format info instead of the
fourcc alone is to avoid the overhead of iterating through all formats
when the whole format info structure is available. As a result, these
helpers are very simple so they are made inline.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 include/drm/drm_fourcc.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index bcb389f04618..01cd353d9302 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -143,6 +143,48 @@ struct drm_format_name_buf {
 	char str[32];
 };
 
+/**
+ * drm_format_info_is_yuv_packed - check that the format info matches a YUV
+ * format with data laid in a single plane
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a packed YUV format.
+ */
+static inline bool
+drm_format_info_is_yuv_packed(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->num_planes == 1;
+}
+
+/**
+ * drm_format_info_is_yuv_semiplanar - check that the format info matches a YUV
+ * format with data laid in two planes (luminance and chrominance)
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a semiplanar YUV format.
+ */
+static inline bool
+drm_format_info_is_yuv_semiplanar(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->num_planes == 2;
+}
+
+/**
+ * drm_format_info_is_yuv_planar - check that the format info matches a YUV
+ * format with data laid in three planes (one for each YUV component)
+ * @info: format info
+ *
+ * Returns:
+ * A boolean indicating whether the format info matches a planar YUV format.
+ */
+static inline bool
+drm_format_info_is_yuv_planar(const struct drm_format_info *info)
+{
+	return info->is_yuv && info->num_planes == 3;
+}
+
 const struct drm_format_info *__drm_format_info(u32 format);
 const struct drm_format_info *drm_format_info(u32 format);
 const struct drm_format_info *
-- 
2.19.2

