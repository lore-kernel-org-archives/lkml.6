Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E2BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8102402F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8102402F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754040AbeGENe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:34:29 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41376 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753836AbeGENdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:23 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id F11D7CD64;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 28/34] media: camss: csid: Different format support on source pad
Date:   Thu,  5 Jul 2018 16:32:59 +0300
Message-Id: <1530797585-8555-29-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually the format on the source pad is the same as on the sink pad.
However the CSID is able to do some format conversions. To support
this make the format on the source pad selectable amongst a list
of formats. This list can be different for each sink pad format.
This is still not used but will be when the format conversions
are implemented.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 69 +++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 18420e3..8fd7909 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -300,6 +300,47 @@ static const struct csid_format csid_formats_8x96[] = {
 	}
 };
 
+static u32 csid_find_code(u32 *code, unsigned int n_code,
+			  unsigned int index, u32 req_code)
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
+static u32 csid_src_pad_code(struct csid_device *csid, u32 sink_code,
+			     unsigned int index, u32 src_req_code)
+{
+	if (csid->camss->version == CAMSS_8x16) {
+		if (index > 0)
+			return 0;
+
+		return sink_code;
+	} else if (csid->camss->version == CAMSS_8x96) {
+		switch (sink_code) {
+		default:
+			if (index > 0)
+				return 0;
+
+			return sink_code;
+		}
+	} else {
+		return 0;
+	}
+}
+
 static const struct csid_format *csid_get_fmt_entry(
 					const struct csid_format *formats,
 					unsigned int nformat,
@@ -667,15 +708,15 @@ static void csid_try_format(struct csid_device *csid,
 
 	case MSM_CSID_PAD_SRC:
 		if (csid->testgen_mode->cur.val == 0) {
-			/* Test generator is disabled, keep pad formats */
-			/* in sync - set and return a format same as sink pad */
-			struct v4l2_mbus_framefmt format;
+			/* Test generator is disabled, */
+			/* keep pad formats in sync */
+			u32 code = fmt->code;
 
-			format = *__csid_get_format(csid, cfg,
-						    MSM_CSID_PAD_SINK, which);
-			*fmt = format;
+			*fmt = *__csid_get_format(csid, cfg,
+						      MSM_CSID_PAD_SINK, which);
+			fmt->code = csid_src_pad_code(csid, fmt->code, 0, code);
 		} else {
-			/* Test generator is enabled, set format on source*/
+			/* Test generator is enabled, set format on source */
 			/* pad to allow test generator usage */
 
 			for (i = 0; i < csid->nformats; i++)
@@ -709,7 +750,6 @@ static int csid_enum_mbus_code(struct v4l2_subdev *sd,
 			       struct v4l2_subdev_mbus_code_enum *code)
 {
 	struct csid_device *csid = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
 
 	if (code->pad == MSM_CSID_PAD_SINK) {
 		if (code->index >= csid->nformats)
@@ -718,13 +758,16 @@ static int csid_enum_mbus_code(struct v4l2_subdev *sd,
 		code->code = csid->formats[code->index].code;
 	} else {
 		if (csid->testgen_mode->cur.val == 0) {
-			if (code->index > 0)
-				return -EINVAL;
+			struct v4l2_mbus_framefmt *sink_fmt;
 
-			format = __csid_get_format(csid, cfg, MSM_CSID_PAD_SINK,
-						   code->which);
+			sink_fmt = __csid_get_format(csid, cfg,
+						     MSM_CSID_PAD_SINK,
+						     code->which);
 
-			code->code = format->code;
+			code->code = csid_src_pad_code(csid, sink_fmt->code,
+						       code->index, 0);
+			if (!code->code)
+				return -EINVAL;
 		} else {
 			if (code->index >= csid->nformats)
 				return -EINVAL;
-- 
2.7.4

