Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE5FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A62D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3eIWTaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A62D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbeK3BiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388832AbeK3BiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199522147C;
        Thu, 29 Nov 2018 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501950;
        bh=+Da9gyaksuOfYNhSx+varx3Oi19Qk/0Lw0DfuulWW80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3eIWTafZDMaQ5qKM5HVn6ig8W0FA8KDyKANDSSVmfrmN8ND64Sn0VfQ7n6fM1+M/
         iUhTmOSLdIwAyQjzb2TiOqOXNqpd4HqlAkCI8go3BntNu6Bz0KwxZy8k3saO4h4r4A
         D/m+Dk7rxW7RxVXbjQK9dHnuIa1D+oD9REfqFGc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.19 108/110] media: ov5640: fix auto gain & exposure when changing mode
Date:   Thu, 29 Nov 2018 15:13:19 +0100
Message-Id: <20181129135925.638274233@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
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

commit 3cca8ef5f774cbd61c8db05d9aa401de9bb59c66 upstream.

Ensure that auto gain and auto exposure are well restored
when changing mode.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Tested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov5640.c |   96 +++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1022,6 +1022,18 @@ static int ov5640_get_gain(struct ov5640
 	return gain & 0x3ff;
 }
 
+static int ov5640_set_gain(struct ov5640_dev *sensor, int gain)
+{
+	return ov5640_write_reg16(sensor, OV5640_REG_AEC_PK_REAL_GAIN,
+				  (u16)gain & 0x3ff);
+}
+
+static int ov5640_set_autogain(struct ov5640_dev *sensor, bool on)
+{
+	return ov5640_mod_reg(sensor, OV5640_REG_AEC_PK_MANUAL,
+			      BIT(1), on ? 0 : BIT(1));
+}
+
 static int ov5640_set_stream_dvp(struct ov5640_dev *sensor, bool on)
 {
 	int ret;
@@ -1588,7 +1600,7 @@ static int ov5640_set_mode_exposure_calc
 	}
 
 	/* set capture gain */
-	ret = __v4l2_ctrl_s_ctrl(sensor->ctrls.gain, cap_gain16);
+	ret = ov5640_set_gain(sensor, cap_gain16);
 	if (ret)
 		return ret;
 
@@ -1601,7 +1613,7 @@ static int ov5640_set_mode_exposure_calc
 	}
 
 	/* set exposure */
-	return __v4l2_ctrl_s_ctrl(sensor->ctrls.exposure, cap_shutter);
+	return ov5640_set_exposure(sensor, cap_shutter);
 }
 
 /*
@@ -1609,26 +1621,13 @@ static int ov5640_set_mode_exposure_calc
  * change mode directly
  */
 static int ov5640_set_mode_direct(struct ov5640_dev *sensor,
-				  const struct ov5640_mode_info *mode,
-				  bool auto_exp)
+				  const struct ov5640_mode_info *mode)
 {
-	int ret;
-
 	if (!mode->reg_data)
 		return -EINVAL;
 
 	/* Write capture setting */
-	ret = ov5640_load_regs(sensor, mode);
-	if (ret < 0)
-		return ret;
-
-	/* turn auto gain/exposure back on for direct mode */
-	ret = __v4l2_ctrl_s_ctrl(sensor->ctrls.auto_gain, 1);
-	if (ret)
-		return ret;
-
-	return __v4l2_ctrl_s_ctrl(sensor->ctrls.auto_exp, auto_exp ?
-				  V4L2_EXPOSURE_AUTO : V4L2_EXPOSURE_MANUAL);
+	return ov5640_load_regs(sensor, mode);
 }
 
 static int ov5640_set_mode(struct ov5640_dev *sensor)
