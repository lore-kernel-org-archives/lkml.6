Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA26C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD020820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECD020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502858AbeKWUNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:13:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49275 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390514AbeKWUKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 90BD920DD6; Fri, 23 Nov 2018 10:26:48 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7FA3420DD7;
        Fri, 23 Nov 2018 10:26:30 +0100 (CET)
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
Subject: [PATCH v2 12/43] drm/fourcc: Add format helpers for checking YUV sub-sampling
Date:   Fri, 23 Nov 2018 10:24:44 +0100
Message-Id: <20181123092515.2511-13-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces new format helpers that use the previously-introduced
format info helpers for checking YUV sub-sampling.

Only the format fourcc is required by these helpers and the formats are
iterated from the list.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/drm_fourcc.c | 105 +++++++++++++++++++++++++++++++++++
 include/drm/drm_fourcc.h     |   5 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index b56e773f9f63..6d395c586ad5 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -492,6 +492,111 @@ bool drm_format_is_yuv_planar(uint32_t format)
 }
 EXPORT_SYMBOL(drm_format_is_yuv_planar);
 
+/**
+ * drm_format_is_yuv_sampling_410 - check that the format is a YUV format with
+ * 4:1:0 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:1:0
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_410(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_410(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_410);
+
+/**
+ * drm_format_is_yuv_sampling_411 - check that the format is a YUV format with
+ * 4:1:1 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:1:1
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_411(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_411(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_411);
+
+/**
+ * drm_format_is_yuv_sampling_420 - check that the format is a YUV format with
+ * 4:2:0 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:2:0
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_420(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_420(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_420);
+
+/**
+ * drm_format_is_yuv_sampling_422 - check that the format is a YUV format with
+ * 4:2:2 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:2:2
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_422(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_422(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_422);
+
+/**
+ * drm_format_is_yuv_sampling_444 - check that the format is a YUV format with
+ * 4:4:4 sub-sampling
+ * @format: pixel format
+ *
+ * Returns:
+ * A boolean indicating whether the format is a YUV format with 4:4:4
+ * sub-sampling.
+ */
+bool drm_format_is_yuv_sampling_444(uint32_t format)
+{
+	const struct drm_format_info *info;
+
+	info = drm_format_info(format);
+	if (!info)
+		return false;
+
+	return drm_format_info_is_yuv_sampling_444(info);
+}
+EXPORT_SYMBOL(drm_format_is_yuv_sampling_444);
+
 /**
  * drm_format_info_block_width - width in pixels of block.
  * @info: pixel format info
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index d170b7b323f7..cf082d8b6ad4 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -278,6 +278,11 @@ bool drm_format_is_yuv(uint32_t format);
 bool drm_format_is_yuv_packed(uint32_t format);
 bool drm_format_is_yuv_semiplanar(uint32_t format);
 bool drm_format_is_yuv_planar(uint32_t format);
+bool drm_format_is_yuv_sampling_410(uint32_t format);
+bool drm_format_is_yuv_sampling_411(uint32_t format);
+bool drm_format_is_yuv_sampling_420(uint32_t format);
+bool drm_format_is_yuv_sampling_422(uint32_t format);
+bool drm_format_is_yuv_sampling_444(uint32_t format);
 unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
-- 
2.19.1

