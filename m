Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C7ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3BA2086C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wlhI3oO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3BA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeKDXHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbeKDXHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E49D20868;
        Sun,  4 Nov 2018 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339557;
        bh=riIHcRL70OuaNbGnZ9hkWU4cP1Idaoz5og/jlexgcZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wlhI3oO5RfgojUu1bVVb5RErbA7OpMZVR/7739m7aFauXZAVxsaKiE/K4A/hf6pRo
         xyhGdyf4A8gGEtEsGk6DjAqozBQgtQoJE4BshKLzUXKmIHHkfbmuWOHRD15aYg1Hv1
         FZhcWHsWw5OIjRMrH2fmTGCLP3nZdmJHiMsEmFYQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hugues Fruchet <hugues.fruchet@st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 54/57] media: ov5640: fix mode change regression
Date:   Sun,  4 Nov 2018 08:51:41 -0500
Message-Id: <20181104135144.88324-54-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/media/i2c/ov5640.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 071f4bc240ca..2ddd86ddf649 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -223,6 +223,7 @@ struct ov5640_dev {
 	int power_count;
 
 	struct v4l2_mbus_framefmt fmt;
+	bool pending_fmt_change;
 
 	const struct ov5640_mode_info *current_mode;
 	enum ov5640_frame_rate current_fr;
@@ -255,7 +256,7 @@ static inline struct v4l2_subdev *ctrl_to_sd(struct v4l2_ctrl *ctrl)
  * should be identified and removed to speed register load time
  * over i2c.
  */
-
+/* YUV422 UYVY VGA@30fps */
 static const struct reg_value ov5640_init_setting_30fps_VGA[] = {
 	{0x3103, 0x11, 0, 0}, {0x3008, 0x82, 0, 5}, {0x3008, 0x42, 0, 0},
 	{0x3103, 0x03, 0, 0}, {0x3017, 0x00, 0, 0}, {0x3018, 0x00, 0, 0},
@@ -1968,9 +1969,12 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
 
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
@@ -2544,10 +2548,13 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
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
@@ -2642,9 +2649,14 @@ static int ov5640_probe(struct i2c_client *client,
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
@@ -2656,7 +2668,6 @@ static int ov5640_probe(struct i2c_client *client,
 	sensor->current_fr = OV5640_30_FPS;
 	sensor->current_mode =
 		&ov5640_mode_data[OV5640_30_FPS][OV5640_MODE_VGA_640_480];
-	sensor->pending_mode_change = true;
 
 	sensor->ae_target = 52;
 
-- 
2.17.1

