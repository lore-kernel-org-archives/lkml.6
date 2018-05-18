Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeERPcs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbeERPcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:32:46 -0400
Date: Sat, 19 May 2018 00:32:41 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>, Julia Cartwright <julia@ni.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] kselftests: ftrace: Add tests for the preemptoff
 and irqsoff tracers
Message-Id: <20180519003241.928109adf305c24f9881215b@kernel.org>
In-Reply-To: <20180518015421.129868-3-joel@joelfernandes.org>
References: <20180518015421.129868-1-joel@joelfernandes.org>
        <20180518015421.129868-3-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

55ty jmnOn Thu, 17 May 2018 18:54:21 -0700
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Here we add unit tests for the preemptoff and irqsoff tracer by using a
> kernel module introduced previously to trigger atomic sections in the
> kernel.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Erick Reyes <erickreyes@google.com>
> Cc: Julia Cartwright <julia@ni.com>
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/ftrace/config         |  3 +
>  .../test.d/preemptirq/irqsoff_tracer.tc       | 74 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> 
> diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
> index b01924c71c09..29588b328345 100644
> --- a/tools/testing/selftests/ftrace/config
> +++ b/tools/testing/selftests/ftrace/config
> @@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
>  CONFIG_TRACER_SNAPSHOT=y
>  CONFIG_STACK_TRACER=y
>  CONFIG_HIST_TRIGGERS=y
> +CONFIG_PREEMPT_TRACER=y
> +CONFIG_IRQSOFF_TRACER=y
> +CONFIG_TEST_ATOMIC_SECTIONS=m
> diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> new file mode 100644
> index 000000000000..b76d781c5645
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: test for the preemptirqsoff tracer
> +
> +MOD=test_atomic_sections
> +
> +fail() {
> +    reset_tracer
> +    rmmod $MOD || true
> +    exit_fail
> +}
> +
> +unsup() { #msg
> +    reset_tracer
> +    rmmod $MOD || true
> +    echo $1
> +    exit_unsupported
> +}
> +
> +modprobe $MOD || unsup "$MOD module not available"
> +rmmod $MOD
> +
> +grep "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
> +grep "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"

Could you pass "-q" for all grep command in this script if it just for checking the pattern exists?

Thank you,

> +
> +reset_tracer
> +
> +# Simulate preemptoff section for half a second couple of times
> +echo preemptoff > current_tracer
> +sleep 1
> +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=preempt atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +
> +cat trace
> +
> +# Confirm which tracer
> +grep "tracer: preemptoff" trace || fail
> +
> +# Check the end of the section
> +egrep "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +
> +# Simulate irqsoff section for half a second couple of times
> +echo irqsoff > current_tracer
> +sleep 1
> +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +modprobe test_atomic_sections atomic_mode=irq atomic_time=500000 || fail
> +rmmod test_atomic_sections || fail
> +
> +cat trace
> +
> +# Confirm which tracer
> +grep "tracer: irqsoff" trace || fail
> +
> +# Check the end of the section
> +egrep "5.....us : <stack trace>" trace || fail
> +
> +# Check for 500ms of latency
> +egrep "latency: 5..... us" trace || fail
> +
> +reset_tracer
> +exit 0
> +
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