@@ -1636,6 +1635,7 @@ static int ov5640_set_mode(struct ov5640
 	const struct ov5640_mode_info *mode = sensor->current_mode;
 	const struct ov5640_mode_info *orig_mode = sensor->last_mode;
 	enum ov5640_downsize_mode dn_mode, orig_dn_mode;
+	bool auto_gain = sensor->ctrls.auto_gain->val == 1;
 	bool auto_exp =  sensor->ctrls.auto_exp->val == V4L2_EXPOSURE_AUTO;
 	int ret;
 
@@ -1643,19 +1643,23 @@ static int ov5640_set_mode(struct ov5640
 	orig_dn_mode = orig_mode->dn_mode;
 
 	/* auto gain and exposure must be turned off when changing modes */
-	ret = __v4l2_ctrl_s_ctrl(sensor->ctrls.auto_gain, 0);
-	if (ret)
-		return ret;
+	if (auto_gain) {
+		ret = ov5640_set_autogain(sensor, false);
+		if (ret)
+			return ret;
+	}
 
-	ret = ov5640_set_autoexposure(sensor, false);
-	if (ret)
-		return ret;
+	if (auto_exp) {
+		ret = ov5640_set_autoexposure(sensor, false);
+		if (ret)
+			goto restore_auto_gain;
+	}
 
 	if ((dn_mode == SUBSAMPLING && orig_dn_mode == SCALING) ||
 	    (dn_mode == SCALING && orig_dn_mode == SUBSAMPLING)) {
 		/*
 		 * change between subsampling and scaling
-		 * go through exposure calucation
+		 * go through exposure calculation
 		 */
 		ret = ov5640_set_mode_exposure_calc(sensor, mode);
 	} else {
@@ -1663,11 +1667,16 @@ static int ov5640_set_mode(struct ov5640
 		 * change inside subsampling or scaling
 		 * download firmware directly
 		 */
-		ret = ov5640_set_mode_direct(sensor, mode, auto_exp);
+		ret = ov5640_set_mode_direct(sensor, mode);
 	}
-
 	if (ret < 0)
-		return ret;
+		goto restore_auto_exp_gain;
+
+	/* restore auto gain and exposure */
+	if (auto_gain)
+		ov5640_set_autogain(sensor, true);
+	if (auto_exp)
+		ov5640_set_autoexposure(sensor, true);
 
 	ret = ov5640_set_binning(sensor, dn_mode != SCALING);
 	if (ret < 0)
@@ -1689,6 +1698,15 @@ static int ov5640_set_mode(struct ov5640
 	sensor->last_mode = mode;
 
 	return 0;
+
+restore_auto_exp_gain:
+	if (auto_exp)
+		ov5640_set_autoexposure(sensor, true);
+restore_auto_gain:
+	if (auto_gain)
+		ov5640_set_autogain(sensor, true);
+
+	return ret;
 }
 
 static int ov5640_set_framefmt(struct ov5640_dev *sensor,
@@ -2201,20 +2219,20 @@ static int ov5640_set_ctrl_white_balance
 	return ret;
 }
 
-static int ov5640_set_ctrl_exposure(struct ov5640_dev *sensor, int exp)
+static int ov5640_set_ctrl_exposure(struct ov5640_dev *sensor,
+				    enum v4l2_exposure_auto_type auto_exposure)
 {
 	struct ov5640_ctrls *ctrls = &sensor->ctrls;
-	bool auto_exposure = (exp == V4L2_EXPOSURE_AUTO);
+	bool auto_exp = (auto_exposure == V4L2_EXPOSURE_AUTO);
 	int ret = 0;
 
 	if (ctrls->auto_exp->is_new) {
-		ret = ov5640_mod_reg(sensor, OV5640_REG_AEC_PK_MANUAL,
-				     BIT(0), auto_exposure ? 0 : BIT(0));
+		ret = ov5640_set_autoexposure(sensor, auto_exp);
 		if (ret)
 			return ret;
 	}
 
-	if (!auto_exposure && ctrls->exposure->is_new) {
+	if (!auto_exp && ctrls->exposure->is_new) {
 		u16 max_exp;
 
 		ret = ov5640_read_reg16(sensor, OV5640_REG_AEC_PK_VTS,
@@ -2234,25 +2252,19 @@ static int ov5640_set_ctrl_exposure(stru
 	return ret;
 }
 
-static int ov5640_set_ctrl_gain(struct ov5640_dev *sensor, int auto_gain)
+static int ov5640_set_ctrl_gain(struct ov5640_dev *sensor, bool auto_gain)
 {
 	struct ov5640_ctrls *ctrls = &sensor->ctrls;
 	int ret = 0;
 
 	if (ctrls->auto_gain->is_new) {
-		ret = ov5640_mod_reg(sensor, OV5640_REG_AEC_PK_MANUAL,
-				     BIT(1),
-				     ctrls->auto_gain->val ? 0 : BIT(1));
+		ret = ov5640_set_autogain(sensor, auto_gain);
 		if (ret)
 			return ret;
 	}
 
-	if (!auto_gain && ctrls->gain->is_new) {
-		u16 gain = (u16)ctrls->gain->val;
-
-		ret = ov5640_write_reg16(sensor, OV5640_REG_AEC_PK_REAL_GAIN,
-					 gain & 0x3ff);
-	}
+	if (!auto_gain && ctrls->gain->is_new)
+		ret = ov5640_set_gain(sensor, ctrls->gain->val);
 
 	return ret;
 }


