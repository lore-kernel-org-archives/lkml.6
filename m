Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59094C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F0F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfBLOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43683 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfBLOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:29 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4f-0005Af-FO; Tue, 12 Feb 2019 15:30:13 +0100
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
Subject: [RFC PATCH v1 05/25] printk-rb: add basic non-blocking reading interface
Date:   Tue, 12 Feb 2019 15:29:43 +0100
Message-Id: <20190212143003.48446-6-john.ogness@linutronix.de>
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

Add reader iterator static declaration/initializer, dynamic
initializer, and functions to iterate and retrieve ring buffer data.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk_ringbuffer.h |  20 ++++
 lib/printk_ringbuffer.c           | 190 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)

diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
index 1aec9d5666b1..5fdaf632c111 100644
--- a/include/linux/printk_ringbuffer.h
+++ b/include/linux/printk_ringbuffer.h
@@ -43,6 +43,19 @@ static struct prb_cpulock name = {					\
 	.irqflags = &_##name##_percpu_irqflags,				\
 }
 
+#define PRB_INIT ((unsigned long)-1)
+
+#define DECLARE_STATIC_PRINTKRB_ITER(name, rbaddr)			\
+static struct prb_iterator name = {					\
+	.rb = rbaddr,							\
+	.lpos = PRB_INIT,						\
+}
+
+struct prb_iterator {
+	struct printk_ringbuffer *rb;
+	unsigned long lpos;
+};
+
 #define DECLARE_STATIC_PRINTKRB(name, szbits, cpulockptr)		\
 static char _##name##_buffer[1 << (szbits)]				\
 	__aligned(__alignof__(long));					\
@@ -62,6 +75,13 @@ char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
 		  unsigned int size);
 void prb_commit(struct prb_handle *h);
 
+/* reader interface */
+void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
+		   u64 *seq);
+void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src);
+int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq);
+int prb_iter_data(struct prb_iterator *iter, char *buf, int size, u64 *seq);
+
 /* utility functions */
 void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
 void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
index 90c7f9a9f861..1d1e886a0966 100644
--- a/lib/printk_ringbuffer.c
+++ b/lib/printk_ringbuffer.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/errno.h>
 #include <linux/printk_ringbuffer.h>
 
 #define PRB_SIZE(rb) (1 << rb->size_bits)
@@ -8,6 +10,7 @@
 #define PRB_WRAPS(rb, lpos) (lpos >> rb->size_bits)
 #define PRB_WRAP_LPOS(rb, lpos, xtra) \
 	((PRB_WRAPS(rb, lpos) + xtra) << rb->size_bits)
