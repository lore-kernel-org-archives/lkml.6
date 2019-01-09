Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D720C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFBE20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfAIJUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:13930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbfAIJUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="105163065"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2019 01:20:22 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] perf thread-stack: Hide x86 retpolines
Date:   Wed,  9 Jan 2019 11:18:35 +0200
Message-Id: <20190109091835.5570-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109091835.5570-1-adrian.hunter@intel.com>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 retpoline functions pollute the call graph by showing up everywhere
there is an indirect branch, but they do not really mean anything. Make
changes so that the default retpoline functions will no longer appear in
the call graph. Note this only affects the call graph, since all the
original branches are left unchanged.

This does not handle function return thunks, nor is there any improvement
for the handling of inline thunks or extern thunks.

Example:

$ cat simple-retpoline.c
__attribute__((noinline)) int bar(void)
{
        return -1;
}

int foo(void)
{
        return bar() + 1;
}

__attribute__((indirect_branch("thunk"))) int main()
{
        int (*volatile fn)(void) = foo;

        fn();
        return fn();
}
$ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
$ objdump -d simple-retpoline
<SNIP>
0000000000001040 <main>:
    1040:       48 83 ec 18             sub    $0x18,%rsp
    1044:       48 8d 05 25 01 00 00    lea    0x125(%rip),%rax        # 1170 <foo>
    104b:       48 89 44 24 08          mov    %rax,0x8(%rsp)
    1050:       48 8b 44 24 08          mov    0x8(%rsp),%rax
    1055:       e8 1f 01 00 00          callq  1179 <__x86_indirect_thunk_rax>
    105a:       48 8b 44 24 08          mov    0x8(%rsp),%rax
    105f:       48 83 c4 18             add    $0x18,%rsp
    1063:       e9 11 01 00 00          jmpq   1179 <__x86_indirect_thunk_rax>
<SNIP>
0000000000001160 <bar>:
    1160:       b8 ff ff ff ff          mov    $0xffffffff,%eax
    1165:       c3                      retq
<SNIP>
0000000000001170 <foo>:
    1170:       e8 eb ff ff ff          callq  1160 <bar>
    1175:       83 c0 01                add    $0x1,%eax
    1178:       c3                      retq
0000000000001179 <__x86_indirect_thunk_rax>:
    1179:       e8 07 00 00 00          callq  1185 <__x86_indirect_thunk_rax+0xc>
    117e:       f3 90                   pause
    1180:       0f ae e8                lfence
    1183:       eb f9                   jmp    117e <__x86_indirect_thunk_rax+0x5>
    1185:       48 89 04 24             mov    %rax,(%rsp)
    1189:       c3                      retq
<SNIP>
$ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0,017 MB simple-retpoline.perf.data ]
$ perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
2019-01-08 14:03:37.851655 Creating database...
2019-01-08 14:03:37.863256 Writing records...
2019-01-08 14:03:38.069750 Adding indexes
2019-01-08 14:03:38.078799 Done
$ ~/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db

Before:

    main
        -> __x86_indirect_thunk_rax
            -> __x86_indirect_thunk_rax
                -> foo
                    -> bar

After:

    main
        -> foo
            -> bar

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 112 ++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 632c07a125ab..805e30836460 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -20,6 +20,7 @@
 #include "thread.h"
 #include "event.h"
 #include "machine.h"
+#include "env.h"
 #include "util.h"
 #include "debug.h"
 #include "symbol.h"
@@ -29,6 +30,19 @@
 
 #define STACK_GROWTH 2048
 
