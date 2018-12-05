Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A7520892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A7520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeLEXuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:50:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbeLEXsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:32 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047DD2133F;
        Wed,  5 Dec 2018 23:48:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu7-0000Ey-09; Wed, 05 Dec 2018 18:48:31 -0500
Message-Id: <20181205234830.908802709@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [for-next][PATCH 17/30] tracing: Add tracefs file buffer_percentage
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a "buffer_percentage" file, that allows users to specify how much of the
buffer (percentage of pages) need to be filled before waking up a task
blocked on a per cpu trace_pipe_raw file.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 39 ++++++++++++++++-----------
 kernel/trace/trace.c       | 54 +++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h       |  1 +
 3 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9edb628603ab..5434c16f2192 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -489,6 +489,7 @@ struct ring_buffer_per_cpu {
 	local_t				commits;
 	local_t				pages_touched;
 	local_t				pages_read;
+	long				last_pages_touch;
 	size_t				shortest_full;
 	unsigned long			read;
 	unsigned long			read_bytes;
@@ -2632,7 +2633,9 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
 static __always_inline void
 rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 {
-	bool pagebusy;
+	size_t nr_pages;
+	size_t dirty;
+	size_t full;
 
 	if (buffer->irq_work.waiters_pending) {
 		buffer->irq_work.waiters_pending = false;
@@ -2646,24 +2649,27 @@ rb_wakeups(struct ring_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 		irq_work_queue(&cpu_buffer->irq_work.work);
 	}
 
-	pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+	if (cpu_buffer->last_pages_touch == local_read(&cpu_buffer->pages_touched))
+		return;
 
-	if (!pagebusy && cpu_buffer->irq_work.full_waiters_pending) {
-		size_t nr_pages;
-		size_t dirty;
-		size_t full;
+	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
+		return;
 
-		full = cpu_buffer->shortest_full;
-		nr_pages = cpu_buffer->nr_pages;
-		dirty = ring_buffer_nr_dirty_pages(buffer, cpu_buffer->cpu);
-		if (full && nr_pages && (dirty * 100) <= full * nr_pages)
-			return;
+	if (!cpu_buffer->irq_work.full_waiters_pending)
+		return;
 
-		cpu_buffer->irq_work.wakeup_full = true;
-		cpu_buffer->irq_work.full_waiters_pending = false;
-		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&cpu_buffer->irq_work.work);
-	}
+	cpu_buffer->last_pages_touch = local_read(&cpu_buffer->pages_touched);
+
+	full = cpu_buffer->shortest_full;
+	nr_pages = cpu_buffer->nr_pages;
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu_buffer->cpu);
+	if (full && nr_pages && (dirty * 100) <= full * nr_pages)
+		return;
+
+	cpu_buffer->irq_work.wakeup_full = true;
+	cpu_buffer->irq_work.full_waiters_pending = false;
+	/* irq_work_queue() supplies it's own memory barriers */
+	irq_work_queue(&cpu_buffer->irq_work.work);
 }
 
 /*
@@ -4394,6 +4400,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->commits, 0);
 	local_set(&cpu_buffer->pages_touched, 0);
 	local_set(&cpu_buffer->pages_read, 0);
+	cpu_buffer->last_pages_touch = 0;
 	cpu_buffer->shortest_full = 0;
 	cpu_buffer->read = 0;
 	cpu_buffer->read_bytes = 0;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 48d5eb22ff33..d382fd1aa4a6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6948,7 +6948,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
 			goto out;
 
-		ret = wait_on_pipe(iter, 1);
+		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 
@@ -7662,6 +7662,53 @@ static const struct file_operations rb_simple_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t
+buffer_percent_read(struct file *filp, char __user *ubuf,
+		    size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	char buf[64];
+	int r;
+
+	r = tr->buffer_percent;
+	r = sprintf(buf, "%d\n", r);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+buffer_percent_write(struct file *filp, const char __user *ubuf,
+		     size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100)
+		return -EINVAL;
+
+	if (!val)
+		val = 1;
+
+	tr->buffer_percent = val;
+
+	(*ppos)++;
+
+	return cnt;
+}
+
+static const struct file_operations buffer_percent_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= buffer_percent_read,
+	.write		= buffer_percent_write,
+	.release	= tracing_release_generic_tr,
+	.llseek		= default_llseek,
+};
+
 struct dentry *trace_instance_dir;
 
 static void
@@ -7970,6 +8017,11 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("timestamp_mode", 0444, d_tracer, tr,
 			  &trace_time_stamp_mode_fops);
 
+	tr->buffer_percent = 1;
+
+	trace_create_file("buffer_percent", 0444, d_tracer,
+			tr, &buffer_percent_fops);
+
 	create_trace_options_dir(tr);
 
 #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ab16eca76e59..08900828d282 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -247,6 +247,7 @@ struct trace_array {
 	int			clock_id;
 	int			nr_topts;
 	bool			clear_trace;
+	int			buffer_percent;
 	struct tracer		*current_trace;
 	unsigned int		trace_flags;
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
-- 
2.19.1


