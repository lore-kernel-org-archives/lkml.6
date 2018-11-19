Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2534EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17772086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVNVRXi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17772086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbeKTC4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbeKTC4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD4720831;
        Mon, 19 Nov 2018 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645114;
        bh=mdKyZfKaagV3JDHBsq5e5GASGqyaoC4FWnFEfSKjDYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVNVRXi1ENOWfZzQDY/5MPYyFprgpLL2YXbPUWQLSaVbvM59wAC7lQP2H4v3lKku/
         ZWeiVCW3TIFkCEYhNcSGANDUPTCYNUEXWfLhfDFLOthFmhxLukdjXejiEomF/3CqLE
         cRUxH2oAhulxuK7C+/s8a7Fr6LlVhLZiwXxqjfqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/205] media: ov5640: fix mode change regression
Date:   Mon, 19 Nov 2018 17:25:48 +0100
Message-Id: <20181119162624.717749308@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugues Fruchet <hugues.fruchet@st.com>

[ Upstream commit fb98e29ff1ea5a8118265d11f0e03bc8608a49cb ]

fixes: 6949d864776e ("media: ov5640: do not change mode if format or frame interval is unchanged").

Symptom was fuzzy image because of JPEG default format
not being changed according to new format selected, fix this.
Init sequence initialises format to YUV422 UYVY but
sensor->fmt initial value was set to JPEG, fix this.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov5640.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -223,6 +223,7 @@ struct ov5640_dev {
 	int power_count;
 
 	struct v4l2_mbus_framefmt fmt;
+	bool pending_fmt_change;
 
 	const struct ov5640_mode_info *current_mode;
 	enum ov5640_frame_rate current_fr;
@@ -255,7 +256,7 @@ static inline struct v4l2_subdev *ctrl_t
  * should be identified and removed to speed register load time
  * over i2c.
  */
-
+/* YUV422 UYVY VGA@30fps */
 static const struct reg_value ov5640_init_setting_30fps_VGA[] = {
 	{0x3103, 0x11, 0, 0}, {0x3008, 0x82, 0, 5}, {0x3008, 0x42, 0, 0},
 	{0x3103, 0x03, 0, 0}, {0x3017, 0x00, 0, 0}, {0x3018, 0x00, 0, 0},
@@ -1968,9 +1969,12 @@ static int ov5640_set_fmt(struct v4l2_su
 
 	if (new_mode != sensor->current_mode) {
 		sensor->current_mode = new_mode;
-		sensor->fmt = *mbus_fmt;
 		sensor->pending_mode_change = true;
 	}
+	if (mbus_fmt->code != sensor->fmt.code) {
+		sensor->fmt = *mbus_fmt;
+		sensor->pending_fmt_change = true;
+	}
 out:
 	mutex_unlock(&sensor->lock);
 	return ret;
@@ -2544,10 +2548,13 @@ static int ov5640_s_stream(struct v4l2_s
 			ret = ov5640_set_mode(sensor, sensor->current_mode);
 			if (ret)
 				goto out;
+		}
 
+		if (enable && sensor->pending_fmt_change) {
 			ret = ov5640_set_framefmt(sensor, &sensor->fmt);
 			if (ret)
 				goto out;
+			sensor->pending_fmt_change = false;
 		}
 
 		if (sensor->ep.bus_type == V4L2_MBUS_CSI2)
@@ -2642,9 +2649,14 @@ static int ov5640_probe(struct i2c_clien
 		return -ENOMEM;
 
 	sensor->i2c_client = client;
+
+	/*
+	 * default init sequence initialize sensor to
+	 * YUV422 UYVY VGA@30fps
+	 */
 	fmt = &sensor->fmt;
-	fmt->code = ov5640_formats[0].code;
-	fmt->colorspace = ov5640_formats[0].colorspace;
+	fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
 	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
 	fmt->quantization = V4L2_QUANTIZATION_FULL_RANGE;
 	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
@@ -2656,7 +2668,6 @@ static int ov5640_probe(struct i2c_clien
 	sensor->current_fr = OV5640_30_FPS;
 	sensor->current_mode =
 		&ov5640_mode_data[OV5640_30_FPS][OV5640_MODE_VGA_640_480];
-	sensor->pending_mode_change = true;
 
 	sensor->ae_target = 52;
 