+/*
+ * State of retpoline detection.
+ *
+ * RETPOLINE_NONE: no retpoline detection
+ * X86_RETPOLINE_POSSIBLE: x86 retpoline possible
+ * X86_RETPOLINE_DETECTED: x86 retpoline detected
+ */
+enum retpoline_state_t {
+	RETPOLINE_NONE,
+	X86_RETPOLINE_POSSIBLE,
+	X86_RETPOLINE_DETECTED,
+};
+
 /**
  * struct thread_stack_entry - thread stack entry.
  * @ret_addr: return address
@@ -64,6 +78,7 @@ struct thread_stack_entry {
  * @crp: call/return processor
  * @comm: current comm
  * @arr_sz: size of array if this is the first element of an array
+ * @rstate: used to detect retpolines
  */
 struct thread_stack {
 	struct thread_stack_entry *stack;
@@ -76,6 +91,7 @@ struct thread_stack {
 	struct call_return_processor *crp;
 	struct comm *comm;
 	unsigned int arr_sz;
+	enum retpoline_state_t rstate;
 };
 
 /*
@@ -115,10 +131,16 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 	if (err)
 		return err;
 
-	if (thread->mg && thread->mg->machine)
-		ts->kernel_start = machine__kernel_start(thread->mg->machine);
-	else
+	if (thread->mg && thread->mg->machine) {
+		struct machine *machine = thread->mg->machine;
+		const char *arch = perf_env__arch(machine->env);
+
+		ts->kernel_start = machine__kernel_start(machine);
+		if (!strcmp(arch, "x86"))
+			ts->rstate = X86_RETPOLINE_POSSIBLE;
+	} else {
 		ts->kernel_start = 1ULL << 63;
+	}
 	ts->crp = crp;
 
 	return 0;
@@ -733,6 +755,70 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 				     false, true);
 }
 
+static bool is_x86_retpoline(const char *name)
+{
+	const char *p = strstr(name, "__x86_indirect_thunk_");
+
+	return p == name || !strcmp(name, "__indirect_thunk_start");
+}
+
+/*
+ * x86 retpoline functions pollute the call graph. This function removes them.
+ * This does not handle function return thunks, nor is there any improvement
+ * for the handling of inline thunks or extern thunks.
+ */
+static int thread_stack__x86_retpoline(struct thread_stack *ts,
+				       struct perf_sample *sample,
+				       struct addr_location *to_al)
+{
+	struct thread_stack_entry *tse = &ts->stack[ts->cnt - 1];
+	struct call_path_root *cpr = ts->crp->cpr;
+	struct symbol *sym = tse->cp->sym;
+	struct symbol *tsym = to_al->sym;
+	struct call_path *cp;
+
+	if (sym && sym->name && is_x86_retpoline(sym->name)) {
+		/*
+		 * This is a x86 retpoline fn. It pollutes the call graph by
+		 * showing up everywhere there is an indirect branch, but does
+		 * not itself mean anything. Here the top-of-stack is removed,
+		 * by decrementing the stack count, and then further down, the
+		 * resulting top-of-stack is replaced with the actual target.
+		 * The result is that the retpoline functions will no longer
+		 * appear in the call graph. Note this only affects the call
+		 * graph, since all the original branches are left unchanged.
+		 */
+		ts->cnt -= 1;
+		sym = ts->stack[ts->cnt - 2].cp->sym;
+		if (sym && sym == tsym && to_al->addr != tsym->start) {
+			/*
+			 * Target is back to the middle of the symbol we came
+			 * from so assume it is an indirect jmp and forget it
+			 * altogether.
+			 */
+			ts->cnt -= 1;
+			return 0;
+		}
+	} else if (sym && sym == tsym) {
+		/*
+		 * Target is back to the symbol we came from so assume it is an
+		 * indirect jmp and forget it altogether.
+		 */
+		ts->cnt -= 1;
+		return 0;
+	}
+
+	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 2].cp, tsym,
+				sample->addr, ts->kernel_start);
+	if (!cp)
+		return -ENOMEM;
+
+	/* Replace the top-of-stack with the actual target */
+	ts->stack[ts->cnt - 1].cp = cp;
+
+	return 0;
+}
+
 int thread_stack__process(struct thread *thread, struct comm *comm,
 			  struct perf_sample *sample,
 			  struct addr_location *from_al,
@@ -740,6 +826,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 			  struct call_return_processor *crp)
 {
 	struct thread_stack *ts = thread__stack(thread, sample->cpu);
+	enum retpoline_state_t rstate;
 	int err = 0;
 
 	if (ts && !ts->crp) {
@@ -755,6 +842,10 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		ts->comm = comm;
 	}
 
+	rstate = ts->rstate;
+	if (rstate == X86_RETPOLINE_DETECTED)
+		ts->rstate = X86_RETPOLINE_POSSIBLE;
+
 	/* Flush stack on exec */
 	if (ts->comm != comm && thread->pid_ == thread->tid) {
 		err = __thread_stack__flush(thread, ts);
@@ -791,10 +882,25 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 					ts->kernel_start);
 		err = thread_stack__push_cp(ts, ret_addr, sample->time, ref,
 					    cp, false, trace_end);
+
+		/*
+		 * A call to the same symbol but not the start of the symbol,
+		 * may be the start of a x86 retpoline.
+		 */
+		if (!err && rstate == X86_RETPOLINE_POSSIBLE && to_al->sym &&
+		    from_al->sym == to_al->sym &&
+		    to_al->addr != to_al->sym->start)
+			ts->rstate = X86_RETPOLINE_DETECTED;
+
 	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
 		if (!sample->ip || !sample->addr)
 			return 0;
 
+		/* x86 retpoline 'return' doesn't match the stack */
+		if (rstate == X86_RETPOLINE_DETECTED && ts->cnt > 2 &&
+		    ts->stack[ts->cnt - 1].ret_addr != sample->addr)
+			return thread_stack__x86_retpoline(ts, sample, to_al);
+
 		err = thread_stack__pop_cp(thread, ts, sample->addr,
 					   sample->time, ref, from_al->sym);
 		if (err) {
-- 
2.17.1

