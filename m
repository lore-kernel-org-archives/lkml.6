Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A37C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B39F2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864442;
	bh=PwJ2E8W221dvg9FsNUSQ64CXnzFRhczx88WNbKxukHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hn8hN8HJOcBJJjqGExswcPd+/uav+Vfcrt9XRtBO4gdiE8AiFNWiMe0E/RwtTLnYB
	 CPtRyuKzuVvO2j3FMZGfp+JEjAwsVYSzlWEcFe2HWdxMY6sFPjRwkr/JUB2wP4T8gV
	 3e4ylyDtNP1Ub3ORPErw6CJylkwhrMGMj+U0g+zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfAGMeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGMd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:33:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A50C0206BB;
        Mon,  7 Jan 2019 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864439;
        bh=PwJ2E8W221dvg9FsNUSQ64CXnzFRhczx88WNbKxukHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9b7IH+DcMsogq9IQAuF5v0opXxAIcmrInveRzmPdAKwre9GzihABtmAhuXappUvO
         YqpE/VoZQli0i0+PD8OW4hzUF8G9zmT8ZKE6rF1bBxmxKE3Pl+sc3Cp/Fk3SNsm+j7
         tCfV+m7s48u/Y9tRVqECV71ORd2OqQQPN6PFs/aM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.20 003/145] media: ov5640: Fix set format regression
Date:   Mon,  7 Jan 2019 13:30:40 +0100
Message-Id: <20190107104437.769711486@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


