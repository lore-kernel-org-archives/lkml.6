Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EF821902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498760;
	bh=x+Arir7KB/bzFr1P7cgN1MFHk1rnLTa4tu1se/qbtn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T+3L2Y5x2XAwaeLLiwwZ6nugDBJIxQ/4OzRED7wJAxppcVMvPTO7hf1MKr6Zxmqy1
	 2Mrfm2Bwo5a2b6Vrb5d3/ULu8bfwDlclVeYJ68CWFUkQ+BVwqvxKXuPPT6/LpfRZCY
	 KXBZZzX8yveG4b3DyGgNa9IeQKt2lwxaparoQB+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbfBROF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390281AbfBROF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9E221902;
        Mon, 18 Feb 2019 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498755;
        bh=x+Arir7KB/bzFr1P7cgN1MFHk1rnLTa4tu1se/qbtn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sf0zifhsv0tZP50/U6CqtckFl5WOvYELFJ+j7XpnI2mIi+giN5qGfgMMUma+1X4Vp
         0FzInQR0LhTBiYb27WkYwnScz0HmpVOXx/JhwGfDDOC8B1rbnrZyKutftBdjThnwia
         uNXgpqZQX0Ve1AtiT4X1FDfEv+wKC9tPqp7AHY6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladis Dronov <vdronov@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4.4 111/143] HID: debug: fix the ring buffer implementation
Date:   Mon, 18 Feb 2019 14:43:59 +0100
Message-Id: <20190218133533.080825962@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladis Dronov <vdronov@redhat.com>

commit 13054abbaa4f1fd4e6f3b4b63439ec033b4c8035 upstream.

Ring buffer implementation in hid_debug_event() and hid_debug_events_read()
is strange allowing lost or corrupted data. After commit 717adfdaf147
("HID: debug: check length before copy_to_user()") it is possible to enter
an infinite loop in hid_debug_events_read() by providing 0 as count, this
locks up a system. Fix this by rewriting the ring buffer implementation
with kfifo and simplify the code.

This fixes CVE-2019-3819.

v2: fix an execution logic and add a comment
v3: use __set_current_state() instead of set_current_state()

