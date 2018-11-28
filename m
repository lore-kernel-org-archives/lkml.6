Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA66AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AFA2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AFA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeK2EW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:22:27 -0500
Received: from shell.v3.sk ([90.176.6.54]:39088 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeK2EWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:22:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 54497996FF;
        Wed, 28 Nov 2018 18:19:38 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cQurqNvyUPMq; Wed, 28 Nov 2018 18:19:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 17550983F6;
        Wed, 28 Nov 2018 18:19:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N_cwyyut0UiB; Wed, 28 Nov 2018 18:19:26 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CB661996A6;
        Wed, 28 Nov 2018 18:19:25 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wenyou Yang <wenyou.yang@microchip.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/6] media: ov7740: get rid of extra ifdefs
Date:   Wed, 28 Nov 2018 18:19:14 +0100
Message-Id: <20181128171918.160643-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128171918.160643-1-lkundrak@v3.sk>
References: <20181128171918.160643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stubbed v4l2_subdev_get_try_format() will return a correct error when
configured without CONFIG_VIDEO_V4L2_SUBDEV_API.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/media/i2c/ov7740.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 6e9c233cfbe3..781ddcc743d4 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -780,9 +780,7 @@ static int ov7740_set_fmt(struct v4l2_subdev *sd,
 	struct ov7740 *ov7740 =3D container_of(sd, struct ov7740, subdev);
 	const struct ov7740_pixfmt *ovfmt;
 	const struct ov7740_framesize *fsize;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *mbus_fmt;
-#endif
 	int ret;
=20
 	mutex_lock(&ov7740->mutex);
@@ -795,16 +793,15 @@ static int ov7740_set_fmt(struct v4l2_subdev *sd,
 		ret =3D ov7740_try_fmt_internal(sd, &format->format, NULL, NULL);
 		if (ret)
 			goto error;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		mbus_fmt =3D v4l2_subdev_get_try_format(sd, cfg, format->pad);
+		if (IS_ERR(mbus_fmt)) {
+			ret =3D PTR_ERR(mbus_fmt);
+			goto error;
+		}
 		*mbus_fmt =3D format->format;
=20
 		mutex_unlock(&ov7740->mutex);
 		return 0;
-#else
-		ret =3D -ENOTTY;
-		goto error;
-#endif
 	}
=20
 	ret =3D ov7740_try_fmt_internal(sd, &format->format, &ovfmt, &fsize);
@@ -827,20 +824,18 @@ static int ov7740_get_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_format *format)
 {
 	struct ov7740 *ov7740 =3D container_of(sd, struct ov7740, subdev);
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *mbus_fmt;
-#endif
 	int ret =3D 0;
=20
 	mutex_lock(&ov7740->mutex);
 	if (format->which =3D=3D V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		mbus_fmt =3D v4l2_subdev_get_try_format(sd, cfg, 0);
-		format->format =3D *mbus_fmt;
-		ret =3D 0;
-#else
-		ret =3D -ENOTTY;
-#endif
+		if (IS_ERR(mbus_fmt)) {
+			ret =3D PTR_ERR(mbus_fmt);
+		} else {
+			format->format =3D *mbus_fmt;
+			ret =3D 0;
+		}
 	} else {
 		format->format =3D ov7740->format;
 	}
--=20
2.19.1

