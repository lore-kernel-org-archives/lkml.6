Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DF12070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfACNXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:23:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731018AbfACNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:23:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DNYnM1385429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:23:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DNY2P1385426;
        Thu, 3 Jan 2019 05:23:34 -0800
Date:   Thu, 3 Jan 2019 05:23:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-bd8e68ace110941f375f5d566b0cd99fe80634b8@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
          adrian.hunter@intel.com
In-Reply-To: <20181221120620.9659-4-adrian.hunter@intel.com>
References: <20181221120620.9659-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf thread-stack: Avoid direct reference to the
 thread's stack
Git-Commit-ID: bd8e68ace110941f375f5d566b0cd99fe80634b8
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

Commit-ID:  bd8e68ace110941f375f5d566b0cd99fe80634b8
Gitweb:     https://git.kernel.org/tip/bd8e68ace110941f375f5d566b0cd99fe80634b8
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 21 Dec 2018 14:06:15 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 2 Jan 2019 10:48:18 -0300

perf thread-stack: Avoid direct reference to the thread's stack

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
 tools/perf/util/thread-stack.c | 81 +++++++++++++++++++++++++-----------------
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
