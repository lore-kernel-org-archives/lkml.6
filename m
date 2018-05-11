Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEKTyy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbeEKTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:53:42 -0400
Message-Id: <20180511195340.876528094@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 11 May 2018 15:49:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-rt-users@vger.kernel.org
Subject: [RFC][PATCH 06/10] tracing: Add trigger file for trace_markers tracefs/ftrace/print
References: <20180511194927.190877137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0006-tracing-Add-trigger-file-for-trace_markers-tracefs-f.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Allow writing to the trace_markers file initiate triggers defined in
tracefs/ftrace/print/trigger file. This will allow of user space to trigger
the same type of triggers (including histograms) that the trace events use.

Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Karim Yaghmour <karim.yaghmour@opersys.com>
Cc: Brendan Gregg <bgregg@netflix.com>
Suggested-by: Joel Fernandes <joelaf@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c         | 17 +++++++++++++++++
 kernel/trace/trace.h         |  1 +
 kernel/trace/trace_entries.h |  6 ++++--
 kernel/trace/trace_export.c  |  7 +++++++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e0d6ffb76985..f11b89fa5049 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6074,6 +6074,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	struct ring_buffer_event *event;
+	enum event_trigger_type tt = ETT_NONE;
 	struct ring_buffer *buffer;
 	struct print_entry *entry;
 	unsigned long irq_flags;
@@ -6122,6 +6123,12 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		written = cnt;
 	len = cnt;
 
+	if (tr->trace_marker_file && !list_empty(&tr->trace_marker_file->triggers)) {
+		/* do not add \n before testing triggers, but add \0 */
+		entry->buf[cnt] = '\0';
+		tt = event_triggers_call(tr->trace_marker_file, entry, event);
+	}
+
 	if (entry->buf[cnt - 1] != '\n') {
 		entry->buf[cnt] = '\n';
 		entry->buf[cnt + 1] = '\0';
@@ -6130,6 +6137,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	__buffer_unlock_commit(buffer, event);
 
+	if (tt)
+		event_triggers_post_call(tr->trace_marker_file, tt);
+
 	if (written > 0)
 		*fpos += written;
 
@@ -7896,6 +7906,7 @@ static __init void create_trace_instances(struct dentry *d_tracer)
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
+	struct trace_event_file *file;
 	int cpu;
 
 	trace_create_file("available_tracers", 0444, d_tracer,
@@ -7928,6 +7939,12 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("trace_marker", 0220, d_tracer,
 			  tr, &tracing_mark_fops);
 
+	file = __find_event_file(tr, "ftrace", "print");
+	if (file && file->dir)
+		trace_create_file("trigger", 0644, file->dir, file,
+				  &event_trigger_fops);
+	tr->trace_marker_file = file;
+
 	trace_create_file("trace_marker_raw", 0220, d_tracer,
 			  tr, &tracing_mark_raw_fops);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2414fd72dedd..c7fa58d31a84 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -259,6 +259,7 @@ struct trace_array {
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
+	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
 	int			ref;
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index e3a658bac10f..de3fce14cd00 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -230,7 +230,7 @@ FTRACE_ENTRY(bprint, bprint_entry,
 	FILTER_OTHER
 );
 
-FTRACE_ENTRY(print, print_entry,
+FTRACE_ENTRY_REG(print, print_entry,
 
 	TRACE_PRINT,
 
@@ -242,7 +242,9 @@ FTRACE_ENTRY(print, print_entry,
 	F_printk("%ps: %s",
 		 (void *)__entry->ip, __entry->buf),
 
-	FILTER_OTHER
+	FILTER_OTHER,
+
+	 ftrace_event_register
 );
 
 FTRACE_ENTRY(raw_data, raw_data_entry,
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index d842f1eadfe5..45630a76ed3a 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -14,6 +14,13 @@
 
 #include "trace_output.h"
 
+/* Stub function for events with triggers */
+static int ftrace_event_register(struct trace_event_call *call,
+				 enum trace_reg type, void *data)
+{
+	return 0;
+}
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM	ftrace
 
-- 
2.17.0
