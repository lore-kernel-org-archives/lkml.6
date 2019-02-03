Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E414C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0029820823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfBCOEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:04:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52926 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbfBCNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:45 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0003tp-Uv; Sun, 03 Feb 2019 13:49:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006ps-LO; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Marco Felsch" <m.felsch@pengutronix.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.422413240@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 035/305] media: tvp5150: fix width alignment during
 set_selection()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Felsch <m.felsch@pengutronix.de>

commit bd24db04101f45a9c1d874fe21b0c7eab7bcadec upstream.

The driver ignored the width alignment which exists due to the UYVY
colorspace format. Fix the width alignment and make use of the the
provided v4l2 helper function to set the width, height and all
alignments in one.

Fixes: 963ddc63e20d ("[media] media: tvp5150: Add cropping support")

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/i2c/tvp5150.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -873,9 +873,6 @@ static int tvp5150_s_crop(struct v4l2_su
 
 	/* tvp5150 has some special limits */
 	rect.left = clamp(rect.left, 0, TVP5150_MAX_CROP_LEFT);
-	rect.width = clamp_t(unsigned int, rect.width,
-			     TVP5150_H_MAX - TVP5150_MAX_CROP_LEFT - rect.left,
-			     TVP5150_H_MAX - rect.left);
 	rect.top = clamp(rect.top, 0, TVP5150_MAX_CROP_TOP);
 
 	/* Calculate height based on current standard */
@@ -889,9 +886,16 @@ static int tvp5150_s_crop(struct v4l2_su
 	else
 		hmax = TVP5150_V_MAX_OTHERS;
 
-	rect.height = clamp_t(unsigned int, rect.height,
+	/*
+	 * alignments:
+	 *  - width = 2 due to UYVY colorspace
+	 *  - height, image = no special alignment
+	 */
+	v4l_bound_align_image(&rect.width,
+			      TVP5150_H_MAX - TVP5150_MAX_CROP_LEFT - rect.left,
+			      TVP5150_H_MAX - rect.left, 1, &rect.height,
 			      hmax - TVP5150_MAX_CROP_TOP - rect.top,
-			      hmax - rect.top);
+			      hmax - rect.top, 0, 0);
 
 	tvp5150_write(sd, TVP5150_VERT_BLANKING_START, rect.top);
 	tvp5150_write(sd, TVP5150_VERT_BLANKING_STOP,

