Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA8C04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C642080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C642080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeKRDRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:17:08 -0500
Received: from kozue.soulik.info ([108.61.200.231]:45118 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKRDRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:17:08 -0500
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Nov 2018 22:17:05 EST
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id EAE7A1012A2;
        Sun, 18 Nov 2018 01:54:37 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, linux-kernel@vger.kernel.org,
        hjc@rock-chips.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, Randy Li <ayaka@soulik.info>
Subject: [PATCH v4 1/2] drm/fourcc: add a 10bits fully packed variant of NV12
Date:   Sun, 18 Nov 2018 00:53:45 +0800
Message-Id: <20181117165346.25091-2-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181117165346.25091-1-ayaka@soulik.info>
References: <20181117165346.25091-1-ayaka@soulik.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pixel format is a fully packed and 10bits variant of NV12.
A luma pixel would take 10bits in memory, without any
filled bits between pixels in a stride.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index f523948c82b1..76d3ce314f31 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -237,6 +237,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_X0L2,		.depth = 0,  .num_planes = 1,
 		  .char_per_block = { 8, 0, 0 }, .block_w = { 2, 0, 0 }, .block_h = { 2, 0, 0 },
 		  .hsub = 2, .vsub = 2, .is_yuv = true },
+		{ .format = DRM_FORMAT_NV12_10LE40,	.depth = 0,  .num_planes = 2, .cpp = { 1, 2, 0 }, .hsub = 2, .vsub = 2 },
 	};
 
 	unsigned int i;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e7e48f1f4a74..5de5aff83d85 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -193,6 +193,14 @@ extern "C" {
 #define DRM_FORMAT_NV61		fourcc_code('N', 'V', '6', '1') /* 2x1 subsampled Cb:Cr plane */
 #define DRM_FORMAT_NV24		fourcc_code('N', 'V', '2', '4') /* non-subsampled Cr:Cb plane */
 #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
+/*
+ * A fully packed  2 plane YCbCr
+ * Y1 0-9, Y2 10-19, Y3 20-29, Y4 20-39
+ * ....
+ * U1V1: 0-19, U2V2: 20-39
+ */
+#define DRM_FORMAT_NV12_10LE40	fourcc_code('R', 'K', '2', '0') /* 2x2 subsampled Cr:Cb plane */
+
 
 /*
  * 3 plane YCbCr
-- 
2.14.5

