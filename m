Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbeDJNNR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753244AbeDJNNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:13:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D54C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 10 Apr 2018 09:13:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410091311.20bd8ccc@gandalf.local.home>
In-Reply-To: <20180410083625.2c904ab2@gandalf.local.home>
References: <20180410061447.GQ21835@dhcp22.suse.cz>
        <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
        <20180410074921.GU21835@dhcp22.suse.cz>
        <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
        <20180410081231.GV21835@dhcp22.suse.cz>
        <CAGWkznEM=AX=3LWDmgyz4GRkWy81TNdFQQXZ7+W4=Ek4ZsnsJw@mail.gmail.com>
        <20180410090128.GY21835@dhcp22.suse.cz>
        <CAGWkznEf0siz1-RFSJwuKCjUtbKM=P1djo2Nc7sU1GS0AgWv2w@mail.gmail.com>
        <20180410104902.GC21835@dhcp22.suse.cz>
        <20180410082316.263d34ec@gandalf.local.home>
        <20180410122706.GH21835@dhcp22.suse.cz>
        <20180410083625.2c904ab2@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 08:36:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Apr 2018 14:27:06 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > I would rather that the code outside of MM not touch implementation
> > details like OOM_SCORE_ADJ_MIN. It is really hard to get rid of abusers
> > whenever you try to change something in MM then. Especially when the
> > usecase is quite dubious.  
> 
> Fair enough. I was reluctant to use the OOM_SCORE_ADJ_MIN in this case.
> 
> Perhaps I can create an option that lets users decide how they want to
> allocate.
> 
> For people like Joel, it will try hard (by default) and set oom_origin,
> but the user could also set an option "no_mem_reclaim", where it will
> not set oom_origin, but will also use NORETRY as well, where it wont
> trigger OOM and will not be the designated victim of OOM. But it will
> likely not allocate memory if the system is under heavy use. Then for
> Zhaoyang's tests, all he has to do is to set that option (or clear it,
> if the option is "mem_reclaim", which is what I'll probably call it).
> 


Something like this:

-- Steve

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index a0233edc0718..807e2bcb21b3 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -106,7 +106,8 @@ __poll_t ring_buffer_poll_wait(struct ring_buffer *buffer, int cpu,
 
 void ring_buffer_free(struct ring_buffer *buffer);
 
-int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size, int cpu);
+int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
+			int cpu, int rbflags);
 
 void ring_buffer_change_overwrite(struct ring_buffer *buffer, int val);
 
@@ -201,6 +202,7 @@ int ring_buffer_print_page_header(struct trace_seq *s);
 
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
+	RB_FL_NO_RECLAIM	= 1 << 1,
 };
 
 #ifdef CONFIG_RING_BUFFER
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c9cb9767d49b..b7fd541ca025 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1160,7 +1160,8 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	return 0;
 }
 
-static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
+static int __rb_allocate_pages(long nr_pages, struct list_head *pages,
+			       int cpu, int rbflags)
 {
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
@@ -1185,6 +1186,12 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 	 */
 	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
 
+	/* Do not try hard to get memory, and do not trigger OOM */
+	if (rbflags & RB_FL_NO_RECLAIM) {
+		mflags = GFP_KERNEL | __GFP_NORETRY;
+		user_thread = false;
+	}
+
 	/*
 	 * If a user thread allocates too much, and si_mem_available()
 	 * reports there's enough memory, even though there is not.
@@ -1232,13 +1239,13 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 }
 
 static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
-			     unsigned long nr_pages)
+			     unsigned long nr_pages, int rbflags)
 {
 	LIST_HEAD(pages);
 
 	WARN_ON(!nr_pages);
 
-	if (__rb_allocate_pages(nr_pages, &pages, cpu_buffer->cpu))
+	if (__rb_allocate_pages(nr_pages, &pages, cpu_buffer->cpu, rbflags))
 		return -ENOMEM;
 
 	/*
@@ -1297,7 +1304,7 @@ rb_allocate_cpu_buffer(struct ring_buffer *buffer, long nr_pages, int cpu)
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
 
-	ret = rb_allocate_pages(cpu_buffer, nr_pages);
+	ret = rb_allocate_pages(cpu_buffer, nr_pages, buffer->flags);
 	if (ret < 0)
 		goto fail_free_reader;
 
@@ -1685,7 +1692,7 @@ static void update_pages_handler(struct work_struct *work)
  * Returns 0 on success and < 0 on failure.
  */
 int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
-			int cpu_id)
+			int cpu_id, int rbflags)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long nr_pages;
@@ -1739,7 +1746,7 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 			 */
 			INIT_LIST_HEAD(&cpu_buffer->new_pages);
 			if (__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
-						&cpu_buffer->new_pages, cpu)) {
+					&cpu_buffer->new_pages, cpu, rbflags)) {
 				/* not enough memory for new pages */
 				err = -ENOMEM;
 				goto out_err;
@@ -1795,7 +1802,7 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
 		if (cpu_buffer->nr_pages_to_update > 0 &&
 			__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
-					    &cpu_buffer->new_pages, cpu_id)) {
+					&cpu_buffer->new_pages, cpu_id, rbflags)) {
 			err = -ENOMEM;
 			goto out_err;
 		}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e18e69183c9a..ff0164affe0a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -250,7 +250,8 @@ unsigned long long ns2usecs(u64 nsec)
 	 TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |			\
 	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
 	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
