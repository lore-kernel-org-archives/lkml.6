Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB64208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB64208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeIXRid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32791 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728817AbeIXRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:32 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8OBXbjm011901;
        Mon, 24 Sep 2018 13:36:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mnav5arvx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Sep 2018 13:36:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E3E83D;
        Mon, 24 Sep 2018 11:36:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1EE545650;
        Mon, 24 Sep 2018 11:36:40 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 24 Sep
 2018 13:36:39 +0200
Received: from localhost (10.201.23.97) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 24 Sep 2018 13:36:39
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] drm/stm: ltdc: Solve issue on pixel clock & data enable polarity
Date:   Mon, 24 Sep 2018 13:36:21 +0200
Message-ID: <1537788981-21479-3-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537788981-21479-1-git-send-email-yannick.fertre@st.com>
References: <1537788981-21479-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong flags used for set the pixel clock & data enable polarities.
Add trace for polarities of hsync, vsync, data enabled & pixel clock.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 808d9fb..f671abc 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -517,7 +517,7 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct videomode vm;
 	u32 hsync, vsync, accum_hbp, accum_vbp, accum_act_w, accum_act_h;
 	u32 total_width, total_height;
-	u32 val;
+	u32 val = 0;
 
 	drm_display_mode_to_videomode(mode, &vm);
 
@@ -538,7 +538,22 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	total_height = accum_act_h + vm.vfront_porch;
 
 	/* Configures the HS, VS, DE and PC polarities. Default Active Low */
-	val = 0;
+	if (vm.flags & DISPLAY_FLAGS_HSYNC_LOW)
+		DRM_DEBUG_DRIVER("Horizontal Synchronization polarity is active low");
+	if (vm.flags & DISPLAY_FLAGS_HSYNC_HIGH)
+		DRM_DEBUG_DRIVER("Horizontal Synchronization polarity is active high");
+	if (vm.flags & DISPLAY_FLAGS_VSYNC_LOW)
+		DRM_DEBUG_DRIVER("Vertical Synchronization polarity is active low");
+	if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
+		DRM_DEBUG_DRIVER("Vertical Synchronization polarity is active high");
+	if (vm.flags & DISPLAY_FLAGS_DE_LOW)
+		DRM_DEBUG_DRIVER("Data Enable polarity is active low");
+	if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
+		DRM_DEBUG_DRIVER("Data Enable polarity is active high");
+	if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		DRM_DEBUG_DRIVER("Pixel clock polarity is active low");
+	if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+		DRM_DEBUG_DRIVER("Pixel clock polarity is active high");
 
 	if (vm.flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		val |= GCR_HSPOL;
@@ -546,10 +561,10 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		val |= GCR_VSPOL;
 
-	if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
+	if (vm.flags & DISPLAY_FLAGS_DE_LOW)
 		val |= GCR_DEPOL;
 
-	if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+	if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
 		val |= GCR_PCPOL;
 
 	reg_update_bits(ldev->regs, LTDC_GCR,
-- 
2.7.4

