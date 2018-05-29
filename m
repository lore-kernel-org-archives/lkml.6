Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935604AbeE2PXf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935450AbeE2PX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:29 -0400
Message-Id: <20180529152326.556999106@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [for-next][PATCH 04/19] tracing: Add __find_event_file() to find event files without
 restrictions
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0004-tracing-Add-__find_event_file-to-find-event-files-wi.patch
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

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h        |  3 +++
 kernel/trace/trace_events.c | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6bfc2467479c..07c43960a704 100644
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
