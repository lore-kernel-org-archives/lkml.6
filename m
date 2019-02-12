Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B07C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D491214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfBLOac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43710 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfBLOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:29 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4h-0005Af-4B; Tue, 12 Feb 2019 15:30:15 +0100
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
Subject: [RFC PATCH v1 07/25] printk-rb: add functionality required by printk
Date:   Tue, 12 Feb 2019 15:29:45 +0100
Message-Id: <20190212143003.48446-8-john.ogness@linutronix.de>
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

The printk subsystem needs to be able to query the size of the ring
buffer, seek to specific entries within the ring buffer, and track
if records could not be stored in the ring buffer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk_ringbuffer.h |  5 +++
 lib/printk_ringbuffer.c           | 95 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
index 106f20ef8b4d..ec3d7ceec378 100644
--- a/include/linux/printk_ringbuffer.h
+++ b/include/linux/printk_ringbuffer.h
@@ -17,6 +17,7 @@ struct printk_ringbuffer {
 	unsigned int size_bits;
 
 	u64 seq;
+	atomic_long_t lost;
 
 	atomic_long_t tail;
 	atomic_long_t head;
@@ -78,6 +79,7 @@ static struct printk_ringbuffer name = {				\
 	.buffer = &_##name##_buffer[0],					\
 	.size_bits = szbits,						\
 	.seq = 0,							\
+	.lost = ATOMIC_LONG_INIT(0),					\
 	.tail = ATOMIC_LONG_INIT(-111 * sizeof(long)),			\
 	.head = ATOMIC_LONG_INIT(-111 * sizeof(long)),			\
 	.reserve = ATOMIC_LONG_INIT(-111 * sizeof(long)),		\
@@ -100,9 +102,12 @@ void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src);
 int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq);
 int prb_iter_wait_next(struct prb_iterator *iter, char *buf, int size,
 		       u64 *seq);
+int prb_iter_seek(struct prb_iterator *iter, u64 seq);
 int prb_iter_data(struct prb_iterator *iter, char *buf, int size, u64 *seq);
 
 /* utility functions */
+int prb_buffer_size(struct printk_ringbuffer *rb);
+void prb_inc_lost(struct printk_ringbuffer *rb);
 void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
 void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
 
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
index c2ddf4cb9f92..ce33b5add5a1 100644
--- a/lib/printk_ringbuffer.c
+++ b/lib/printk_ringbuffer.c
@@ -175,11 +175,16 @@ void prb_commit(struct prb_handle *h)
 				head = PRB_WRAP_LPOS(rb, head, 1);
 				continue;
 			}
+			while (atomic_long_read(&rb->lost)) {
+				atomic_long_dec(&rb->lost);
+				rb->seq++;
+			}
 			e->seq = ++rb->seq;
 			head += e->size;
 			changed = true;
 		}
 		atomic_long_set_release(&rb->head, res);
+
 		atomic_dec(&rb->ctx);
 
 		if (atomic_long_read(&rb->reserve) == res)
@@ -486,3 +491,93 @@ int prb_iter_wait_next(struct prb_iterator *iter, char *buf, int size, u64 *seq)
 
 	return ret;
 }
+
+/*
+ * prb_iter_seek: Seek forward to a specific record.
+ * @iter: Iterator to advance.
+ * @seq: Record number to advance to.
+ *
+ * Advance @iter such that a following call to prb_iter_data() will provide
+ * the contents of the specified record. If a record is specified that does
+ * not yet exist, advance @iter to the end of the record list.
+ *
+ * Note that iterators cannot be rewound. So if a record is requested that
+ * exists but is previous to @iter in position, @iter is considered invalid.
+ *
+ * It is safe to call this function from any context and state.
+ *
+ * Returns 1 on succces, 0 if specified record does not yet exist (@iter is
+ * now at the end of the list), or -EINVAL if @iter is now invalid.
+ */
+int prb_iter_seek(struct prb_iterator *iter, u64 seq)
+{
+	u64 cur_seq;
+	int ret;
+
+	/* first check if the iterator is already at the wanted seq */
+	if (seq == 0) {
+		if (iter->lpos == PRB_INIT)
+			return 1;
+		else
+			return -EINVAL;
+	}
+	if (iter->lpos != PRB_INIT) {
+		if (prb_iter_data(iter, NULL, 0, &cur_seq) >= 0) {
+			if (cur_seq == seq)
+				return 1;
+			if (cur_seq > seq)
+				return -EINVAL;
+		}
+	}
+
+	/* iterate to find the wanted seq */
+	for (;;) {
+		ret = prb_iter_next(iter, NULL, 0, &cur_seq);
+		if (ret <= 0)
+			break;
+
+		if (cur_seq == seq)
+			break;
+
+		if (cur_seq > seq) {
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * prb_buffer_size: Get the size of the ring buffer.
+ * @rb: The ring buffer to get the size of.
+ *
+ * Return the number of bytes used for the ring buffer entry storage area.
+ * Note that this area stores both entry header and entry data. Therefore
+ * this represents an upper bound to the amount of data that can be stored
+ * in the ring buffer.
+ *
+ * It is safe to call this function from any context and state.
+ *
+ * Returns the size in bytes of the entry storage area.
+ */
+int prb_buffer_size(struct printk_ringbuffer *rb)
+{
+	return PRB_SIZE(rb);
+}
+
+/*
+ * prb_inc_lost: Increment the seq counter to signal a lost record.
+ * @rb: The ring buffer to increment the seq of.
+ *
+ * Increment the seq counter so that a seq number is intentially missing
+ * for the readers. This allows readers to identify that a record is
+ * missing. A writer will typically use this function if prb_reserve()
+ * fails.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void prb_inc_lost(struct printk_ringbuffer *rb)
+{
+	atomic_long_inc(&rb->lost);
+}
-- 
2.11.0

