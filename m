Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF46ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFD12085B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI2b7r/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFD12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbeKDXHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730543AbeKDXHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35ECB2085B;
        Sun,  4 Nov 2018 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339559;
        bh=XyC6cyXdbpF8fMOArSFTW6Ldht9rR5hOGCzCouedw2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YI2b7r/6d11Qb5k5oQMn6FH+/aQSgDL2YTpvkasM5auIPYOx6G2V3o8ESOvS9UJQW
         Cvcdw1nNUXCMO7R6lXge4dOE79CHWOPs5qBhtm3iK7xJpDELu8tfHMMB/TWhraRuM0
         Av0PgeIS2cjUzZ+0FSniKgoLPp41n5OSUt21lMZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hugues Fruchet <hugues.fruchet@st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 57/57] media: ov5640: fix restore of last mode set
Date:   Sun,  4 Nov 2018 08:51:44 -0500
Message-Id: <20181104135144.88324-57-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@st.com>

[ Upstream commit 985cdcb08a0488558d1005139596b64d73bee267 ]

Mode setting depends on last mode set, in particular
because of exposure calculation when downscale mode
change between subsampling and scaling.
At stream on the last mode was wrongly set to current mode,
so no change was detected and exposure calculation
was not made, fix this.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Tested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 2ddd86ddf649..7b662bd1c7a0 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -226,6 +226,7 @@ struct ov5640_dev {
 	bool pending_fmt_change;
 
 	const struct ov5640_mode_info *current_mode;
+	const struct ov5640_mode_info *last_mode;
 	enum ov5640_frame_rate current_fr;
 	struct v4l2_fract frame_interval;
 
@@ -1614,10 +1615,10 @@ static int ov5640_set_mode_direct(struct ov5640_dev *sensor,
 	return __v4l2_ctrl_s_ctrl(sensor->ctrls.auto_exp, exposure);
 }
 
-static int ov5640_set_mode(struct ov5640_dev *sensor,
-			   const struct ov5640_mode_info *orig_mode)
+static int ov5640_set_mode(struct ov5640_dev *sensor)
 {
 	const struct ov5640_mode_info *mode = sensor->current_mode;
+	const struct ov5640_mode_info *orig_mode = sensor->last_mode;
 	enum ov5640_downsize_mode dn_mode, orig_dn_mode;
 	s32 exposure;
 	int ret;
@@ -1674,6 +1675,7 @@ static int ov5640_set_mode(struct ov5640_dev *sensor,
 		return ret;
 
 	sensor->pending_mode_change = false;
+	sensor->last_mode = mode;
 
 	return 0;
 }
@@ -1690,6 +1692,7 @@ static int ov5640_restore_mode(struct ov5640_dev *sensor)
 	ret = ov5640_load_regs(sensor, &ov5640_mode_init_data);
 	if (ret < 0)
 		return ret;
+	sensor->last_mode = &ov5640_mode_init_data;
 
 	ret = ov5640_mod_reg(sensor, OV5640_REG_SYS_ROOT_DIVIDER, 0x3f,
 			     (ilog2(OV5640_SCLK2X_ROOT_DIVIDER_DEFAULT) << 2) |
@@ -1698,7 +1701,7 @@ static int ov5640_restore_mode(struct ov5640_dev *sensor)
 		return ret;
 
 	/* now restore the last capture mode */
-	ret = ov5640_set_mode(sensor, &ov5640_mode_init_data);
+	ret = ov5640_set_mode(sensor);
 	if (ret < 0)
 		return ret;
 
@@ -2545,7 +2548,7 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
 
 	if (sensor->streaming == !enable) {
 		if (enable && sensor->pending_mode_change) {
-			ret = ov5640_set_mode(sensor, sensor->current_mode);
+			ret = ov5640_set_mode(sensor);
 			if (ret)
 				goto out;
 		}
@@ -2668,6 +2671,7 @@ static int ov5640_probe(struct i2c_client *client,
 	sensor->current_fr = OV5640_30_FPS;
 	sensor->current_mode =
 		&ov5640_mode_data[OV5640_30_FPS][OV5640_MODE_VGA_640_480];
+	sensor->last_mode = sensor->current_mode;
 
 	sensor->ae_target = 52;
 
-- 
2.17.1

