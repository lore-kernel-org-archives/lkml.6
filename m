Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeDPI3L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:29:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:21623 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752941AbeDPI3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:29:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="220744017"
Subject: Re: [PATCH v5 1/3] perf/core: store context switch out type into Perf
 trace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
 <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
 <20180409092603.GY4043@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <17c73937-5fdc-7323-366d-edb2f483b30c@linux.intel.com>
Date: Mon, 16 Apr 2018 11:29:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409092603.GY4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 09.04.2018 12:26, Peter Zijlstra wrote:
> On Mon, Apr 09, 2018 at 10:25:32AM +0300, Alexey Budankov wrote:
>>
>> Store preempting context switch out event into Perf trace as a part of 
>> PERF_RECORD_SWITCH[_CPU_WIDE] record.
>>
>> Percentage of preempting and non-preempting context switches help 
>> understanding the nature of workloads (CPU or IO bound) that are running 
>> on a machine;
>>
>> The event is treated as preemption one when task->state value of the 
>> thread being switched out is TASK_RUNNING. Event type encoding is 
>> implemented using PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit;
>> 	
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Acme, I'm thinking you should route this, since most of the changes are
> actually to the tool.

This is just to make sure it doesn't sneak out of your attention 
in hope the plan is still the same as Peter mentioned above.

Thanks,
Alexey

> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index fc1c330c6bd6..872a5aaa77eb 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7584,6 +7584,10 @@ static void perf_event_switch(struct task_struct *task,
>>  		},
>>  	};
>>  
>> +	if (!sched_in && task->state == TASK_RUNNING)
>> +		switch_event.event_id.header.misc |=
>> +				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
> 
> I typically prefer {} over any multi-line expression.
> 
>>  	perf_iterate_sb(perf_event_switch_output,
>>  		       &switch_event,
>>  		       NULL);
> 
