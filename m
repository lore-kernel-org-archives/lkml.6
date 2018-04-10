Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeDJLGk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:06:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:06:39 -0400
Date: Tue, 10 Apr 2018 13:06:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: yuankuiz@codeaurora.org
cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH] time: tick-sched: use bool for tick_stopped
In-Reply-To: <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1804101242110.2058@nanos.tec.linutronix.de>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org> <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com> <f253686d26b3470f0e9b60502eb62315@codeaurora.org> <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
 <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:
> On 2018-04-10 05:10 PM, Thomas Gleixner wrote:
> > On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:
> > > On 2018-04-10 04:00 PM, Rafael J. Wysocki wrote:
> > > > On Tue, Apr 10, 2018 at 9:33 AM,  <yuankuiz@codeaurora.org> wrote:
> > > > > From: John Zhao <yuankuiz@codeaurora.org>
> > > > >
> > > > > Variable tick_stopped returned by tick_nohz_tick_stopped
> > > > > can have only true / false values. Since the return type
> > > > > of the tick_nohz_tick_stopped is also bool, variable
> > > > > tick_stopped nice to have data type as bool in place of unsigned int.
> > > > > Moreover, the executed instructions cost could be minimal
> > > > > without potiential data type conversion.
> > > > >
> > > > > Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
> > > > > ---
> > > > >  kernel/time/tick-sched.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
> > > > > index 6de959a..4d34309 100644
> > > > > --- a/kernel/time/tick-sched.h
> > > > > +++ b/kernel/time/tick-sched.h
> > > > > @@ -48,8 +48,8 @@ struct tick_sched {
> > > > >         unsigned long                   check_clocks;
> > > > >         enum tick_nohz_mode             nohz_mode;
> > > > >
> > > > > +       bool                            tick_stopped    : 1;
> > > > >         unsigned int                    inidle          : 1;
> > > > > -       unsigned int                    tick_stopped    : 1;
> > > > >         unsigned int                    idle_active     : 1;
> > > > >         unsigned int                    do_timer_last   : 1;
> > > > >         unsigned int                    got_idle_tick   : 1;
> > > >
> > > > I don't think this is a good idea at all.
> > > >
> > > > Please see https://lkml.org/lkml/2017/11/21/384 for example.
> > > [ZJ] Thanks for this sharing. Looks like, this patch fall into the case of
> > > "Maybe".
> > 
> > This patch falls into the case 'pointless' because it adds extra storage
> [ZJ] 1 bit vs 1 bit. no more.

Groan. No. Care to look at the data structure? You create a new storage,
which is incidentally merged into the other bitfield by the compiler at a
different bit position, but there is no guarantee that a compiler does
that. It's free to use distinct storage for that bool based bit.

> > for no benefit at all.
> [ZJ] tick_stopped is returned by the tick_nohz_tick_stopped() which is bool.
> The benefit is no any potiential type conversion could be minded.

A bit stays a bit. 'bool foo : 1;' or 'unsigned int foo : 1' has to be
evaluated as a bit. So there is a type conversion from BIT to bool required
because BIT != bool.

By chance the evaluation can be done by evaluating the byte in which the
bit is placed just because the compiler knows that the remaining bits are
not used. There is no guarantee that this is done, it happens to be true
for a particular compiler.

But that does not make it any more interesting. It just makes the code
harder to read and eventually leads to bigger storage.

Thanks,

	tglx
