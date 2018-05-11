Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEKTzu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeEKTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:53:42 -0400
Message-Id: <20180511195340.732283838@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 11 May 2018 15:49:32 -0400
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
Subject: [RFC][PATCH 05/10] tracing: Do not show filter file for ftrace internal events
References: <20180511194927.190877137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-tracing-Do-not-show-filter-file-for-ftrace-internal-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The filter file in the ftrace internal events, like in
/sys/kernel/tracing/events/ftrace/function/filter is not attached to any
functionality. Do not create them as they are meaningless.

In the future, if an ftrace internal event gets filter functionality, then
it will need to create it directly.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5b647904a65b..14ff4ff3caab 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2007,16 +2007,18 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 			return -1;
 		}
 	}
-	trace_create_file("filter", 0644, file->dir, file,
-			  &ftrace_event_filter_fops);
 
 	/*
 	 * Only event directories that can be enabled should have
-	 * triggers.
+	 * triggers or filters.
 	 */
-	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
+	if (!(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE)) {
+		trace_create_file("filter", 0644, file->dir, file,
+				  &ftrace_event_filter_fops);
+
 		trace_create_file("trigger", 0644, file->dir, file,
 				  &event_trigger_fops);
+	}
 
 #ifdef CONFIG_HIST_TRIGGERS
 	trace_create_file("hist", 0444, file->dir, file,
-- 
2.17.0
