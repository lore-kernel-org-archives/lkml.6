Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038AD2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038AD2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeIREaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:30:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48286 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeIREaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:30:55 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C44C0C77;
        Mon, 17 Sep 2018 23:01:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 036/126] media: camss: csid: Configure data type and decode format properly
Date:   Tue, 18 Sep 2018 00:41:24 +0200
Message-Id: <20180917211707.140164724@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todor Tomov <todor.tomov@linaro.org>

[ Upstream commit c628e78899ff8006b5f9d8206da54ed3bb994342 ]

The CSID decodes the input data stream. When the input comes from
the Test Generator the format of the stream is set on the source
media pad. When the input comes from the CSIPHY the format is the
one on the sink media pad. Use the proper format for each case.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/camss-8x16/camss-csid.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/media/platform/qcom/camss-8x16/camss-csid.c
+++ b/drivers/media/platform/qcom/camss-8x16/camss-csid.c
@@ -392,9 +392,6 @@ static int csid_set_stream(struct v4l2_s
 		    !media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
 			return -ENOLINK;
 
-		dt = csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SRC].code)->
-								data_type;
-
 		if (tg->enabled) {
 			/* Config Test Generator */
 			struct v4l2_mbus_framefmt *f =
@@ -416,6 +413,9 @@ static int csid_set_stream(struct v4l2_s
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_0(0));
 
+			dt = csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->data_type;
+
 			/* 5:0 data type */
 			val = dt;
 			writel_relaxed(val, csid->base +
@@ -425,6 +425,9 @@ static int csid_set_stream(struct v4l2_s
 			val = tg->payload_mode;
 			writel_relaxed(val, csid->base +
 				       CAMSS_CSID_TG_DT_n_CGG_2(0));
+
+			df = csid_get_fmt_entry(
+				csid->fmt[MSM_CSID_PAD_SRC].code)->decode_format;
 		} else {
 			struct csid_phy_config *phy = &csid->phy;
 
@@ -439,13 +442,16 @@ static int csid_set_stream(struct v4l2_s
 
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


