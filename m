Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755716AbeDWOxd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755423AbeDWOx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:53:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C4C21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 23 Apr 2018 10:53:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joelaf@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>, kernel-team@lge.com
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Message-ID: <20180423105325.7d5d245b@gandalf.local.home>
In-Reply-To: <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
References: <20180417040748.212236-1-joelaf@google.com>
        <20180417040748.212236-4-joelaf@google.com>
        <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
        <20180419054302.GD13370@sejong>
        <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
        <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
        <20180423031926.GF26088@linux.vnet.ibm.com>
        <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 10:31:28 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I've been wanting to introduce an alternative tracepoint instrumentation
> "flavor" for e.g. system call entry/exit which rely on SRCU rather than
> sched-rcu (preempt-off). This would allow taking faults within the instrumentation
> probe, which makes lots of things easier when fetching data from user-space
> upon system call entry/exit. This could also be used to cleanly instrument
> the idle loop.

I'd be OK with such an approach. And I don't think it would be that
hard to implement. It could be similar to the rcu_idle() tracepoints,
where each flavor simply passes in what protection it uses for
DO_TRACE(). We could do linker tricks to tell the tracepoint.c code how
the tracepoint is protected (add section code, that could be read to
update flags in the tracepoint). Of course modules that have
tracepoints could only use the standard preempt ones.

That is, if trace_##event##_srcu(trace_##event##_sp, PARAMS), is used,
then the trace_##event##_sp would need to be created somewhere. The use
of trace_##event##_srcu() would create a section entry, and on boot up
we can see that the use of this tracepoint requires srcu protection
with a pointer to the trace_##event##_sp srcu_struct. This could be
used to make sure that trace_#event() call isn't done multiple times
that uses two different protection flavors.

I'm just brain storming the idea, and I'm sure I screwed up something
above, but I do believe it is feasible.

> 
> I would be tempted to proceed carefully and introduce a new kind of SRCU
> tracepoint rather than changing all existing ones from sched-rcu to SRCU
> though.

Agreed.

> 
> So the lockdep stuff could use the SRCU tracepoint flavor, which I guess
> would be faster than the rcu_irq_enter_*().

Also agree.

-- Steve
