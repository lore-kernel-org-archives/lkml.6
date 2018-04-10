Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeDJL05 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:26:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeDJL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:26:56 -0400
Date: Tue, 10 Apr 2018 13:26:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: yuankuiz@codeaurora.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH] time: tick-sched: use bool for tick_stopped
Message-ID: <20180410112637.GD4082@hirez.programming.kicks-ass.net>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
 <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
 <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
 <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 06:07:17PM +0800, yuankuiz@codeaurora.org wrote:
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
> > > [ZJ] Thanks for this sharing. Looks like, this patch fall into the
> > > case of
> > > "Maybe".
> > 
> > This patch falls into the case 'pointless' because it adds extra storage
> [ZJ] 1 bit vs 1 bit. no more.

Since its a different type, the bitfields will not be merged. Also I'm
surprised a bitfield with base-type _Bool is even allowed.

> > for no benefit at all.
> [ZJ] tick_stopped is returned by the tick_nohz_tick_stopped() which is bool.
> The benefit is no any potiential type conversion could be minded.

Do you have any actual evidence for that? Is there a compiler stupid
enough to generate code to convert a bool to a 1bit value?
