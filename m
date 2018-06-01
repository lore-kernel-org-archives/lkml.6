Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeFAUEO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 16:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753080AbeFAUEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:04:12 -0400
X-Google-Smtp-Source: ADUXVKJTziHuGVkUImjtRCa9kvbV3hLJ8l/dEDPD8dCsjHLDgvMS5+oidCgL3O2AFeOEqAWeVzljUoywLFi8V5x0Lag=
MIME-Version: 1.0
References: <20180601082811.4c0d33ba@imladris.surriel.com> <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
 <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de> <1527882207.7898.86.camel@surriel.com>
In-Reply-To: <1527882207.7898.86.camel@surriel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 1 Jun 2018 13:03:57 -0700
X-Gmail-Original-Message-ID: <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
Message-ID: <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
To: riel@surriel.com
Cc: Mike Galbraith <efault@gmx.de>, Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 12:43 PM Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 2018-06-01 at 20:48 +0200, Mike Galbraith wrote:
> > On Fri, 2018-06-01 at 14:22 -0400, Rik van Riel wrote:
> > > On Fri, 2018-06-01 at 08:11 -0700, Andy Lutomirski wrote:
> > > > On Fri, Jun 1, 2018 at 5:28 AM Rik van Riel <riel@surriel.com>
> > > > wrote:
> > > > >
> > > > > Song noticed switch_mm_irqs_off taking a lot of CPU time in
> > > > > recent
> > > > > kernels,using 2.4% of a 48 CPU system during a netperf to
> > > > > localhost
> > > > > run.
> > > > > Digging into the profile, we noticed that cpumask_clear_cpu and
> > > > > cpumask_set_cpu together take about half of the CPU time taken
> > > > > by
> > > > > switch_mm_irqs_off.
> > > > >
> > > > > However, the CPUs running netperf end up switching back and
> > > > > forth
> > > > > between netperf and the idle task, which does not require
> > > > > changes
> > > > > to the mm_cpumask. Furthermore, the init_mm cpumask ends up
> > > > > being
> > > > > the most heavily contended one in the system.`
> > > > >
> > > > > Skipping cpumask_clear_cpu and cpumask_set_cpu for init_mm
> > > > > (mostly the idle task) reduced CPU use of switch_mm_irqs_off
> > > > > from 2.4% of the CPU to 1.9% of the CPU, with the following
> > > > > netperf commandline:
> > > >
> > > > I'm conceptually fine with this change.  Does
> > > > mm_cpumask(&init_mm)
> > > > end
> > > > up in a deterministic state?
> > >
> > > Given that we do not touch mm_cpumask(&init_mm)
> > > any more, and that bitmask never appears to be
> > > used for things like tlb shootdowns (kernel TLB
> > > shootdowns simply go to everybody), I suspect
> > > it ends up in whatever state it is initialized
> > > to on startup.
> > >
> > > I had not looked into this much, because it does
> > > not appear to be used for anything.
> > >
> > > > Mike, depending on exactly what's going on with your benchmark,
> > > > this
> > > > might help recover a bit of your performance, too.
> > >
> > > It will be interesting to know how this change
> > > impacts others.
> >
> > previous pipe-test number
> > 4.13.16         2.024978 usecs/loop -- avg 2.045250 977.9 KHz
> > 4.14.47         2.234518 usecs/loop -- avg 2.227716 897.8 KHz
> > 4.15.18         2.287815 usecs/loop -- avg 2.295858 871.1 KHz
> > 4.16.13         2.286036 usecs/loop -- avg 2.279057 877.6 KHz
> > 4.17.0.g88a8676 2.288231 usecs/loop -- avg 2.288917 873.8 KHz
> >
> > new numbers
> > 4.17.0.g0512e01 2.268629 usecs/loop -- avg 2.269493 881.3 KHz
> > 4.17.0.g0512e01 2.035401 usecs/loop -- avg 2.038341 981.2 KHz +andy
> > 4.17.0.g0512e01 2.238701 usecs/loop -- avg 2.231828 896.1 KHz
> > -andy+rik
> >
> > There might be something there with your change Rik, but it's small
> > enough to be wary of variance.  Andy's "invert the return of
> > tlb_defer_switch_to_init_mm()" is OTOH pretty clear.
>
> If inverting the return value of that function helps
> some systems, chances are the other value might help
> other systems.
>
> That makes you wonder whether it might make sense
> to always switch to lazy TLB mode, and only call
> switch_mm at TLB flush time, regardless of whether
> the CPU supports PCID...
>

Mike, you never did say: do you have PCID on your CPU?  Also, what is
your workload doing to cause so many switches back and forth between
init_mm and a task.

The point of the optimization is that switching to init_mm() should be
fairly fast on a PCID system, whereas an IPI to do the deferred flush
is very expensive regardless of PCID.  I wonder if we could do
something fancy where we stay on the task mm for short idles but
switch to init_mm before going deeply idle.  We'd also want to switch
to init_mm when we go idle due to migrating the previously running
task, I think.

Previously, it was hard to make any decisions based on the target idle
state because the idle code chose its target state so late in the
idling process that the CPU was halfway shut down already.  But I
think this is fixed now.

--Andy
