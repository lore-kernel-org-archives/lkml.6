Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeDFNBU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbeDFNBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F9321842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130114.856301626@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>
Subject: [for-next][PATCH 17/18] tracing: Add rcu dereference annotation for filter->prog
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0017-tracing-Add-rcu-dereference-annotation-for-filter-pr.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

ftrace_function_set_filter() referenences filter->prog without annotation
and sparse complains about it. It needs a rcu_dereference_protected()
wrapper.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 703a416aa5c2..cf8460caa95c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1992,7 +1992,8 @@ static bool is_or(struct prog_entry *prog, int i)
 static int ftrace_function_set_filter(struct perf_event *event,
 				      struct event_filter *filter)
 {
-	struct prog_entry *prog = filter->prog;
+	struct prog_entry *prog = rcu_dereference_protected(filter->prog,
+						lockdep_is_held(&event_mutex));
 	struct function_filter_data data = {
 		.first_filter  = 1,
 		.first_notrace = 1,
-- 
2.15.1
