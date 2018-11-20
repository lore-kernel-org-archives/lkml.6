Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B68C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C3D206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C3D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeKUDsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:48:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34377 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeKUDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:48:02 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gP9ej-0006rb-Vs; Tue, 20 Nov 2018 17:17:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/amd/display: fix dereference of pointer fs_params before it is null checked
Date:   Tue, 20 Nov 2018 17:17:45 +0000
Message-Id: <20181120171745.13812-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there are several instances of pointer fs_params being
dereferenced before fs_params is being null checked.  Fix this by
only dereferencing fs_params after the null check.

Detected by CoverityScan, CID#1475565 ("Dereference before null check")

Fixes: e1e8a020c6b8 ("drm/amd/display: Add support for Freesync 2 HDR and Content to Display Mapping")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../drm/amd/display/modules/color/color_gamma.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 7480f072c375..bbecbaefb741 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -813,20 +813,26 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 	const struct hw_x_point *coord_x = coordinate_x;
 	struct fixed31_32 scaledX = dc_fixpt_zero;
 	struct fixed31_32 scaledX1 = dc_fixpt_zero;
-	struct fixed31_32 max_display = dc_fixpt_from_int(fs_params->max_display);
-	struct fixed31_32 min_display = dc_fixpt_from_fraction(fs_params->min_display, 10000);
-	struct fixed31_32 max_content = dc_fixpt_from_int(fs_params->max_content);
-	struct fixed31_32 min_content = dc_fixpt_from_fraction(fs_params->min_content, 10000);
+	struct fixed31_32 max_display;
+	struct fixed31_32 min_display;
+	struct fixed31_32 max_content;
+	struct fixed31_32 min_content;
 	struct fixed31_32 clip = dc_fixpt_one;
 	struct fixed31_32 output;
 	bool use_eetf = false;
 	bool is_clipped = false;
-	struct fixed31_32 sdr_white_level = dc_fixpt_from_int(fs_params->sdr_white_level);
+	struct fixed31_32 sdr_white_level;
 
 	if (fs_params == NULL || fs_params->max_content == 0 ||
 			fs_params->max_display == 0)
 		return false;
 
+	max_display = dc_fixpt_from_int(fs_params->max_display);
+	min_display = dc_fixpt_from_fraction(fs_params->min_display, 10000);
+	max_content = dc_fixpt_from_int(fs_params->max_content);
+	min_content = dc_fixpt_from_fraction(fs_params->min_content, 10000);
+	sdr_white_level = dc_fixpt_from_int(fs_params->sdr_white_level);
+
 	if (fs_params->min_display > 1000) // cap at 0.1 at the bottom
 		min_display = dc_fixpt_from_fraction(1, 10);
 	if (fs_params->max_display < 100) // cap at 100 at the top
-- 
2.19.1

