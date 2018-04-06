Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDFNBT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752802AbeDFNBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3047A21838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130114.998259587@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>
Subject: [for-next][PATCH 18/18] tracing: Add rcu dereference annotation for test func that touches
 filter->prog
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0018-tracing-Add-rcu-dereference-annotation-for-test-func.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

A boot up test function update_pred_fn() dereferences filter->prog without
the proper rcu annotation.

To do this, we must also take the event_mutex first. Normally, this isn't
needed because this test function can not race with other use cases that
touch the event filters (it is disabled if any events are enabled).

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index cf8460caa95c..1bda4ec95e18 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2155,7 +2155,8 @@ static int test_pred_visited_fn(struct filter_pred *pred, void *event)
 
 static void update_pred_fn(struct event_filter *filter, char *fields)
 {
-	struct prog_entry *prog = filter->prog;
+	struct prog_entry *prog = rcu_dereference_protected(filter->prog,
+						lockdep_is_held(&event_mutex));
 	int i;
 
 	for (i = 0; prog[i].pred; i++) {
@@ -2197,6 +2198,8 @@ static __init int ftrace_test_event_filter(void)
 			break;
 		}
 
+		/* Needed to dereference filter->prog */
+		mutex_lock(&event_mutex);
 		/*
 		 * The preemption disabling is not really needed for self
 		 * tests, but the rcu dereference will complain without it.
@@ -2209,6 +2212,8 @@ static __init int ftrace_test_event_filter(void)
 		err = filter_match_preds(filter, &d->rec);
 		preempt_enable();
 
+		mutex_unlock(&event_mutex);
+
 		__free_filter(filter);
 
 		if (test_pred_visited) {
-- 
2.15.1
