Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6184C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9427523F57
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9427523F57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeGAQ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:29:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933844AbeGAQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:29:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89F4692B;
        Sun,  1 Jul 2018 16:29:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 083/101] media: dvb_frontend: fix locking issues at dvb_frontend_get_event()
Date:   Sun,  1 Jul 2018 18:22:09 +0200
Message-Id: <20180701160800.482347008@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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

Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-core/dvb_frontend.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -251,8 +251,20 @@ static void dvb_frontend_add_event(struc
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
@@ -270,13 +282,8 @@ static int dvb_frontend_get_event(struct
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


