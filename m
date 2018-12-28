Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9B72146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999299;
	bh=UVY5grcJCQB/9liYA7OOkxirK3m6fbJCRLAxEUG3kvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkBn7Z7m1+yDfDccMT1RLi8HHNimHXo9jIPejAQTPsj8a69yaF4aw7otXP+FpnlVu
	 nyLlKbvCWuZjZ84kkynB8v+K624xeaw3+Ju2W8UIZ6LxUOp5ZBppnaSxUjAopPWDAq
	 Pll9qkCfBKaKqnpJQswChJty0rWJyMXqr7eiRTjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbeL1MO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbeL1MOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCFE2184B;
        Fri, 28 Dec 2018 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999294;
        bh=UVY5grcJCQB/9liYA7OOkxirK3m6fbJCRLAxEUG3kvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJVmqHTgi2nVXNAxdPfkz9vhym2UTrKKL/wwodST876XxyNGnPb5IjYwjkK8USc3n
         +PDBTNWTye5+1k/XkEMQ2qZQNi/W63UDrskKTk1X/IWnmCP5E8HtRbQfU7ztXKeyum
         B+jb4/7Jxuon13ahBofhqHNmRKLbIGsL9PjHIOOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.19 39/46] media: ov5640: Fix set format regression
Date:   Fri, 28 Dec 2018 12:52:33 +0100
Message-Id: <20181228113127.171051863@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit 07115449919383548d094ff83cc27bd08639a8a1 upstream.

The set_fmt operations updates the sensor format only when the image format
is changed. When only the image sizes gets changed, the format do not get
updated causing the sensor to always report the one that was previously in
use.

Without this patch, updating frame size only fails:
  [fmt:UYVY8_2X8/640x480@1/30 field:none colorspace:srgb xfer:srgb ...]

With this patch applied:
  [fmt:UYVY8_2X8/1024x768@1/30 field:none colorspace:srgb xfer:srgb ...]

Fixes: 6949d864776e ("media: ov5640: do not change mode if format or frame interval is unchanged")

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Adam Ford <aford173@gmail.com> #imx6 w/ CSI2 interface on 4.19.6 and 4.20-RC5
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov5640.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2020,6 +2020,7 @@ static int ov5640_set_fmt(struct v4l2_su
 	struct ov5640_dev *sensor = to_ov5640_dev(sd);
 	const struct ov5640_mode_info *new_mode;
 	struct v4l2_mbus_framefmt *mbus_fmt = &format->format;
+	struct v4l2_mbus_framefmt *fmt;
 	int ret;
 
 	if (format->pad != 0)
@@ -2037,22 +2038,20 @@ static int ov5640_set_fmt(struct v4l2_su
 	if (ret)
 		goto out;
 
-	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-		struct v4l2_mbus_framefmt *fmt =
-			v4l2_subdev_get_try_format(sd, cfg, 0);
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		fmt = v4l2_subdev_get_try_format(sd, cfg, 0);
+	else
+		fmt = &sensor->fmt;
 
-		*fmt = *mbus_fmt;
-		goto out;
-	}
+	*fmt = *mbus_fmt;
 
 	if (new_mode != sensor->current_mode) {
 		sensor->current_mode = new_mode;
 		sensor->pending_mode_change = true;
 	}
-	if (mbus_fmt->code != sensor->fmt.code) {
-		sensor->fmt = *mbus_fmt;
+	if (mbus_fmt->code != sensor->fmt.code)
 		sensor->pending_fmt_change = true;
-	}
+
 out:
 	mutex_unlock(&sensor->lock);
 	return ret;


