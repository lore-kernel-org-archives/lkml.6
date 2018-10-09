Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4552087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4552087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJIPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:13:29 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:36315 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeJIPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:13:29 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2018 11:13:27 EDT
X-IronPort-AV: E=Sophos;i="5.54,359,1534789800"; 
   d="scan'208";a="240321"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Oct 2018 13:21:28 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9040"; a="1605172"
Received: from mgottam-linux.qualcomm.com ([10.204.66.66])
  by ironmsg03-blr.qualcomm.com with ESMTP; 09 Oct 2018 13:21:26 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id A540D2E3B; Tue,  9 Oct 2018 13:21:25 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH] media: venus: handle peak bitrate set property
Date:   Tue,  9 Oct 2018 13:21:23 +0530
Message-Id: <1539071483-1371-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max bitrate property is not supported for venus version 4xx.
Add a version check for the same.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index ef11495..3f50cd0 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -757,18 +757,20 @@ static int venc_set_properties(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
-	if (!ctr->bitrate_peak)
-		bitrate *= 2;
-	else
-		bitrate = ctr->bitrate_peak;
+	if (!IS_V4(inst->core)) {
+		if (!ctr->bitrate_peak)
+			bitrate *= 2;
+		else
+			bitrate = ctr->bitrate_peak;
 
-	ptype = HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
-	brate.bitrate = bitrate;
-	brate.layer_id = 0;
+		ptype = HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
+		brate.bitrate = bitrate;
+		brate.layer_id = 0;
 
-	ret = hfi_session_set_property(inst, ptype, &brate);
-	if (ret)
-		return ret;
+		ret = hfi_session_set_property(inst, ptype, &brate);
+		if (ret)
+			return ret;
+	}
 
 	if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_H264) {
 		profile = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_H264_PROFILE,
-- 
1.9.1

