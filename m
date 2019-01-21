Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE2C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3B02087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078945;
	bh=Z7L+O5Ra7KHCdWrph5I/mmEJOznmY+OgYNWdwu96ucI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P4CDiImKws3bO4CHFDdJlwrCvHK7DpE/f6hL8HLmIvY4lWtx5XOLm2Q5gZTOhYopm
	 VgHTwdFLtu4fOkxE+DfTH4tf6A9gC/Th8qLgCGDyT2oCFzyoY7ymAw83M8tI9CXYxg
	 fGj4IQhR2cQmIsiEVi0IV8kYAVklI6KfVCiIi8sU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfAUNzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731749AbfAUNzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5088120861;
        Mon, 21 Jan 2019 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078939;
        bh=Z7L+O5Ra7KHCdWrph5I/mmEJOznmY+OgYNWdwu96ucI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lB1iUmpVbDawPbYcdeSFsXP/FjyA7ppOyo1TfP5avQClNezKgpZ7AkFPkbZBiVX8c
         vva/RmrjdxEiohr+VfDGLZhlmcqsC1auoFQgxQZs3iGmnNebtOUdWSE5PB5bCCHeBk
         x5uPSeRjedXiaDo9RNOI7ZeyzYURa2PT1TJfIsvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "stable@vger.kernel.org, Mauro Carvalho Chehab" 
        <mchehab+samsung@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.9 07/51] media: em28xx: Fix misplaced reset of dev->v4l::field_count
Date:   Mon, 21 Jan 2019 14:44:03 +0100
Message-Id: <20190121122454.154518807@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1062,6 +1062,8 @@ int em28xx_start_analog_streaming(struct
 
 	em28xx_videodbg("%s\n", __func__);
 
+	dev->v4l2->field_count = 0;
+
 	/* Make sure streaming is not already in progress for this type
 	   of filehandle (e.g. video, vbi) */
 	rc = res_get(dev, vq->type);
@@ -1290,8 +1292,6 @@ static void em28xx_ctrl_notify(struct v4
 {
 	struct em28xx *dev = priv;
 
-	dev->v4l2->field_count = 0;
-
 	/*
 	 * In the case of non-AC97 volume controls, we still need
 	 * to do some setups at em28xx, in order to mute/unmute


