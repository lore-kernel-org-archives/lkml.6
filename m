Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83378C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BD820851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BD820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeKTUcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:32:15 -0500
Received: from shell.v3.sk ([90.176.6.54]:50062 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbeKTUcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:32:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5FFF3C6FAF;
        Tue, 20 Nov 2018 11:03:54 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BHnhfT89NXH9; Tue, 20 Nov 2018 11:03:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 07ACBC6FB7;
        Tue, 20 Nov 2018 11:03:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JoF1636aojNX; Tue, 20 Nov 2018 11:03:39 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3DD7DC6FB1;
        Tue, 20 Nov 2018 11:03:39 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Subject: [PATCH v3 01/14] media: ov7670: split register setting from set_fmt() logic
Date:   Tue, 20 Nov 2018 11:03:06 +0100
Message-Id: <20181120100318.367987-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120100318.367987-1-lkundrak@v3.sk>
References: <20181120100318.367987-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to restore the last set format after the device return=
s
from a power off.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- This patch was added to the series

 drivers/media/i2c/ov7670.c | 80 ++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index bc68a3a5b4ec..ee2302fbdeee 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -240,6 +240,7 @@ struct ov7670_info {
 	};
 	struct v4l2_mbus_framefmt format;
 	struct ov7670_format_struct *fmt;  /* Current format */
+	struct ov7670_win_size *wsize;
 	struct clk *clk;
 	struct gpio_desc *resetb_gpio;
 	struct gpio_desc *pwdn_gpio;
@@ -1003,48 +1004,20 @@ static int ov7670_try_fmt_internal(struct v4l2_su=
bdev *sd,
 	return 0;
 }
=20
-/*
- * Set a format.
- */
-static int ov7670_set_fmt(struct v4l2_subdev *sd,
-		struct v4l2_subdev_pad_config *cfg,
-		struct v4l2_subdev_format *format)
+static int ov7670_apply_fmt(struct v4l2_subdev *sd)
 {
-	struct ov7670_format_struct *ovfmt;
-	struct ov7670_win_size *wsize;
 	struct ov7670_info *info =3D to_state(sd);
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
-	struct v4l2_mbus_framefmt *mbus_fmt;
-#endif
+	struct ov7670_win_size *wsize =3D info->wsize;
 	unsigned char com7, com10 =3D 0;
 	int ret;
=20
-	if (format->pad)
-		return -EINVAL;
-
-	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) {
-		ret =3D ov7670_try_fmt_internal(sd, &format->format, NULL, NULL);
-		if (ret)
-			return ret;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
-		mbus_fmt =3D v4l2_subdev_get_try_format(sd, cfg, format->pad);
-		*mbus_fmt =3D format->format;
-		return 0;
-#else
-		return -ENOTTY;
-#endif
-	}
-
-	ret =3D ov7670_try_fmt_internal(sd, &format->format, &ovfmt, &wsize);
-	if (ret)
-		return ret;
 	/*
 	 * COM7 is a pain in the ass, it doesn't like to be read then
 	 * quickly written afterward.  But we have everything we need
 	 * to set it absolutely here, as long as the format-specific
 	 * register sets list it first.
 	 */
-	com7 =3D ovfmt->regs[0].value;
+	com7 =3D info->fmt->regs[0].value;
 	com7 |=3D wsize->com7_bit;
 	ret =3D ov7670_write(sd, REG_COM7, com7);
 	if (ret)
@@ -1066,7 +1039,7 @@ static int ov7670_set_fmt(struct v4l2_subdev *sd,
 	/*
 	 * Now write the rest of the array.  Also store start/stops
 	 */
-	ret =3D ov7670_write_array(sd, ovfmt->regs + 1);
+	ret =3D ov7670_write_array(sd, info->fmt->regs + 1);
 	if (ret)
 		return ret;
=20
@@ -1081,8 +1054,6 @@ static int ov7670_set_fmt(struct v4l2_subdev *sd,
 			return ret;
 	}
=20
-	info->fmt =3D ovfmt;
-
 	/*
 	 * If we're running RGB565, we must rewrite clkrc after setting
 	 * the other parameters or the image looks poor.  If we're *not*
@@ -1100,6 +1071,46 @@ static int ov7670_set_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
=20
+/*
+ * Set a format.
+ */
+static int ov7670_set_fmt(struct v4l2_subdev *sd,
+		struct v4l2_subdev_pad_config *cfg,
+		struct v4l2_subdev_format *format)
+{
+	struct ov7670_info *info =3D to_state(sd);
+#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
+	struct v4l2_mbus_framefmt *mbus_fmt;
+#endif
+	int ret;
+
+	if (format->pad)
+		return -EINVAL;
+
+	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) {
+		ret =3D ov7670_try_fmt_internal(sd, &format->format, NULL, NULL);
+		if (ret)
+			return ret;
+#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
+		mbus_fmt =3D v4l2_subdev_get_try_format(sd, cfg, format->pad);
+		*mbus_fmt =3D format->format;
+		return 0;
+#else
+		return -ENOTTY;
+#endif
+	}
+
+	ret =3D ov7670_try_fmt_internal(sd, &format->format, &info->fmt, &info-=
>wsize);
+	if (ret)
+		return ret;
+
+	ret =3D ov7670_apply_fmt(sd);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int ov7670_get_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_pad_config *cfg,
 			  struct v4l2_subdev_format *format)
@@ -1847,6 +1858,7 @@ static int ov7670_probe(struct i2c_client *client,
=20
 	info->devtype =3D &ov7670_devdata[id->driver_data];
 	info->fmt =3D &ov7670_formats[0];
+	info->wsize =3D &info->devtype->win_sizes[0];
=20
 	ov7670_get_default_format(sd, &info->format);
=20
--=20
2.19.1

