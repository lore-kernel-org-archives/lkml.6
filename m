Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BE020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BE020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeLIWFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:05:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36932 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbeLIWFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:05:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002ie-9W; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Gk-4O; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.748191073@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 058/328] udlfb: fix semaphore value leak
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
[b.zolnierkie: fix immediatelly -> immediately typo]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[bwh: Backported to 3.16: Pointers to struct dlfb_data are named "dev" rather
 than "dlfb"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/udlfb.c | 27 ++-------------------------
 include/video/udlfb.h       |  1 -
 2 files changed, 2 insertions(+), 26 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -928,14 +928,6 @@ static void dlfb_free(struct kref *kref)
 	kfree(dev);
 }
 
-static void dlfb_release_urb_work(struct work_struct *work)
-{
-	struct urb_node *unode = container_of(work, struct urb_node,
-					      release_urb_work.work);
-
-	up(&unode->dev->urbs.limit_sem);
-}
-
 static void dlfb_free_framebuffer(struct dlfb_data *dev)
 {
 	struct fb_info *info = dev->info;
@@ -1797,14 +1789,7 @@ static void dlfb_urb_completion(struct u
 	dev->urbs.available++;
 	spin_unlock_irqrestore(&dev->urbs.lock, flags);
 
-	/*
-	 * When using fb_defio, we deadlock if up() is called
-	 * while another is waiting. So queue to another process.
-	 */
-	if (fb_defio)
-		schedule_delayed_work(&unode->release_urb_work, 0);
-	else
-		up(&dev->urbs.limit_sem);
+	up(&dev->urbs.limit_sem);
 }
 
 static void dlfb_free_urb_list(struct dlfb_data *dev)
@@ -1813,16 +1798,11 @@ static void dlfb_free_urb_list(struct dl
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	int ret;
 	unsigned long flags;
 
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
-
-		/* Getting interrupted means a leak, but ok at disconnect */
-		ret = down_interruptible(&dev->urbs.limit_sem);
-		if (ret)
-			break;
+		down(&dev->urbs.limit_sem);
 
 		spin_lock_irqsave(&dev->urbs.lock, flags);
 
@@ -1862,9 +1842,6 @@ static int dlfb_alloc_urb_list(struct dl
 			break;
 		unode->dev = dev;
 
-		INIT_DELAYED_WORK(&unode->release_urb_work,
-			  dlfb_release_urb_work);
-
 		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb) {
 			kfree(unode);
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -19,7 +19,6 @@ struct dloarea {
 struct urb_node {
 	struct list_head entry;
 	struct dlfb_data *dev;
-	struct delayed_work release_urb_work;
 	struct urb *urb;
 };
 

