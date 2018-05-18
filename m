Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeERRAH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:00:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38377 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeERRAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:00:04 -0400
X-Google-Smtp-Source: AB8JxZrXHw6ZBsSZfBHCHrpo1wvy7/N6kiyChKhe57ofTQpULJO0AWv6tdxeI812VBKPyiB5hE/wpg==
Date: Fri, 18 May 2018 10:00:01 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Todd Kjos <tkjos@google.com>, Erick Reyes <erickreyes@google.com>,
        Julia Cartwright <julia@ni.com>, kernel-team@android.com
Subject: Re: [PATCH 2/2] kselftests: ftrace: Add tests for the preemptoff and
 irqsoff tracers
Message-ID: <20180518170001.GA87521@joelaf.mtv.corp.google.com>
References: <20180518015421.129868-1-joel@joelfernandes.org>
 <20180518015421.129868-3-joel@joelfernandes.org>
 <20180519003241.928109adf305c24f9881215b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519003241.928109adf305c24f9881215b@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 12:32:41AM +0900, Masami Hiramatsu wrote:
> Hi Joel,
> 
> 55ty jmnOn Thu, 17 May 2018 18:54:21 -0700
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > Here we add unit tests for the preemptoff and irqsoff tracer by using a
> > kernel module introduced previously to trigger atomic sections in the
> > kernel.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Peter Zilstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Thomas Glexiner <tglx@linutronix.de>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Erick Reyes <erickreyes@google.com>
> > Cc: Julia Cartwright <julia@ni.com>
> > Cc: kernel-team@android.com
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  tools/testing/selftests/ftrace/config         |  3 +
> >  .../test.d/preemptirq/irqsoff_tracer.tc       | 74 +++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
> > index b01924c71c09..29588b328345 100644
> > --- a/tools/testing/selftests/ftrace/config
> > +++ b/tools/testing/selftests/ftrace/config
> > @@ -4,3 +4,6 @@ CONFIG_FUNCTION_PROFILER=y
> >  CONFIG_TRACER_SNAPSHOT=y
> >  CONFIG_STACK_TRACER=y
> >  CONFIG_HIST_TRIGGERS=y
> > +CONFIG_PREEMPT_TRACER=y
> > +CONFIG_IRQSOFF_TRACER=y
> > +CONFIG_TEST_ATOMIC_SECTIONS=m
> > diff --git a/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> > new file mode 100644
> > index 000000000000..b76d781c5645
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc
> > @@ -0,0 +1,74 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: test for the preemptirqsoff tracer
> > +
> > +MOD=test_atomic_sections
> > +
> > +fail() {
> > +    reset_tracer
> > +    rmmod $MOD || true
> > +    exit_fail
> > +}
> > +
> > +unsup() { #msg
> > +    reset_tracer
> > +    rmmod $MOD || true
> > +    echo $1
> > +    exit_unsupported
> > +}
> > +
> > +modprobe $MOD || unsup "$MOD module not available"
> > +rmmod $MOD
> > +
> > +grep "preemptoff" available_tracers || unsup "preemptoff tracer not enabled"
> > +grep "irqsoff" available_tracers || unsup "irqsoff tracer not enabled"
> 
> Could you pass "-q" for all grep command in this script if it just for checking the pattern exists?

Fixed, thanks!

Will send out update rolled into the series its testing.

- Joel
