Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEKTxu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbeEKTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:53:42 -0400
Message-Id: <20180511195340.438096887@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 11 May 2018 15:49:30 -0400
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
Subject: [RFC][PATCH 03/10] tracing: Have event_trace_init() called by trace_init_tracefs()
References: <20180511194927.190877137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-tracing-Have-event_trace_init-called-by-trace_init_t.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of having both trace_init_tracefs() and event_trace_init() be called
by fs_initcall() routines, have event_trace_init() called directly by
trace_init_tracefs(). This will guarantee order of how the events are
created with respect to the rest of the ftrace infrastructure. This is
needed to be able to assoctiate event files with ftrace internal events,
such as the trace_marker.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 2 ++
 kernel/trace/trace.h        | 1 +
 kernel/trace/trace_events.c | 4 +---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 414d7210b2ec..e0d6ffb76985 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8111,6 +8111,8 @@ static __init int tracer_init_tracefs(void)
 	if (IS_ERR(d_tracer))
 		return 0;
 
+	event_trace_init();
+
 	init_tracer_tracefs(&global_trace, d_tracer);
 	ftrace_init_tracefs_toplevel(&global_trace, d_tracer);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8ecca43d6aea..2414fd72dedd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1451,6 +1451,7 @@ trace_find_event_field(struct trace_event_call *call, char *name);
 extern void trace_event_enable_cmd_record(bool enable);
 extern void trace_event_enable_tgid_record(bool enable);
 
+extern int event_trace_init(void);
 extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index caf76355f0a3..5b647904a65b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3144,7 +3144,7 @@ static __init int event_trace_enable_again(void)
 
 early_initcall(event_trace_enable_again);
 
-static __init int event_trace_init(void)
+__init int event_trace_init(void)
 {
 	struct trace_array *tr;
 	struct dentry *d_tracer;
@@ -3189,8 +3189,6 @@ void __init trace_event_init(void)
 	event_trace_enable();
 }
 
-fs_initcall(event_trace_init);
-
 #ifdef CONFIG_FTRACE_STARTUP_TEST
 
 static DEFINE_SPINLOCK(test_spinlock);
-- 
2.17.0
