Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755447AbeDWObb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:31:31 -0400
Received: from mail.efficios.com ([167.114.142.138]:40998 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755325AbeDWOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:31:30 -0400
Date: Mon, 23 Apr 2018 10:31:28 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>, kernel-team@lge.com
Message-ID: <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180423031926.GF26088@linux.vnet.ibm.com>
References: <20180417040748.212236-1-joelaf@google.com> <20180417040748.212236-4-joelaf@google.com> <20180418180250.7b6038dddba46b37c94b796c@kernel.org> <20180419054302.GD13370@sejong> <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com> <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com> <20180423031926.GF26088@linux.vnet.ibm.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: irqflags: Avoid unnecessary calls to trace_ if you can
Thread-Index: DQRYiTRVYj41WszA/KsTohOMG0nJGA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 22, 2018, at 11:19 PM, Paul E. McKenney paulmck@linux.vnet.ibm.com wrote:

> On Sun, Apr 22, 2018 at 06:14:18PM -0700, Joel Fernandes wrote:
>> On Fri, Apr 20, 2018 at 12:07 AM, Joel Fernandes <joelaf@google.com> wrote:
>> > Hi,
>> >
>> > Thanks Matsami and Namhyung for the suggestions!
>> >
>> > On Wed, Apr 18, 2018 at 10:43 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>> >> On Wed, Apr 18, 2018 at 06:02:50PM +0900, Masami Hiramatsu wrote:
>> >>> On Mon, 16 Apr 2018 21:07:47 -0700
>> >>> Joel Fernandes <joelaf@google.com> wrote:
>> >>>
>> >>> > With TRACE_IRQFLAGS, we call trace_ API too many times. We don't need
>> >>> > to if local_irq_restore or local_irq_save didn't actually do anything.
>> >>> >
>> >>> > This gives around a 4% improvement in performance when doing the
>> >>> > following command: "time find / > /dev/null"
>> >>> >
>> >>> > Also its best to avoid these calls where possible, since in this series,
>> >>> > the RCU code in tracepoint.h seems to be call these quite a bit and I'd
>> >>> > like to keep this overhead low.
>> >>>
>> >>> Can we assume that the "flags" has only 1 bit irq-disable flag?
>> >>> Since it skips calling raw_local_irq_restore(flags); too,
>> >>
>> >> I don't know how many it impacts on performance but maybe we can have
>> >> an arch-specific config option something like below?
>> >
>> > The flags restoration I am hoping is "cheap" but I haven't measured
>> > specifically the cost of this though.
>> >
>> >>
>> >>
>> >>> if there is any state in the flags on any arch, it may change the
>> >>> result. In that case, we can do it as below (just skipping trace_hardirqs_*)
>> >>>
>> >>> int disabled = irqs_disabled();
>> >>
>> >>   if (disabled == raw_irqs_disabled_flags(flags)) {
>> >> #ifndef CONFIG_ARCH_CAN_SKIP_NESTED_IRQ_RESTORE
>> >>         raw_local_irq_restore(flags);
>> >> #endif
>> >>         return;
>> >>   }
>> >
>> > Hmm, somehow I feel this part should be written generically enough
>> > that it applies to all architectures (as a first step).
>> >
>> >>
>> >>>
>> >>> if (!raw_irqs_disabled_flags(flags) && disabled)
>> >>>       trace_hardirqs_on();
>> >>>
>> >>> raw_local_irq_restore(flags);
>> >>>
>> >>> if (raw_irqs_disabled_flags(flags) && !disabled)
>> >>>       trace_hardirqs_off();
>> >
>> > I like this idea since its a good thing to do the flag restoration
>> > just to be safe and preserve the current behaviors. Also my goal was
>> > to reduce the trace_ calls in this series, so its probably better I
>> > just do as you're suggesting. I will do some experiments and make the
>> > changes for the next series.
>> 
>> So about performance of this series..
>> 
>> lockdep hooking into tracepoint code is a bit heavy, compared to
>> without this series. That's because of the design approach of
>> IRQ on/off -> Trace point -> lockdep
>> 
>> Versus without this series which does
>> IRQ on/off -> lockdep
>> 
>> So we lose performance because of that.
>> 
>> This particular patch improves the situation, as such so this
>> particular patch is probably good to merge once we can test
>> performance of Matsami's suggestion as well.
>> 
>> However, patch 4/4 which makes lockdep use the tracepoint causes a
>> performance hit of around 8% of mean time when I run:
>> hackbench -g 4 -f 2 -l 30000
>> 
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

I've been wanting to introduce an alternative tracepoint instrumentation
"flavor" for e.g. system call entry/exit which rely on SRCU rather than
sched-rcu (preempt-off). This would allow taking faults within the instrumentation
probe, which makes lots of things easier when fetching data from user-space
upon system call entry/exit. This could also be used to cleanly instrument
the idle loop.

I would be tempted to proceed carefully and introduce a new kind of SRCU
tracepoint rather than changing all existing ones from sched-rcu to SRCU
though.

So the lockdep stuff could use the SRCU tracepoint flavor, which I guess
would be faster than the rcu_irq_enter_*().

Thanks,

Mathieu


> 
>							Thanx, Paul
> 
>> Meanwhile I'll also do some performance testing with Matsami's idea as well..
>> 
>> thanks,
>> 
>> - Joel

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
