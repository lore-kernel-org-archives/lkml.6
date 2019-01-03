Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D3C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2D21874
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519655;
	bh=d0AMOEfk+nNg1kBWimnvzOlvrzWjOk7tKSbesQNcPI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQuNz+JKrWz2LiKh22kee2T2Cre5oTj9/YTVuuvyQcbig8D/+doRHRYMtAfaOibwl
	 aZDEHsrQWJVmPxkHykGz8w8eVXQxf+C63dkYDnBQ1AY5Gmv9rKJEDeEjIoD8G9mKqs
	 WSj4y9OuEWHWLvq18FZtJtBbM7ykzJPcBZOpJz2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfACMrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731344AbfACMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:32 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6513721872;
        Thu,  3 Jan 2019 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519652;
        bh=d0AMOEfk+nNg1kBWimnvzOlvrzWjOk7tKSbesQNcPI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPT5Gm/kyz2TI1g5N/ye+wDJAfbbgiHYtIkhTHS1bDWDfc9xwXb/Kh2l/bdSGqvm7
         h/qtMkha/OH53bD4720VCCEGKMAg+w0CcrH03GJCbw98Wkd1TGUuTr5eArr+tTPH1w
         KqwQ8oaGYqqSS/mGjPRF5LGAv2/0LwydsBSTJWA8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/29] perf thread-stack: Avoid direct reference to the thread's stack
Date:   Thu,  3 Jan 2019 09:46:04 -0300
Message-Id: <20190103124609.29672-25-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for fixing thread stack processing for the idle task,
avoid direct reference to the thread's stack. The thread stack will
change to an array of thread stacks, at which point the meaning of the
direct reference will change.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-4-adrian.hunter@intel.com
[ Rename thread_stack__ts() to thread__stack() since this operates on a 'thread' struct ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 81 ++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 068c7c8db4be..d93cd286b048 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -111,9 +111,16 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 		ts->kernel_start = 1ULL << 63;
 	ts->crp = crp;
 
+	thread->ts = ts;
+
 	return ts;
 }
 
