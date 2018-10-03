Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF58C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C7C20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C7C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJDAJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:09:13 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43F54811AC;
        Wed,  3 Oct 2018 17:19:55 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-200-24.brq.redhat.com [10.40.200.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53BE309136D;
        Wed,  3 Oct 2018 17:19:52 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 1/3] HID: debug: avoid infinite loop and corrupting data
Date:   Wed,  3 Oct 2018 19:19:34 +0200
Message-Id: <20181003171936.11271-2-vdronov@redhat.com>
In-Reply-To: <20181003171936.11271-1-vdronov@redhat.com>
References: <20181003171936.11271-1-vdronov@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 03 Oct 2018 17:19:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hid_debug_events_read() does not properly handle the case when tail < head
and count < HID_DEBUG_BUFSIZE - head and returns corrupted data. Also,
after commit 717adfdaf147 ("HID: debug: check length before
copy_to_user()") it can enter an infinite loop if called with count == 0.
Fix this by properly handling this case and adding a check.

Also, the function has "while (ret == 0)" loop which is not needed, remove
it.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/hid/hid-debug.c | 109 ++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index b48100236df8..20580871b0ec 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -722,7 +722,7 @@ void hid_dump_input(struct hid_device *hdev, struct hid_usage *usage, __s32 valu
 	hid_debug_event(hdev, buf);
 
 	kfree(buf);
-        wake_up_interruptible(&hdev->debug_wait);
+	wake_up_interruptible(&hdev->debug_wait);
 
 }
 EXPORT_SYMBOL_GPL(hid_dump_input);
@@ -1112,73 +1112,95 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 	int ret = 0, len;
 	DECLARE_WAITQUEUE(wait, current);
 
-	mutex_lock(&list->read_mutex);
-	while (ret == 0) {
-		if (list->head == list->tail) {
-			add_wait_queue(&list->hdev->debug_wait, &wait);
-			set_current_state(TASK_INTERRUPTIBLE);
+	if (!count)
+		return 0;
 
-			while (list->head == list->tail) {
-				if (file->f_flags & O_NONBLOCK) {
-					ret = -EAGAIN;
-					break;
-				}
-				if (signal_pending(current)) {
-					ret = -ERESTARTSYS;
-					break;
-				}
+	mutex_lock(&list->read_mutex);
+	if (list->head == list->tail) {
+		add_wait_queue(&list->hdev->debug_wait, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		while (list->head == list->tail) {
+			if (file->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
 
-				if (!list->hdev || !list->hdev->debug) {
-					ret = -EIO;
-					set_current_state(TASK_RUNNING);
-					goto out;
-				}
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
+			}
 
-				/* allow O_NONBLOCK from other threads */
-				mutex_unlock(&list->read_mutex);
-				schedule();
-				mutex_lock(&list->read_mutex);
-				set_current_state(TASK_INTERRUPTIBLE);
+			if (!list->hdev || !list->hdev->debug) {
+				ret = -EIO;
+				set_current_state(TASK_RUNNING);
+				goto out;
 			}
 
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&list->hdev->debug_wait, &wait);
+			/* allow O_NONBLOCK from other threads */
+			mutex_unlock(&list->read_mutex);
+			schedule();
+			mutex_lock(&list->read_mutex);
+			set_current_state(TASK_INTERRUPTIBLE);
 		}
 
-		if (ret)
-			goto out;
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&list->hdev->debug_wait, &wait);
+	}
+
+	if (ret)
+		goto out;
 
-		/* pass the ringbuffer contents to userspace */
+	/* pass the ringbuffer content to userspace */
 copy_rest:
-		if (list->tail == list->head)
-			goto out;
-		if (list->tail > list->head) {
-			len = list->tail - list->head;
-			if (len > count)
-				len = count;
+	if (list->tail == list->head)
+		goto out;
+
+	/* the data from the head to the tail in the buffer is linear */
+	if (list->tail > list->head) {
+		len = list->tail - list->head;
+		if (len > count)
+			len = count;
 
-			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
+		if (copy_to_user(buffer + ret,
+		      &list->hid_debug_buf[list->head], len)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret += len;
+		list->head += len;
+	} else {
+		len = HID_DEBUG_BUFSIZE - list->head;
+
+		/* the data is split in 2 pieces: from the head to the end of
+		 * the ring buffer and from the start of the ring buffer to the
+		 *  tail. check if we need to copy out only the part between the
+		 * head and the end.
+		 */
+		if (len > count) {
+			len = count;
+
+			if (copy_to_user(buffer,
+			      &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
 				goto out;
 			}
 			ret += len;
 			list->head += len;
 		} else {
-			len = HID_DEBUG_BUFSIZE - list->head;
-			if (len > count)
-				len = count;
-
-			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
+			if (copy_to_user(buffer,
+			      &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
 				goto out;
 			}
 			list->head = 0;
 			ret += len;
 			count -= len;
+
+			/* check for a corner case when len == count */
 			if (count > 0)
 				goto copy_rest;
 		}
-
 	}
 out:
 	mutex_unlock(&list->read_mutex);
@@ -1256,4 +1278,3 @@ void hid_debug_exit(void)
 {
 	debugfs_remove_recursive(hid_debug_root);
 }
-
-- 
2.19.0

