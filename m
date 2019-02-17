Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD497C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8902E21B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 01:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfBQBcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 20:32:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfBQBcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 20:32:47 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gvBJi-0008N7-Ha; Sun, 17 Feb 2019 02:32:26 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH v1 04/25] printk-rb: add writer interface
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-5-john.ogness@linutronix.de>
        <20190214151650.5y337yy2jnnztsc6@pathway.suse.cz>
        <87ef8aosby.fsf@linutronix.de>
        <20190215134711.pimxhuwipkzlgq23@pathway.suse.cz>
Date:   Sun, 17 Feb 2019 02:32:22 +0100
In-Reply-To: <20190215134711.pimxhuwipkzlgq23@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 15 Feb 2019 14:47:11 +0100")
Message-ID: <87d0nr5heh.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

I've made changes to the patch that hopefully align with what you are
looking for. I would appreciate it if you could go over it and see if
the changes are in the right direction. And if so, you should decide
whether I should make these kinds of changes for the whole series and
submit a v2 before you continue with the review.

The list of changes:

- Added comments everywhere I think they could be useful. Is it too
  much?

- Renamed struct prb_handle to prb_reserved_entry (more appropriate).

- Fixed up macros as you requested.

- The implementation from prb_commit() has been moved to a new
  prb_commit_all_reserved(). This should resolve the confusion in the
  "failed to push_tail()" code.

- I tried moving calc_next() into prb_reserve(), but it was pure
  insanity. I played with refactoring for a while until I found
  something that I think looks nice. I moved the implementation of
  calc_next() along with its containing loop into a new function
  find_res_ptrs(). This function does what calc_next() and push_tail()
  did. With this solution, I think prb_reserve() looks pretty
  clean. However, the optimization of communicating about the wrap is
  gone. So even though find_res_ptrs() knew if a wrap occurred,
  prb_reserve() figures it out again for itself. If we want the
  optimization, I still think the best approach is the -1,0,1 return
  value of find_res_ptrs().

I'm looking forward to your response.

John Ogness


diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
index 4239dc86e029..ab6177c9fe0a 100644
--- a/include/linux/printk_ringbuffer.h
+++ b/include/linux/printk_ringbuffer.h
@@ -25,6 +25,23 @@ struct printk_ringbuffer {
 	atomic_t		ctx;
 };
 
+/*
+ * struct prb_reserved_entry: Reserved but not yet committed entry.
+ * @rb: The printk_ringbuffer where the entry was reserved.
+ *
+ * This is a handle used by the writer to represent an entry that has been
+ * reserved but not yet committed.
+ *
+ * The structure does not actually store any information about the entry that
+ * has been reserved because this information is not required by the
+ * implementation. The struct could prove useful if extra tracking or even
+ * fundamental changes to the ringbuffer were to be implemented. And as such
+ * would not require changes to writers.
+ */
+struct prb_reserved_entry {
+	struct printk_ringbuffer	*rb;
+};
+
 #define DECLARE_STATIC_PRINTKRB_CPULOCK(name)				\
 static struct prb_cpulock name = {					\
 	.owner		= ATOMIC_INIT(-1),				\
@@ -46,6 +63,11 @@ static struct printk_ringbuffer name = {				\
 	.ctx		= ATOMIC_INIT(0),				\
 }
 
+/* writer interface */
+char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		  unsigned int size);
+void prb_commit(struct prb_reserved_entry *e);
+
 /* utility functions */
 void prb_lock(struct prb_cpulock *cpu_lock);
 void prb_unlock(struct prb_cpulock *cpu_lock);
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
index 54c750092810..fbe1d92b9b60 100644
--- a/lib/printk_ringbuffer.c
+++ b/lib/printk_ringbuffer.c
@@ -2,6 +2,59 @@
 #include <linux/smp.h>
 #include <linux/printk_ringbuffer.h>
 
