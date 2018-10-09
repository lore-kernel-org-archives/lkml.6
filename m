Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4159C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610A12087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610A12087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJIPP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:15:58 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:35662 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbeJIPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:15:58 -0400
X-IronPort-AV: E=Sophos;i="5.54,359,1534789800"; 
   d="scan'208";a="240336"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Oct 2018 13:24:02 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9040"; a="1605185"
Received: from mgottam-linux.qualcomm.com ([10.204.66.66])
  by ironmsg03-blr.qualcomm.com with ESMTP; 09 Oct 2018 13:24:01 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id 6DA732E3B; Tue,  9 Oct 2018 13:24:00 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH] media: venus: add support for key frame
Date:   Tue,  9 Oct 2018 13:23:54 +0530
Message-Id: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When client requests for a keyframe, set the property
to hardware to generate the sync frame.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 45910172..f332c8e 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct venc_controls *ctr = &inst->controls.enc;
 	u32 bframes;
 	int ret;
+	void *ptr;
+	u32 ptype;
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
@@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 
 		ctr->num_b_frames = bframes;
 		break;
+	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
+		ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
+		ret = hfi_session_set_property(inst, ptype, ptr);
+
+		if (ret)
+			return ret;
+
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -309,6 +319,9 @@ int venc_ctrl_init(struct venus_inst *inst)
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_H264_I_PERIOD, 0, (1 << 16) - 1, 1, 0);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
+
 	ret = inst->ctrl_handler.error;
 	if (ret)
 		goto err;
-- 
1.9.1

