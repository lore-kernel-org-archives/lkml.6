Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29069C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED157214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfBLOas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43835 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfBLOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:45 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4g-0005Af-52; Tue, 12 Feb 2019 15:30:14 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v1 06/25] printk-rb: add blocking reader support
Date:   Tue, 12 Feb 2019 15:29:44 +0100
Message-Id: <20190212143003.48446-7-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blocking read function for readers. An irq_work function is
used to signal the wait queue so that write notification can
be triggered from any context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk_ringbuffer.h | 20 ++++++++++++++++
 lib/printk_ringbuffer.c           | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
index 5fdaf632c111..106f20ef8b4d 100644
--- a/include/linux/printk_ringbuffer.h
+++ b/include/linux/printk_ringbuffer.h
@@ -2,8 +2,10 @@
 #ifndef _LINUX_PRINTK_RINGBUFFER_H
 #define _LINUX_PRINTK_RINGBUFFER_H
 
+#include <linux/irq_work.h>
 #include <linux/atomic.h>
 #include <linux/percpu.h>
+#include <linux/wait.h>
 
 struct prb_cpulock {
 	atomic_t owner;
@@ -22,6 +24,10 @@ struct printk_ringbuffer {
 
 	struct prb_cpulock *cpulock;
 	atomic_t ctx;
+
+	struct wait_queue_head *wq;
+	atomic_long_t wq_counter;
+	struct irq_work *wq_work;
 };
 
 struct prb_entry {
@@ -59,6 +65,15 @@ struct prb_iterator {
 #define DECLARE_STATIC_PRINTKRB(name, szbits, cpulockptr)		\
 static char _##name##_buffer[1 << (szbits)]				\
 	__aligned(__alignof__(long));					\
+static DECLARE_WAIT_QUEUE_HEAD(_##name##_wait);				\
+static void _##name##_wake_work_func(struct irq_work *irq_work)		\
+{									\
+	wake_up_interruptible_all(&_##name##_wait);			\
+}									\
+static struct irq_work _##name##_wake_work = {				\
+	.func = _##name##_wake_work_func,				\
+	.flags = IRQ_WORK_LAZY,						\
+};									\
 static struct printk_ringbuffer name = {				\
 	.buffer = &_##name##_buffer[0],					\
 	.size_bits = szbits,						\
@@ -68,6 +83,9 @@ static struct printk_ringbuffer name = {				\
 	.reserve = ATOMIC_LONG_INIT(-111 * sizeof(long)),		\
 	.cpulock = cpulockptr,						\
 	.ctx = ATOMIC_INIT(0),						\
+	.wq = &_##name##_wait,						\
+	.wq_counter = ATOMIC_LONG_INIT(0),				\
+	.wq_work = &_##name##_wake_work,				\
 }
 
 /* writer interface */
@@ -80,6 +98,8 @@ void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
 		   u64 *seq);
 void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src);
 int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq);
+int prb_iter_wait_next(struct prb_iterator *iter, char *buf, int size,
+		       u64 *seq);
 int prb_iter_data(struct prb_iterator *iter, char *buf, int size, u64 *seq);
 
 /* utility functions */
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
index 1d1e886a0966..c2ddf4cb9f92 100644
--- a/lib/printk_ringbuffer.c
+++ b/lib/printk_ringbuffer.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -154,6 +155,7 @@ static bool push_tail(struct printk_ringbuffer *rb, unsigned long tail)
 void prb_commit(struct prb_handle *h)
 {
 	struct printk_ringbuffer *rb = h->rb;
+	bool changed = false;
 	struct prb_entry *e;
 	unsigned long head;
 	unsigned long res;
@@ -175,6 +177,7 @@ void prb_commit(struct prb_handle *h)
 			}
 			e->seq = ++rb->seq;
 			head += e->size;
+			changed = true;
 		}
 		atomic_long_set_release(&rb->head, res);
 		atomic_dec(&rb->ctx);
@@ -185,6 +188,12 @@ void prb_commit(struct prb_handle *h)
 	}
 
 	prb_unlock(rb->cpulock, h->cpu);
+
+	if (changed) {
+		atomic_long_inc(&rb->wq_counter);
+		if (wq_has_sleeper(rb->wq))
+			irq_work_queue(rb->wq_work);
+	}
 }
 
 /*
@@ -437,3 +446,43 @@ int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq)
 
 	return 1;
 }
+
+/*
+ * prb_iter_wait_next: Advance to the next record, blocking if none available.
+ * @iter: Iterator tracking the current position.
+ * @buf: A buffer to store the data of the next record. May be NULL.
+ * @size: The size of @buf. (Ignored if @buf is NULL.)
+ * @seq: The sequence number of the next record. May be NULL.
+ *
+ * If a next record is already available, this function works like
+ * prb_iter_next(). Otherwise block interruptible until a next record is
+ * available.
+ *
+ * When a next record is available, @iter is advanced and (if specified)
+ * the data and/or sequence number of that record are provided.
+ *
+ * This function might sleep.
+ *
+ * Returns 1 if @iter was advanced, -EINVAL if @iter is now invalid, or
+ * -ERESTARTSYS if interrupted by a signal.
+ */
+int prb_iter_wait_next(struct prb_iterator *iter, char *buf, int size, u64 *seq)
+{
+	unsigned long last_seen;
+	int ret;
+
+	for (;;) {
+		last_seen = atomic_long_read(&iter->rb->wq_counter);
+
+		ret = prb_iter_next(iter, buf, size, seq);
+		if (ret != 0)
+			break;
+
+		ret = wait_event_interruptible(*iter->rb->wq,
+			last_seen != atomic_long_read(&iter->rb->wq_counter));
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
-- 
2.11.0

