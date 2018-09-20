Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBC7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14D921531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14D921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbeITSqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:46:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:5248 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387756AbeITSqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:46:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 06:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74829221"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 06:02:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/6] perf tools: Improve thread_stack__event() for trace begin / end
Date:   Thu, 20 Sep 2018 16:00:45 +0300
Message-Id: <20180920130048.31432-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920130048.31432-1-adrian.hunter@intel.com>
References: <20180920130048.31432-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thread_stack__event() is used to create call stacks, by keeping track of
calls and returns. Improve the handling of trace begin / end to allow for a
trace that ends in a call.

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a trace
ends with a call. Before remedying that, enhance the thread stack so that
it does not expect to see the 'return' for a 'call' that ends the trace.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index dd17d6a38d3a..cea28b9074c1 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -36,6 +36,7 @@
  * @branch_count: the branch count when the entry was created
  * @cp: call path
  * @no_call: a 'call' was not seen
+ * @trace_end: a 'call' but trace ended
  */
 struct thread_stack_entry {
 	u64 ret_addr;
@@ -44,6 +45,7 @@ struct thread_stack_entry {
 	u64 branch_count;
 	struct call_path *cp;
 	bool no_call;
+	bool trace_end;
 };
 
 /**
@@ -112,7 +114,8 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 	return ts;
 }
 
-static int thread_stack__push(struct thread_stack *ts, u64 ret_addr)
+static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
+			      bool trace_end)
 {
 	int err = 0;
 
@@ -124,6 +127,7 @@ static int thread_stack__push(struct thread_stack *ts, u64 ret_addr)
 		}
 	}
 
+	ts->stack[ts->cnt].trace_end = trace_end;
 	ts->stack[ts->cnt++].ret_addr = ret_addr;
 
 	return err;
@@ -150,6 +154,18 @@ static void thread_stack__pop(struct thread_stack *ts, u64 ret_addr)
 	}
 }
 
+static void thread_stack__pop_trace_end(struct thread_stack *ts)
+{
+	size_t i;
+
+	for (i = ts->cnt; i; ) {
+		if (ts->stack[--i].trace_end)
+			ts->cnt = i;
+		else
+			return;
+	}
+}
+
 static bool thread_stack__in_kernel(struct thread_stack *ts)
 {
 	if (!ts->cnt)
@@ -254,10 +270,19 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		ret_addr = from_ip + insn_len;
 		if (ret_addr == to_ip)
 			return 0; /* Zero-length calls are excluded */
-		return thread_stack__push(thread->ts, ret_addr);
-	} else if (flags & PERF_IP_FLAG_RETURN) {
-		if (!from_ip)
-			return 0;
+		return thread_stack__push(thread->ts, ret_addr,
+					  flags && PERF_IP_FLAG_TRACE_END);
+	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
+		/*
+		 * If the caller did not change the trace number (which would
+		 * have flushed the stack) then try to make sense of the stack.
+		 * Possibly, tracing began after returning to the current
+		 * address, so try to pop that. Also, do not expect a call made
+		 * when the trace ended, to return, so pop that.
+		 */
+		thread_stack__pop(thread->ts, to_ip);
+		thread_stack__pop_trace_end(thread->ts);
+	} else if ((flags & PERF_IP_FLAG_RETURN) && from_ip) {
 		thread_stack__pop(thread->ts, to_ip);
 	}
 
-- 
2.17.1

