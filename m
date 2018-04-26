Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeDZRct (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756784AbeDZRcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:32:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC63217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180426173201.924880227@goodmis.org>
User-Agent: quilt/0.63-1
Date: Thu, 26 Apr 2018 13:30:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 3/7] tracing: Fix kernel crash while using empty filter with perf
References: <20180426173039.426131207@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0003-tracing-Fix-kernel-crash-while-using-empty-filter-wi.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Kernel is crashing when user tries to record 'ftrace:function' event
with empty filter:

  # perf record -e ftrace:function --filter="" ls

  # dmesg
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
  Oops: 0000 [#1] SMP PTI
  ...
  RIP: 0010:ftrace_profile_set_filter+0x14b/0x2d0
  RSP: 0018:ffffa4a7c0da7d20 EFLAGS: 00010246
  RAX: ffffa4a7c0da7d64 RBX: 0000000000000000 RCX: 0000000000000006
  RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff8c48ffc968f0
  ...
  Call Trace:
   _perf_ioctl+0x54a/0x6b0
   ? rcu_all_qs+0x5/0x30
  ...

After patch:
  # perf record -e ftrace:function --filter="" ls
  failed to set filter "" on event ftrace:function with 22 (Invalid argument)

Also, if user tries to echo "" > filter, it used to throw an error.
This behavior got changed by commit 80765597bc58 ("tracing: Rewrite
filter logic to be simpler and faster"). This patch restores the
behavior as a side effect:

Before patch:
  # echo "" > filter
  #

After patch:
  # echo "" > filter
  bash: echo: write error: Invalid argument
  #

Link: http://lkml.kernel.org/r/20180420150758.19787-1-ravi.bangoria@linux.ibm.com

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 9b4716bb8bb0..1f951b3df60c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1499,14 +1499,14 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	if (!nr_preds) {
-		prog = NULL;
-	} else {
-		prog = predicate_parse(filter_string, nr_parens, nr_preds,
+	if (!nr_preds)
+		return -EINVAL;
+
+	prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);
-		if (IS_ERR(prog))
-			return PTR_ERR(prog);
-	}
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
 	rcu_assign_pointer(filter->prog, prog);
 	return 0;
 }
-- 
2.16.3
