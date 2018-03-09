Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932116AbeCIN3g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:29:36 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32983 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeCIN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:29:33 -0500
X-Google-Smtp-Source: AG47ELtwU5payDYcj/XLKcNfsGATLTQNUQERjkx0OADKSHGSQRxJz8INkaH19aOzZvuIdQuZLz3zTQ==
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <08aa9f8a-afe5-e1d3-5301-d196beb665b5@mvista.com>
Date: Fri, 9 Mar 2018 07:29:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309110418.lwtennjqwqcxh422@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 05:04 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-08 13:54:17 [-0600], Corey Minyard wrote:
>>> It will work but I don't think pushing this into workqueue/tasklet is a
>>> good idea. You want to wakeup all waiters on waitqueue X (probably one
>>> waiter) and instead there is one one wakeup + ctx-switch which does the
>>> final wakeup.
>> True, but this is an uncommon and already fairly expensive operation being
>> done.  Adding a context switch doesn't seem that bad.
> still no need to make it more expensive if it can be avoided.
>
>>> But now I had an idea: swake_up_all() could iterate over list and
>>> instead performing wakes it would just wake_q_add() the tasks. Drop the
>>> lock and then wake_up_q(). So in case there is wakeup pending and the
>>> task removed itself from the list then the task may observe a spurious
>>> wakeup.
>> That sounds promising, but where does wake_up_q() get called?  No matter
>> what
>> it's an expensive operation and I'm not sure where you would put it in this
>> case.
> Look at this:
>
...
>   
>   void swake_up(struct swait_queue_head *q)
>   {
> @@ -66,25 +62,14 @@ EXPORT_SYMBOL(swake_up);
>    */
>   void swake_up_all(struct swait_queue_head *q)
>   {
> -	struct swait_queue *curr;
> -	LIST_HEAD(tmp);
> +	unsigned long flags;
> +	DEFINE_WAKE_Q(wq);
>   
> -	WARN_ON(irqs_disabled());
> -	raw_spin_lock_irq(&q->lock);
> -	list_splice_init(&q->task_list, &tmp);
> -	while (!list_empty(&tmp)) {
> -		curr = list_first_entry(&tmp, typeof(*curr), task_list);
> +	raw_spin_lock_irqsave(&q->lock, flags);
> +	swake_add_all_wq(q, &wq);
> +	raw_spin_unlock_irqrestore(&q->lock, flags);
>   
> -		wake_up_state(curr->task, TASK_NORMAL);
> -		list_del_init(&curr->task_list);
> -
> -		if (list_empty(&tmp))
> -			break;
> -
> -		raw_spin_unlock_irq(&q->lock);
> -		raw_spin_lock_irq(&q->lock);
> -	}
> -	raw_spin_unlock_irq(&q->lock);
> +	wake_up_q(&wq);

 From what I can tell, wake_up_q() is unbounded, and you have undone what
the previous code had tried to accomplish.  In the scenario I'm talking 
about,
interrupts are still disabled here.  That's why I was asking about where 
to put
wake_up_q(), I knew you could put it here, but it didn't seem to me to help
at all.

>   }
>   EXPORT_SYMBOL(swake_up_all);
>   
>
>> I had another idea.  This is only occurring if RT is not enabled, because
>> with
>> RT all the irq disable things go away and you are generally running in task
>> context.  So why not have a different version of swake_up_all() for non-RT
>> that does work from irqs-off context?
> With the patch above I have puzzle part which would allow to use swait
> based completions upstream. That ifdef would probably not help.

I agree that having a bounded time way to wake up a bunch of threads while
interrupts are disabled would solve a bunch of issues.  I just don't see 
how it
can be done without pushing it off to a softirq or workqueue.

-corey

>> -corey
> Sebastian