-	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS)
+	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
+	 TRACE_ITER_MEM_RECLAIM)
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
@@ -974,7 +975,7 @@ static void free_snapshot(struct trace_array *tr)
 	 * The max_tr ring buffer has some state (e.g. ring->clock) and
 	 * we want preserve it.
 	 */
-	ring_buffer_resize(tr->max_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
+	ring_buffer_resize(tr->max_buffer.buffer, 1, RING_BUFFER_ALL_CPUS, 0);
 	set_buffer_entries(&tr->max_buffer, 1);
 	tracing_reset_online_cpus(&tr->max_buffer);
 	tr->allocated_snapshot = false;
@@ -1494,7 +1495,9 @@ static int run_tracer_selftest(struct tracer *type)
 		/* If we expanded the buffers, make sure the max is expanded too */
 		if (ring_buffer_expanded)
 			ring_buffer_resize(tr->max_buffer.buffer, trace_buf_size,
-					   RING_BUFFER_ALL_CPUS);
+					   RING_BUFFER_ALL_CPUS,
+					   tr->trace_flags & TRACE_ITER_MEM_RECLAIM ?
+					   0 : RB_FL_NO_RECLAIM);
 		tr->allocated_snapshot = true;
 	}
 #endif
@@ -1520,7 +1523,9 @@ static int run_tracer_selftest(struct tracer *type)
 		/* Shrink the max buffer again */
 		if (ring_buffer_expanded)
 			ring_buffer_resize(tr->max_buffer.buffer, 1,
-					   RING_BUFFER_ALL_CPUS);
+					   RING_BUFFER_ALL_CPUS,
+					   tr->trace_flags & TRACE_ITER_MEM_RECLAIM ?
+					   0 : RB_FL_NO_RECLAIM);
 	}
 #endif
 
@@ -5168,7 +5173,7 @@ static int resize_buffer_duplicate_size(struct trace_buffer *trace_buf,
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			ret = ring_buffer_resize(trace_buf->buffer,
-				 per_cpu_ptr(size_buf->data, cpu)->entries, cpu);
+				 per_cpu_ptr(size_buf->data, cpu)->entries, cpu, 0);
 			if (ret < 0)
 				break;
 			per_cpu_ptr(trace_buf->data, cpu)->entries =
@@ -5176,7 +5181,7 @@ static int resize_buffer_duplicate_size(struct trace_buffer *trace_buf,
 		}
 	} else {
 		ret = ring_buffer_resize(trace_buf->buffer,
-				 per_cpu_ptr(size_buf->data, cpu_id)->entries, cpu_id);
+				 per_cpu_ptr(size_buf->data, cpu_id)->entries, cpu_id, 0);
 		if (ret == 0)
 			per_cpu_ptr(trace_buf->data, cpu_id)->entries =
 				per_cpu_ptr(size_buf->data, cpu_id)->entries;
@@ -5202,7 +5207,9 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->trace_buffer.buffer)
 		return 0;
 
-	ret = ring_buffer_resize(tr->trace_buffer.buffer, size, cpu);
+	ret = ring_buffer_resize(tr->trace_buffer.buffer, size, cpu,
+				 tr->trace_flags & TRACE_ITER_MEM_RECLAIM ?
+				 0 : RB_FL_NO_RECLAIM);
 	if (ret < 0)
 		return ret;
 
@@ -5211,7 +5218,9 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	    !tr->current_trace->use_max_tr)
 		goto out;
 
-	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
+	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu,
+				 tr->trace_flags & TRACE_ITER_MEM_RECLAIM ?
+				 0 : RB_FL_NO_RECLAIM);
 	if (ret < 0) {
 		int r = resize_buffer_duplicate_size(&tr->trace_buffer,
 						     &tr->trace_buffer, cpu);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6fb46a06c9dc..2c901f52baf2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1143,6 +1143,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(IRQ_INFO,		"irq-info"),		\
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
+		C(MEM_RECLAIM,		"mem-reclaim"),		\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
