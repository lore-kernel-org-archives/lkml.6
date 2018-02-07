Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbeBGU3M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754705AbeBGU2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:28:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FF4217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180207202817.368040144@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 07 Feb 2018 15:24:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 18/20 v2] tracing/perf: Allow perf to use function based events
References: <20180207202402.253089656@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0018-tracing-perf-Allow-perf-to-use-function-based-events.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Have perf use function based events.

 # echo 'SyS_openat(int dfd, string buf, x32 flags, x32 mode)' > /sys/kernel/tracing/function_events
 # perf record -e functions:SyS_openat grep task_forks /proc/kallsyms
 # perf script
    grep   913 [002]  5713.413239: functions:SyS_openat: entry_SYSCALL_64_fastpath->sys_openat(dfd=-100, buf=/proc/kallsyms, flags=100, mode=0)

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/function-based-events.rst |   3 +-
 kernel/trace/trace_event_ftrace.c             | 134 ++++++++++++++++++++------
 2 files changed, 104 insertions(+), 33 deletions(-)

diff --git a/Documentation/trace/function-based-events.rst b/Documentation/trace/function-based-events.rst
index 3b341992b93d..6effde96d3d6 100644
--- a/Documentation/trace/function-based-events.rst
+++ b/Documentation/trace/function-based-events.rst
@@ -48,7 +48,8 @@ enable  filter  format  hist  id  trigger
 
 Even though the above function based event does not record much more
 than the function tracer does, it does become a full fledge event.
-This can be used by the histogram infrastructure, and triggers.
+This can be used by the histogram infrastructure, triggers, and perf
+where one can attach eBPF programs to.
 
  # cat events/functions/do_IRQ/format
 name: do_IRQ
diff --git a/kernel/trace/trace_event_ftrace.c b/kernel/trace/trace_event_ftrace.c
index 732ba570466b..303a56c3339a 100644
--- a/kernel/trace/trace_event_ftrace.c
+++ b/kernel/trace/trace_event_ftrace.c
@@ -749,46 +749,33 @@ static int get_string(unsigned long addr, unsigned int idx,
 	return len;
 }
 
-static void func_event_trace(struct trace_event_file *trace_file,
-			     struct func_event *func_event,
-			     unsigned long ip, unsigned long parent_ip,
-			     struct pt_regs *pt_regs)
+static int get_event_size(struct func_event *func_event, struct pt_regs *pt_regs,
+			  long *args, int *nr_args)
 {
-	struct func_event_hdr *entry;
-	struct trace_event_call *call = &func_event->call;
-	struct ring_buffer_event *event;
-	struct ring_buffer *buffer;
-	struct func_arg *arg;
-	long args[func_event->arg_cnt];
-	long long val = 1;
-	unsigned long irq_flags;
-	int str_offset;
-	int str_idx = 0;
-	int nr_args = 0;
 	int size;
-	int pc;
-
-	if (trace_trigger_soft_disabled(trace_file))
-		return;
-
-	local_save_flags(irq_flags);
-	pc = preempt_count();
 
-	size = func_event->arg_offset + sizeof(*entry);
+	size = func_event->arg_offset + sizeof(struct func_event_hdr);
 
 	if (func_event->arg_cnt)
-		nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
+		*nr_args = arch_get_func_args(pt_regs, 0, func_event->arg_cnt, args);
+	else
+		*nr_args = 0;
 
 	if (func_event->has_strings)
-		size += calculate_strings(func_event, nr_args, args);
+		size += calculate_strings(func_event, *nr_args, args);
 
-	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
-						call->event.type,
-						size, irq_flags, pc);
-	if (!event)
-		return;
+	return size;
+}
+
+static void
+record_entry(struct func_event_hdr *entry, struct func_event *func_event,
+	     unsigned long ip, unsigned long parent_ip, int nr_args, long *args)
+{
+	struct func_arg *arg;
+	long long val;
+	int str_offset;
+	int str_idx = 0;
 
-	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 	entry->parent_ip = parent_ip;
 
@@ -811,11 +798,80 @@ static void func_event_trace(struct trace_event_file *trace_file,
 		} else
 			memcpy(&entry->data[arg->offset], &val, arg->size);
 	}
