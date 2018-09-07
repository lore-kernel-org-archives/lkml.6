Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4EDC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211C20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E211C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeIHCDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:03:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbeIHCDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:03:13 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75BCDEF6;
        Fri,  7 Sep 2018 21:20:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.18 121/145] udlfb: fix semaphore value leak
Date:   Fri,  7 Sep 2018 23:09:47 +0200
Message-Id: <20180907210913.095562297@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 9d0aa601e4cd9c0892f90d36e8488d79b72f4073 upstream.

I observed that the performance of the udl fb driver degrades over time.
On a freshly booted machine, it takes 6 seconds to do "ls -la /usr/bin";
after some time of use, the same operation takes 14 seconds.

The reason is that the value of "limit_sem" decays over time.

The udl driver uses a semaphore "limit_set" to specify how many free urbs
are there on dlfb->urbs.list. If the count is zero, the "down" operation
will sleep until some urbs are added to the freelist.

In order to avoid some hypothetical deadlock, the driver will not call
"up" immediately, but it will offload it to a workqueue. The problem is
that if we call "schedule_delayed_work" on the same work item multiple
times, the work item may only be executed once.

This is happening:
* some urb completes
* dlfb_urb_completion adds it to the free list
* dlfb_urb_completion calls schedule_delayed_work to schedule the function
  dlfb_release_urb_work to increase the semaphore count
* as the urb is on the free list, some other task grabs it and submits it
* the submitted urb completes, dlfb_urb_completion is called again
* dlfb_urb_completion calls schedule_delayed_work, but the work is already
  scheduled, so it does nothing
* finally, dlfb_release_urb_work is called, it increases the semaphore
  count by 1, although it should increase it by 2

So, the semaphore count is decreasing over time, and this causes gradual
performance degradation.

Note that in the current kernel, the "up" function may be called from
interrupt and it may race with the "down" function called by another
thread, so we don't have to offload the call of "up" to a workqueue at
all. This patch removes the workqueue code. The patch also changes
"down_interruptible" to "down" in dlfb_free_urb_list, so that we will
clean up the driver properly even if a signal arrives.

With this patch, the performance of udlfb no longer degrades.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
[b.zolnierkie: fix immediatelly -> immediately typo]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/udlfb.c |   27 ++-------------------------
 include/video/udlfb.h       |    1 -
 2 files changed, 2 insertions(+), 26 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -922,14 +922,6 @@ static void dlfb_free(struct kref *kref)
 	kfree(dlfb);
 }
 
-static void dlfb_release_urb_work(struct work_struct *work)
-{
-	struct urb_node *unode = container_of(work, struct urb_node,
-					      release_urb_work.work);
-
-	up(&unode->dlfb->urbs.limit_sem);
-}
-
 static void dlfb_free_framebuffer(struct dlfb_data *dlfb)
 {
 	struct fb_info *info = dlfb->info;
@@ -1789,14 +1781,7 @@ static void dlfb_urb_completion(struct u
 	dlfb->urbs.available++;
 	spin_unlock_irqrestore(&dlfb->urbs.lock, flags);
 
-	/*
-	 * When using fb_defio, we deadlock if up() is called
-	 * while another is waiting. So queue to another process.
-	 */
-	if (fb_defio)
-		schedule_delayed_work(&unode->release_urb_work, 0);
-	else
-		up(&dlfb->urbs.limit_sem);
+	up(&dlfb->urbs.limit_sem);
 }
 
 static void dlfb_free_urb_list(struct dlfb_data *dlfb)
@@ -1805,16 +1790,11 @@ static void dlfb_free_urb_list(struct dl
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	int ret;
 	unsigned long flags;
 
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
-
-		/* Getting interrupted means a leak, but ok at disconnect */
-		ret = down_interruptible(&dlfb->urbs.limit_sem);
-		if (ret)
-			break;
+		down(&dlfb->urbs.limit_sem);
 
 		spin_lock_irqsave(&dlfb->urbs.lock, flags);
 
@@ -1854,9 +1834,6 @@ static int dlfb_alloc_urb_list(struct dl
 			break;
 		unode->dlfb = dlfb;
 
-		INIT_DELAYED_WORK(&unode->release_urb_work,
-			  dlfb_release_urb_work);
-
 		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb) {
 			kfree(unode);
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -20,7 +20,6 @@ struct dloarea {
 struct urb_node {
 	struct list_head entry;
 	struct dlfb_data *dlfb;
-	struct delayed_work release_urb_work;
 	struct urb *urb;
 };
 