Backport to v4.4: some (tree-wide) patches are missing in v4.4 so
cherry-pick relevant pieces from:
 * 6396bb22151 ("treewide: kzalloc() -> kcalloc()")
 * a9a08845e9ac ("vfs: do bulk POLL* -> EPOLL* replacement")
 * 92529623d242 ("HID: debug: improve hid_debug_event()")
 * 174cd4b1e5fb ("sched/headers: Prepare to move signal wakeup & sigpending
   methods from <linux/sched.h> into <linux/sched/signal.h>")

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1669187
Cc: stable@vger.kernel.org # v4.18+
Fixes: cd667ce24796 ("HID: use debugfs for events/reports dumping")
Fixes: 717adfdaf147 ("HID: debug: check length before copy_to_user()")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-debug.c   |  122 ++++++++++++++++++----------------------------
 include/linux/hid-debug.h |    9 +--
 2 files changed, 52 insertions(+), 79 deletions(-)

--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -30,6 +30,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/kfifo.h>
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -455,7 +456,7 @@ static char *resolv_usage_page(unsigned
 	char *buf = NULL;
 
 	if (!f) {
-		buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_ATOMIC);
+		buf = kzalloc(HID_DEBUG_BUFSIZE, GFP_ATOMIC);
 		if (!buf)
 			return ERR_PTR(-ENOMEM);
 	}
@@ -659,17 +660,12 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
 /* enqueue string to 'events' ring buffer */
 void hid_debug_event(struct hid_device *hdev, char *buf)
 {
-	int i;
 	struct hid_debug_list *list;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hdev->debug_list_lock, flags);
-	list_for_each_entry(list, &hdev->debug_list, node) {
-		for (i = 0; i < strlen(buf); i++)
-			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
-				buf[i];
-		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
-        }
+	list_for_each_entry(list, &hdev->debug_list, node)
+		kfifo_in(&list->hid_debug_fifo, buf, strlen(buf));
 	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
 
 	wake_up_interruptible(&hdev->debug_wait);
@@ -720,8 +716,7 @@ void hid_dump_input(struct hid_device *h
 	hid_debug_event(hdev, buf);
 
 	kfree(buf);
-        wake_up_interruptible(&hdev->debug_wait);
-
+	wake_up_interruptible(&hdev->debug_wait);
 }
 EXPORT_SYMBOL_GPL(hid_dump_input);
 
@@ -1086,8 +1081,8 @@ static int hid_debug_events_open(struct
 		goto out;
 	}
 
-	if (!(list->hid_debug_buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_KERNEL))) {
-		err = -ENOMEM;
+	err = kfifo_alloc(&list->hid_debug_fifo, HID_DEBUG_FIFOSIZE, GFP_KERNEL);
+	if (err) {
 		kfree(list);
 		goto out;
 	}
@@ -1107,77 +1102,57 @@ static ssize_t hid_debug_events_read(str
 		size_t count, loff_t *ppos)
 {
 	struct hid_debug_list *list = file->private_data;
-	int ret = 0, len;
+	int ret = 0, copied;
 	DECLARE_WAITQUEUE(wait, current);
 
 	mutex_lock(&list->read_mutex);
-	while (ret == 0) {
-		if (list->head == list->tail) {
-			add_wait_queue(&list->hdev->debug_wait, &wait);
-			set_current_state(TASK_INTERRUPTIBLE);
-
-			while (list->head == list->tail) {
-				if (file->f_flags & O_NONBLOCK) {
-					ret = -EAGAIN;
-					break;
-				}
-				if (signal_pending(current)) {
-					ret = -ERESTARTSYS;
-					break;
-				}
-
-				if (!list->hdev || !list->hdev->debug) {
-					ret = -EIO;
-					set_current_state(TASK_RUNNING);
-					goto out;
-				}
-
-				/* allow O_NONBLOCK from other threads */
-				mutex_unlock(&list->read_mutex);
-				schedule();
-				mutex_lock(&list->read_mutex);
-				set_current_state(TASK_INTERRUPTIBLE);
+	if (kfifo_is_empty(&list->hid_debug_fifo)) {
+		add_wait_queue(&list->hdev->debug_wait, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		while (kfifo_is_empty(&list->hid_debug_fifo)) {
+			if (file->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
 			}
 
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&list->hdev->debug_wait, &wait);
-		}
-
-		if (ret)
-			goto out;
-
-		/* pass the ringbuffer contents to userspace */
-copy_rest:
-		if (list->tail == list->head)
-			goto out;
-		if (list->tail > list->head) {
-			len = list->tail - list->head;
-			if (len > count)
-				len = count;
-
-			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
-				goto out;
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
 			}
-			ret += len;
-			list->head += len;
-		} else {
-			len = HID_DEBUG_BUFSIZE - list->head;
-			if (len > count)
-				len = count;
 
-			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
+			/* if list->hdev is NULL we cannot remove_wait_queue().
+			 * if list->hdev->debug is 0 then hid_debug_unregister()
+			 * was already called and list->hdev is being destroyed.
+			 * if we add remove_wait_queue() here we can hit a race.
+			 */
+			if (!list->hdev || !list->hdev->debug) {
+				ret = -EIO;
+				set_current_state(TASK_RUNNING);
 				goto out;
 			}
-			list->head = 0;
-			ret += len;
-			count -= len;
-			if (count > 0)
-				goto copy_rest;
+
+			/* allow O_NONBLOCK from other threads */
+			mutex_unlock(&list->read_mutex);
+			schedule();
+			mutex_lock(&list->read_mutex);
+			set_current_state(TASK_INTERRUPTIBLE);
 		}
 
+		__set_current_state(TASK_RUNNING);
+		remove_wait_queue(&list->hdev->debug_wait, &wait);
+
+		if (ret)
+			goto out;
 	}
+
+	/* pass the fifo content to userspace, locking is not needed with only
+	 * one concurrent reader and one concurrent writer
+	 */
+	ret = kfifo_to_user(&list->hid_debug_fifo, buffer, count, &copied);
+	if (ret)
+		goto out;
+	ret = copied;
 out:
 	mutex_unlock(&list->read_mutex);
 	return ret;
@@ -1188,7 +1163,7 @@ static unsigned int hid_debug_events_pol
 	struct hid_debug_list *list = file->private_data;
 
 	poll_wait(file, &list->hdev->debug_wait, wait);
-	if (list->head != list->tail)
+	if (!kfifo_is_empty(&list->hid_debug_fifo))
 		return POLLIN | POLLRDNORM;
 	if (!list->hdev->debug)
 		return POLLERR | POLLHUP;
@@ -1203,7 +1178,7 @@ static int hid_debug_events_release(stru
 	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
-	kfree(list->hid_debug_buf);
+	kfifo_free(&list->hid_debug_fifo);
 	kfree(list);
 
 	return 0;
@@ -1254,4 +1229,3 @@ void hid_debug_exit(void)
 {
 	debugfs_remove_recursive(hid_debug_root);
 }
-
--- a/include/linux/hid-debug.h
+++ b/include/linux/hid-debug.h
@@ -24,7 +24,10 @@
 
 #ifdef CONFIG_DEBUG_FS
 
+#include <linux/kfifo.h>
+
 #define HID_DEBUG_BUFSIZE 512
+#define HID_DEBUG_FIFOSIZE 512
 
 void hid_dump_input(struct hid_device *, struct hid_usage *, __s32);
 void hid_dump_report(struct hid_device *, int , u8 *, int);
@@ -37,11 +40,8 @@ void hid_debug_init(void);
 void hid_debug_exit(void);
 void hid_debug_event(struct hid_device *, char *);
 
-
 struct hid_debug_list {
-	char *hid_debug_buf;
-	int head;
-	int tail;
+	DECLARE_KFIFO_PTR(hid_debug_fifo, char);
 	struct fasync_struct *fasync;
 	struct hid_device *hdev;
 	struct list_head node;
@@ -64,4 +64,3 @@ struct hid_debug_list {
 #endif
 
 #endif
-


