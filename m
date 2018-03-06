Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeCFJuv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:50:51 -0500
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:49931 "EHLO
        tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeCFJus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:50:48 -0500
Subject: Re: uprobes/perf: KASAN: use-after-free in uprobe_perf_close
References: <4da123ee-1ad1-fbd3-d5c0-bd9f5ed26434@lab.ntt.co.jp>
 <20180222163715.GA1485@redhat.com>
 <20180222170427.GQ25181@hirez.programming.kicks-ass.net>
 <20180222170947.GW25235@hirez.programming.kicks-ass.net>
 <20180222174041.GA2802@redhat.com>
From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Message-ID: <35f890f7-1194-4509-a1e4-d63d1c7d22ab@lab.ntt.co.jp>
Date: Tue, 6 Mar 2018 18:49:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222174041.GA2802@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CC-Mail-RelayStamp: 1
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2018 2:40 AM, Oleg Nesterov wrote:
> On 02/22, Peter Zijlstra wrote:
>>
>> On Thu, Feb 22, 2018 at 06:04:27PM +0100, Peter Zijlstra wrote:
>>> On Thu, Feb 22, 2018 at 05:37:15PM +0100, Oleg Nesterov wrote:
>>
>>>> This all makes me think that we should change (fix) kernel/events/core.c...
>>>
>>> That's going to be mighty dodgy though, holding a reference on the task
>>> will avoid the task from dying which will avoid the events from being
>>> destroyed which will avoid the task from dying which will... if you get
>>> my drift :-)
>>
>> Hmm, it might not be all that bad.. I need to re-read some of that code.
> 
> I was thinking about the change below below. I do not think this patch is actually
> correct/complete, but it seems to me that if perf_event_exit_task_context() does
> put_task_struct(current) then put_ctx()->put_task_struct() should go away, every
> user of ctx->task should check TASK_TOMBSTONE anyway?
> 
> Oleg.
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1165,8 +1165,6 @@ static void put_ctx(struct perf_event_context *ctx)
>   	if (atomic_dec_and_test(&ctx->refcount)) {
>   		if (ctx->parent_ctx)
>   			put_ctx(ctx->parent_ctx);
> -		if (ctx->task && ctx->task != TASK_TOMBSTONE)
> -			put_task_struct(ctx->task);
>   		call_rcu(&ctx->rcu_head, free_ctx);
>   	}
>   }
> @@ -3731,10 +3729,9 @@ alloc_perf_context(struct pmu *pmu, struct task_struct *task)
>   		return NULL;
>   
>   	__perf_event_init_context(ctx);
> -	if (task) {
> +	if (task)
>   		ctx->task = task;
> -		get_task_struct(task);
> -	}
> +
>   	ctx->pmu = pmu;
>   
>   	return ctx;
> @@ -4109,6 +4106,8 @@ static void _free_event(struct perf_event *event)
>   
>   	if (event->ctx)
>   		put_ctx(event->ctx);
> +	if (event->hw.target)
> +		put_task_struct(event->hw.target);
>   
>   	exclusive_event_destroy(event);
>   	module_put(event->pmu->module);
> @@ -9475,6 +9474,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>   		 * and we cannot use the ctx information because we need the
>   		 * pmu before we get a ctx.
>   		 */
> +		get_task_struct(task);
>   		event->hw.target = task;
>   	}
>   
> @@ -9590,6 +9590,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>   		perf_detach_cgroup(event);
>   	if (event->ns)
>   		put_pid_ns(event->ns);
> +	if (task)
> +		put_task_struct(task);
>   	kfree(event);
>   
>   	return ERR_PTR(err);
> @@ -10572,7 +10574,6 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
>   	RCU_INIT_POINTER(child->perf_event_ctxp[ctxn], NULL);
>   	put_ctx(child_ctx); /* cannot be last */
>   	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
> -	put_task_struct(current); /* cannot be last */
>   
>   	clone_ctx = unclone_ctx(child_ctx);
>   	raw_spin_unlock_irq(&child_ctx->lock);
> 
Sorry for late reply. I tried these changes. It didn't fix the problem. 
With these changes, the use-after-free access of task_struct occurs at 
_free_event() for the last remaining event.

In your changes, I tried keeping get/put_task_struct() in 
perf_alloc_context()/put_ctx() intact and The problem did not occur. 
Changes are mentioned below.

-Prashant

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c98cce4ceebd..65889d2b5ae2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4109,6 +4109,8 @@ static void _free_event(struct perf_event *event)

  	if (event->ctx)
  		put_ctx(event->ctx);
+	if (event->hw.target)
+		put_task_struct(event->hw.target);

  	exclusive_event_destroy(event);
  	module_put(event->pmu->module);
@@ -9593,6 +9595,7 @@ perf_event_alloc(struct perf_event_attr *attr, int 
cpu,
  		 * and we cannot use the ctx information because we need the
  		 * pmu before we get a ctx.
  		 */
+		get_task_struct(task);
  		event->hw.target = task;
  	}

@@ -9708,6 +9711,8 @@ perf_event_alloc(struct perf_event_attr *attr, int 
cpu,
  		perf_detach_cgroup(event);
  	if (event->ns)
  		put_pid_ns(event->ns);
+	if (task)
+		put_task_struct(task);
  	kfree(event);

  	return ERR_PTR(err);
