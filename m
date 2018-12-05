Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F0DC07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF0D20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF0D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeLEXti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbeLEXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5D1214DA;
        Wed,  5 Dec 2018 23:48:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu6-0000EO-Re; Wed, 05 Dec 2018 18:48:30 -0500
Message-Id: <20181205234830.758310141@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [for-next][PATCH 16/30] ring-buffer: Add percentage of ring buffer full to wake up reader
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of just waiting for a page to be full before waking up a pending
reader, allow the reader to pass in a "percentage" of pages that have
content before waking up a reader. This should help keep the process of
reading the events not cause wake ups that constantly cause reading of the
buffer.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  4 ++-
 kernel/trace/ring_buffer.c  | 71 ++++++++++++++++++++++++++++++++++---
 kernel/trace/trace.c        |  8 ++---
 3 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0940fda59872..5b9ae62272bb 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -97,7 +97,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
-int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full);
+int ring_buffer_wait(struct ring_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table);
 
@@ -189,6 +189,8 @@ bool ring_buffer_time_stamp_abs(struct ring_buffer *buffer);
 
 size_t ring_buffer_page_len(void *page);
 
+size_t ring_buffer_nr_pages(struct ring_buffer *buffer, int cpu);
+size_t ring_buffer_nr_dirty_pages(struct ring_buffer *buffer, int cpu);
 
 void *ring_buffer_alloc_read_page(struct ring_buffer *buffer, int cpu);
 void ring_buffer_free_read_page(struct ring_buffer *buffer, int cpu, void *data);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 65bd4616220d..9edb628603ab 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -487,6 +487,9 @@ struct ring_buffer_per_cpu {
 	local_t				dropped_events;
 	local_t				committing;
 	local_t				commits;
+	local_t				pages_touched;
+	local_t				pages_read;
+	size_t				shortest_full;
 	unsigned long			read;
 	unsigned long			read_bytes;
 	u64				write_stamp;
@@ -529,6 +532,41 @@ struct ring_buffer_iter {
 	u64				read_stamp;
 };
 
+/**
+ * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
+ * @buffer: The ring_buffer to get the number of pages from
+ * @cpu: The cpu of the ring_buffer to get the number of pages from
+ *
+ * Returns the number of pages used by a per_cpu buffer of the ring buffer.
+ */
+size_t ring_buffer_nr_pages(struct ring_buffer *buffer, int cpu)
+{
+	return buffer->buffers[cpu]->nr_pages;
+}
+
+/**
+ * ring_buffer_nr_pages_dirty - get the number of used pages in the ring buffer
+ * @buffer: The ring_buffer to get the number of pages from
+ * @cpu: The cpu of the ring_buffer to get the number of pages from
+ *
+ * Returns the number of pages that have content in the ring buffer.
+ */
+size_t ring_buffer_nr_dirty_pages(struct ring_buffer *buffer, int cpu)
+{
+	size_t read;
+	size_t cnt;
+
+	read = local_read(&buffer->buffers[cpu]->pages_read);
+	cnt = local_read(&buffer->buffers[cpu]->pages_touched);
+	/* The reader can read an empty page, but not more than that */
+	if (cnt < read) {
+		WARN_ON_ONCE(read > cnt + 1);
+		return 0;
+	}
+
+	return cnt - read;
+}
+
 /*
  * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
  *
@@ -556,7 +594,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
  * as data is added to any of the @buffer's cpu buffers. Otherwise
  * it will wait for data to be added to a specific cpu buffer.
  */
-int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
+int ring_buffer_wait(struct ring_buffer *buffer, int cpu, int full)
 {
 	struct ring_buffer_per_cpu *uninitialized_var(cpu_buffer);
 	DEFINE_WAIT(wait);
@@ -571,7 +609,7 @@ int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
 	if (cpu == RING_BUFFER_ALL_CPUS) {
 		work = &buffer->irq_work;
 		/* Full only makes sense on per cpu reads */
-		full = false;
+		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return -ENODEV;
@@ -623,15 +661,22 @@ int ring_buffer_wait(struct ring_buffer *buffer, int cpu, bool full)
 		    !ring_buffer_empty_cpu(buffer, cpu)) {
 			unsigned long flags;
 			bool pagebusy;
+			size_t nr_pages;
+			size_t dirty;
 
 			if (!full)
 				break;
 
 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+			nr_pages = cpu_buffer->nr_pages;
+			dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+			if (!cpu_buffer->shortest_full ||
+			    cpu_buffer->shortest_full < full)
+				cpu_buffer->shortest_full = full;
 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-
-			if (!pagebusy)
+			if (!pagebusy &&
+			    (!nr_pages || (dirty * 100) > full * nr_pages))
 				break;
 		}
 
@@ -1054,6 +1099,7 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
+	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -2603,6 +2649,16 @@ rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 	pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
 
 	if (!pagebusy && cpu_buffer->irq_work.full_waiters_pending) {
+		size_t nr_pages;
+		size_t dirty;
+		size_t full;
+
+		full = cpu_buffer->shortest_full;
+		nr_pages = cpu_buffer->nr_pages;
+		dirty = ring_buffer_nr_dirty_pages(buffer, cpu_buffer->cpu);
+		if (full && nr_pages && (dirty * 100) <= full * nr_pages)
+			return;
+
 		cpu_buffer->irq_work.wakeup_full = true;
 		cpu_buffer->irq_work.full_waiters_pending = false;
 		/* irq_work_queue() supplies it's own memory barriers */
@@ -3732,13 +3788,15 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 		goto spin;
 
 	/*
-	 * Yeah! We succeeded in replacing the page.
+	 * Yay! We succeeded in replacing the page.
 	 *
 	 * Now make the new head point back to the reader page.
 	 */
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
 	rb_inc_page(cpu_buffer, &cpu_buffer->head_page);
 
+	local_inc(&cpu_buffer->pages_read);
+
 	/* Finally update the reader page to the new head */
 	cpu_buffer->reader_page = reader;
 	cpu_buffer->reader_page->read = 0;
@@ -4334,6 +4392,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->entries, 0);
 	local_set(&cpu_buffer->committing, 0);
 	local_set(&cpu_buffer->commits, 0);
+	local_set(&cpu_buffer->pages_touched, 0);
+	local_set(&cpu_buffer->pages_read, 0);
+	cpu_buffer->shortest_full = 0;
 	cpu_buffer->read = 0;
 	cpu_buffer->read_bytes = 0;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ff1c4b20cd0a..48d5eb22ff33 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1431,7 +1431,7 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 }
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
-static int wait_on_pipe(struct trace_iterator *iter, bool full)
+static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
@@ -5693,7 +5693,7 @@ static int tracing_wait_pipe(struct file *filp)
 
 		mutex_unlock(&iter->mutex);
 
-		ret = wait_on_pipe(iter, false);
+		ret = wait_on_pipe(iter, 0);
 
 		mutex_lock(&iter->mutex);
 
@@ -6751,7 +6751,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 
-			ret = wait_on_pipe(iter, false);
+			ret = wait_on_pipe(iter, 0);
 			if (ret)
 				return ret;
 
@@ -6948,7 +6948,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
 			goto out;
 
-		ret = wait_on_pipe(iter, true);
+		ret = wait_on_pipe(iter, 1);
 		if (ret)
 			goto out;
 
-- 
2.19.1


