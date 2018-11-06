Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3ECC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF3D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF3D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeKGHma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbeKGHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:42:29 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B7220830;
        Tue,  6 Nov 2018 22:15:03 +0000 (UTC)
Date:   Tue, 6 Nov 2018 17:15:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-ID: <20181106171501.59ccabbc@gandalf.local.home>
In-Reply-To: <20181104115913.74l4yzecisvtt2j5@yavin>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
        <20181101204720.6ed3fe37@vmware.local.home>
        <20181102050509.tw3dhvj5urudvtjl@yavin>
        <20181102065932.bdt4pubbrkvql4mp@yavin>
        <20181102091658.1bc979a4@gandalf.local.home>
        <20181103070253.ajrqzs5xu2vf5stu@yavin>
        <20181104115913.74l4yzecisvtt2j5@yavin>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2018 22:59:13 +1100
Aleksa Sarai <cyphar@cyphar.com> wrote:

> The same issue is present in __save_stack_trace
> (arch/x86/kernel/stacktrace.c). This is likely the only reason that --
> as Steven said -- stacktraces wouldn't work with ftrace-graph (and thus
> with the refactor both of you are discussing).

By the way, I was playing with the the orc unwinder and stack traces
from the function graph tracer return code, and got it working with the
below patch. Caution, that patch also has a stack trace hardcoded in
the return path of the function graph tracer, so you don't want to run
function graph tracing without filtering.

You can apply the patch and do:

 # cd /sys/kernel/debug/tracing
 # echo schedule > set_ftrace_filter
 # echo function_graph > current_tracer
 # cat trace

 3)               |  schedule() {
     rcu_preempt-10    [003] ....    91.160297: <stack trace>
 => ftrace_return_to_handler
 => return_to_handler
 => schedule_timeout
 => rcu_gp_kthread
 => kthread
 => ret_from_fork
 3) # 4009.085 us |  }
 3)               |  schedule() {
     kworker/1:0-17    [001] ....    91.163288: <stack trace>
 => ftrace_return_to_handler
 => return_to_handler
 => worker_thread
 => kthread
 => ret_from_fork
 1) # 7000.070 us |  }
 1)               |  schedule() {
     rcu_preempt-10    [003] ....    91.164311: <stack trace>
 => ftrace_return_to_handler
 => return_to_handler
 => schedule_timeout
 => rcu_gp_kthread
 => kthread
 => ret_from_fork
 3) # 4006.540 us |  }


Where just adding the stack trace without the other code, these traces
ended at "return_to_handler".

This patch is not for inclusion, it was just a test to see how to make
this work.

-- Steve

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 91b2cff4b79a..4bcd646ae1f4 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -320,13 +320,15 @@ ENTRY(ftrace_graph_caller)
 ENDPROC(ftrace_graph_caller)
 
 ENTRY(return_to_handler)
-	UNWIND_HINT_EMPTY
-	subq  $24, %rsp
+	subq $8, %rsp
+	UNWIND_HINT_FUNC
+	subq  $16, %rsp
 
 	/* Save the return values */
 	movq %rax, (%rsp)
 	movq %rdx, 8(%rsp)
 	movq %rbp, %rdi
+	leaq 16(%rsp), %rsi
 
 	call ftrace_return_to_handler
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 169b3c44ee97..aaeca73218cc 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -242,13 +242,16 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	trace->calltime = current->ret_stack[index].calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = index;
+
+	trace_dump_stack(0);
 }
 
 /*
  * Send the trace to the ring-buffer.
  * @return the original return address.
  */
-unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer,
+	unsigned long *ptr)
 {
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
@@ -257,6 +260,8 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	trace.rettime = trace_clock_local();
 	barrier();
 	current->curr_ret_stack--;
+	*ptr = ret;
+
 	/*
 	 * The curr_ret_stack can be less than -1 only if it was
 	 * filtered out and it's about to return from the function.
