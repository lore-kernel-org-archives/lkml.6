Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCUCWp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbeCUCVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA9B2185B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022131.503299000@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 43/46] tracing: Embed replace_filter_string() helper function
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0043-tracing-Embed-replace_filter_string-helper-function.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The replace_filter_string() frees the current string and then copies a given
string. But in the two locations that it was used, the allocation happened
right after the filter was allocated (nothing to replace). There's no need
for this to be a helper function. Embedding the allocation in the two places
where it was called will make changing the code in the future easier.

Also make the variable consistent (always use "filter_string" as the name,
as it was used in one instance as "filter_str")

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2401b7c727a3..c3c6eee1e4df 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -664,17 +664,6 @@ static void remove_filter_string(struct event_filter *filter)
 	filter->filter_string = NULL;
 }
 
-static int replace_filter_string(struct event_filter *filter,
-				 char *filter_string)
-{
-	kfree(filter->filter_string);
-	filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
-	if (!filter->filter_string)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static void append_filter_err(struct filter_parse_state *ps,
 			      struct event_filter *filter)
 {
@@ -1802,9 +1791,8 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 		if (!filter)
 			goto fail_mem;
 
-		/* Can only fail on no memory */
-		err = replace_filter_string(filter, filter_string);
-		if (err)
+		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
+		if (!filter->filter_string)
 			goto fail_mem;
 
 		err = replace_preds(file->event_call, filter, ps, false);
@@ -1868,7 +1856,7 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 	return -ENOMEM;
 }
 
-static int create_filter_start(char *filter_str, bool set_str,
+static int create_filter_start(char *filter_string, bool set_str,
 			       struct filter_parse_state **psp,
 			       struct event_filter **filterp)
 {
@@ -1880,8 +1868,11 @@ static int create_filter_start(char *filter_str, bool set_str,
 
 	/* allocate everything, and if any fails, free all and fail */
 	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
-	if (filter && set_str)
-		err = replace_filter_string(filter, filter_str);
+	if (filter && set_str) {
+		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
+		if (!filter->filter_string)
+			err = -ENOMEM;
+	}
 
 	ps = kzalloc(sizeof(*ps), GFP_KERNEL);
 
@@ -1895,7 +1886,7 @@ static int create_filter_start(char *filter_str, bool set_str,
 	*filterp = filter;
 	*psp = ps;
 
-	parse_init(ps, filter_ops, filter_str);
+	parse_init(ps, filter_ops, filter_string);
 	err = filter_parse(ps);
 	if (err && set_str)
 		append_filter_err(ps, filter);
-- 
2.15.1
