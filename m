Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Sh74EcdEGVvGGAAAmS7hNA
	; Thu, 07 Jun 2018 14:44:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B641608BA; Thu,  7 Jun 2018 14:44:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 08185607DC;
	Thu,  7 Jun 2018 14:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08185607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934920AbeFGOof (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:44:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40711 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934070AbeFGOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:44:31 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbu-0005Zx-5q; Thu, 07 Jun 2018 15:09:54 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002mV-CR; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.776153868@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 076/410] media: cpia2: Fix a couple off by one bugs
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit d5ac225c7d64c9c3ef821239edc035634e594ec9 upstream.

The cam->buffers[] array has cam->num_frames elements so the > needs to
be changed to >= to avoid going beyond the end of the array.  The
->buffers[] array is allocated in cpia2_allocate_buffers() if you want
to confirm.

Fixes: ab33d5071de7 ("V4L/DVB (3376): Add cpia2 camera support")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/cpia2/cpia2_v4l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/cpia2/cpia2_v4l.c
+++ b/drivers/media/usb/cpia2/cpia2_v4l.c
@@ -812,7 +812,7 @@ static int cpia2_querybuf(struct file *f
 	struct camera_data *cam = video_drvdata(file);
 
 	if(buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-	   buf->index > cam->num_frames)
+	   buf->index >= cam->num_frames)
 		return -EINVAL;
 
 	buf->m.offset = cam->buffers[buf->index].data - cam->frame_buffer;
@@ -863,7 +863,7 @@ static int cpia2_qbuf(struct file *file,
 
 	if(buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE ||
 	   buf->memory != V4L2_MEMORY_MMAP ||
-	   buf->index > cam->num_frames)
+	   buf->index >= cam->num_frames)
 		return -EINVAL;
 
 	DBG("QBUF #%d\n", buf->index);
