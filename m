Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53010C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6920817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA6920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeKZVGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:06:38 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:33473 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbeKZVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:06:38 -0500
X-IronPort-AV: E=Sophos;i="5.56,281,1539628200"; 
   d="scan'208";a="253930"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Nov 2018 15:42:57 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9088"; a="2185948"
Received: from mgottam-linux.qualcomm.com ([10.204.65.20])
  by ironmsg03-blr.qualcomm.com with ESMTP; 26 Nov 2018 15:42:57 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id D0B1231E8; Mon, 26 Nov 2018 15:42:55 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH v3] media: venus: amend buffer size for bitstream plane
Date:   Mon, 26 Nov 2018 15:42:53 +0530
Message-Id: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept the buffer size requested by client and compare it
against driver calculated size and set the maximum to
bitstream plane.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index ce85962..e43dd3d 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -303,6 +303,7 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
 	struct v4l2_plane_pix_format *pfmt = pixmp->plane_fmt;
 	const struct venus_format *fmt;
+	u32 sizeimage;
 
 	memset(pfmt[0].reserved, 0, sizeof(pfmt[0].reserved));
 	memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
@@ -334,9 +335,10 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 	pixmp->num_planes = fmt->num_planes;
 	pixmp->flags = 0;
 
-	pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
-						     pixmp->width,
-						     pixmp->height);
+	sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
+					     pixmp->width,
+					     pixmp->height);
+	pfmt[0].sizeimage = max(ALIGN(pfmt[0].sizeimage, SZ_4K), sizeimage);
 
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		pfmt[0].bytesperline = ALIGN(pixmp->width, 128);
@@ -408,8 +410,10 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
 
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		inst->fmt_out = fmt;
-	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		inst->fmt_cap = fmt;
+		inst->output_buf_size = pixmp->plane_fmt[0].sizeimage;
+	}
 
 	return 0;
 }
@@ -908,6 +912,7 @@ static int venc_queue_setup(struct vb2_queue *q,
 		sizes[0] = venus_helper_get_framesz(inst->fmt_cap->pixfmt,
 						    inst->width,
 						    inst->height);
+		sizes[0] = max(sizes[0], inst->output_buf_size);
 		inst->output_buf_size = sizes[0];
 		break;
 	default:
-- 
1.9.1

