Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0170C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8682087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8682087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJIPP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:15:28 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:33323 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeJIPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:15:27 -0400
X-IronPort-AV: E=Sophos;i="5.54,359,1534789800"; 
   d="scan'208";a="240332"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Oct 2018 13:23:28 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9040"; a="1605184"
Received: from mgottam-linux.qualcomm.com ([10.204.66.66])
  by ironmsg03-blr.qualcomm.com with ESMTP; 09 Oct 2018 13:23:26 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id E12202E3B; Tue,  9 Oct 2018 13:23:25 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH] media: venus: add support for selection rectangles
Date:   Tue,  9 Oct 2018 13:23:23 +0530
Message-Id: <1539071603-1588-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handles target type crop by setting the new active rectangle
to hardware. The new rectangle should be within YUV size.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 3f50cd0..754c19a 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -478,16 +478,31 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
 venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
 {
 	struct venus_inst *inst = to_inst(file);
+	int ret;
+	u32 buftype;
 
 	if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
 		return -EINVAL;
 
 	switch (s->target) {
 	case V4L2_SEL_TGT_CROP:
-		if (s->r.width != inst->out_width ||
-		    s->r.height != inst->out_height ||
+		if (s->r.width > inst->out_width ||
+		    s->r.height > inst->out_height ||
 		    s->r.top != 0 || s->r.left != 0)
 			return -EINVAL;
+		if (s->r.width != inst->width ||
+		    s->r.height != inst->height) {
+			buftype = HFI_BUFFER_OUTPUT;
+			ret = venus_helper_set_output_resolution(inst,
+								 s->r.width,
+								 s->r.height,
+								 buftype);
+			if (ret)
+				return ret;
+
+			inst->width = s->r.width;
+			inst->height = s->r.height;
+		}
 		break;
 	default:
 		return -EINVAL;
-- 
1.9.1

