Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D9DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4672070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519678;
	bh=rLDIUm1nHl8YygjrqPx3xY6cV8HgT5fEAQFCbQKqbYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nXvM2uM/rE14Ka2aRGXon7vIr6IzkIg/soJp1X9ck/4ku5DOhAqc91EvjelHmy4Y6
	 nG340+MC5aeWo0GxugjAn558OevcyCQQstlKtZ4WonkfwdlAOlTUPakqONaQQ5MerG
	 /bz2pzC5UHE+/SO4h+KttWZLJJBKDS38wJUkYVvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfACMr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731666AbfACMrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:43 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF0521871;
        Thu,  3 Jan 2019 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519661;
        bh=rLDIUm1nHl8YygjrqPx3xY6cV8HgT5fEAQFCbQKqbYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWAgi0hZPlwEWng5hDUZDi8LRsOeVc1ow7AIwQaJqfNNZvP28eFCaGLRMeYyZu2aH
         8YiU6+/weCJBURDrL3lZYmd2EvWEOJGK3G+1wLIAhm3AOVwYjdK2OtyYvwWtXm+2ip
         qR3UKqfN7gK87w6wpu9kqOaR9Zs1mYelPU0IMHeo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/29] perf thread-stack: Fix thread stack processing for the idle task
Date:   Thu,  3 Jan 2019 09:46:08 -0300
Message-Id: <20190103124609.29672-29-acme@kernel.org>
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

perf creates a single 'struct thread' to represent the idle task. That
is because threads are identified by PID and TID, and the idle task
always has PID == TID == 0.

However, there are actually separate idle tasks for each CPU. That
creates a problem for thread stack processing which assumes that each
thread has a single stack, not one stack per CPU.

Fix that by passing through the CPU number, and in the case of the idle
"thread", pick the thread stack from an array based on the CPU number.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c    |  4 +-
 tools/perf/util/intel-bts.c    |  4 +-
 tools/perf/util/intel-pt.c     |  6 +--
 tools/perf/util/thread-stack.c | 72 +++++++++++++++++++++++++++-------
 tools/perf/util/thread-stack.h |  8 ++--
 5 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 88d52ed85ffc..d079f36d342d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1182,7 +1182,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 					   struct addr_location *al, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->attr;
-	size_t depth = thread_stack__depth(thread);
+	size_t depth = thread_stack__depth(thread, sample->cpu);
 	const char *name = NULL;
 	static int spacing;
 	int len = 0;
