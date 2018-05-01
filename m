Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756106AbeEAQou (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:44:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34865 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbeEAQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:44:49 -0400
X-Google-Smtp-Source: AB8JxZomyvo4LgY4aO1ACqC6pGkVO9cOn1pTqLZFXSWXiZS3bImJjnt8G4ZkFwpRSyQlz/2M1mUsydMPUcMwxhJXw80=
MIME-Version: 1.0
References: <20180501014204.67548-1-joelaf@google.com> <20180501014204.67548-6-joelaf@google.com>
 <20180501102401.2cac5781@gandalf.local.home>
In-Reply-To: <20180501102401.2cac5781@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 16:44:37 +0000
Message-ID: <CAJWu+oowGDfwWGa6yju4F_qYG_CWh7a4Bk=pnVXuBv0_HjX5nA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 5/6] tracepoint: Make rcuidle tracepoint callers
 use SRCU
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 7:24 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Apr 2018 18:42:03 -0700
> Joel Fernandes <joelaf@google.com> wrote:

> > In recent tests with IRQ on/off tracepoints, a large performance
> > overhead ~10% is noticed when running hackbench. This is root caused to
> > calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> > tracepoint code. Following a long discussion on the list [1] about this,
> > we concluded that srcu is a better alternative for use during rcu idle.
> > Although it does involve extra barriers, its lighter than the sched-rcu
> > version which has to do additional RCU calls to notify RCU idle about
> > entry into RCU sections.
> >
> > In this patch, we change the underlying implementation of the
> > trace_*_rcuidle API to use SRCU. This has shown to improve performance
> > alot for the high frequency irq enable/disable tracepoints.

> Can you post some numbers?


Here are some numbers (which I'll also include in the next series spin):

With a run of the following 30 times on a single core x86 Qemu instance
with 1GB memory:
hackbench -g 4 -f 2 -l 3000

Completion times in seconds. CONFIG_PROVE_LOCKING=y.

No patches (without this series)
Mean: 3.048
Median: 3.025
Std Dev: 0.064

With Lockdep using irq tracepoints with RCU implementation:
Mean: 3.451   (-11.66 %)
Median: 3.447 (-12.22%)
Std Dev: 0.049

With Lockdep using irq tracepoints with SRCU implementation:
Mean: 3.020   (I would consider the improvement against the "without this
series" case as just noise).
Median: 3.013
Std Dev: 0.033

thanks,

- Joel
