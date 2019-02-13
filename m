Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D9EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72BF222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083320;
	bh=6g1fndi1bL9LQtsJdE1f+o/qY02MDXdZwrwRvYqYR0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=muyW6Z5VqvpqqypZTgjg34ZmbP7H0iLy3208WkMCE5LQkT9UtRsSq4yu3scLe/SR0
	 P7jh7vVLDJsQMcuF2X1S71YOdAbnXdz7Bc8t7dr3lk0NXQPb9Ap9F+Gr1OyODqo4V9
	 yxUJUGqGn70T6mw3lGHlW8HT+we+kIf7P/buxeqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405567AbfBMSl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403859AbfBMSl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6DC222D6;
        Wed, 13 Feb 2019 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083315;
        bh=6g1fndi1bL9LQtsJdE1f+o/qY02MDXdZwrwRvYqYR0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDXDUB2Nykqq3FmfSTEeGwYc9b9q0tW8FbrJFUS96cHolkKcrktI7MooeET1YztiK
         x65LjricMONYLW+7xIl2d136l9Kr5lUQ4bQOAz6OtH12YOPNBV9j+X9Kk9LkU3JRUz
         po3Mb/20RbXHjOEyMEA7ivtYuGBbItsWcpRoBR6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Christie <mchristi@redhat.com>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Xiubo Li <xiubli@redhat.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 31/35] uio: change to use the mutex lock instead of the spin lock
Date:   Wed, 13 Feb 2019 19:38:26 +0100
Message-Id: <20190213183707.462377925@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

commit 543af5861f41af0a5d2432f6fb5976af50f9cee5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c          |   32 +++++++++++++-------------------
 include/linux/uio_driver.h |    2 +-
 2 files changed, 14 insertions(+), 20 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -435,7 +435,6 @@ static int uio_open(struct inode *inode,
 	struct uio_device *idev;
 	struct uio_listener *listener;
 	int ret = 0;
-	unsigned long flags;
 
 	mutex_lock(&minor_lock);
 	idev = idr_find(&uio_idr, iminor(inode));
@@ -462,10 +461,10 @@ static int uio_open(struct inode *inode,
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
 
@@ -497,12 +496,11 @@ static int uio_release(struct inode *ino
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
@@ -515,12 +513,11 @@ static unsigned int uio_poll(struct file
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
 	unsigned int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq)
 		ret = -EIO;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 
 	if (ret)
 		return ret;
@@ -539,12 +536,11 @@ static ssize_t uio_read(struct file *fil
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
@@ -594,9 +590,8 @@ static ssize_t uio_write(struct file *fi
 	struct uio_device *idev = listener->dev;
 	ssize_t retval;
 	s32 irq_on;
-	unsigned long flags;
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq) {
 		retval = -EIO;
 		goto out;
@@ -620,7 +615,7 @@ static ssize_t uio_write(struct file *fi
 	retval = idev->info->irqcontrol(idev->info, irq_on);
 
 out:
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 	return retval ? retval : sizeof(s32);
 }
 
@@ -874,7 +869,7 @@ int __uio_register_device(struct module
 
 	idev->owner = owner;
 	idev->info = info;
-	spin_lock_init(&idev->info_lock);
+	mutex_init(&idev->info_lock);
 	init_waitqueue_head(&idev->wait);
 	atomic_set(&idev->event, 0);
 
@@ -940,7 +935,6 @@ EXPORT_SYMBOL_GPL(__uio_register_device)
 void uio_unregister_device(struct uio_info *info)
 {
 	struct uio_device *idev;
-	unsigned long flags;
 
 	if (!info || !info->uio_dev)
 		return;
@@ -954,9 +948,9 @@ void uio_unregister_device(struct uio_in
 	if (info->irq && info->irq != UIO_IRQ_CUSTOM)
 		free_irq(info->irq, idev);
 
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	idev->info = NULL;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 
 	device_unregister(&idev->dev);
 
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


