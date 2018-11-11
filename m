Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A10C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9632220869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9632220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeKLFsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729563AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0000lM-2q; Sun, 11 Nov 2018 19:58:32 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001NT-SB; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.562474407@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 018/366] media: dvb_frontend: fix locking issues at
 dvb_frontend_get_event()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit 76d81243a487c09619822ef8e7201a756e58a87d upstream.

As warned by smatch:
	drivers/media/dvb-core/dvb_frontend.c:314 dvb_frontend_get_event() warn: inconsistent returns 'sem:&fepriv->sem'.
	  Locked on:   line 288
	               line 295
	               line 306
	               line 314
	  Unlocked on: line 303

The lock implementation for get event is wrong, as, if an
interrupt occurs, down_interruptible() will fail, and the
routine will call up() twice when userspace calls the ioctl
again.

The bad code is there since when Linux migrated to git, in
2005.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/dvb-core/dvb_frontend.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -229,8 +229,20 @@ static void dvb_frontend_add_event(struc
 	wake_up_interruptible (&events->wait_queue);
 }
 
+static int dvb_frontend_test_event(struct dvb_frontend_private *fepriv,
+				   struct dvb_fe_events *events)
+{
+	int ret;
+
+	up(&fepriv->sem);
+	ret = events->eventw != events->eventr;
+	down(&fepriv->sem);
+
+	return ret;
+}
+
 static int dvb_frontend_get_event(struct dvb_frontend *fe,
-			    struct dvb_frontend_event *event, int flags)
+			          struct dvb_frontend_event *event, int flags)
 {
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	struct dvb_fe_events *events = &fepriv->events;
@@ -248,13 +260,8 @@ static int dvb_frontend_get_event(struct
 		if (flags & O_NONBLOCK)
 			return -EWOULDBLOCK;
 
-		up(&fepriv->sem);
-
-		ret = wait_event_interruptible (events->wait_queue,
-						events->eventw != events->eventr);
-
-		if (down_interruptible (&fepriv->sem))
-			return -ERESTARTSYS;
+		ret = wait_event_interruptible(events->wait_queue,
+					       dvb_frontend_test_event(fepriv, events));
 
 		if (ret < 0)
 			return ret;

