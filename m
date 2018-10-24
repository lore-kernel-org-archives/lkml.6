Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBCC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAD12064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAD12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeJXWVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:21:00 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:4626 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbeJXWVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:21:00 -0400
X-IronPort-AV: E=Sophos;i="5.54,420,1534789800"; 
   d="scan'208";a="259607"
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Oct 2018 19:22:45 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9055"; a="4810413"
Received: from mgottam-linux.qualcomm.com ([10.204.66.66])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Oct 2018 19:22:45 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id 3E1463063; Wed, 24 Oct 2018 19:22:44 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH v2] media: venus: add support for key frame
Date:   Wed, 24 Oct 2018 19:22:42 +0530
Message-Id: <1540389162-30358-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When client requests for a keyframe, set the property
to hardware to generate the sync frame.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 45910172..6c2655d 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -79,8 +79,10 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct venus_inst *inst = ctrl_to_inst(ctrl);
 	struct venc_controls *ctr = &inst->controls.enc;
+	struct hfi_enable en = { .enable = 1 };
 	u32 bframes;
 	int ret;
+	u32 ptype;
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
@@ -173,6 +175,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 
 		ctr->num_b_frames = bframes;
 		break;
+	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
+		if (inst->streamon_out && inst->streamon_cap) {
+			ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
+			ret = hfi_session_set_property(inst, ptype, &en);
+
+			if (ret)
+				return ret;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -188,7 +199,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 27);
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 28);
 	if (ret)
 		return ret;
 
@@ -309,6 +320,9 @@ int venc_ctrl_init(struct venus_inst *inst)
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

