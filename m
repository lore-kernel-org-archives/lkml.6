Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD750C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9686920818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9686920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeKLGXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:23:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50116 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730254AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000oN-1L; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001q5-In; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.84819816@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 323/366] media: v4l: event: Prevent freeing event
 subscriptions while accessed
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit ad608fbcf166fec809e402d548761768f602702c upstream.

The event subscriptions are added to the subscribed event list while
holding a spinlock, but that lock is subsequently released while still
accessing the subscription object. This makes it possible to unsubscribe
the event --- and freeing the subscription object's memory --- while
the subscription object is simultaneously accessed.

Prevent this by adding a mutex to serialise the event subscription and
unsubscription. This also gives a guarantee to the callback ops that the
add op has returned before the del op is called.

This change also results in making the elems field less special:
subscriptions are only added to the event list once they are fully
initialised.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Fixes: c3b5b0241f62 ("V4L/DVB: V4L: Events: Add backend")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-event.c | 38 +++++++++++++++++++-----------------
 drivers/media/v4l2-core/v4l2-fh.c    |  2 ++
 include/media/v4l2-fh.h              |  1 +
 3 files changed, 23 insertions(+), 18 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -119,14 +119,6 @@ static void __v4l2_event_queue_fh(struct
 	if (sev == NULL)
 		return;
 
-	/*
-	 * If the event has been added to the fh->subscribed list, but its
-	 * add op has not completed yet elems will be 0, treat this as
-	 * not being subscribed.
-	 */
-	if (!sev->elems)
-		return;
-
 	/* Increase event sequence number on fh. */
 	fh->sequence++;
 
@@ -209,6 +201,7 @@ int v4l2_event_subscribe(struct v4l2_fh
 	struct v4l2_subscribed_event *sev, *found_ev;
 	unsigned long flags;
 	unsigned i;
+	int ret = 0;
 
 	if (sub->type == V4L2_EVENT_ALL)
 		return -EINVAL;
@@ -226,31 +219,36 @@ int v4l2_event_subscribe(struct v4l2_fh
 	sev->flags = sub->flags;
 	sev->fh = fh;
 	sev->ops = ops;
+	sev->elems = elems;
+
+	mutex_lock(&fh->subscribe_lock);
 
 	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
 	found_ev = v4l2_event_subscribed(fh, sub->type, sub->id);
-	if (!found_ev)
-		list_add(&sev->list, &fh->subscribed);
 	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
 
 	if (found_ev) {
+		/* Already listening */
 		kfree(sev);
-		return 0; /* Already listening */
+		goto out_unlock;
 	}
 
 	if (sev->ops && sev->ops->add) {
-		int ret = sev->ops->add(sev, elems);
+		ret = sev->ops->add(sev, elems);
 		if (ret) {
-			sev->ops = NULL;
-			v4l2_event_unsubscribe(fh, sub);
-			return ret;
+			kfree(sev);
+			goto out_unlock;
 		}
 	}
 
-	/* Mark as ready for use */
-	sev->elems = elems;
+	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
+	list_add(&sev->list, &fh->subscribed);
+	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
+
+out_unlock:
+	mutex_unlock(&fh->subscribe_lock);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(v4l2_event_subscribe);
 
@@ -289,6 +287,8 @@ int v4l2_event_unsubscribe(struct v4l2_f
 		return 0;
 	}
 
+	mutex_lock(&fh->subscribe_lock);
+
 	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
 
 	sev = v4l2_event_subscribed(fh, sub->type, sub->id);
@@ -306,6 +306,8 @@ int v4l2_event_unsubscribe(struct v4l2_f
 	if (sev && sev->ops && sev->ops->del)
 		sev->ops->del(sev);
 
+	mutex_unlock(&fh->subscribe_lock);
+
 	kfree(sev);
 
 	return 0;
--- a/drivers/media/v4l2-core/v4l2-fh.c
+++ b/drivers/media/v4l2-core/v4l2-fh.c
@@ -42,6 +42,7 @@ void v4l2_fh_init(struct v4l2_fh *fh, st
 	INIT_LIST_HEAD(&fh->available);
 	INIT_LIST_HEAD(&fh->subscribed);
 	fh->sequence = -1;
+	mutex_init(&fh->subscribe_lock);
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_init);
 
@@ -88,6 +89,7 @@ void v4l2_fh_exit(struct v4l2_fh *fh)
 	if (fh->vdev == NULL)
 		return;
 	v4l2_event_unsubscribe_all(fh);
+	mutex_destroy(&fh->subscribe_lock);
 	fh->vdev = NULL;
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_exit);
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -41,6 +41,7 @@ struct v4l2_fh {
 
 	/* Events */
 	wait_queue_head_t	wait;
+	struct mutex		subscribe_lock;
 	struct list_head	subscribed; /* Subscribed events */
 	struct list_head	available; /* Dequeueable event */
 	unsigned int		navailable;

