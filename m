Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEFCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1047E2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvJU6rA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1047E2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeKZVqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbeKZVqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:46:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAE362147D;
        Mon, 26 Nov 2018 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229574;
        bh=GFoeAVCUfxg53TAUXp5wkMKNguHhavjykJNTGHPw+tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvJU6rA1tq0LKU4j1+ij2gv6Bes9n+H23zB9qGpOzQoiHLU+Zd6f+BF24RHqdTw5t
         AbPdjc+wDGvdRLf0lj/37meIJwXLODsEEkDViM9mpcY61dbq0W4H6/Z1iW2efhZ8l5
         ujRzqy8XqLuC4J0nGBlDA5RC/gz66eIGQdjsv1Xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 15/24] media: v4l: event: Add subscription to list before calling "add" operation
Date:   Mon, 26 Nov 2018 11:51:09 +0100
Message-Id: <20181126105031.969917516@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
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

commit 92539d3eda2c090b382699bbb896d4b54e9bdece upstream.

Patch ad608fbcf166 changed how events were subscribed to address an issue
elsewhere. As a side effect of that change, the "add" callback was called
before the event subscription was added to the list of subscribed events,
causing the first event queued by the add callback (and possibly other
events arriving soon afterwards) to be lost.

Fix this by adding the subscription to the list before calling the "add"
callback, and clean up afterwards if that fails.

Fixes: ad608fbcf166 ("media: v4l: event: Prevent freeing event subscriptions while accessed")

Reported-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
Tested-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: stable@vger.kernel.org (for 4.14 and up)
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-event.c |   43 +++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -194,6 +194,22 @@ int v4l2_event_pending(struct v4l2_fh *f
 }
 EXPORT_SYMBOL_GPL(v4l2_event_pending);
 
+static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
+{
+	struct v4l2_fh *fh = sev->fh;
+	unsigned int i;
+
+	lockdep_assert_held(&fh->subscribe_lock);
+	assert_spin_locked(&fh->vdev->fh_lock);
+
+	/* Remove any pending events for this subscription */
+	for (i = 0; i < sev->in_use; i++) {
+		list_del(&sev->events[sev_pos(sev, i)].list);
+		fh->navailable--;
+	}
+	list_del(&sev->list);
+}
+
 int v4l2_event_subscribe(struct v4l2_fh *fh,
 			 const struct v4l2_event_subscription *sub, unsigned elems,
 			 const struct v4l2_subscribed_event_ops *ops)
@@ -225,27 +241,23 @@ int v4l2_event_subscribe(struct v4l2_fh
 
 	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
 	found_ev = v4l2_event_subscribed(fh, sub->type, sub->id);
+	if (!found_ev)
+		list_add(&sev->list, &fh->subscribed);
 	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
 
 	if (found_ev) {
 		/* Already listening */
 		kfree(sev);
-		goto out_unlock;
-	}
-
-	if (sev->ops && sev->ops->add) {
+	} else if (sev->ops && sev->ops->add) {
 		ret = sev->ops->add(sev, elems);
 		if (ret) {
+			spin_lock_irqsave(&fh->vdev->fh_lock, flags);
+			__v4l2_event_unsubscribe(sev);
+			spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
 			kfree(sev);
-			goto out_unlock;
 		}
 	}
 
-	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
-	list_add(&sev->list, &fh->subscribed);
-	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
-
-out_unlock:
 	mutex_unlock(&fh->subscribe_lock);
 
 	return ret;
@@ -280,7 +292,6 @@ int v4l2_event_unsubscribe(struct v4l2_f
 {
 	struct v4l2_subscribed_event *sev;
 	unsigned long flags;
-	int i;
 
 	if (sub->type == V4L2_EVENT_ALL) {
 		v4l2_event_unsubscribe_all(fh);
@@ -292,14 +303,8 @@ int v4l2_event_unsubscribe(struct v4l2_f
 	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
 
 	sev = v4l2_event_subscribed(fh, sub->type, sub->id);
-	if (sev != NULL) {
-		/* Remove any pending events for this subscription */
-		for (i = 0; i < sev->in_use; i++) {
-			list_del(&sev->events[sev_pos(sev, i)].list);
-			fh->navailable--;
-		}
-		list_del(&sev->list);
-	}
+	if (sev != NULL)
+		__v4l2_event_unsubscribe(sev);
 
 	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
 


