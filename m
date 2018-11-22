Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5082075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5082075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391428AbeKVMFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbeKVMFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:05:01 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7862080F;
        Thu, 22 Nov 2018 01:28:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gPdmk-0005HO-Mo; Wed, 21 Nov 2018 20:28:02 -0500
Message-Id: <20181122012708.491151844@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 20:27:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC][PATCH 00/14] function_graph: Rewrite to allow multiple users
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I talked with many of you at Plumbers about rewriting the function graph
tracer. Well, this is it. I was originally going to produce just a
proof of concept, but when I found that I had to fix a design flaw
and that covered all the arch code anyway, I decided to do more of a
RFC patch set.

I probably should add more comments to the code, and update the 
function graph design documentation, but I wanted to get this out
before the US Turkey day for your enjoyment while you try to let your
pants buckle again.

Why the rewrite?

Well the fuction graph tracer is arguably the strongest of the tracers.
It shows both the entrance and exit of a function, can give the timings
of a function, and shows the execution of the code quite nicely.

But it has one major flaw.

It can't let more than one user access it at a time. The function
tracer has had that feature for years now, but due to the design of
the function graph tracer it was difficult to implement. Why?

Because you must maintain the state of a three-tuple.

 Task, Function, Callback

The state is determined at by the entryfunc and must be passed to the
retfunc when the function being traced returns. But this is not an
easy task, as that state can be different for each task, each function
and each callback.

What's the solution? I use the shadow stack that is already being
used to store the function return addresses.

  A big thanks to Masami Hiramatsu for suggesting this idea!

For now, I only allow an 16 users of the function graph tracer at a time.
That should be more than enough. I create an array of 16 fgraph_ops
pointers. When a user registers their fgraph_ops to the function graph
tracer, it is assigned an index into that array, which will hold a pointer
to the fgraph_ops being registered.

On entry of the function, the array is iterated and each entryfunc of
the fgraph_ops in the array is called. If the entryfunc returns non-zero,
then the index of that fgraph_ops is pushed on the shadow stack (along
with the index to the "ret_stack entry" structure, for fast access
to it). If the entryfunc returns zero, then it is ignored. If at least
one function returned non-zero then the return of the traced function
will also be traced.

On the return of the function, the shadow stack is examined and all
the indexes that were pushed on the stack is read, and each fgraph_ops
retfunc is called in the reverse order.

When a fgraph_ops is unregistered, its index in the array is set to point
to a "stub" fgraph_ops that holds stub functions that just return
"0" for the entryfunc and does nothing for the retfunc. This is because
the retfunc may be called literally days after the entryfunc is called
and we want to be able to free the fgraph_ops that is unregistered.

Note, if another fgraph_ops is registered in the same location, its
retfunc may be called that was set by a previous fgraph_ops. This
is not a regression because that's what can happen today if you unregister
a callback from the current function_graph tracer and register another
one. If this is an issue, there are ways to solve it.

This patch series is based on top of the one I just sent out to fix
the design flaw:

  http://lkml.kernel.org/r/20181122002801.501220343@goodmis.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/fgraph-multi

Head SHA1: b177713619ad49f3dacacfcc11ed110da73ac857


Steven Rostedt (VMware) (14):
      fgraph: Create a fgraph.c file to store function graph infrastructure
      fgraph: Have set_graph_notrace only affect function_graph tracer
      arm64: function_graph: Remove use of FTRACE_NOTRACE_DEPTH
      function_graph: Remove the use of FTRACE_NOTRACE_DEPTH
      ftrace: Create new ftrace-internal.h header
      fgraph: Move function graph specific code into fgraph.c
      fgraph: Add new fgraph_ops structure to enable function graph hooks
      function_graph: Remove unused task_curr_ret_stack()
      function_graph: Move ftrace_graph_get_addr() to fgraph.c
      function_graph: Have profiler use new helper ftrace_graph_get_ret_stack()
      function_graph: Convert ret_stack to a series of longs
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Allow for more than one callback to be registered

----
 arch/arm64/kernel/stacktrace.c       |   3 -
 include/linux/ftrace.h               |  42 +-
 include/linux/sched.h                |   2 +-
 kernel/trace/Makefile                |   1 +
 kernel/trace/fgraph.c                | 816 +++++++++++++++++++++++++++++++++++
 kernel/trace/ftrace.c                | 469 ++------------------
 kernel/trace/ftrace_internal.h       |  75 ++++
 kernel/trace/trace.h                 |   6 +
 kernel/trace/trace_functions_graph.c | 329 ++------------
 kernel/trace/trace_irqsoff.c         |  10 +-
 kernel/trace/trace_sched_wakeup.c    |  10 +-
 kernel/trace/trace_selftest.c        |   8 +-
 12 files changed, 1016 insertions(+), 755 deletions(-)
 create mode 100644 kernel/trace/fgraph.c
 create mode 100644 kernel/trace/ftrace_internal.h
