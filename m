Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeDZCSP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:18:15 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:50628 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeDZCSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:18:12 -0400
X-Google-Smtp-Source: AB8JxZqGUkhN3ykONOQfAtTp4WM/etXwVDT28fuWQciscy59bq+I+So+lipKFDEVIVy8bBtwgmpZ+F9ZuJfjqtgR2LA=
MIME-Version: 1.0
In-Reply-To: <20180423031926.GF26088@linux.vnet.ibm.com>
References: <20180417040748.212236-1-joelaf@google.com> <20180417040748.212236-4-joelaf@google.com>
 <20180418180250.7b6038dddba46b37c94b796c@kernel.org> <20180419054302.GD13370@sejong>
 <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
 <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com> <20180423031926.GF26088@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 25 Apr 2018 19:18:10 -0700
Message-ID: <CAJWu+opRDiaL+hRbKYDp-kt-DiRQzu6Y1ceugHSURCsSN+H-aA@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 8:19 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Sun, Apr 22, 2018 at 06:14:18PM -0700, Joel Fernandes wrote:
[...]
>> I narrowed the performance hit down to the call to
>> rcu_irq_enter_irqson() and rcu_irq_exit_irqson() in __DO_TRACE.
>> Commenting these 2 functions brings the perf level back.
>>
>> I was thinking about RCU usage here, and really we never change this
>> particular performance-sensitive tracepoint's function table 99.9% of
>> the time, so it seems there's quite in a win if we just had another
>> read-mostly synchronization mechanism that doesn't do all the RCU
>> tracking that's currently done here and such a mechanism can be
>> simpler..
>>
>> If I understand correctly, RCU also adds other complications such as
>> that it can't be used from the idle path, that's why the
>> rcu_irq_enter_* was added in the first place. Would be nice if we can
>> just avoid these RCU calls for the preempt/irq tracepoints... Any
>> thoughts about this or any other ideas to solve this?
>
> In theory, the tracepoint code could use SRCU instead of RCU, given that
> SRCU readers can be in the idle loop, although at the expense of a couple
> of smp_mb() calls in each tracepoint.  In practice, I must defer to the
> people who know the tracepoint code better than I.

Paul and me were chatting about handling of tracing from an NMI. If
the tracepoint's implementation were to be switched to using SRCU
instead of RCU, a complication could arise due to the use of
this_cpu_inc from srcu_read_lock.

int __srcu_read_lock(struct srcu_struct *sp)
{
        int idx;

        idx = READ_ONCE(sp->srcu_idx) & 0x1;
        this_cpu_inc(sp->sda->srcu_lock_count[idx]);
        smp_mb(); /* B */  /* Avoid leaking the critical section. */
        return idx;
}
EXPORT_SYMBOL_GPL(__srcu_read_lock);

What could happen is if an NMI preempts the this_cpu_inc, and also
happens to call a tracepoint from the NMI handler, then this could
result in a lost-update issue on architectures that don't support
add-to-memory instructions. Paul said he wouldn't want to use atomics
to resolve this inorder to keep the srcu overhead low.

One way we discussed to resolve this could be to use a different
srcu_struct for NMI invocations, so that the above lost update doesn't
occur. We could use in_nmi() and switch the srcu_read_lock to use the
NMI version of the srcu_struct. Another way could be to just warn for
now if the srcu version of the trace_ API was used from NMI. This
could be fragile if some code path indirect results in a tracepoint
call so we should probably handle it by detecting and using the
correct srcu_struct for the srcu_read_lock.

thanks,

 - Joel
