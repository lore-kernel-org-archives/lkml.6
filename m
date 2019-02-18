Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18642064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfBRVzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:55:43 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59942 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfBRVzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:55:42 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gvqss-0007bv-00; Mon, 18 Feb 2019 21:55:30 +0000
Date:   Mon, 18 Feb 2019 16:55:30 -0500
From:   Rich Felker <dalias@libc.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Regression in SYS_membarrier expedited
Message-ID: <20190218215530.GJ23599@brightrain.aerifal.cx>
References: <20190217184800.GA16118@brightrain.aerifal.cx>
 <53623603.9626.1550439285362.JavaMail.zimbra@efficios.com>
 <20190217215235.GH23599@brightrain.aerifal.cx>
 <20190217220805.GI23599@brightrain.aerifal.cx>
 <424503257.251.1550503352008.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424503257.251.1550503352008.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:22:32AM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 17, 2019, at 5:08 PM, Rich Felker dalias@libc.org wrote:
> 
> > On Sun, Feb 17, 2019 at 04:52:35PM -0500, Rich Felker wrote:
> >> On Sun, Feb 17, 2019 at 04:34:45PM -0500, Mathieu Desnoyers wrote:
> >> > ----- On Feb 17, 2019, at 1:48 PM, Rich Felker dalias@libc.org wrote:
> >> > 
> >> > > commit a961e40917fb14614d368d8bc9782ca4d6a8cd11 made it so that the
> >> > > MEMBARRIER_CMD_PRIVATE_EXPEDITED command cannot be used without first
> >> > > registering intent to use it. However, registration is an expensive
> >> > > operation since commit 3ccfebedd8cf54e291c809c838d8ad5cc00f5688, which
> >> > > added synchronize_sched() to it; this means it's no longer possible to
> >> > > lazily register intent at first use, and it's unreasonably expensive
> >> > > to preemptively register intent for possibly extremely-short-lived
> >> > > processes that will never use it. (My usage case is in libc (musl),
> >> > > where I can't know if the process will be short- or long-lived;
> >> > > unnecessary and potentially expensive syscalls can't be made
> >> > > preemptively, only lazily at first use.)
> >> > > 
> >> > > Can we restore the functionality of MEMBARRIER_CMD_PRIVATE_EXPEDITED
> >> > > to work even without registration? The motivation of requiring
> >> > > registration seems to be:
> >> > > 
> >> > >    "Registering at this time removes the need to interrupt each and
> >> > >    every thread in that process at the first expedited
> >> > >    sys_membarrier() system call."
> >> > > 
> >> > > but interrupting every thread in the process is exactly what I expect,
> >> > > and is not a problem. What does seem like a big problem is waiting for
> >> > > synchronize_sched() to synchronize with an unboundedly large number of
> >> > > cores (vs only a few threads in the process), especially in the
> >> > > presence of full_nohz, where it seems like latency would be at least a
> >> > > few ms and possibly unbounded.
> >> > > 
> >> > > Short of a working SYS_membarrier that doesn't require expensive
> >> > > pre-registration, I'm stuck just implementing it in userspace with
> >> > > signals...
> >> > 
> >> > Hi Rich,
> >> > 
> >> > Let me try to understand the scenario first.
> >> > 
> >> > musl libc support for using membarrier private expedited
> >> > would require to first register membarrier private expedited for
> >> > the process at musl library init (typically after exec). At that stage, the
> >> > process is still single-threaded, right ? So there is no reason
> >> > to issue a synchronize_sched() (or now synchronize_rcu() in newer
> >> > kernels):
> >> > 
> >> > membarrier_register_private_expedited()
> >> > 
> >> >         if (!(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)) {
> >> >                 /*
> >> >                  * Ensure all future scheduler executions will observe the
> >> >                  * new thread flag state for this process.
> >> >                  */
> >> >                 synchronize_rcu();
> >> >         }
> >> > 
> >> > So considering that pre-registration carefully done before the process
> >> > becomes multi-threaded just costs a system call (and not a synchronize_sched()),
> >> > does it make the pre-registration approach more acceptable ?
> >> 
> >> It does get rid of the extreme cost, but I don't think it would be
> >> well-received by users who don't like random unnecessary syscalls at
> >> init time (each adding a few us of startup time cost). If it's so
> >> cheap, why isn't it just the default at kernel-side process creation?
> >> Why is there any requirement of registration to begin with? Reading
> >> the code, it looks like all it does is set a flag, and all this flag
> >> is used for is erroring-out if it's not set.
> > 
> > On further thought, pre-registration could be done at first
> > pthread_create rather than process entry, which would probably be
> > acceptable. But the question remains why it's needed at all, and
> > neither of these approaches is available to code that doesn't have the
> > privilege of being part of libc. For example, library code that might
> > be loaded via dlopen can't safely use SYS_membarrier without
> > introducing unbounded latency before the first use.
> 
> For membarrier private expedited, the need for pre-registration is currently
> there because of powerpc not wanting to slow down switch_mm() for processes
> not needing that command.
> 
> That's the only reason I see for it. If we would have accepted to add
> a smp_mb() to the powerpc switch_mm() scheduler path, we could have done
> so without registration for the private expedited membarrier command.

I don't understand why the barrier is needed at all; the ipi ping
should suffice to execute a barrier instruction on all cores on which
a thread of the process is running, and if any other core subsequently
picks up a thread of the process to run, it must necessarily perform a
barrier just to synchronize with whatever core the thread was
previously running on (not to mention synchronizing the handoff
itself). Is this just to optimize out ipi pinging cores that threads
of the process are not currently running on, but were last running on
and could become running on again without migration?

> commit a961e40917fb hints at the sync_core private expedited membarrier
> commands (which was being actively designed at that time) which may
> require pre-registration. However, things did not turn out that way: we
> ended up adding the required core serializing barriers unconditionally
> into each architecture.
> 
> Considering that sync_core private expedited membarrier ended up not needing
> pre-registration, I think this pre-registration optimization may have been
> somewhat counter-productive, since I doubt the overhead of smp_mb() in a
> switch_mm() for powerpc is that high, but I don't have the hardware handy
> to provide numbers. So we end up slowing down everyone by requiring a
> registration system call after exec. :-(

I'm surprised it's even possible to do switch_mm correctly with no
barrier...

> One possible way out of this would be to make MEMBARRIER_CMD_PRIVATE_EXPEDITED
> and MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE work fine without pre-registration
> in future kernels. Therefore, the application could try using them without
> registration. If it works, all is fine, else it would treat the error how it
> sees fit, either through explicit registration and trying again, or returning
> the error to the caller.

This would be nice. I think the register-at-first-pthread_create works
fine for my case now, but as noted it doesn't work when you can't
control libc internals.

> The only change I see we would require to make this work is to turn
> arch/powerpc/include/asm/membarrier.h membarrier_arch_switch_mm() into
> an unconditional smp_mb().

I finally found this just now; before I was mistakenly grepping for
MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY rather than
MEMBARRIER_STATE_PRIVATE_EXPEDITED, and couldn't find anywhere it was
actually used.

> Thoughts ?

I'm all for making it work without pre-registration. I don't care
whether this is via heavier barriers in ppc or via pinging more cores,
or some other mechanism, but maybe others have opinions on this.

One alternative might be auto-registration, ipi pinging all cores the
process has threads on (even not currently running) for the first
membarrier, so that they see the membarrier_state updated without
having to synchronize with the rcu/scheduler, then doing the same as
now after the first call. I'm not sure if this creates opportunities
for abuse; probably no worse than the process could do just by
actually running lots of threads.

Rich
