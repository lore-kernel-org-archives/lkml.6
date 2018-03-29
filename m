Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeC2Lyn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:54:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbeC2Lyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:54:40 -0400
Date: Thu, 29 Mar 2018 13:54:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Markus Metzger <markus.t.metzger@intel.com>
Subject: Re: [PATCH] perf: Allow suppressing AUX records
Message-ID: <20180329115429.GX4043@hirez.programming.kicks-ass.net>
References: <20171115120022.o7hmfdb7vpeikvjl@hirez.programming.kicks-ass.net>
 <20180115150020.8509-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115150020.8509-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 05:00:20PM +0200, Alexander Shishkin wrote:
> It has been pointed out to me many times that it is useful to be able
> to switch off AUX records to save the bandwidth for records that actually
> matter, for example, in AUX overwrite mode.
> 
> The usefulness of PERF_RECORD_AUX is in some of its flags, like the
> TRUNCATED flag that tells the decoder where exactly gaps in the trace are.
> The OVERWRITE flag, on the other hand will be set on every single record
> in overwrite mode. However, a PERF_RECORD_AUX[flags=OVERWRITE] is
> generated on every target task's sched_out, which over time adds up to
> a lot of useless information.
> 
> In case the existing userspace depends on AUX records in the overwrite
> mode, we preserve the original behavior and add an opt-in for the new
> behavior, wherein the 'useless' records get suppressed.
> 
> This patch adds an attribute bit to the described effect.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Markus Metzger <markus.t.metzger@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  include/uapi/linux/perf_event.h |  3 ++-
>  kernel/events/core.c            |  5 +++++
>  kernel/events/ring_buffer.c     | 13 +++++++++++--
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index c77c9a2ebbbb..d7a981130561 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -370,7 +370,8 @@ struct perf_event_attr {
>  				context_switch :  1, /* context switch data */
>  				write_backward :  1, /* Write ring buffer from end to beginning */
>  				namespaces     :  1, /* include namespaces data */
> -				__reserved_1   : 35;
> +				suppress_aux   :  1, /* don't generate PERF_RECORD_AUX */
> +				__reserved_1   : 34;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */

So I'm basically fine with this patch, however I wonder if we really
need this suppress flag and can't just unconditionally drop these
events.

Ash said that as far as he knows no Intel-PT user actually relies on it;
Will is there anything ARM that is known to rely on them?

In anycase, tentative ACK on this, unless we wants to be brave and forgo
this flag.

Ingo, any opinions?


> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4e1a1bf8d867..6245a88c2bda 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10012,6 +10012,11 @@ SYSCALL_DEFINE5(perf_event_open,
>  		goto err_context;
>  	}
>  
> +	if (attr.suppress_aux && !pmu->setup_aux) {
> +		err = -EINVAL;
> +		goto err_context;
> +	}
> +
>  	/*
>  	 * Look up the group leader (we will attach this event to it):
>  	 */
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 141aa2ca8728..381f080e6409 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -426,6 +426,12 @@ static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
>  	return false;
>  }
>  
> +/*
> + * These flags won't generate a PERF_RECORD_AUX on their own if
> + * attr::suppress_aux is set.
> + */
> +#define SUPPRESSABLE_FLAGS	PERF_AUX_FLAG_OVERWRITE
> +
>  /*
>   * Commit the data written by hardware into the ring buffer by adjusting
>   * aux_head and posting a PERF_RECORD_AUX into the perf buffer. It is the
> @@ -460,8 +466,11 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>  		 * Only send RECORD_AUX if we have something useful to communicate
>  		 */
>  
> -		perf_event_aux_event(handle->event, aux_head, size,
> -		                     handle->aux_flags);
> +		if (!handle->event->attr.suppress_aux ||
> +		    (handle->aux_flags & ~(u64)SUPPRESSABLE_FLAGS)) {
> +			perf_event_aux_event(handle->event, aux_head, size,
> +					     handle->aux_flags);
> +		}
>  	}
>  
>  	rb->user_page->aux_head = rb->aux_head;
> -- 
> 2.15.1
> 