+/*
+ * struct prb_entry: An entry within the ringbuffer.
+ * @size: The size in bytes of the entry or -1 if terminating.
+ * @seq: The unique sequence number of the entry.
+ * @data: The data bytes of the entry.
+ *
+ * The struct is typecasted directly into the ringbuffer data array to access
+ * an entry. The @size specifies the complete size of the entry including any
+ * padding. The next entry will be located at &this_entry + this_entry.size.
+ * The only exception is if the entry is terminating (size = -1). In this case
+ * @seq and @data are invalid and the next entry is at the beginning of the
+ * ringbuffer data array.
+ */
+struct prb_entry {
+	unsigned int	size;
+	u64		seq;
+	char		data[0];
+};
+
+/* the size and size bitmask of the ringbuffer data array */
+#define PRB_SIZE(rb) (1L << rb->size_bits)
+#define PRB_SIZE_BITMASK(rb) (PRB_SIZE(rb) - 1)
+
+/* given a logical position, return its index in the ringbuffer data array */
+#define PRB_INDEX(rb, lpos) (lpos & PRB_SIZE_BITMASK(rb))
+
+/*
+ * given a logical position, return how many times the data buffer has
+ * wrapped, where logical position 0 begins at index 0 with no wraps
+ */
+#define PRB_WRAPS(rb, lpos) (lpos >> rb->size_bits)
+
+/*
+ * given a logical position, return the logical position that represents the
+ * beginning of the ringbuffer data array for this wrap
+ */
+#define PRB_THIS_WRAP_START_LPOS(rb, lpos) \
+	(PRB_WRAPS(rb, lpos) << rb->size_bits)
+
+/*
+ * given a logical position, return the logical position that represents the
+ * beginning of the ringbuffer data array for the next wrap
+ */
+#define PRB_NEXT_WRAP_START_LPOS(rb, lpos) \
+	((PRB_WRAPS(rb, lpos) + 1) << rb->size_bits)
+
+/*
+ * entries are aligned to allow direct typecasts as struct prb_entry
+ */
+#define PRB_ENTRY_ALIGN sizeof(long)
+#define PRB_ENTRY_ALIGN_SIZE(sz) \
+	((sz + (PRB_ENTRY_ALIGN - 1)) & ~(PRB_ENTRY_ALIGN - 1))
+
 /*
  * prb_lock: Perform a processor-reentrant spin lock.
  * @cpu_lock: A pointer to the lock object.
@@ -58,3 +111,257 @@ void prb_unlock(struct prb_cpulock *cpu_lock)
 	}
 	put_cpu();
 }
+
+/* translate a logical position to an entry in the data array */
+static struct prb_entry *to_entry(struct printk_ringbuffer *rb,
+				  unsigned long lpos)
+{
+	char *buffer = rb->buffer;
+
+	buffer += PRB_INDEX(rb, lpos);
+	return (struct prb_entry *)buffer;
+}
+
+/* try to move the tail pointer forward, thus removing the oldest entry */
+static bool push_tail(struct printk_ringbuffer *rb, unsigned long tail)
+{
+	unsigned long new_tail, head;
+	struct prb_entry *e;
+
+	/* maybe another context already pushed the tail */
+	if (tail != atomic_long_read(&rb->tail))
+		return true;
+
+	/*
+	 * Determine what the new tail should be. If the tail is a
+	 * terminating entry, the new tail will be beyond the entry
+	 * at the beginning of the data array.
+	 */
+	e = to_entry(rb, tail);
+	if (e->size != -1)
+		new_tail = tail + e->size;
+	else
+		new_tail = PRB_NEXT_WRAP_START_LPOS(rb, tail);
+
+	/* make sure the new tail does not overtake the head */
+	head = atomic_long_read(&rb->head);
+	if (head - new_tail > PRB_SIZE(rb))
+		return false;
+
+	/*
+	 * The result of this cmpxchg does not matter. If it succeeds,
+	 * this context pushed the tail. If it fails, some other context
+	 * pushed the tail. Either way, the tail was pushed.
+	 */
+	atomic_long_cmpxchg(&rb->tail, tail, new_tail);
+	return true;
+}
+
+/*
+ * If this context incremented rb->ctx to 1, move the head pointer
+ * beyond all reserved entries.
+ */
+static void prb_commit_all_reserved(struct printk_ringbuffer *rb)
+{
+	unsigned long head, res;
+	struct prb_entry *e;
+
+	for (;;) {
+		if (atomic_read(&rb->ctx) > 1) {
+			/* another context will adjust the head pointer */
+			atomic_dec(&rb->ctx);
+			break;
+		}
+
+		/*
+		 * This is the only context that will adjust the head pointer.
+		 * If NMIs interrupt at any time, they can reserve/commit new
+		 * entries, but they will not adjust the head pointer.
+		 */
+
+		/* assign sequence numbers before moving the head pointer */
+		head = atomic_long_read(&rb->head);
+		res = atomic_long_read(&rb->reserve);
+		while (head != res) {
+			e = to_entry(rb, head);
+			if (e->size == -1) {
+				head = PRB_NEXT_WRAP_START_LPOS(rb, head);
+				continue;
+			}
+			e->seq = ++rb->seq;
+			head += e->size;
+		}
+
+		/*
+		 * move the head pointer, thus making all reserved entries
+		 * visible to any readers
+		 */
+		atomic_long_set_release(&rb->head, res);
+
+		atomic_dec(&rb->ctx);
+		if (atomic_long_read(&rb->reserve) == res)
+			break;
+		/*
+		 * The reserve pointer is different than previously read. New
+		 * entries were reserve/committed by NMI contexts, possibly
+		 * before ctx was decremented by this context. Go back and move
+		 * the head pointer beyond those entries as well.
+		 */
+		atomic_inc(&rb->ctx);
+	}
+
+	/* Enable interrupts and allow other CPUs to reserve/commit. */
+	prb_unlock(rb->cpulock);
+}
+
+/*
+ * prb_commit: Commit a reserved entry to the ring buffer.
+ * @e: A structure referencing a the reserved entry to commit.
+ *
+ * Commit data that has been reserved using prb_reserve(). Once the entry
+ * has been committed, it can be invalidated at any time. If a writer is
+ * interested in using the data after committing, the writer should make
+ * its own copy first or use the prb_iter_ reader functions to access the
+ * data in the ring buffer.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void prb_commit(struct prb_reserved_entry *e)
+{
+	prb_commit_all_reserved(e->rb);
+}
+
+/* given the size to reserve, determine current and next reserve pointers */
+static bool find_res_ptrs(struct printk_ringbuffer *rb, unsigned long *res_old,
+			  unsigned long *res_new, unsigned int size)
+{
+	unsigned long tail, entry_begin;
+
+	/*
+	 * The reserve pointer is not allowed to overtake the index of the
+	 * tail pointer. If this would happen, the tail pointer must be
+	 * pushed, thus removing the oldest entry.
+	 */
+	for (;;) {
+		tail = atomic_long_read(&rb->tail);
+		*res_old = atomic_long_read(&rb->reserve);
+
+		/*
+		 * If the new reserve pointer wraps, the new entry will
+		 * begin at the beginning of the data array. This loop
+		 * exists only to handle the wrap.
+		 */
+		for (entry_begin = *res_old;;) {
+
+			*res_new = entry_begin + size;
+
+			if (*res_new - tail > PRB_SIZE(rb)) {
+				/* would overtake tail, push tail */
+
+				if (!push_tail(rb, tail)) {
+					/* couldn't push tail, can't reserve */
+					return false;
+				}
+
+				/* tail pushed, try again */
+				break;
+			}
+
+			if (PRB_WRAPS(rb, entry_begin) ==
+			    PRB_WRAPS(rb, *res_new)) {
+				/* reserve pointer values determined */
+				return true;
+			}
+
+			/*
+			 * The new entry will wrap. Calculate the new reserve
+			 * pointer based on the beginning of the data array
+			 * for the wrap of the new reserve pointer.
+			 */
+			entry_begin = PRB_THIS_WRAP_START_LPOS(rb, *res_new);
+		}
+	}
+}
+
+/*
+ * prb_reserve: Reserve an entry within a ring buffer.
+ * @e: A structure to be setup and reference a reserved entry.
+ * @rb: A ring buffer to reserve data within.
+ * @size: The number of bytes to reserve.
+ *
+ * Reserve an entry of at least @size bytes to be used by the caller. If
+ * successful, the data region of the entry belongs to the caller and cannot
+ * be invalidated by any other task/context. For this reason, the caller
+ * should call prb_commit() as quickly as possible in order to avoid preventing
+ * other tasks/contexts from reserving data in the case that the ring buffer
+ * has wrapped.
+ *
+ * It is safe to call this function from any context and state.
+ *
+ * Returns a pointer to the reserved data (and @e is setup to reference the
+ * entry containing that data) or NULL if it was not possible to reserve data.
+ */
+char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		  unsigned int size)
+{
+	unsigned long res_old, res_new;
+	struct prb_entry *entry;
+
+	if (size == 0)
+		return NULL;
+
+	/* add entry header to size and align for the following entry */
+	size = PRB_ENTRY_ALIGN_SIZE(sizeof(struct prb_entry) + size);
+
+	if (size >= PRB_SIZE(rb))
+		return NULL;
+
+	/*
+	 * Lock out all other CPUs and disable interrupts. Only NMIs will
+	 * be able to interrupt. It will stay this way until the matching
+	 * commit is called.
+	 */
+	prb_lock(rb->cpulock);
+
+	/*
+	 * Clarify the responsibility of this context. If this context
+	 * increments ctx to 1, this context is responsible for pushing
+	 * the head pointer beyond all reserved entries on commit.
+	 */
+	atomic_inc(&rb->ctx);
+
+	/*
+	 * Move the reserve pointer forward. Since NMIs can interrupt at any
+	 * time, modifying the reserve pointer is done in a cmpxchg loop.
+	 */
+	do {
+		if (!find_res_ptrs(rb, &res_old, &res_new, size)) {
+			/*
+			 * Not possible to move the reserve pointer. Try to
+			 * commit all reserved entries because this context
+			 * might have that responsibility (if it incremented
+			 * ctx to 1).
+			 */
+			prb_commit_all_reserved(rb);
+			return NULL;
+		}
+	} while (!atomic_long_try_cmpxchg_acquire(&rb->reserve,
+						  &res_old, res_new));
+
+	entry = to_entry(rb, res_old);
+	if (PRB_WRAPS(rb, res_old) != PRB_WRAPS(rb, res_new)) {
+		/*
+		 * The reserve wraps. Create the terminating entry and get the
+		 * pointer to the actually reserved entry at the beginning of
+		 * the data array on the wrap of the new reserve pointer.
+		 */
+		entry->size = -1;
+		entry = to_entry(rb, PRB_THIS_WRAP_START_LPOS(rb, res_new));
+	}
+
+	/* The size is set now. The seq is set later, on commit. */
+	entry->size = size;
+
+	e->rb = rb;
+	return &entry->data[0];
+}
