Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeCUCWt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbeCUCVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB0E2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022131.190058562@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 41/46] tracing: Remove filter allocator helper
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0041-tracing-Remove-filter-allocator-helper.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The __alloc_filter() function does nothing more that allocate the filter.
There's no reason to have it as a helper function.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index f42442cd423a..3d60bbeb2ef1 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -866,14 +866,6 @@ void free_event_filter(struct event_filter *filter)
 	__free_filter(filter);
 }
 
-static struct event_filter *__alloc_filter(void)
-{
-	struct event_filter *filter;
-
-	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
-	return filter;
-}
-
 static int __alloc_preds(struct event_filter *filter, int n_preds)
 {
 	struct filter_pred *pred;
@@ -1812,7 +1804,7 @@ static int replace_system_preds(struct trace_subsystem_dir *dir,
 
 		list_add_tail(&filter_item->list, &filter_list);
 
-		filter_item->filter = __alloc_filter();
+		filter_item->filter = kzalloc(sizeof(*filter), GFP_KERNEL);
 		if (!filter_item->filter)
 			goto fail_mem;
 		filter = filter_item->filter;
@@ -1886,7 +1878,7 @@ static int create_filter_start(char *filter_str, bool set_str,
 	WARN_ON_ONCE(*psp || *filterp);
 
 	/* allocate everything, and if any fails, free all and fail */
-	filter = __alloc_filter();
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
 	if (filter && set_str)
 		err = replace_filter_string(filter, filter_str);
 
-- 
2.15.1
