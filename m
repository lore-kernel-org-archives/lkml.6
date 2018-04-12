Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDLByr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbeDLBym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:54:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EEB2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180412015441.083284319@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 11 Apr 2018 21:54:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com
Subject: [PATCH 5/5] tracing: Enforce passing in filter=NULL to create_filter()
References: <20180412015359.244491749@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-tracing-Enforce-passing-in-filter-NULL-to-create_fil.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's some inconsistency with what to set the output parameter filterp
when passing to create_filter(..., struct event_filter **filterp).

Whatever filterp points to, should be NULL when calling this function. The
create_filter() calls create_filter_start() with a pointer to a local
"filter" variable that is set to NULL. The create_filter_start() has a
WARN_ON() if the passed in pointer isn't pointing to a value set to NULL.

Ideally, create_filter() should pass the filterp variable it received to
create_filter_start() and not hide it as with a local variable, this allowed
create_filter() to fail, and not update the passed in filter, and the caller
of create_filter() then tried to free filter, which was never initialized to
anything, causing memory corruption.

Link: http://lkml.kernel.org/r/00000000000032a0c30569916870@google.com

Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Reported-by: syzbot+dadcc936587643d7f568@syzkaller.appspotmail.com
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5eba1cec945c..9b4716bb8bb0 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1704,18 +1704,16 @@ static int create_filter(struct trace_event_call *call,
 			 struct event_filter **filterp)
 {
 	struct filter_parse_error *pe = NULL;
-	struct event_filter *filter = NULL;
 	int err;
 
-	err = create_filter_start(filter_string, set_str, &pe, &filter);
+	err = create_filter_start(filter_string, set_str, &pe, filterp);
 	if (err)
 		return err;
 
-	err = process_preds(call, filter_string, filter, pe);
+	err = process_preds(call, filter_string, *filterp, pe);
 	if (err && set_str)
-		append_filter_err(pe, filter);
+		append_filter_err(pe, *filterp);
 
-	*filterp = filter;
 	return err;
 }
 
@@ -1739,24 +1737,22 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 				struct trace_array *tr,
 				char *filter_str, struct event_filter **filterp)
 {
-	struct event_filter *filter = NULL;
 	struct filter_parse_error *pe = NULL;
 	int err;
 
-	err = create_filter_start(filter_str, true, &pe, &filter);
+	err = create_filter_start(filter_str, true, &pe, filterp);
 	if (!err) {
 		err = process_system_preds(dir, tr, pe, filter_str);
 		if (!err) {
 			/* System filters just show a default message */
-			kfree(filter->filter_string);
-			filter->filter_string = NULL;
+			kfree((*filterp)->filter_string);
+			(*filterp)->filter_string = NULL;
 		} else {
-			append_filter_err(pe, filter);
+			append_filter_err(pe, *filterp);
 		}
 	}
 	create_filter_finish(pe);
 
-	*filterp = filter;
 	return err;
 }
 
@@ -1764,7 +1760,7 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 int apply_event_filter(struct trace_event_file *file, char *filter_string)
 {
 	struct trace_event_call *call = file->event_call;
-	struct event_filter *filter;
+	struct event_filter *filter = NULL;
 	int err;
 
 	if (!strcmp(strstrip(filter_string), "0")) {
@@ -1817,7 +1813,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 {
 	struct event_subsystem *system = dir->subsystem;
 	struct trace_array *tr = dir->tr;
-	struct event_filter *filter;
+	struct event_filter *filter = NULL;
 	int err = 0;
 
 	mutex_lock(&event_mutex);
@@ -2024,7 +2020,7 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 			      char *filter_str)
 {
 	int err;
-	struct event_filter *filter;
+	struct event_filter *filter = NULL;
 	struct trace_event_call *call;
 
 	mutex_lock(&event_mutex);
-- 
2.16.3
