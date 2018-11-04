Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC8ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61D3204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrucWPsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61D3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbeKDXJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbeKDXJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D3520868;
        Sun,  4 Nov 2018 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339687;
        bh=YWtGsITl2NvrjOZ/SyMxkAdTHBeXBYeJ9zWtoqV/pT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrucWPsELeiMhgZJec26bD5qruimSqTs6S/6TiWGvy4g6SIqM/iywSIIiIhkEteQZ
         MR+ZSnZJXU5X8whrtuNN0d83QwX5MgoDz27zIj6lLxF4Rwfl/IxuxF/pjD1Iqs2o88
         6eq5g/Hg5iiuwDrgtJf4JZvIM/sR37yBRwQDIE2Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 12/13] media: tvp5150: fix width alignment during set_selection()
Date:   Sun,  4 Nov 2018 08:54:32 -0500
Message-Id: <20181104135433.88734-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135433.88734-1-sashal@kernel.org>
References: <20181104135433.88734-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/media/i2c/tvp5150.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 193e7d6c29c8..44227a9631a9 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -864,9 +864,6 @@ static int tvp5150_s_crop(struct v4l2_subdev *sd, const struct v4l2_crop *a)
 
 	/* tvp5150 has some special limits */
 	rect.left = clamp(rect.left, 0, TVP5150_MAX_CROP_LEFT);
-	rect.width = clamp_t(unsigned int, rect.width,
-			     TVP5150_H_MAX - TVP5150_MAX_CROP_LEFT - rect.left,
-			     TVP5150_H_MAX - rect.left);
 	rect.top = clamp(rect.top, 0, TVP5150_MAX_CROP_TOP);
 
 	/* Calculate height based on current standard */
@@ -880,9 +877,16 @@ static int tvp5150_s_crop(struct v4l2_subdev *sd, const struct v4l2_crop *a)
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
-- 
2.17.1

