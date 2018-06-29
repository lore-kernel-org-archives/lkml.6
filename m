Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB76C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F14E27E31
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F14E27E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755307AbeF2LWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:22:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38782 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753847AbeF2LWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:22:40 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5TBJ0jr009754;
        Fri, 29 Jun 2018 13:22:31 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jwk7585t2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Jun 2018 13:22:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E8D738;
        Fri, 29 Jun 2018 11:22:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A5BE2937;
        Fri, 29 Jun 2018 11:22:29 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Jun
 2018 13:22:29 +0200
Received: from localhost (10.201.23.68) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Jun 2018 13:22:28
 +0200
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: ltdc: filter mode pixel clock vs pad constraint
Date:   Fri, 29 Jun 2018 13:22:22 +0200
Message-ID: <1530271342-5532-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filter the requested mode pixel clock frequency according
to the pad maximum supported frequency.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 16 ++++++++++++----
 drivers/gpu/drm/stm/ltdc.h |  1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 00e3262..96d20c2 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -491,6 +491,14 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 	int target_max = target + CLK_TOLERANCE_HZ;
 	int result;
 
+	result = clk_round_rate(ldev->pixel_clk, target);
+
+	DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
+
+	/* Filter modes according to the max frequency supported by the pads */
+	if (result > ldev->caps.pad_max_freq_hz)
+		return MODE_CLOCK_HIGH;
+
 	/*
 	 * Accept all "preferred" modes:
 	 * - this is important for panels because panel clock tolerances are
@@ -502,10 +510,6 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (mode->type & DRM_MODE_TYPE_PREFERRED)
 		return MODE_OK;
 
-	result = clk_round_rate(ldev->pixel_clk, target);
-
-	DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
-
 	/*
 	 * Filter modes according to the clock value, particularly useful for
 	 * hdmi modes that require precise pixel clocks.
@@ -1039,11 +1043,15 @@ static int ltdc_get_caps(struct drm_device *ddev)
 		 * does not work on 2nd layer.
 		 */
 		ldev->caps.non_alpha_only_l1 = true;
+		ldev->caps.pad_max_freq_hz = 90000000;
+		if (ldev->caps.hw_version == HWVER_10200)
+			ldev->caps.pad_max_freq_hz = 65000000;
 		break;
 	case HWVER_20101:
 		ldev->caps.reg_ofs = REG_OFS_4;
 		ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a1;
 		ldev->caps.non_alpha_only_l1 = false;
+		ldev->caps.pad_max_freq_hz = 150000000;
 		break;
 	default:
 		return -ENODEV;
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index c14e4db..0294d38 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -20,6 +20,7 @@ struct ltdc_caps {
 	u32 bus_width;		/* bus width (32 or 64 bits) */
 	const u32 *pix_fmt_hw;	/* supported pixel formats */
 	bool non_alpha_only_l1; /* non-native no-alpha formats on layer 1 */
+	int pad_max_freq_hz;	/* max frequency supported by pad */
 };
 
 #define LTDC_MAX_LAYER	4
-- 
1.9.1

