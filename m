Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8172DC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2D218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfBCNx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:53:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54404 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbfBCNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:53:23 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqID3-0003tu-Vu; Sun, 03 Feb 2019 13:53:22 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9p-0007Mo-C0; Sun, 03 Feb 2019 14:50:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.469608874@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 256/305] media: vb2: don't call __vb2_queue_cancel if
 vb2_start_streaming failed
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 04990215dec43c424daff00d1f622167b8aafd1f upstream.

vb2_start_streaming() already rolls back the buffers, so there is no
need to call __vb2_queue_cancel(). Especially since __vb2_queue_cancel()
does too much, such as zeroing the q->queued_count value, causing vb2
to think that no buffers have been queued.

It appears that this call to __vb2_queue_cancel() is a left-over from
before commit b3379c6201bb3.

Fixes: b3379c6201bb3 ('vb2: only call start_streaming if sufficient buffers are queued')

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/videobuf2-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -2200,10 +2200,8 @@ static int vb2_internal_streamon(struct
 	 */
 	if (q->queued_count >= q->min_buffers_needed) {
 		ret = vb2_start_streaming(q);
-		if (ret) {
-			__vb2_queue_cancel(q);
+		if (ret)
 			return ret;
-		}
 	}
 
 	q->streaming = 1;

