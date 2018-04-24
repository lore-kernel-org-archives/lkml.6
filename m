Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeDXXVK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:21:10 -0400
Received: from mail.efficios.com ([167.114.142.138]:58876 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDXXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:21:06 -0400
Date: Tue, 24 Apr 2018 19:21:04 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Joel Fernandes <joelaf@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <849066633.939.1524612064698.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
References: <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com> <20180423172244.694dbc9d@gandalf.local.home> <20180424155655.GA820@linux.vnet.ibm.com> <CAJWu+or_-emRLeBbfOtQYyn9W8v-KHH8XecV_k-p5FX_3BLHAQ@mail.gmail.com> <20180424172658.GT26088@linux.vnet.ibm.com> <20180424182302.GA404@linux.vnet.ibm.com> <20180424182623.GA1357@linux.vnet.ibm.com> <CAJWu+opC9pLxoiXq7QDRUDe6ouC4ij398bHCfnUwp+h7Y_ssDg@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: irqflags: Avoid unnecessary calls to trace_ if you can
Thread-Index: WU6CymGZebXJeTf9VSa/uszFIN4/qg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 24, 2018, at 2:59 PM, Joel Fernandes joelaf@google.com wrote:

> Hi Paul,
> 
> On Tue, Apr 24, 2018 at 11:26 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
>> On Tue, Apr 24, 2018 at 11:23:02AM -0700, Paul E. McKenney wrote:
>>> On Tue, Apr 24, 2018 at 10:26:58AM -0700, Paul E. McKenney wrote:
>>> > On Tue, Apr 24, 2018 at 09:01:34AM -0700, Joel Fernandes wrote:
>>> > > On Tue, Apr 24, 2018 at 8:56 AM, Paul E. McKenney
>>> > > <paulmck@linux.vnet.ibm.com> wrote:
>>> > > > On Mon, Apr 23, 2018 at 05:22:44PM -0400, Steven Rostedt wrote:
>>> > > >> On Mon, 23 Apr 2018 13:12:21 -0400 (EDT)
>>> > > >> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>> > > >>
>>> > > >>
>>> > > >> > I'm inclined to explicitly declare the tracepoints with their given
>>> > > >> > synchronization method. Tracepoint probe callback functions for currently
>>> > > >> > existing tracepoints expect to have preemption disabled when invoked.
>>> > > >> > This assumption will not be true anymore for srcu-tracepoints.
>>> > > >>
>>> > > >> Actually, why not have a flag attached to the tracepoint_func that
>>> > > >> states if it expects preemption to be enabled or not? If a
>>> > > >> trace_##event##_srcu() is called, then simply disable preemption before
>>> > > >> calling the callbacks for it. That way if a callback is fine for use
>>> > > >> with srcu, then it would require calling
>>> > > >>
>>> > > >>       register_trace_##event##_may_sleep();
>>> > > >>
>>> > > >> Then if someone uses this on a tracepoint where preemption is disabled,
>>> > > >> we simply do not call it.
>>> > > >
>>> > > > One more stupid question...  If we are having to trace so much stuff
>>> > > > in the idle loop, are we perhaps grossly overstating the extent of that
>>> > > > "idle" loop?  For being called "idle", this code seems quite busy!
>>> > >
>>> > > ;-)
>>> > > The performance hit I am observing is when running a heavy workload,
>>> > > like hackbench or something like that. That's what I am trying to
>>> > > correct.
>>> > > By the way is there any limitation on using SRCU too early during
>>> > > boot? I backported Mathieu's srcu tracepoint patches but the kernel
>>> > > hangs pretty early in the boot. I register lockdep probes in
>>> > > start_kernel. I am hoping that's not why.
>>> > >
>>> > > I could also have just screwed up the backporting... may be for my
>>> > > testing, I will just replace the rcu API with the srcu instead of all
>>> > > of Mathieu's new TRACE_EVENT macros for SRCU, since all I am trying to
>>> > > do right now is measure the performance of my patches with SRCU.
>>> >
>>> > Gah, yes, there is an entry on my capacious todo list on making SRCU
>>> > grace periods work during early boot and mid-boot.  Let me see what
>>> > I can do...
>>>
>>> OK, just need to verify that you are OK with call_srcu()'s callbacks
>>> not being invoked until sometime during core_initcall() time.  (If you
>>> really do need them to be invoked before that, in theory it is possible,
>>> but in practice it is weird, even for RCU.)
>>
>> Oh, and that early at boot, you will need to use DEFINE_SRCU() or
>> DEFINE_STATIC_SRCU() rather than dynamic allocation and initialization.
>>
>>                                                         Thanx, Paul
>>
> 
> Oh ok.
> 
> About call_rcu, calling it later may be an issue since we register the
> probes in start_kernel, for the first probe call_rcu will be sched,
> but for the second one I think it'll try to call_rcu to get rid of the
> first one.
> 
> This is the relevant code that gets called when probes are added:
> 
> static inline void release_probes(struct tracepoint_func *old)
> {
>        if (old) {
>                struct tp_probes *tp_probes = container_of(old,
>                        struct tp_probes, probes[0]);
>                call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
>        }
> }
> 
> Maybe we can somehow defer the call_srcu until later? Would that be possible?
> 
> also Mathieu, you didn't modify the call_rcu_sched in your prototype
> to be changed to use call_srcu, should you be doing that?

You're right, I think I should have introduced a call_srcu in there.
It's missing in my prototype.

However, in the prototype I did, we need to wait for *both* sched-rcu
and SRCU grace periods, because we don't track which site is using which
rcu flavor.

So you could achieve this relatively easily by means of two chained
RCU callbacks, e.g.:

release_probes() calls call_rcu_sched(... , rcu_free_old_probes)

and then in rcu_free_old_probes() do:

call_srcu(... , srcu_free_old_probes)

and perform kfree(container_of(head, struct tp_probes, rcu));
within srcu_free_old_probes.

It is somewhat a hack, but should work.

Thanks,

Mathieu

> 
> thanks,
> 
>  - Joel

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
