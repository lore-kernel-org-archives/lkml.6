Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC92086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FC92086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeKIRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:18:38 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:27279 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbeKIRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:18:38 -0500
X-IronPort-AV: E=Sophos;i="5.54,482,1534789800"; 
   d="scan'208";a="280333"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Nov 2018 13:09:05 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9071"; a="1984371"
Received: from mgottam-linux.qualcomm.com ([10.204.65.20])
  by ironmsg03-blr.qualcomm.com with ESMTP; 09 Nov 2018 13:09:05 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id D11F430E6; Fri,  9 Nov 2018 13:09:03 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH v2] media: venus: add support for selection rectangles
Date:   Fri,  9 Nov 2018 13:09:01 +0530
Message-Id: <1541749141-6989-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handles target type crop by setting the new active rectangle
to hardware. The new rectangle should be within YUV size.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index ce85962..d26c129 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -478,16 +478,34 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
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
-		    s->r.top != 0 || s->r.left != 0)
-			return -EINVAL;
+		if (s->r.left != 0) {
+			s->r.width += s->r.left;
+			s->r.left = 0;
+		}
+
+		if (s->r.top != 0) {
+			s->r.height += s->r.top;
+			s->r.top = 0;
+		}
+
+		if (s->r.width > inst->width)
+			s->r.width = inst->width;
+		else
+			inst->width = s->r.width;
+
+		if (s->r.height > inst->height)
+			s->r.height = inst->height;
+		else
+			inst->height = s->r.height;
+
 		break;
 	default:
 		return -EINVAL;
-- 
1.9.1

