Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1FBC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3B920879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078766;
	bh=YenEyqfZo3iDX7VBWyzcMgLFPEyC5pulIxfCBBHCv98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jXcpdQZdgrg8XQju1YEOwy2ErEq6/Sek5vJcBHUnoUjdYaRrQcT9n6YZKq6uwaPts
	 vIwXNBO8biM+EjQeN9OcY22KB7W3cpLYgRrmUv0jw8NWnjSf8sjGTIkPceOykF+yxw
	 sldvviaenYDBbL+kcH7NilT793KLHwyv1MR1Zr74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfAUNwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:52:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbfAUNwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:52:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62EB2084C;
        Mon, 21 Jan 2019 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078760;
        bh=YenEyqfZo3iDX7VBWyzcMgLFPEyC5pulIxfCBBHCv98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7IpnaA6HZrH3HIuHO/kql645U9OlfdJaF+Hns6/UNNLSSbvmuTCwHPEpn3XqB9s6
         s58b8byYAMZm+xdpTe6dHG4bzzXwuQ4V600AGWrN1z3+GJldHlk9kx1vMvpiM8/iCa
         GDYe0QeRBWI+Bg7wN3dQbVL1o8FoTfjmt3LH/cTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "stable@vger.kernel.org, Mauro Carvalho Chehab" 
        <mchehab+samsung@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 07/59] media: em28xx: Fix misplaced reset of dev->v4l::field_count
Date:   Mon, 21 Jan 2019 14:43:32 +0100
Message-Id: <20190121122457.283855347@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

The backport of commit afeaade90db4 "media: em28xx: make
v4l2-compliance happier by starting sequence on zero" added a
reset on em28xx_v4l2::field_count to em28xx_enable_analog_tuner()
but it should be done in em28xx_start_analog_streaming().

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx-video.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -900,8 +900,6 @@ static int em28xx_enable_analog_tuner(st
 	if (!mdev || !v4l2->decoder)
 		return 0;
 
-	dev->v4l2->field_count = 0;
-
 	/*
 	 * This will find the tuner that is connected into the decoder.
 	 * Technically, this is not 100% correct, as the device may be
@@ -1074,6 +1072,8 @@ int em28xx_start_analog_streaming(struct
 
 	em28xx_videodbg("%s\n", __func__);
 
+	dev->v4l2->field_count = 0;
+
 	/* Make sure streaming is not already in progress for this type
 	   of filehandle (e.g. video, vbi) */
 	rc = res_get(dev, vq->type);


