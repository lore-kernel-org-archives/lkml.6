Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20669C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5235208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5235208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIZPGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:06:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:06:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8stpG3772848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:54:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8ss4c3772845;
        Wed, 26 Sep 2018 01:54:54 -0700
Date:   Wed, 26 Sep 2018 01:54:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4d60e5e36aa6f11b4d9eadc5d2b94128f24870c7@git.kernel.org>
Cc:     jolsa@redhat.com, adrian.hunter@intel.com, acme@redhat.com,
        tglx@linutronix.de, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@redhat.com
In-Reply-To: <20180920130048.31432-4-adrian.hunter@intel.com>
References: <20180920130048.31432-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Improve thread_stack__event() for trace
 begin / end
Git-Commit-ID: 4d60e5e36aa6f11b4d9eadc5d2b94128f24870c7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4d60e5e36aa6f11b4d9eadc5d2b94128f24870c7
Gitweb:     https://git.kernel.org/tip/4d60e5e36aa6f11b4d9eadc5d2b94128f24870c7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 20 Sep 2018 16:00:45 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 20 Sep 2018 15:16:17 -0300

perf tools: Improve thread_stack__event() for trace begin / end

thread_stack__event() is used to create call stacks, by keeping track of
calls and returns. Improve the handling of trace begin / end to allow
for a trace that ends in a call.

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, enhance the thread stack
so that it does not expect to see the 'return' for a 'call' that ends
the trace.

Committer notes:

Added this:

                return thread_stack__push(thread->ts, ret_addr,
-                                         flags && PERF_IP_FLAG_TRACE_END);
+                                         flags & PERF_IP_FLAG_TRACE_END);

To fix problem spotted by:

debian:9:            clang version 3.8.1-24 (tags/RELEASE_381/final)
debian:experimental: clang version 6.0.1-6 (tags/RELEASE_601/final)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index dd17d6a38d3a..e3f7dfecafa9 100644
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
+					  flags & PERF_IP_FLAG_TRACE_END);
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
 