+#define PRB_DATA_SIZE(e) (e->size - sizeof(struct prb_entry))
 #define PRB_DATA_ALIGN sizeof(long)
 
 static bool __prb_trylock(struct prb_cpulock *cpu_lock,
@@ -247,3 +250,190 @@ char *prb_reserve(struct prb_handle *h, struct printk_ringbuffer *rb,
 
 	return &h->entry->data[0];
 }
+
+/*
+ * prb_iter_copy: Copy an iterator.
+ * @dest: The iterator to copy to.
+ * @src: The iterator to copy from.
+ *
+ * Make a deep copy of an iterator. This is particularly useful for making
+ * backup copies of an iterator in case a form of rewinding it needed.
+ *
+ * It is safe to call this function from any context and state. But
+ * note that this function is not atomic. Callers should not make copies
+ * to/from iterators that can be accessed by other tasks/contexts.
+ */
+void prb_iter_copy(struct prb_iterator *dest, struct prb_iterator *src)
+{
+	memcpy(dest, src, sizeof(*dest));
+}
+
+/*
+ * prb_iter_init: Initialize an iterator for a ring buffer.
+ * @iter: The iterator to initialize.
+ * @rb: A ring buffer to that @iter should iterate.
+ * @seq: The sequence number of the position preceding the first record.
+ *       May be NULL.
+ *
+ * Initialize an iterator to be used with a specified ring buffer. If @seq
+ * is non-NULL, it will be set such that prb_iter_next() will provide a
+ * sequence value of "@seq + 1" if no records were missed.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
+		   u64 *seq)
+{
+	memset(iter, 0, sizeof(*iter));
+	iter->rb = rb;
+	iter->lpos = PRB_INIT;
+
+	if (!seq)
+		return;
+
+	for (;;) {
+		struct prb_iterator tmp_iter;
+		int ret;
+
+		prb_iter_copy(&tmp_iter, iter);
+
+		ret = prb_iter_next(&tmp_iter, NULL, 0, seq);
+		if (ret < 0)
+			continue;
+
+		if (ret == 0)
+			*seq = 0;
+		else
+			(*seq)--;
+		break;
+	}
+}
+
+static bool is_valid(struct printk_ringbuffer *rb, unsigned long lpos)
+{
+	unsigned long head, tail;
+
+	tail = atomic_long_read(&rb->tail);
+	head = atomic_long_read(&rb->head);
+	head -= tail;
+	lpos -= tail;
+
+	if (lpos >= head)
+		return false;
+	return true;
+}
+
+/*
+ * prb_iter_data: Retrieve the record data at the current position.
+ * @iter: Iterator tracking the current position.
+ * @buf: A buffer to store the data of the record. May be NULL.
+ * @size: The size of @buf. (Ignored if @buf is NULL.)
+ * @seq: The sequence number of the record. May be NULL.
+ *
+ * If @iter is at a record, provide the data and/or sequence number of that
+ * record (if specified by the caller).
+ *
+ * It is safe to call this function from any context and state.
+ *
+ * Returns >=0 if the current record contains valid data (returns 0 if @buf
+ * is NULL or returns the size of the data block if @buf is non-NULL) or
+ * -EINVAL if @iter is now invalid.
+ */
+int prb_iter_data(struct prb_iterator *iter, char *buf, int size, u64 *seq)
+{
+	struct printk_ringbuffer *rb = iter->rb;
+	unsigned long lpos = iter->lpos;
+	unsigned int datsize = 0;
+	struct prb_entry *e;
+
+	if (buf || seq) {
+		e = to_entry(rb, lpos);
+		if (!is_valid(rb, lpos))
+			return -EINVAL;
+		/* memory barrier to ensure valid lpos */
+		smp_rmb();
+		if (buf) {
+			datsize = PRB_DATA_SIZE(e);
+			/* memory barrier to ensure load of datsize */
+			smp_rmb();
+			if (!is_valid(rb, lpos))
+				return -EINVAL;
+			if (PRB_INDEX(rb, lpos) + datsize >
+			    PRB_SIZE(rb) - PRB_DATA_ALIGN) {
+				return -EINVAL;
+			}
+			if (size > datsize)
+				size = datsize;
+			memcpy(buf, &e->data[0], size);
+		}
+		if (seq)
+			*seq = e->seq;
+		/* memory barrier to ensure loads of entry data */
+		smp_rmb();
+	}
+
+	if (!is_valid(rb, lpos))
+		return -EINVAL;
+
+	return datsize;
+}
+
+/*
+ * prb_iter_next: Advance to the next record.
+ * @iter: Iterator tracking the current position.
+ * @buf: A buffer to store the data of the next record. May be NULL.
+ * @size: The size of @buf. (Ignored if @buf is NULL.)
+ * @seq: The sequence number of the next record. May be NULL.
+ *
+ * If a next record is available, @iter is advanced and (if specified)
+ * the data and/or sequence number of that record are provided.
+ *
+ * It is safe to call this function from any context and state.
+ *
+ * Returns 1 if @iter was advanced, 0 if @iter is at the end of the list, or
+ * -EINVAL if @iter is now invalid.
+ */
+int prb_iter_next(struct prb_iterator *iter, char *buf, int size, u64 *seq)
+{
+	struct printk_ringbuffer *rb = iter->rb;
+	unsigned long next_lpos;
+	struct prb_entry *e;
+	unsigned int esize;
+
+	if (iter->lpos == PRB_INIT) {
+		next_lpos = atomic_long_read(&rb->tail);
+	} else {
+		if (!is_valid(rb, iter->lpos))
+			return -EINVAL;
+		/* memory barrier to ensure valid lpos */
+		smp_rmb();
+		e = to_entry(rb, iter->lpos);
+		esize = e->size;
+		/* memory barrier to ensure load of size */
+		smp_rmb();
+		if (!is_valid(rb, iter->lpos))
+			return -EINVAL;
+		next_lpos = iter->lpos + esize;
+	}
+	if (next_lpos == atomic_long_read(&rb->head))
+		return 0;
+	if (!is_valid(rb, next_lpos))
+		return -EINVAL;
+	/* memory barrier to ensure valid lpos */
+	smp_rmb();
+
+	iter->lpos = next_lpos;
+	e = to_entry(rb, iter->lpos);
+	esize = e->size;
+	/* memory barrier to ensure load of size */
+	smp_rmb();
+	if (!is_valid(rb, iter->lpos))
+		return -EINVAL;
+	if (esize == -1)
+		iter->lpos = PRB_WRAP_LPOS(rb, iter->lpos, 1);
+
+	if (prb_iter_data(iter, buf, size, seq) < 0)
+		return -EINVAL;
+
+	return 1;
+}
-- 
2.11.0

