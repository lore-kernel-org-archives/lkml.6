Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCNNL3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:11:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCNNL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:11:26 -0400
Date: Wed, 14 Mar 2018 14:11:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
Message-ID: <20180314131120.GK4064@hirez.programming.kicks-ass.net>
References: <d109ixq7.fsf@gmail.com>
 <20180312082741.GD4064@hirez.programming.kicks-ass.net>
 <CALyZvKxKXWiFF9OYtykXEfnx-k+xaAM7XREEQ+N58oJtOTZhew@mail.gmail.com>
 <20180314094519.GD4082@hirez.programming.kicks-ass.net>
 <CALyZvKzbLi6K9DFwOXu7h--MdxWFv9A3==0xORuQ=KwtJx3ZrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALyZvKzbLi6K9DFwOXu7h--MdxWFv9A3==0xORuQ=KwtJx3ZrQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 12:55:20PM +0000, Jason Vas Dias wrote:

> > So you can avoid the whole ioctl(ENABLE), ioctl(DISABLE) nonsense and
> > just let them run and do:
> >
> > 	read(group_fd, &buf_pre, size);
> > 	/* your code section */
> > 	read(group_fd, &buf_post, size);
> >
> > 	/* compute buf_post - buf_pre */
> >
> > Which is only 2 system calls, not 4.
> 
> But I can't, really - I am trying to restrict the
> performance counter measurements
> to only a subset of the code, and exclude
> performance measurement result processing  -
> so the timeline is like:

>                       struct timespec t_start, t_end;
>                       perf_event_open(...);
>                       thread_main_loop() { ... do {
>           t     _    clock_gettime(CLOCK_MONOTONIC_RAW, &t_start);
>           t+x _   enable_perf  ();
>                       total_work = do_some_work();
>                       disable_perf ();
>                       clock_gettime(CLOCK_MONOTONIC_RAW, &t_end);
>            t+y_
>                       read_perf_counters_and_store_results
>                        ( perf_grp_fd, &results ,  total_work,
>                          TS2T( &t_end ) - TS2T( &t_start)
>                         );
>            } while (.... );
>         }
> 
>    Now. here the bandwidth / performance results recorded by
>    my 'read_perf_counters_and_store_results' method
>    is very sensitive to the measurement of the OUTER
>    elapsed time .

I still don't see why you have to do that enable_perf() / disable_perf()
stuff. What goes wrong if you just let them run and do 2
read_perf*() things?
