Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E10FC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B590E218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357716;
	bh=8kNn21ykzl4x+U4JpIaH2L0/TNxiCnSLBXh3ZqdsaX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VmY7b/RVSczCvhAnyDjbjGcL4jm/LMmxzqwKl1YaTyA4Iq+8uONrTWI9Zs4cRT3dd
	 E4ae2wKFhZEwF7+Rf3Q06TTHgrcsYVgZ7a8xrOTImmyfgX5gu8HWeXFLdoy/GWHn12
	 9JPgXzFBqiThnSFcBiXu/+lnB+nCZu4gHZ2Q3jBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfAXTV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729299AbfAXTVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:21:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D66218D0;
        Thu, 24 Jan 2019 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357711;
        bh=8kNn21ykzl4x+U4JpIaH2L0/TNxiCnSLBXh3ZqdsaX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=li6daC9q9xU6iDjYmV7v+Q84NP6H2NKRwPlEf635RwrrhX7sDn0iSEY2eBoUdghJp
         Wd4IQIrrL6Q7ODMrRqAXxPH3jdCL0YmivLT1rPnS1eSog/xz+3ZHp5cjZy2GFl3IXd
         P7UefgAN9FpnRnZJpZEnsC0g6P8rB6ielm9j2Vp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "stable@vger.kernel.org, Mauro Carvalho Chehab" 
        <mchehab+samsung@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 14/52] media: em28xx: Fix misplaced reset of dev->v4l::field_count
Date:   Thu, 24 Jan 2019 20:19:38 +0100
Message-Id: <20190124190143.397651825@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

The backport of commit afeaade90db4 "media: em28xx: make
v4l2-compliance happier by starting sequence on zero" added a
reset on em28xx_v4l2::field_count to em28xx_ctrl_notify(),
but it should be done in em28xx_start_analog_streaming().

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/em28xx/em28xx-video.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -931,6 +931,8 @@ int em28xx_start_analog_streaming(struct
 
 	em28xx_videodbg("%s\n", __func__);
 
+	dev->v4l2->field_count = 0;
+
 	/* Make sure streaming is not already in progress for this type
 	   of filehandle (e.g. video, vbi) */
 	rc = res_get(dev, vq->type);
@@ -1141,8 +1143,6 @@ static void em28xx_ctrl_notify(struct v4
 {
 	struct em28xx *dev = priv;
 
-	dev->v4l2->field_count = 0;
-
 	/*
 	 * In the case of non-AC97 volume controls, we still need
 	 * to do some setups at em28xx, in order to mute/unmute


