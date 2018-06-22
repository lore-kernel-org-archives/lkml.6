Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D161AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9466D2451F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9466D2451F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbeFVPjr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:39:47 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:46425 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933955AbeFVPeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:34:03 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 459E14F886;
        Fri, 22 Jun 2018 18:33:59 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 10/32] media: camss: csid: Configure data type and decode format properly
Date:   Fri, 22 Jun 2018 18:33:19 +0300
Message-Id: <1529681621-9682-11-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
References: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSID decodes the input data stream. When the input comes from
the Test Generator the format of the stream is set on the source
media pad. When the input comes from the CSIPHY the format is the
one on the sink media pad. Use the proper format for each case.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index c0fef17..3cde07e 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -384,9 +384,6 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 		    !media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
 			return -ENOLINK;
 
-		dt = csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SRC].code)->
-								data_type;
-
 		if (tg->enabled) {
 			/* Config Test Generator */
 			struct v4l2_mbus_framefmt *f =
@@ -408,6 +405,9 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_0(0));
 
+			dt = csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->data_type;
+
 			/* 5:0 data type */
 			val = dt;
 			writel_relaxed(val, csid->base +
@@ -417,6 +417,9 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 			val = tg->payload_mode;
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_2(0));
+
+			df = csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->decode_format;
 		} else {
 			struct csid_phy_config *phy = &csid->phy;
 
@@ -431,13 +434,16 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 
 			writel_relaxed(val,
 				       csid->base + CAMSS_CSID_CORE_CTRL_1);
+
+			dt = csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SINK].code)->data_type;
+			df = csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SINK].code)->decode_format;
 		}
 
 		/* Config LUT */
 
 		dt_shift = (cid % 4) * 8;
-		df = csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SINK].code)->
-								decode_format;
 
 		val = readl_relaxed(csid->base + CAMSS_CSID_CID_LUT_VC_n(vc));
 		val &= ~(0xff << dt_shift);
-- 
2.7.4

