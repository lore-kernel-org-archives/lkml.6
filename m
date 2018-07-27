Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B4C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367E0208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367E0208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbeG0RvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732097AbeG0RvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:51:08 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602F5205C9;
        Fri, 27 Jul 2018 16:28:27 +0000 (UTC)
Date:   Fri, 27 Jul 2018 12:28:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180727122825.281a3a67@gandalf.local.home>
In-Reply-To: <20180726235044.10195-4-joel@joelfernandes.org>
References: <20180726235044.10195-1-joel@joelfernandes.org>
        <20180726235044.10195-4-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 16:50:44 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> This patch detaches the preemptirq tracepoints from the tracers and
> keeps it separate.
> 
> Advantages:
> * Lockdep and irqsoff event can now run in parallel since they no longer
> have their own calls.
> 
> * This unifies the usecase of adding hooks to an irqsoff and irqson
> event, and a preemptoff and preempton event.
>   3 users of the events exist:
>   - Lockdep
>   - irqsoff and preemptoff tracers
>   - irqs and preempt trace events
> 
> The unification cleans up several ifdefs and makes the code in preempt
> tracer and irqsoff tracers simpler. It gets rid of all the horrific
> ifdeferry around PROVE_LOCKING and makes configuration of the different
> users of the tracepoints more easy and understandable. It also gets rid
> of the time_* function calls from the lockdep hooks used to call into
> the preemptirq tracer which is not needed anymore. The negative delta in
> lines of code in this patch is quite large too.
> 
> In the patch we introduce a new CONFIG option PREEMPTIRQ_TRACEPOINTS
> as a single point for registering probes onto the tracepoints. With
> this,
> the web of config options for preempt/irq toggle tracepoints and its
> users becomes:
> 
>  PREEMPT_TRACER   PREEMPTIRQ_EVENTS  IRQSOFF_TRACER PROVE_LOCKING
>        |                 |     \         |           |
>        \    (selects)    /      \        \ (selects) /
>       TRACE_PREEMPT_TOGGLE       ----> TRACE_IRQFLAGS
>                       \                  /
>                        \ (depends on)   /
>                      PREEMPTIRQ_TRACEPOINTS
> 
> One note, I have to check for lockdep recursion in the code that calls
> the trace events API and bail out if we're in lockdep recursion
> protection to prevent something like the following case: a spin_lock is
> taken. Then lockdep_acquired is called.  That does a raw_local_irq_save
> and then sets lockdep_recursion, and then calls __lockdep_acquired. In
> this function, a call to get_lock_stats happens which calls
> preempt_disable, which calls trace IRQS off somewhere which enters my
> tracepoint code and sets the tracing_irq_cpu flag to prevent recursion.
> This flag is then never cleared causing lockdep paths to never be
> entered and thus causing splats and other bad things.
> 
> Other than the performance tests mentioned in the previous patch, I also
> ran the locking API test suite. I verified that all tests cases are
> passing.
> 
> I also injected issues by not registering lockdep probes onto the
> tracepoints and I see failures to confirm that the probes are indeed
> working.
> 
> This series + lockdep probes not registered (just to inject errors):
> [    0.000000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]          hard-safe-A + irqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]          soft-safe-A + irqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]          hard-safe-A + irqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]          soft-safe-A + irqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> [    0.000000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> 
> With this series + lockdep probes registered, all locking tests pass:
> 
> [    0.000000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
> [    0.000000]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> [    0.000000]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> [    0.000000]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> [    0.000000]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> [    0.000000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/ftrace.h            |  11 +-
>  include/linux/irqflags.h          |  11 +-
>  include/linux/lockdep.h           |   8 +-
>  include/linux/preempt.h           |   2 +-
>  include/trace/events/preemptirq.h |  23 +--
>  init/main.c                       |   5 +-
>  kernel/locking/lockdep.c          |  35 ++---

Did Peter ever give an Acked-by for this patch?

-- Steve

>  kernel/sched/core.c               |   2 +-
>  kernel/trace/Kconfig              |  22 ++-
>  kernel/trace/Makefile             |   2 +-
>  kernel/trace/trace_irqsoff.c      | 231 ++++++++----------------------
>  kernel/trace/trace_preemptirq.c   |  72 ++++++++++
>  12 files changed, 195 insertions(+), 229 deletions(-)
>  create mode 100644 kernel/trace/trace_preemptirq.c
> 
> 
