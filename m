Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCDDC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4829021479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjU21V27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4829021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbeK3BiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388832AbeK3BiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE77B2147C;
        Thu, 29 Nov 2018 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501947;
        bh=VfLuBBYOpeRh3jnBKMziyi/qr/rqs/bhhKIzfoc1t/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjU21V27jrdJI00jvnyJzPN0+O0QHKIhjr9A7RGKFz49AtWjGsCWYzxV0F+puI0Od
         66OF4XMtzbAZ3EcPoGidmPNnSR57uLPVJ9lvpNNgqVpV6oqQ2xRAUKLFh8Haqp5BvN
         EnBoTCneg+Cdi8HFLU0T6LfkAm2qAV096NfcMpzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.19 107/110] media: ov5640: fix exposure regression
Date:   Thu, 29 Nov 2018 15:13:18 +0100
Message-Id: <20181129135925.596288829@linuxfoundation.org>
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

commit dc29a1c187eedc1d498cb567c44bbbc832b009cb upstream.

Symptom was black image when capturing HD or 5Mp picture
due to manual exposure set to 1 while it was intended to
set autoexposure to "manual", fix this.

Fixes: bf4a4b518c20 ("media: ov5640: Don't force the auto exposure state at start time").

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov5640.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -960,6 +960,12 @@ static int ov5640_load_regs(struct ov564
 	return ov5640_set_timings(sensor, mode);
 }
 
+static int ov5640_set_autoexposure(struct ov5640_dev *sensor, bool on)
+{
+	return ov5640_mod_reg(sensor, OV5640_REG_AEC_PK_MANUAL,
+			      BIT(0), on ? 0 : BIT(0));
+}
+
 /* read exposure, in number of line periods */
 static int ov5640_get_exposure(struct ov5640_dev *sensor)
 {
@@ -1604,7 +1610,7 @@ static int ov5640_set_mode_exposure_calc
  */
 static int ov5640_set_mode_direct(struct ov5640_dev *sensor,
 				  const struct ov5640_mode_info *mode,
-				  s32 exposure)
+				  bool auto_exp)
 {
 	int ret;
 
@@ -1621,7 +1627,8 @@ static int ov5640_set_mode_direct(struct
 	if (ret)
 		return ret;
 
-	return __v4l2_ctrl_s_ctrl(sensor->ctrls.auto_exp, exposure);
+	return __v4l2_ctrl_s_ctrl(sensor->ctrls.auto_exp, auto_exp ?
+				  V4L2_EXPOSURE_AUTO : V4L2_EXPOSURE_MANUAL);
 }
 
 static int ov5640_set_mode(struct ov5640_dev *sensor)
@@ -1629,7 +1636,7 @@ static int ov5640_set_mode(struct ov5640
 	const struct ov5640_mode_info *mode = sensor->current_mode;
 	const struct ov5640_mode_info *orig_mode = sensor->last_mode;
 	enum ov5640_downsize_mode dn_mode, orig_dn_mode;
-	s32 exposure;
+	bool auto_exp =  sensor->ctrls.auto_exp->val == V4L2_EXPOSURE_AUTO;
 	int ret;
 
 	dn_mode = mode->dn_mode;
@@ -1640,8 +1647,7 @@ static int ov5640_set_mode(struct ov5640
 	if (ret)
 		return ret;
 
-	exposure = sensor->ctrls.auto_exp->val;
-	ret = ov5640_set_exposure(sensor, V4L2_EXPOSURE_MANUAL);
+	ret = ov5640_set_autoexposure(sensor, false);
 	if (ret)
 		return ret;
 
@@ -1657,7 +1663,7 @@ static int ov5640_set_mode(struct ov5640
 		 * change inside subsampling or scaling
 		 * download firmware directly
 		 */
-		ret = ov5640_set_mode_direct(sensor, mode, exposure);
+		ret = ov5640_set_mode_direct(sensor, mode, auto_exp);
 	}
 
 	if (ret < 0)


