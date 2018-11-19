Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61590C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB9D21780
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaftfHoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB9D21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405383AbeKTDYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405346AbeKTDYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBB7B21780;
        Mon, 19 Nov 2018 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646826;
        bh=gXMf1nTIe927W/EvVPUSX46Wgpjv9ajf/hO07S2tl5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaftfHoy9i1X41epfr7Wl+3Xyg2uKBDxnUS9tt/TQCMioc2MKW1UBp2MdFM2Nuxhw
         Pg5Nj6Gn/lgNSQv+XzAPzbaoz6QOGWmGNdw/FK15WAp0wvuN36cH7jwL1dvKjzHTHg
         IX2c7Gelx0s2SC/g6ZQEw1DoQf9MqFO8PLgvWXJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 103/160] media: tvp5150: fix width alignment during set_selection()
Date:   Mon, 19 Nov 2018 17:29:02 +0100
Message-Id: <20181119162640.935976652@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit bd24db04101f45a9c1d874fe21b0c7eab7bcadec ]

The driver ignored the width alignment which exists due to the UYVY
colorspace format. Fix the width alignment and make use of the the
provided v4l2 helper function to set the width, height and all
alignments in one.

Fixes: 963ddc63e20d ("[media] media: tvp5150: Add cropping support")

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/tvp5150.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -870,9 +870,6 @@ static int tvp5150_s_crop(struct v4l2_su
 
 	/* tvp5150 has some special limits */
 	rect.left = clamp(rect.left, 0, TVP5150_MAX_CROP_LEFT);
-	rect.width = clamp_t(unsigned int, rect.width,
-			     TVP5150_H_MAX - TVP5150_MAX_CROP_LEFT - rect.left,
-			     TVP5150_H_MAX - rect.left);
 	rect.top = clamp(rect.top, 0, TVP5150_MAX_CROP_TOP);
 
 	/* Calculate height based on current standard */
@@ -886,9 +883,16 @@ static int tvp5150_s_crop(struct v4l2_su
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


