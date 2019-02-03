Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E6C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847D02082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfBCOE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:04:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52904 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbfBCNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:45 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0003tq-RQ; Sun, 03 Feb 2019 13:49:43 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006po-KV; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.989602774@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 034/305] media: em28xx: make v4l2-compliance happier
 by starting sequence on zero
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

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit afeaade90db4c5dab93f326d9582be1d5954a198 upstream.

The v4l2-compliance tool complains if a video doesn't start
with a zero sequence number.

While this shouldn't cause any real problem for apps, let's
make it happier, in order to better check the v4l2-compliance
differences before and after patchsets.

This is actually an old issue. It is there since at least its
videobuf2 conversion, e. g. changeset 3829fadc461 ("[media]
em28xx: convert to videobuf2"), if VB1 wouldn't suffer from
the same issue.

Fixes: d3829fadc461 ("[media] em28xx: convert to videobuf2")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/em28xx/em28xx-video.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -928,6 +928,8 @@ int em28xx_start_analog_streaming(struct
 
 	em28xx_videodbg("%s\n", __func__);
 
+	dev->v4l2->field_count = 0;
+
 	/* Make sure streaming is not already in progress for this type
 	   of filehandle (e.g. video, vbi) */
 	rc = res_get(dev, vq->type);