@@ -1716,7 +1716,7 @@ static bool show_event(struct perf_sample *sample,
 		       struct thread *thread,
 		       struct addr_location *al)
 {
-	int depth = thread_stack__depth(thread);
+	int depth = thread_stack__depth(thread, sample->cpu);
 
 	if (!symbol_conf.graph_function)
 		return true;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 7b27d77306c2..ee6ca65f81f4 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -451,7 +451,7 @@ static int intel_bts_process_buffer(struct intel_bts_queue *btsq,
 			continue;
 		intel_bts_get_branch_type(btsq, branch);
 		if (btsq->bts->synth_opts.thread_stack)
-			thread_stack__event(thread, btsq->sample_flags,
+			thread_stack__event(thread, btsq->cpu, btsq->sample_flags,
 					    le64_to_cpu(branch->from),
 					    le64_to_cpu(branch->to),
 					    btsq->intel_pt_insn.length,
@@ -523,7 +523,7 @@ static int intel_bts_process_queue(struct intel_bts_queue *btsq, u64 *timestamp)
 	    !btsq->bts->synth_opts.thread_stack && thread &&
 	    (!old_buffer || btsq->bts->sampling_mode ||
 	     (btsq->bts->snapshot_mode && !buffer->consecutive)))
-		thread_stack__set_trace_nr(thread, buffer->buffer_nr + 1);
+		thread_stack__set_trace_nr(thread, btsq->cpu, buffer->buffer_nr + 1);
 
 	err = intel_bts_process_buffer(btsq, buffer, thread);
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 149ff361ca78..2e72373ec6df 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1174,7 +1174,7 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 	intel_pt_prep_b_sample(pt, ptq, event, sample);
 
 	if (pt->synth_opts.callchain) {
-		thread_stack__sample(ptq->thread, ptq->chain,
+		thread_stack__sample(ptq->thread, ptq->cpu, ptq->chain,
 				     pt->synth_opts.callchain_sz + 1,
 				     sample->ip, pt->kernel_start);
 		sample->callchain = ptq->chain;
@@ -1526,11 +1526,11 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		return 0;
 
 	if (pt->synth_opts.callchain || pt->synth_opts.thread_stack)
-		thread_stack__event(ptq->thread, ptq->flags, state->from_ip,
+		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
 				    state->to_ip, ptq->insn_len,
 				    state->trace_nr);
 	else
-		thread_stack__set_trace_nr(ptq->thread, state->trace_nr);
+		thread_stack__set_trace_nr(ptq->thread, ptq->cpu, state->trace_nr);
 
 	if (pt->sample_branches) {
 		err = intel_pt_synth_branch_sample(ptq);
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 248ed3945bec..d52f27f373ce 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -15,6 +15,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/log2.h>
 #include <errno.h>
 #include "thread.h"
 #include "event.h"
@@ -75,6 +76,16 @@ struct thread_stack {
 	unsigned int arr_sz;
 };
 
+/*
+ * Assume pid == tid == 0 identifies the idle task as defined by
+ * perf_session__register_idle_thread(). The idle task is really 1 task per cpu,
+ * and therefore requires a stack for each cpu.
+ */
+static inline bool thread_stack__per_cpu(struct thread *thread)
+{
+	return !(thread->tid || thread->pid_);
+}
+
 static int thread_stack__grow(struct thread_stack *ts)
 {
 	struct thread_stack_entry *new_stack;
@@ -111,13 +122,16 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 	return 0;
 }
 
-static struct thread_stack *thread_stack__new(struct thread *thread,
+static struct thread_stack *thread_stack__new(struct thread *thread, int cpu,
 					      struct call_return_processor *crp)
 {
 	struct thread_stack *ts = thread->ts, *new_ts;
 	unsigned int old_sz = ts ? ts->arr_sz : 0;
 	unsigned int new_sz = 1;
 
+	if (thread_stack__per_cpu(thread) && cpu > 0)
+		new_sz = roundup_pow_of_two(cpu + 1);
+
 	if (!ts || new_sz > old_sz) {
 		new_ts = calloc(new_sz, sizeof(*ts));
 		if (!new_ts)
@@ -130,6 +144,10 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 		ts = new_ts;
 	}
 
+	if (thread_stack__per_cpu(thread) && cpu > 0 &&
+	    (unsigned int)cpu < ts->arr_sz)
+		ts += cpu;
+
 	if (!ts->stack &&
 	    thread_stack__init(ts, thread, crp))
 		return NULL;
@@ -137,9 +155,34 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 	return ts;
 }
 
-static inline struct thread_stack *thread__stack(struct thread *thread)
+static struct thread_stack *thread__cpu_stack(struct thread *thread, int cpu)
 {
-	return thread ? thread->ts : NULL;
+	struct thread_stack *ts = thread->ts;
+
+	if (cpu < 0)
+		cpu = 0;
+
+	if (!ts || (unsigned int)cpu >= ts->arr_sz)
+		return NULL;
+
+	ts += cpu;
+
+	if (!ts->stack)
+		return NULL;
+
+	return ts;
+}
+
+static inline struct thread_stack *thread__stack(struct thread *thread,
+						    int cpu)
+{
+	if (!thread)
+		return NULL;
+
+	if (thread_stack__per_cpu(thread))
+		return thread__cpu_stack(thread, cpu);
+
+	return thread->ts;
 }
 
 static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
@@ -270,16 +313,16 @@ int thread_stack__flush(struct thread *thread)
 	return err;
 }
 
-int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
+int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr)
 {
-	struct thread_stack *ts = thread__stack(thread);
+	struct thread_stack *ts = thread__stack(thread, cpu);
 
 	if (!thread)
 		return -EINVAL;
 
 	if (!ts) {
-		ts = thread_stack__new(thread, NULL);
+		ts = thread_stack__new(thread, cpu, NULL);
 		if (!ts) {
 			pr_warning("Out of memory: no thread stack\n");
 			return -ENOMEM;
@@ -329,9 +372,9 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 	return 0;
 }
 
-void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
+void thread_stack__set_trace_nr(struct thread *thread, int cpu, u64 trace_nr)
 {
-	struct thread_stack *ts = thread__stack(thread);
+	struct thread_stack *ts = thread__stack(thread, cpu);
 
 	if (!ts)
 		return;
@@ -375,10 +418,11 @@ static inline u64 callchain_context(u64 ip, u64 kernel_start)
 	return ip < kernel_start ? PERF_CONTEXT_USER : PERF_CONTEXT_KERNEL;
 }
 
-void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
+void thread_stack__sample(struct thread *thread, int cpu,
+			  struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start)
 {
-	struct thread_stack *ts = thread__stack(thread);
+	struct thread_stack *ts = thread__stack(thread, cpu);
 	u64 context = callchain_context(ip, kernel_start);
 	u64 last_context;
 	size_t i, j;
@@ -651,7 +695,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 			  struct addr_location *to_al, u64 ref,
 			  struct call_return_processor *crp)
 {
-	struct thread_stack *ts = thread__stack(thread);
+	struct thread_stack *ts = thread__stack(thread, sample->cpu);
 	int err = 0;
 
 	if (ts && !ts->crp) {
@@ -661,7 +705,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	}
 
 	if (!ts) {
-		ts = thread_stack__new(thread, crp);
+		ts = thread_stack__new(thread, sample->cpu, crp);
 		if (!ts)
 			return -ENOMEM;
 		ts->comm = comm;
@@ -726,9 +770,9 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	return err;
 }
 
-size_t thread_stack__depth(struct thread *thread)
+size_t thread_stack__depth(struct thread *thread, int cpu)
 {
-	struct thread_stack *ts = thread__stack(thread);
+	struct thread_stack *ts = thread__stack(thread, cpu);
 
 	if (!ts)
 		return 0;
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index f97c00a8c251..1f626f4a1c40 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -80,14 +80,14 @@ struct call_return_processor {
 	void *data;
 };
 
-int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
+int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr);
-void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr);
-void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
+void thread_stack__set_trace_nr(struct thread *thread, int cpu, u64 trace_nr);
+void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
-size_t thread_stack__depth(struct thread *thread);
+size_t thread_stack__depth(struct thread *thread, int cpu);
 
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, void *data),
-- 
2.19.2

