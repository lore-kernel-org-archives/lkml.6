Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FD7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3BA20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3BA20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJDAJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 283F6C04BD5C;
        Wed,  3 Oct 2018 17:19:58 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-200-24.brq.redhat.com [10.40.200.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9380309136D;
        Wed,  3 Oct 2018 17:19:55 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 2/3] HID: debug: provide reader-writer locking for the ring buffer
Date:   Wed,  3 Oct 2018 19:19:35 +0200
Message-Id: <20181003171936.11271-3-vdronov@redhat.com>
In-Reply-To: <20181003171936.11271-1-vdronov@redhat.com>
References: <20181003171936.11271-1-vdronov@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 03 Oct 2018 17:19:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdev->debug_list->hid_debug_buf is not protected from concurrent updates
from the writer, hid_debug_event() and reads by the reader,
hid_debug_events_read(). Fix this by adding per-list-element spinlock.
Also introduce a temporary buffer tempbuf so copy_to_user() is not called
from under a spinlock.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/hid/hid-debug.c   | 47 +++++++++++++++++++++++----------------
 include/linux/hid-debug.h |  1 +
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 20580871b0ec..e827784baf1a 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -663,15 +663,17 @@ void hid_debug_event(struct hid_device *hdev, char *buf)
 {
 	unsigned i;
 	struct hid_debug_list *list;
-	unsigned long flags;
+	unsigned long flags, flags2;
 
 	spin_lock_irqsave(&hdev->debug_list_lock, flags);
 	list_for_each_entry(list, &hdev->debug_list, node) {
+		spin_lock_irqsave(&list->list_lock, flags2);
 		for (i = 0; buf[i]; i++)
 			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
 				buf[i];
 		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
-        }
+		spin_unlock_irqrestore(&list->list_lock, flags2);
+	}
 	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
 
 	wake_up_interruptible(&hdev->debug_wait);
@@ -1095,6 +1097,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
 	file->private_data = list;
+	spin_lock_init(&list->list_lock);
 	mutex_init(&list->read_mutex);
 
 	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
@@ -1109,6 +1112,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	struct hid_debug_list *list = file->private_data;
+	char *tmpbuf;
+	unsigned long flags;
 	int ret = 0, len;
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -1151,10 +1156,18 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 	if (ret)
 		goto out;
 
-	/* pass the ringbuffer content to userspace */
+	tmpbuf = kmalloc(min_t(size_t, count, HID_DEBUG_BUFSIZE),
+			 GFP_KERNEL|__GFP_NOWARN);
+	if (!tmpbuf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* lock and copy the ringbuffer content to tmpbuf */
+	spin_lock_irqsave(&list->list_lock, flags);
 copy_rest:
 	if (list->tail == list->head)
-		goto out;
+		goto out_unlock;
 
 	/* the data from the head to the tail in the buffer is linear */
 	if (list->tail > list->head) {
@@ -1162,11 +1174,7 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 		if (len > count)
 			len = count;
 
-		if (copy_to_user(buffer + ret,
-		      &list->hid_debug_buf[list->head], len)) {
-			ret = -EFAULT;
-			goto out;
-		}
+		memcpy(tmpbuf + ret, &list->hid_debug_buf[list->head], len);
 		ret += len;
 		list->head += len;
 	} else {
@@ -1180,19 +1188,11 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 		if (len > count) {
 			len = count;
 
-			if (copy_to_user(buffer,
-			      &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
-				goto out;
-			}
+			memcpy(tmpbuf, &list->hid_debug_buf[list->head], len);
 			ret += len;
 			list->head += len;
 		} else {
-			if (copy_to_user(buffer,
-			      &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
-				goto out;
-			}
+			memcpy(tmpbuf, &list->hid_debug_buf[list->head], len);
 			list->head = 0;
 			ret += len;
 			count -= len;
@@ -1202,6 +1202,15 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 				goto copy_rest;
 		}
 	}
+
+out_unlock:
+	spin_unlock_irqrestore(&list->list_lock, flags);
+
+	/* copy out tmpbuf content to userspace */
+	if (ret && copy_to_user(buffer, tmpbuf, ret))
+		ret = -EFAULT;
+	kfree(tmpbuf);
+
 out:
 	mutex_unlock(&list->read_mutex);
 	return ret;
diff --git a/include/linux/hid-debug.h b/include/linux/hid-debug.h
index 8663f216c563..f58665651cb5 100644
--- a/include/linux/hid-debug.h
+++ b/include/linux/hid-debug.h
@@ -45,6 +45,7 @@ struct hid_debug_list {
 	struct fasync_struct *fasync;
 	struct hid_device *hdev;
 	struct list_head node;
+	spinlock_t list_lock;
 	struct mutex read_mutex;
 };
 
-- 
2.19.0