+static inline struct thread_stack *thread__stack(struct thread *thread)
+{
+	return thread ? thread->ts : NULL;
+}
+
 static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
 			      bool trace_end)
 {
@@ -226,8 +233,10 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 
 int thread_stack__flush(struct thread *thread)
 {
-	if (thread->ts)
-		return __thread_stack__flush(thread, thread->ts);
+	struct thread_stack *ts = thread->ts;
+
+	if (ts)
+		return __thread_stack__flush(thread, ts);
 
 	return 0;
 }
@@ -235,16 +244,18 @@ int thread_stack__flush(struct thread *thread)
 int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr)
 {
+	struct thread_stack *ts = thread__stack(thread);
+
 	if (!thread)
 		return -EINVAL;
 
-	if (!thread->ts) {
-		thread->ts = thread_stack__new(thread, NULL);
-		if (!thread->ts) {
+	if (!ts) {
+		ts = thread_stack__new(thread, NULL);
+		if (!ts) {
 			pr_warning("Out of memory: no thread stack\n");
 			return -ENOMEM;
 		}
-		thread->ts->trace_nr = trace_nr;
+		ts->trace_nr = trace_nr;
 	}
 
 	/*
@@ -252,14 +263,14 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 	 * the stack might be completely invalid.  Better to report nothing than
 	 * to report something misleading, so flush the stack.
 	 */
-	if (trace_nr != thread->ts->trace_nr) {
-		if (thread->ts->trace_nr)
-			__thread_stack__flush(thread, thread->ts);
-		thread->ts->trace_nr = trace_nr;
+	if (trace_nr != ts->trace_nr) {
+		if (ts->trace_nr)
+			__thread_stack__flush(thread, ts);
+		ts->trace_nr = trace_nr;
 	}
 
 	/* Stop here if thread_stack__process() is in use */
-	if (thread->ts->crp)
+	if (ts->crp)
 		return 0;
 
 	if (flags & PERF_IP_FLAG_CALL) {
@@ -270,7 +281,7 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		ret_addr = from_ip + insn_len;
 		if (ret_addr == to_ip)
 			return 0; /* Zero-length calls are excluded */
-		return thread_stack__push(thread->ts, ret_addr,
+		return thread_stack__push(ts, ret_addr,
 					  flags & PERF_IP_FLAG_TRACE_END);
 	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
 		/*
@@ -280,10 +291,10 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		 * address, so try to pop that. Also, do not expect a call made
 		 * when the trace ended, to return, so pop that.
 		 */
-		thread_stack__pop(thread->ts, to_ip);
-		thread_stack__pop_trace_end(thread->ts);
+		thread_stack__pop(ts, to_ip);
+		thread_stack__pop_trace_end(ts);
 	} else if ((flags & PERF_IP_FLAG_RETURN) && from_ip) {
-		thread_stack__pop(thread->ts, to_ip);
+		thread_stack__pop(ts, to_ip);
 	}
 
 	return 0;
@@ -291,21 +302,25 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 
 void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
 {
-	if (!thread || !thread->ts)
+	struct thread_stack *ts = thread__stack(thread);
+
+	if (!ts)
 		return;
 
-	if (trace_nr != thread->ts->trace_nr) {
-		if (thread->ts->trace_nr)
-			__thread_stack__flush(thread, thread->ts);
-		thread->ts->trace_nr = trace_nr;
+	if (trace_nr != ts->trace_nr) {
+		if (ts->trace_nr)
+			__thread_stack__flush(thread, ts);
+		ts->trace_nr = trace_nr;
 	}
 }
 
 void thread_stack__free(struct thread *thread)
 {
-	if (thread->ts) {
-		__thread_stack__flush(thread, thread->ts);
-		zfree(&thread->ts->stack);
+	struct thread_stack *ts = thread->ts;
+
+	if (ts) {
+		__thread_stack__flush(thread, ts);
+		zfree(&ts->stack);
 		zfree(&thread->ts);
 	}
 }
@@ -318,6 +333,7 @@ static inline u64 callchain_context(u64 ip, u64 kernel_start)
 void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start)
 {
+	struct thread_stack *ts = thread__stack(thread);
 	u64 context = callchain_context(ip, kernel_start);
 	u64 last_context;
 	size_t i, j;
@@ -330,15 +346,15 @@ void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
 	chain->ips[0] = context;
 	chain->ips[1] = ip;
 
-	if (!thread || !thread->ts) {
+	if (!ts) {
 		chain->nr = 2;
 		return;
 	}
 
 	last_context = context;
 
-	for (i = 2, j = 1; i < sz && j <= thread->ts->cnt; i++, j++) {
-		ip = thread->ts->stack[thread->ts->cnt - j].ret_addr;
+	for (i = 2, j = 1; i < sz && j <= ts->cnt; i++, j++) {
+		ip = ts->stack[ts->cnt - j].ret_addr;
 		context = callchain_context(ip, kernel_start);
 		if (context != last_context) {
 			if (i >= sz - 1)
@@ -590,7 +606,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 			  struct addr_location *to_al, u64 ref,
 			  struct call_return_processor *crp)
 {
-	struct thread_stack *ts = thread->ts;
+	struct thread_stack *ts = thread__stack(thread);
 	int err = 0;
 
 	if (ts && !ts->crp) {
@@ -600,10 +616,9 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	}
 
 	if (!ts) {
-		thread->ts = thread_stack__new(thread, crp);
-		if (!thread->ts)
+		ts = thread_stack__new(thread, crp);
+		if (!ts)
 			return -ENOMEM;
-		ts = thread->ts;
 		ts->comm = comm;
 	}
 
@@ -668,7 +683,9 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 size_t thread_stack__depth(struct thread *thread)
 {
-	if (!thread->ts)
+	struct thread_stack *ts = thread__stack(thread);
+
+	if (!ts)
 		return 0;
-	return thread->ts->cnt;
+	return ts->cnt;
 }
-- 
2.19.2

