Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0566C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7DB24010
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7DB24010
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeGENfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:35:06 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41370 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753828AbeGENdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:23 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id E0FCFCD62;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 26/34] media: camss: vfe: Different format support on source pad
Date:   Thu,  5 Jul 2018 16:32:57 +0300
Message-Id: <1530797585-8555-27-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the format selection on the source pad. Make the format
on the source pad selectable amongst a list of formats. This
list can be different for each sink pad format.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 172 ++++++++++++++++++++------
 1 file changed, 135 insertions(+), 37 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 6fc2be5..b3d2cbf 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -127,6 +127,131 @@ static u8 vfe_get_bpp(const struct vfe_format *formats,
 	return formats[0].bpp;
 }
 
+static u32 vfe_find_code(u32 *code, unsigned int n_code,
+			 unsigned int index, u32 req_code)
+{
+	int i;
+
+	if (!req_code && (index >= n_code))
+		return 0;
+
+	for (i = 0; i < n_code; i++)
+		if (req_code) {
+			if (req_code == code[i])
+				return req_code;
+		} else {
+			if (i == index)
+				return code[i];
+		}
+
+	return code[0];
+}
+
+static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
+			    unsigned int index, u32 src_req_code)
+{
+	struct vfe_device *vfe = to_vfe(line);
+
+	if (vfe->camss->version == CAMSS_8x16)
+		switch (sink_code) {
+		case MEDIA_BUS_FMT_YUYV8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_YUYV8_2X8,
+				MEDIA_BUS_FMT_YUYV8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		case MEDIA_BUS_FMT_YVYU8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_YVYU8_2X8,
+				MEDIA_BUS_FMT_YVYU8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		case MEDIA_BUS_FMT_UYVY8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_UYVY8_2X8,
+				MEDIA_BUS_FMT_UYVY8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		case MEDIA_BUS_FMT_VYUY8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_VYUY8_2X8,
+				MEDIA_BUS_FMT_VYUY8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		default:
+			if (index > 0)
+				return 0;
+
+			return sink_code;
+		}
+	else if (vfe->camss->version == CAMSS_8x96)
+		switch (sink_code) {
+		case MEDIA_BUS_FMT_YUYV8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_YUYV8_2X8,
+				MEDIA_BUS_FMT_YUYV8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		case MEDIA_BUS_FMT_YVYU8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_YVYU8_2X8,
+				MEDIA_BUS_FMT_YVYU8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		case MEDIA_BUS_FMT_UYVY8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_UYVY8_2X8,
+				MEDIA_BUS_FMT_UYVY8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		case MEDIA_BUS_FMT_VYUY8_2X8:
+		{
+			u32 src_code[] = {
+				MEDIA_BUS_FMT_VYUY8_2X8,
+				MEDIA_BUS_FMT_VYUY8_1_5X8,
+			};
+
+			return vfe_find_code(src_code, ARRAY_SIZE(src_code),
+					     index, src_req_code);
+		}
+		default:
+			if (index > 0)
+				return 0;
+
+			return sink_code;
+		}
+	else
+		return 0;
+}
+
 /*
  * vfe_reset - Trigger reset on VFE module and wait to complete
  * @vfe: VFE device
@@ -1387,11 +1512,11 @@ static void vfe_try_format(struct vfe_line *line,
 
 	case MSM_VFE_PAD_SRC:
 		/* Set and return a format same as sink pad */
-
 		code = fmt->code;
 
-		*fmt = *__vfe_get_format(line, cfg, MSM_VFE_PAD_SINK,
-					 which);
+		*fmt = *__vfe_get_format(line, cfg, MSM_VFE_PAD_SINK, which);
+
+		fmt->code = vfe_src_pad_code(line, fmt->code, 0, code);
 
 		if (line->id == VFE_LINE_PIX) {
 			struct v4l2_rect *rect;
@@ -1400,34 +1525,6 @@ static void vfe_try_format(struct vfe_line *line,
 
 			fmt->width = rect->width;
 			fmt->height = rect->height;
-
-			switch (fmt->code) {
-			case MEDIA_BUS_FMT_YUYV8_2X8:
-				if (code == MEDIA_BUS_FMT_YUYV8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_YUYV8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_YUYV8_2X8;
-				break;
-			case MEDIA_BUS_FMT_YVYU8_2X8:
-				if (code == MEDIA_BUS_FMT_YVYU8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_YVYU8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_YVYU8_2X8;
-				break;
-			case MEDIA_BUS_FMT_UYVY8_2X8:
-			default:
-				if (code == MEDIA_BUS_FMT_UYVY8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_UYVY8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
-				break;
-			case MEDIA_BUS_FMT_VYUY8_2X8:
-				if (code == MEDIA_BUS_FMT_VYUY8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_VYUY8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_VYUY8_2X8;
-				break;
-			}
 		}
 
 		break;
@@ -1531,7 +1628,6 @@ static int vfe_enum_mbus_code(struct v4l2_subdev *sd,
 			      struct v4l2_subdev_mbus_code_enum *code)
 {
 	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
 
 	if (code->pad == MSM_VFE_PAD_SINK) {
 		if (code->index >= line->nformats)
@@ -1539,13 +1635,15 @@ static int vfe_enum_mbus_code(struct v4l2_subdev *sd,
 
 		code->code = line->formats[code->index].code;
 	} else {
-		if (code->index > 0)
-			return -EINVAL;
+		struct v4l2_mbus_framefmt *sink_fmt;
 
-		format = __vfe_get_format(line, cfg, MSM_VFE_PAD_SINK,
-					  code->which);
+		sink_fmt = __vfe_get_format(line, cfg, MSM_VFE_PAD_SINK,
+					    code->which);
 
-		code->code = format->code;
+		code->code = vfe_src_pad_code(line, sink_fmt->code,
+					      code->index, 0);
+		if (!code->code)
+			return -EINVAL;
 	}
 
 	return 0;
-- 
2.7.4