+}
+
+static void func_event_trace(struct trace_event_file *trace_file,
+			     struct func_event *func_event,
+			     unsigned long ip, unsigned long parent_ip,
+			     struct pt_regs *pt_regs)
+{
+	struct func_event_hdr *entry;
+	struct trace_event_call *call = &func_event->call;
+	struct ring_buffer_event *event;
+	struct ring_buffer *buffer;
+	long args[func_event->arg_cnt];
+	unsigned long irq_flags;
+	int nr_args;
+	int size;
+	int pc;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	local_save_flags(irq_flags);
+	pc = preempt_count();
+
+	size = get_event_size(func_event, pt_regs, args, &nr_args);
+
+	event = trace_event_buffer_lock_reserve(&buffer, trace_file,
+						call->event.type,
+						size, irq_flags, pc);
+	if (!event)
+		return;
 
+	entry = ring_buffer_event_data(event);
+	record_entry(entry, func_event, ip, parent_ip, nr_args, args);
 	event_trigger_unlock_commit_regs(trace_file, buffer, event,
 					 entry, irq_flags, pc, pt_regs);
 }
 
+#ifdef CONFIG_PERF_EVENTS
+/* Kprobe profile handler */
+static void func_event_perf(struct func_event *func_event,
+			    unsigned long ip, unsigned long parent_ip,
+			    struct pt_regs *pt_regs)
+{
+	struct trace_event_call *call = &func_event->call;
+	struct func_event_hdr *entry;
+	struct hlist_head *head;
+	long args[func_event->arg_cnt];
+	int nr_args = 0;
+	int rctx;
+	int size;
+
+	if (bpf_prog_array_valid(call) && !trace_call_bpf(call, pt_regs))
+		return;
+
+	head = this_cpu_ptr(call->perf_events);
+	if (hlist_empty(head))
+		return;
+
+	size = get_event_size(func_event, pt_regs, args, &nr_args);
+
+	entry = perf_trace_buf_alloc(size, NULL, &rctx);
+	if (!entry)
+		return;
+
+	record_entry(entry, func_event, ip, parent_ip, nr_args, args);
+	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, pt_regs,
+			      head, NULL);
+}
+#else
+static inline void func_event_perf(struct func_event *func_event,
+				   unsigned long ip, unsigned long parent_ip,
+				   struct pt_regs *pt_regs) { }
+#endif
+
 static void
 func_event_call(unsigned long ip, unsigned long parent_ip,
 		    struct ftrace_ops *op, struct pt_regs *pt_regs)
@@ -830,7 +886,10 @@ func_event_call(unsigned long ip, unsigned long parent_ip,
 	rcu_irq_enter_irqson();
 	rcu_read_lock_sched_notrace();
 	list_for_each_entry_rcu(ff, &func_event->files, list) {
-		func_event_trace(ff->file, func_event, ip, parent_ip, pt_regs);
+		if (ff->file)
+			func_event_trace(ff->file, func_event, ip, parent_ip, pt_regs);
+		else
+			func_event_perf(func_event, ip, parent_ip, pt_regs);
 	}
 	rcu_read_unlock_sched_notrace();
 	rcu_irq_exit_irqson();
@@ -1047,6 +1106,17 @@ static int func_event_register(struct trace_event_call *event,
 		return enable_func_event(func_event, file);
 	case TRACE_REG_UNREGISTER:
 		return disable_func_event(func_event, file);
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		return enable_func_event(func_event, NULL);
+	case TRACE_REG_PERF_UNREGISTER:
+		return disable_func_event(func_event, NULL);
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		return 0;
+#endif
 	default:
 		break;
 	}
-- 
2.15.1
