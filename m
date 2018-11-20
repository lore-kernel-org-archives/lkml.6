Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA163C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF17206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF17206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeKTUcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:32:24 -0500
Received: from shell.v3.sk ([90.176.6.54]:50111 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbeKTUcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:32:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 67F66C6FB3;
        Tue, 20 Nov 2018 11:04:02 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j58f3kkpmZbo; Tue, 20 Nov 2018 11:03:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 14465C6FBB;
        Tue, 20 Nov 2018 11:03:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BYEZcKBamoNU; Tue, 20 Nov 2018 11:03:39 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 849ECC6FB2;
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
Subject: [PATCH v3 02/14] media: ov7670: split register setting from set_framerate() logic
Date:   Tue, 20 Nov 2018 11:03:07 +0100
Message-Id: <20181120100318.367987-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120100318.367987-1-lkundrak@v3.sk>
References: <20181120100318.367987-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to restore the last set frame rate after the device
returns from a power off.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- This patch was added to the series

 drivers/media/i2c/ov7670.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index ee2302fbdeee..ead0c360df33 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -810,13 +810,24 @@ static void ov7675_get_framerate(struct v4l2_subdev=
 *sd,
 			(4 * clkrc);
 }
=20
+static int ov7675_apply_framerate(struct v4l2_subdev *sd)
+{
+	struct ov7670_info *info =3D to_state(sd);
+	int ret;
+
+	ret =3D ov7670_write(sd, REG_CLKRC, info->clkrc);
+	if (ret < 0)
+		return ret;
+
+	return ov7670_write(sd, REG_DBLV, info->pll_bypass ? DBLV_BYPASS : DBLV=
_X4);
+}
+
 static int ov7675_set_framerate(struct v4l2_subdev *sd,
 				 struct v4l2_fract *tpf)
 {
 	struct ov7670_info *info =3D to_state(sd);
 	u32 clkrc;
 	int pll_factor;
-	int ret;
=20
 	/*
 	 * The formula is fps =3D 5/4*pixclk for YUV/RGB and
@@ -825,19 +836,10 @@ static int ov7675_set_framerate(struct v4l2_subdev =
*sd,
 	 * pixclk =3D clock_speed / (clkrc + 1) * PLLfactor
 	 *
 	 */
-	if (info->pll_bypass) {
-		pll_factor =3D 1;
-		ret =3D ov7670_write(sd, REG_DBLV, DBLV_BYPASS);
-	} else {
-		pll_factor =3D PLL_FACTOR;
-		ret =3D ov7670_write(sd, REG_DBLV, DBLV_X4);
-	}
-	if (ret < 0)
-		return ret;
-
 	if (tpf->numerator =3D=3D 0 || tpf->denominator =3D=3D 0) {
 		clkrc =3D 0;
 	} else {
+		pll_factor =3D info->pll_bypass ? 1 : PLL_FACTOR;
 		clkrc =3D (5 * pll_factor * info->clock_speed * tpf->numerator) /
 			(4 * tpf->denominator);
 		if (info->fmt->mbus_code =3D=3D MEDIA_BUS_FMT_SBGGR8_1X8)
@@ -859,11 +861,7 @@ static int ov7675_set_framerate(struct v4l2_subdev *=
sd,
 	/* Recalculate frame rate */
 	ov7675_get_framerate(sd, tpf);
=20
-	ret =3D ov7670_write(sd, REG_CLKRC, info->clkrc);
-	if (ret < 0)
-		return ret;
-
-	return ov7670_write(sd, REG_DBLV, DBLV_X4);
+	return ov7675_apply_framerate(sd);
 }
=20
 static void ov7670_get_framerate_legacy(struct v4l2_subdev *sd,
--=20
2.19.1

