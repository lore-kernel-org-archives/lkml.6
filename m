Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31847C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E5922550
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E5922550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGGCGB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:06:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932701AbeGGCF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45195DFDA;
        Sat,  7 Jul 2018 02:05:56 +0000 (UTC)
Received: from gblock2.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B6672166BA9;
        Sat,  7 Jul 2018 02:05:52 +0000 (UTC)
From:   xiubli@redhat.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com, mchristi@redhat.com
Subject: [PATCH v4 2/3] uio: change to use the mutex lock instead of the spin lock
Date:   Fri,  6 Jul 2018 22:05:38 -0400
Message-Id: <1530929139-13652-3-git-send-email-xiubli@redhat.com>
In-Reply-To: <1530929139-13652-1-git-send-email-xiubli@redhat.com>
References: <1530929139-13652-1-git-send-email-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 07 Jul 2018 02:05:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 07 Jul 2018 02:05:56 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

We are hitting a regression with the following commit:

commit a93e7b331568227500186a465fee3c2cb5dffd1f
Author: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Date:   Mon May 14 13:32:23 2018 +1200

    uio: Prevent device destruction while fds are open

The problem is the addition of spin_lock_irqsave in uio_write. This
leads to hitting  uio_write -> copy_from_user -> _copy_from_user ->
might_fault and the logs filling up with sleeping warnings.

I also noticed some uio drivers allocate memory, sleep, grab mutexes
from callouts like open() and release and uio is now doing
spin_lock_irqsave while calling them.

Reported-by: Mike Christie <mchristi@redhat.com>
CC: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/uio/uio.c          | 32 +++++++++++++-------------------
 include/linux/uio_driver.h |  2 +-
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index b4b2ae1..655ade4 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -433,7 +433,6 @@ static int uio_open(struct inode *inode, struct file *filep)
 	struct uio_device *idev;
 	struct uio_listener *listener;
 	int ret = 0;
-	unsigned long flags;
 
 	mutex_lock(&minor_lock);
 	idev = idr_find(&uio_idr, iminor(inode));
@@ -460,10 +459,10 @@ static int uio_open(struct inode *inode, struct file *filep)
 	listener->event_count = atomic_read(&idev->event);
 	filep->private_data = listener;
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (idev->info && idev->info->open)
 		ret = idev->info->open(idev->info, inode);
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 	if (ret)
 		goto err_infoopen;
 
@@ -495,12 +494,11 @@ static int uio_release(struct inode *inode, struct file *filep)
 	int ret = 0;
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (idev->info && idev->info->release)
 		ret = idev->info->release(idev->info, inode);
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 
 	module_put(idev->owner);
 	kfree(listener);
@@ -513,12 +511,11 @@ static __poll_t uio_poll(struct file *filep, poll_table *wait)
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
 	__poll_t ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq)
 		ret = -EIO;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 
 	if (ret)
 		return ret;
@@ -537,12 +534,11 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 	DECLARE_WAITQUEUE(wait, current);
 	ssize_t retval = 0;
 	s32 event_count;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq)
 		retval = -EIO;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 
 	if (retval)
 		return retval;
@@ -592,9 +588,8 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	struct uio_device *idev = listener->dev;
 	ssize_t retval;
 	s32 irq_on;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq) {
 		retval = -EIO;
 		goto out;
@@ -618,7 +613,7 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	retval = idev->info->irqcontrol(idev->info, irq_on);
 
 out:
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 	return retval ? retval : sizeof(s32);
 }
 
@@ -865,7 +860,7 @@ int __uio_register_device(struct module *owner,
 
 	idev->owner = owner;
 	idev->info = info;
-	spin_lock_init(&idev->info_lock);
+	mutex_init(&idev->info_lock);
 	init_waitqueue_head(&idev->wait);
 	atomic_set(&idev->event, 0);
 
@@ -929,7 +924,6 @@ int __uio_register_device(struct module *owner,
 void uio_unregister_device(struct uio_info *info)
 {
 	struct uio_device *idev;
-	unsigned long flags;
 
 	if (!info || !info->uio_dev)
 		return;
@@ -943,9 +937,9 @@ void uio_unregister_device(struct uio_info *info)
 	if (info->irq && info->irq != UIO_IRQ_CUSTOM)
 		free_irq(info->irq, idev);
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	idev->info = NULL;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 
 	device_unregister(&idev->dev);
 
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 6c5f207..6f8b68c 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -75,7 +75,7 @@ struct uio_device {
         struct fasync_struct    *async_queue;
         wait_queue_head_t       wait;
         struct uio_info         *info;
-	spinlock_t		info_lock;
+	struct mutex		info_lock;
         struct kobject          *map_dir;
         struct kobject          *portio_dir;
 };
-- 
1.8.3.1

