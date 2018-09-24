Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F64C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54D32082C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTvK5rPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54D32082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbeIXVHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbeIXVHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:52 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2D820C0A;
        Mon, 24 Sep 2018 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801516;
        bh=/Kg/151d6uBBqfT0doJWdo5CKR++XMoy3zg7wTaO4OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTvK5rPtcQcrnp7R+GNOUuw5mP6tFS0r252KcMUJz5UYnWvmw4rP/YkrQMAWKN+y2
         W3slRhklBsE5RbPs1aRwCuCJdXjvVPF1GV5NrI3J6qxyDQ7yQfaCJOnY8wjRluNhuw
         /rtWmHHQGr/fTODky87N6ds+5zPicOg+HHVxkYlI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/27] perf tools: Improve thread_stack__event() for trace begin / end
Date:   Mon, 24 Sep 2018 12:02:38 -0300
Message-Id: <20180924150242.14235-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
 
-- 
2.14.4

