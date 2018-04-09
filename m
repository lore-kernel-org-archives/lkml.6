Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeDIJ0J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:26:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeDIJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:26:06 -0400
Date: Mon, 9 Apr 2018 11:26:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 1/3] perf/core: store context switch out type into
 Perf trace
Message-ID: <20180409092603.GY4043@hirez.programming.kicks-ass.net>
References: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
 <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 10:25:32AM +0300, Alexey Budankov wrote:
> 
> Store preempting context switch out event into Perf trace as a part of 
> PERF_RECORD_SWITCH[_CPU_WIDE] record.
> 
> Percentage of preempting and non-preempting context switches help 
> understanding the nature of workloads (CPU or IO bound) that are running 
> on a machine;
> 
> The event is treated as preemption one when task->state value of the 
> thread being switched out is TASK_RUNNING. Event type encoding is 
> implemented using PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit;
> 	
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acme, I'm thinking you should route this, since most of the changes are
actually to the tool.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fc1c330c6bd6..872a5aaa77eb 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7584,6 +7584,10 @@ static void perf_event_switch(struct task_struct *task,
>  		},
>  	};
>  
> +	if (!sched_in && task->state == TASK_RUNNING)
> +		switch_event.event_id.header.misc |=
> +				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;

I typically prefer {} over any multi-line expression.

>  	perf_iterate_sb(perf_event_switch_output,
>  		       &switch_event,
>  		       NULL);
