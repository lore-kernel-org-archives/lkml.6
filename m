Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932210AbeDWQSJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755583AbeDWQSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:18:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADFB217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 23 Apr 2018 12:18:00 -0400
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
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@lge.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Message-ID: <20180423121800.47b173af@gandalf.local.home>
In-Reply-To: <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
References: <20180417040748.212236-1-joelaf@google.com>
        <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
        <20180419054302.GD13370@sejong>
        <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
        <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
        <20180423031926.GF26088@linux.vnet.ibm.com>
        <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
        <20180423105325.7d5d245b@gandalf.local.home>
        <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 10:59:43 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The main open question here is whether we want one SRCU grace period
> domain per SRCU tracepoint definition, or just one SRCU domain for all
> SRCU tracepoints would be fine.
> 
> I'm not sure what we would gain by having the extra granularity provided
> by one SRCU grace period domain per tracepoint, and having a single SRCU
> domain for all SRCU tracepoints makes it easy to batch grace period after
> bulk tracepoint modifications.
> 
> Thoughts ?

I didn't think too much depth in this. It was more of just a brain
storming idea. Yeah, one singe RCU domain may be good enough. I was
thinking more of how to know when a tracepoint required the SRCU domain
as supposed to a preempt disabled domain, and wanted to just suggest
the linker script approach.

This is how I detect if trace_printk() is used anywhere in the kernel
(and do that big warning if it is). That way the trace events don't
need to be created any special way. You just use the trace_##event##_X
flavor and it automatically detects what to do. But we need to make
sure the same event isn't used for multiple flavors (SRCU vs schedule),
or maybe we can, and any change would have to do both synchronizations.

-- Steve
