Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F10C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618DE2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjxwDEAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618DE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbeJKXIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6822098A;
        Thu, 11 Oct 2018 15:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272437;
        bh=jkxZ3Z4FqAFPNSS9RSTLZsdBK2mpe9tEzXrC+Pm0yss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjxwDEAdasp+1zVgCAyH0XGZ9ryjPEFpSwor8B+j2IsNcBbHJX37xNLiDAHXnNHbU
         fZgP0xXtgeMjmjuaq7daCy/SGohtQnWNPtosNu1mm2WP1XjQ41q/A42ZxvobzqWioo
         c44M5QsSK+zBtAu+iyQ7aCX27roxkp0Pe6hkUUjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 070/120] media: v4l: event: Prevent freeing event subscriptions while accessed
Date:   Thu, 11 Oct 2018 17:34:11 +0200
Message-Id: <20181011152552.703424376@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org # for 4.14 and up
Fixes: c3b5b0241f62 ("V4L/DVB: V4L: Events: Add backend")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-event.c |   37 +++++++++++++++++------------------
 drivers/media/v4l2-core/v4l2-fh.c    |    2 +
 include/media/v4l2-fh.h              |    1 
 3 files changed, 22 insertions(+), 18 deletions(-)

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
 
-	return 0;
+out_unlock:
+	mutex_unlock(&fh->subscribe_lock);
+
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
@@ -307,6 +307,7 @@ int v4l2_event_unsubscribe(struct v4l2_f
 		sev->ops->del(sev);
 
 	kfree(sev);
+	mutex_unlock(&fh->subscribe_lock);
 
 	return 0;
 }
--- a/drivers/media/v4l2-core/v4l2-fh.c
+++ b/drivers/media/v4l2-core/v4l2-fh.c
@@ -49,6 +49,7 @@ void v4l2_fh_init(struct v4l2_fh *fh, st
 	INIT_LIST_HEAD(&fh->available);
 	INIT_LIST_HEAD(&fh->subscribed);
 	fh->sequence = -1;
+	mutex_init(&fh->subscribe_lock);
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_init);
 
@@ -93,6 +94,7 @@ void v4l2_fh_exit(struct v4l2_fh *fh)
 	if (fh->vdev == NULL)
 		return;
 	v4l2_event_unsubscribe_all(fh);
+	mutex_destroy(&fh->subscribe_lock);
 	fh->vdev = NULL;
 }
 EXPORT_SYMBOL_GPL(v4l2_fh_exit);
--- a/include/media/v4l2-fh.h
+++ b/include/media/v4l2-fh.h
@@ -43,6 +43,7 @@ struct v4l2_fh {
 	wait_queue_head_t	wait;
 	struct list_head	subscribed; /* Subscribed events */
 	struct list_head	available; /* Dequeueable event */
+	struct mutex		subscribe_lock;
 	unsigned int		navailable;
 	u32			sequence;
 


