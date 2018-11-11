Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8103FC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A5F20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4oDMVyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A5F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbeKLJlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732875AbeKLISc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D932154B;
        Sun, 11 Nov 2018 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975316;
        bh=5uIHUeUwvvCiVdmHlKeBCAz154cXx1dFv3mzNw0zqkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4oDMVyEoQPKm5NrSbNl9bDnMdX2jUo8sxInWGZybwkF97NC4XLKxprug2vFc4Ojd
         al8G4V4wOz7WVmoxCQIkjHiqsIq31FG2jaiei9gYRP3fcoKiMWq2CMBoMsoQjN0Mf2
         uUzFyL66UBc2tNgWklBYmjCcnLS0c6nFTJaGTyRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 305/361] media: em28xx: use a default format if TRY_FMT fails
Date:   Sun, 11 Nov 2018 14:20:52 -0800
Message-Id: <20181111221657.805726313@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit f823ce2a1202d47110a7ef86b65839f0be8adc38 upstream.

Follow the V4L2 spec, as warned by v4l2-compliance:

	warn: v4l2-test-formats.cpp(732): TRY_FMT cannot handle an invalid pixelformat.
	warn: v4l2-test-formats.cpp(733): This may or may not be a problem. For more information see:

warn: v4l2-test-formats.cpp(734): http://www.mail-archive.com/linux-media@vger.kernel.org/msg56550.html

Cc: stable@vger.kernel.org
Fixes: bddcf63313c6 ("V4L/DVB (9927): em28xx: use a more standard way to specify video formats")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/em28xx/em28xx-video.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -1471,9 +1471,9 @@ static int vidioc_try_fmt_vid_cap(struct
 
 	fmt = format_by_fourcc(f->fmt.pix.pixelformat);
 	if (!fmt) {
-		em28xx_videodbg("Fourcc format (%08x) invalid.\n",
-				f->fmt.pix.pixelformat);
-		return -EINVAL;
+		fmt = &format[0];
+		em28xx_videodbg("Fourcc format (%08x) invalid. Using default (%08x).\n",
+				f->fmt.pix.pixelformat, fmt->fourcc);
 	}
 
 	if (dev->board.is_em2800) {


