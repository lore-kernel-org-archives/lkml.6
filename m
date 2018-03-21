Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeCUCWr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeCUCVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F54521860
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022131.330974843@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 42/46] tracing: Only add filter list when needed
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0042-tracing-Only-add-filter-list-when-needed.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

replace_system_preds() creates a filter list to free even when it doesn't
really need to have it. Only save filters that require synchronize_sched()
in the filter list to free. This will allow the code to be updated a bit
easier in the future.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3d60bbeb2ef1..2401b7c727a3 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1769,6 +1769,7 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 {
 	struct trace_event_file *file;
 	struct filter_list *filter_item;
+	struct event_filter *filter = NULL;
 	struct filter_list *tmp;
 	LIST_HEAD(filter_list);
 	bool fail = true;
@@ -1790,7 +1791,6 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 	}
 
 	list_for_each_entry(file, &tr->events, list) {
-		struct event_filter *filter;
 
 		if (file->system != dir)
 			continue;
@@ -1798,16 +1798,9 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 		if (event_no_set_filter_flag(file))
 			continue;
 
-		filter_item = kzalloc(sizeof(*filter_item), GFP_KERNEL);
-		if (!filter_item)
-			goto fail_mem;
-
-		list_add_tail(&filter_item->list, &filter_list);
-
-		filter_item->filter = kzalloc(sizeof(*filter), GFP_KERNEL);
-		if (!filter_item->filter)
+		filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+		if (!filter)
 			goto fail_mem;
-		filter = filter_item->filter;
 
 		/* Can only fail on no memory */
 		err = replace_filter_string(filter, filter_string);
@@ -1821,13 +1814,20 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 			append_filter_err(ps, filter);
 		} else
 			event_set_filtered_flag(file);
+
+
+		filter_item = kzalloc(sizeof(*filter_item), GFP_KERNEL);
+		if (!filter_item)
+			goto fail_mem;
+
+		list_add_tail(&filter_item->list, &filter_list);
 		/*
 		 * Regardless of if this returned an error, we still
 		 * replace the filter for the call.
 		 */
-		filter = event_filter(file);
-		event_set_filter(file, filter_item->filter);
-		filter_item->filter = filter;
+		filter_item->filter = event_filter(file);
+		event_set_filter(file, filter);
+		filter = NULL;
 
 		fail = false;
 	}
@@ -1856,6 +1856,7 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 	parse_error(ps, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
+	kfree(filter);
 	/* If any call succeeded, we still need to sync */
 	if (!fail)
 		synchronize_sched();
-- 
2.15.1
