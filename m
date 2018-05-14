Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbeENPU2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:20:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44994 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbeENPU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:20:27 -0400
Date: Mon, 14 May 2018 16:20:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <20180514152022.z3hnkkj3rbcabtyy@lakrids.cambridge.arm.com>
References: <20180510130632.34497-1-mark.rutland@arm.com>
 <20180511105931.yyarmtz2gjkbuq2a@lakrids.cambridge.arm.com>
 <20180511162229.GK12217@hirez.programming.kicks-ass.net>
 <20180514110532.kihs5ilrs67kvq7e@lakrids.cambridge.arm.com>
 <20180514112815.GP12217@hirez.programming.kicks-ass.net>
 <20180514150213.GK12235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514150213.GK12235@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:02:13PM +0200, Peter Zijlstra wrote:
> On Mon, May 14, 2018 at 01:28:15PM +0200, Peter Zijlstra wrote:
> > On Mon, May 14, 2018 at 12:05:33PM +0100, Mark Rutland wrote:
> 
> > > > Also note that in perf_output_put_handle(), where we write ->data_head,
> > > > the store is from an 'unsigned long'. So on 32bit that will result in a
> > > > zero high word. Similarly, in __perf_output_begin() we read ->data_tail
> > > > into an unsigned long, which will discard the high word.
> > > 
> > > Ah, that's a fair point. So it's just compat userspace that this is
> > > potentially borked for. ;)
> > 
> > Right.. #$$#@ compat. Hurmph.. not sure how to go about fixing that
> > there.
> 
> How's this?
> 
> ---
>  include/linux/perf_event.h  | 12 ++++++++++++
>  kernel/events/core.c        | 31 +++++++++++++++++++++++++++++--
>  kernel/events/ring_buffer.c | 39 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e71e99eb9a4e..7834dfb6a83b 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -517,6 +517,7 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
>   */
>  #define PERF_EV_CAP_SOFTWARE		BIT(0)
>  #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
> +#define PERF_EV_CAP_COMPAT		BIT(2)
>  
>  #define SWEVENT_HLIST_BITS		8
>  #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
> @@ -1220,6 +1221,11 @@ static inline bool is_write_backward(struct perf_event *event)
>  	return !!event->attr.write_backward;
>  }
>  
> +static inline bool is_compat_event(struct perf_event *event)
> +{
> +	return event->event_caps & PERF_EV_CAP_COMPAT;
> +}

> @@ -10499,6 +10523,9 @@ SYSCALL_DEFINE5(perf_event_open,
>  		goto err_cred;
>  	}
>  
> +	if (in_compat_syscall())
> +		event->event_caps |= PERF_EV_CAP_COMPAT;
> +

After a native perf_event_open, you could pass the fd (or exec) to
another task that was compat (or vice-versa), so this wouldn't work in
that case (crazy as it may be).

I don't have a better suggestion at present, though.

Thanks,
Mark.
