Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeDIKHQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:07:16 -0400
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:37722 "EHLO
        tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeDIKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:07:15 -0400
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
 <20180222163715.GA1485@redhat.com>
 <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
 <20180222170947.GW25235@hirez.programming.kicks-ass.net>
 <20180222174041.GA2802@redhat.com>
 <35f890f7-1194-4509-a1e4-d63d1c7d22ab@lab.ntt.co.jp>
 <20180409073827.GS4082@hirez.programming.kicks-ass.net>
From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Message-ID: <c5431217-4b1c-1f3b-e842-3e0f9dfcd10e@lab.ntt.co.jp>
Date: Mon, 9 Apr 2018 19:00:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409073827.GS4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CC-Mail-RelayStamp: 1
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2018 4:38 PM, Peter Zijlstra wrote:
> On Tue, Mar 06, 2018 at 06:49:10PM +0900, Prashant Bhole wrote:
>> Sorry for late reply. I tried these changes. It didn't fix the problem. With
> 
> He, sorry for completely forgetting about this one :/
> 
>> these changes, the use-after-free access of task_struct occurs at
>> _free_event() for the last remaining event.
>>
>> In your changes, I tried keeping get/put_task_struct() in
>> perf_alloc_context()/put_ctx() intact and The problem did not occur. Changes
>> are mentioned below.
> 
> Yes, I think you're right in that this is the cleanest solution; it adds
> reference counting to the exact pointer we're using.
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index c98cce4ceebd..65889d2b5ae2 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -4109,6 +4109,8 @@ static void _free_event(struct perf_event *event)
>>
>>   	if (event->ctx)
>>   		put_ctx(event->ctx);
>> +	if (event->hw.target)
>> +		put_task_struct(event->hw.target);
>>
>>   	exclusive_event_destroy(event);
>>   	module_put(event->pmu->module);
>> @@ -9593,6 +9595,7 @@ perf_event_alloc(struct perf_event_attr *attr, int
>> cpu,
>>   		 * and we cannot use the ctx information because we need the
>>   		 * pmu before we get a ctx.
>>   		 */
>> +		get_task_struct(task);
>>   		event->hw.target = task;
>>   	}
>>
>> @@ -9708,6 +9711,8 @@ perf_event_alloc(struct perf_event_attr *attr, int
>> cpu,
>>   		perf_detach_cgroup(event);
>>   	if (event->ns)
>>   		put_pid_ns(event->ns);
>> +	if (task)
> 
> Should this not too be 'event->hw.target', for consistency and clarity?


Yes, I am sending a patch with this change. Thanks.

-Prashant
