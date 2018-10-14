Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C7FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3444D20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3444D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeJNXe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37492 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbeJNXe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:34:57 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMH-0004cD-IU; Sun, 14 Oct 2018 16:31:09 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000Ap-22; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.852054345@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 030/366] media: s3c-camif: fix out-of-bounds array access
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit a398e043637a4819a0e96467bfecaabf3224dd62 upstream.

While experimenting with older compiler versions, I ran
into a warning that no longer shows up on gcc-4.8 or newer:

drivers/media/platform/s3c-camif/camif-capture.c: In function '__camif_subdev_try_format':
drivers/media/platform/s3c-camif/camif-capture.c:1265:25: error: array subscript is below array bounds

This is an off-by-one bug, leading to an access before the start of the
array, while newer compilers silently assume this undefined behavior
cannot happen and leave the loop at index 0 if no other entry matches.

As Sylvester explains, we actually need to ensure that the
value is within the range, so this reworks the loop to be
easier to parse correctly, and an additional check to fall
back on the first format value for any unexpected input.

I found an existing gcc bug for it and added a reduced version
of the function there.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69249#c3
Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/platform/s3c-camif/camif-capture.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1280,16 +1280,17 @@ static void __camif_subdev_try_format(st
 {
 	const struct s3c_camif_variant *variant = camif->variant;
 	const struct vp_pix_limits *pix_lim;
-	int i = ARRAY_SIZE(camif_mbus_formats);
+	unsigned int i;
 
 	/* FIXME: constraints against codec or preview path ? */
 	pix_lim = &variant->vp_pix_limits[VP_CODEC];
 
-	while (i-- >= 0)
+	for (i = 0; i < ARRAY_SIZE(camif_mbus_formats); i++)
 		if (camif_mbus_formats[i] == mf->code)
 			break;
 
-	mf->code = camif_mbus_formats[i];
+	if (i == ARRAY_SIZE(camif_mbus_formats))
+		mf->code = camif_mbus_formats[0];
 
 	if (pad == CAMIF_SD_PAD_SINK) {
 		v4l_bound_align_image(&mf->width, 8, CAMIF_MAX_PIX_WIDTH,

