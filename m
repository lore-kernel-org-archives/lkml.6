Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeEKTxt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbeEKTxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:53:41 -0400
Message-Id: <20180511195340.297584458@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 11 May 2018 15:49:29 -0400
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
Subject: [RFC][PATCH 02/10] tracing: Add __find_event_file() to find event files without
 restrictions
References: <20180511194927.190877137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-Add-__find_event_file-to-find-event-files-wi.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

By adding the function __find_event_file() that can search for files without
restrictions, such as if the event associated with the file has a reg
function, or if it has the "ignore" flag set, the files that are associated
to ftrace internal events (like trace_marker and function events) can be
found and used.

find_event_file() still returns a "filtered" file, as most callers need a
valid trace event file. One created by the trace_events.h macros and not one
created for parsing ftrace specific events.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h        |  3 +++
 kernel/trace/trace_events.c | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 24b666891eaf..8ecca43d6aea 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1454,6 +1454,9 @@ extern void trace_event_enable_tgid_record(bool enable);
 extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
 
+extern struct trace_event_file *__find_event_file(struct trace_array *tr,
+						  const char *system,
+						  const char *event);
 extern struct trace_event_file *find_event_file(struct trace_array *tr,
 						const char *system,
 						const char *event);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 05c7172c6667..caf76355f0a3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2473,8 +2473,9 @@ __trace_add_event_dirs(struct trace_array *tr)
 	}
 }
 
+/* Returns any file that matches the system and event */
 struct trace_event_file *
-find_event_file(struct trace_array *tr, const char *system,  const char *event)
+__find_event_file(struct trace_array *tr, const char *system, const char *event)
 {
 	struct trace_event_file *file;
 	struct trace_event_call *call;
@@ -2485,10 +2486,7 @@ find_event_file(struct trace_array *tr, const char *system,  const char *event)
 		call = file->event_call;
 		name = trace_event_name(call);
 
-		if (!name || !call->class || !call->class->reg)
-			continue;
-
-		if (call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)
+		if (!name || !call->class)
 			continue;
 
 		if (strcmp(event, name) == 0 &&
@@ -2498,6 +2496,20 @@ find_event_file(struct trace_array *tr, const char *system,  const char *event)
 	return NULL;
 }
 
+/* Returns valid trace event files that match system and event */
+struct trace_event_file *
+find_event_file(struct trace_array *tr, const char *system, const char *event)
+{
+	struct trace_event_file *file;
+
+	file = __find_event_file(tr, system, event);
+	if (!file || !file->event_call->class->reg ||
+	    file->event_call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)
+		return NULL;
+
+	return file;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 /* Avoid typos */
-- 
2.17.0
