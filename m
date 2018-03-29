Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeC2Nbo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:31:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:49291 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbeC2Nbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:31:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="46309892"
Date: Thu, 29 Mar 2018 16:31:38 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] perf/core: store context switch out type into
 Perf trace
Message-ID: <20180329133138.b3qe2zvje2ak7qe5@um.fi.intel.com>
References: <0b5dcf43-cfd4-b64e-3d0d-6aa743ff4d4a@linux.intel.com>
 <2f5b6bf3-0321-ec79-8d24-ba1eb536758f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f5b6bf3-0321-ec79-8d24-ba1eb536758f@linux.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 12:20:32PM +0300, Alexey Budankov wrote:
> 
> Store thread context-switch-out event type into Perf trace as a part of 
> PERF_RECORD_SWITCH[_CPU_WIDE] records.
> 
> Introduced types of switch-out events assumed to be 
> a) preempt: task->state == TASK_RUNNING and b) !preempt;
> 
> New !preempt event type is encoded using new 
> PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit extending 
> existing PERF_RECORD_MISC_SWITCH_OUT bit of switch out event:
> 
>     misc &= PERF_RECORD_MISC_SWITCH_OUT | PERF_RECORD_MISC_SWITCH_OUT_PREEMPT

I'd like to offer some suggestions as to how to make the commit message
friendlier for reviewing.

Generally, for every patch, we want to explain the following: what we want,
why we want it and how we want to go about getting it. We also would prefer
to do it in english rather than in C, because for the latter we can just
look at the code.

So, my understanding of this patch translates into something like this.

What: we want to tell apart preemting and non-preempting context switches.
Why: I'm guessing it tells us something about the kind of workloads that
are running on the machine. This doesn't seem to be mentioned anywhere.
How: we add a new bit to the event header to indicate that the corresponding
sched-out is preempting.

> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  include/uapi/linux/perf_event.h       | 4 ++++
>  kernel/events/core.c                  | 4 +++-
>  tools/include/uapi/linux/perf_event.h | 4 ++++

The last one probably wants to be a separate patch.

>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 912b85b52344..cd6ad7e13824 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -655,6 +655,10 @@ struct perf_event_mmap_page {
>   * perf_event_attr::precise_ip.
>   */
>  #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
> +/*
> + * Indicates that thread was preempted in TASK_RUNNING state
> + */
> +#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
>  /*
>   * Reserve the last bit to indicate some extended misc field
>   */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 74a6e8f12a3c..0d39192215bc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7556,6 +7556,8 @@ static void perf_event_switch(struct task_struct *task,
>  			      struct task_struct *next_prev, bool sched_in)
>  {
>  	struct perf_switch_event switch_event;
> +	__u16 switch_type = sched_in ? 0 : PERF_RECORD_MISC_SWITCH_OUT |
> +		(task->state == TASK_RUNNING ? PERF_RECORD_MISC_SWITCH_OUT_PREEMPT : 0);

This is also hard on the eyes. Can't we just

if (!sched_in) {
	misc = SWITCH_OUT;
	if (task->state == TASK_RUNNING)
		misc |= SWITCH_OUT_PREEMPT;
}

?

Thanks,
--
Alex
