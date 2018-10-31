Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBFEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0364E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0364E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeKABQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:16:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44260 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeKABQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:16:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17-v6so16837303wre.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MqNg+8WRoNDgNtXdjjnR7m2AlIp87COMWVgSzQrhDmk=;
        b=f5nRjBQMbx+xTn+gAgp4ZTXfRgTh3G7I7iZXIfyEM3SVSNQa63XE9RAAm3IB3gn457
         rpCutnS8x/Ejgut/Y6GjTjAJ+JMRoQMdNro8QAKluYvcDXvQ4y5fAuxXNMbCAq5528fq
         UcO+3IcF0Egf/0tR8Hhixf/KQUj858pYXKeEG6qCP0nfhlCF4H0zQsIjY1t5pNWR1rJ1
         ZJlWDqSvM5cF3cB4PVrZ7hE4GDmzz+lVs7Hh6p05qdyxSwFO9zwClXZRJ2lH+nkXQIGf
         FPzjZAyx1Y18LOs/i8D5EsBwvDntIk1h3Bk6nY+KXKIIsFCCxFAlWhaTXL9IRMt/Mvgz
         89ew==
X-Gm-Message-State: AGRZ1gJzbM54mkRQsxvu7BMCZeUjM/vf3nUQlc8ozgt+ONNEPGxeVFfr
        pRc//YHAalYMLBHKHgqhJK160g==
X-Google-Smtp-Source: AJdET5eeY2K8Lux3JOTBhqCjm+oQz/5ObKNwG2dWe/qlJPrKISOdFoCFd3RW86qlxKlMFr0ZbPldGQ==
X-Received: by 2002:a5d:4807:: with SMTP id l7-v6mr3372664wrq.46.1541002682398;
        Wed, 31 Oct 2018 09:18:02 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.201])
        by smtp.gmail.com with ESMTPSA id x6-v6sm22202544wru.46.2018.10.31.09.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 09:18:01 -0700 (PDT)
Subject: Re: INFO: rcu detected stall in do_idle
To:     luca abeni <luca.abeni@santannapisa.it>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
References: <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
 <20181030120804.2f30c2da@sweethome>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <2942706f-db18-6d38-02f7-ef21205173ca@redhat.com>
Date:   Wed, 31 Oct 2018 17:18:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030120804.2f30c2da@sweethome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 12:08 PM, luca abeni wrote:
> Hi Peter,
> 
> On Tue, 30 Oct 2018 11:45:54 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> [...]
>>>  2. This is related to perf_event_open syscall reproducer does
>>> before becoming DEADLINE and entering the busy loop. Enabling of
>>> perf swevents generates lot of hrtimers load that happens in the
>>>     reproducer task context. Now, DEADLINE uses rq_clock() for
>>> setting deadlines, but rq_clock_task() for doing runtime
>>> enforcement. In a situation like this it seems that the amount of
>>> irq pressure becomes pretty big (I'm seeing this on kvm, real hw
>>> should maybe do better, pain point remains I guess), so rq_clock()
>>> and rq_clock_task() might become more a more skewed w.r.t. each
>>> other. Since rq_clock() is only used when setting absolute
>>> deadlines for the first time (or when resetting them in certain
>>> cases), after a bit the replenishment code will start to see
>>> postponed deadlines always in the past w.r.t. rq_clock(). And this
>>> brings us back to the fact that the task is never stopped, since it
>>> can't keep up with rq_clock().
>>>
>>>     - Not sure yet how we want to address this [1]. We could use
>>>       rq_clock() everywhere, but tasks might be penalized by irq
>>>       pressure (theoretically this would mandate that irqs are
>>>       explicitly accounted for I guess). I tried to use the skew
>>> between the two clocks to "fix" deadlines, but that puts us at
>>> risks of de-synchronizing userspace and kernel views of deadlines.  
>>
>> Hurm.. right. We knew of this issue back when we did it.
>> I suppose now it hurts and we need to figure something out.
>>
>> By virtue of being a real-time class, we do indeed need to have
>> deadline on the wall-clock. But if we then don't account runtime on
>> that same clock, but on a potentially slower clock, we get the
>> problem that we can run longer than our period/deadline, which is
>> what we're running into here I suppose.
> 
> I might be hugely misunderstanding something here, but in my impression
> the issue is just that if the IRQ time is not accounted to the
> -deadline task, then the non-deadline tasks might be starved.
> 
> I do not see this as a skew between two clocks, but as an accounting
> thing:
> - if we decide that the IRQ time is accounted to the -deadline
>   task (this is what happens with CONFIG_IRQ_TIME_ACCOUNTING disabled),
>   then the non-deadline tasks are not starved (but of course the
>   -deadline tasks executes for less than its reserved time in the
>   period); 
> - if we decide that the IRQ time is not accounted to the -deadline task
>   (this is what happens with CONFIG_IRQ_TIME_ACCOUNTING enabled), then
>   the -deadline task executes for the expected amount of time (about
>   60% of the CPU time), but an IRQ load of 40% will starve non-deadline
>   tasks (this is what happens in the bug that triggered this discussion)
> 
> I think this might be seen as an adimission control issue: when
> CONFIG_IRQ_TIME_ACCOUNTING is disabled, the IRQ time is accounted for
> in the admission control (because it ends up in the task's runtime),
> but when CONFIG_IRQ_TIME_ACCOUNTING is enabled the IRQ time is not
> accounted for in the admission test (the IRQ handler becomes some sort
> of entity with a higher priority than -deadline tasks, on which no
> accounting or enforcement is performed).
> 

I am sorry for taking to long to join in the discussion.

I agree with Luca. I've seem this behavior two time before. Firstly when we were
trying to make the rt throttling to have a very short runtime for non-rt
threads, and then in the proof of concept of the semi-partitioned scheduler.

Firstly, I started thinking on this as a skew between both clocks and disabled
IRQ_TIME_ACCOUNTING. But by ignoring IRQ accounting, we are assuming that the
IRQ runtime will be accounted as the thread's runtime. In other words, we are
just sweeping the trash under the rug, where the rug is the worst case execution
time estimation/definition (which is an even more complex problem). In the
Brazilian part of the Ph.D we are dealing with probabilistic worst case
execution time, and to be able to use probabilistic methods, we need to remove
the noise of the IRQs in the execution time [1]. So, IMHO, using
CONFIG_IRQ_TIME_ACCOUNTING is a good thing.

The fact that we have barely no control of the execution of IRQs, at first
glance, let us think that the idea of considering an IRQ as a task seems to be
absurd. But, it is not. The IRQs run a piece of code that is, in the vast
majority of the case, not related to the current thread, so it runs another
"task". In the occurrence of more than one IRQ concurrently, the processor
serves the IRQ in a predictable order [2], so the processor schedules the IRQs
as a "task". Finally, there are precedence constraints among threads and IRQs.
For instance, the latency can be seen as the response time of the timer IRQ
handler, plus the delta of the return of the handler and the starting of the
execution of cyclictest [3]. In the theory, the idea of precedence constraints
is also about "task".

So IMHO, IRQs can be considered as a task (I am considering in my model), and
the place to account this would be in the admission test.

The problem is that, for the best of my knowledge, there is no admissions test
for such task model/system:

Two level of schedulers. A high priority scheduler that schedules a non
preemptive task set (IRQ) under a fixed priority (the processor scheduler do it,
and on intel it is a fixed priority). A lower priority task set (threads)
scheduled by the OS.

But assuming that our current admission control is more about a safe guard than
an exact admission control - that is, for multiprocessor it is necessary, but
not sufficient. (Theoretically, it works for uniprocessor, but... there is a
paper of Rob Davis somewhere that shows that if we have "context switch" (and so
scheduler for our case)) with different costs, the many things does not hold
true, for instance, Deadline Monotonic is not optimal... but I will have to read
more to enter in this point, anyway, multiprocessor is only necessary).

With this in mind: we do *not* use/have an exact admission test for all cases.
By not having an exact admission test, we assume the user knows what he/she is
doing. In this case, if they have a high load of IRQs... they need to know that:

1) Their periods should be consistent with the "interference" they might receive.
2) Their tasks can miss the deadline because of IRQs (and there is no way to
avoid this without "throttling" IRQs...)

So, is it worth to put a duct tape for this case?

My fear is that, by putting a duct tape here, we would turn things prone to more
complex errors/undeterminism... so...

I think we have another point to add to the discussion at plumbers, Juri.

[1] http://bristot.me/wp-content/uploads/2018/09/conference_071817.pdf
[2] Intel® 64 and IA-32 Architectures Software Developer’s Manual: Volume 3,
    section: 6.9 PRIORITY AMONG SIMULTANEOUS EXCEPTIONS AND INTERRUPTS.
[3] I will detail this a little bit more in the plumbers presentation.

> 
>> And yes, at some point RT workloads need to be aware of the jitter
>> injected by things like IRQs and such. But I believe the rationale was
>> that for soft real-time workloads this current semantic was 'easier'
>> because we get to ignore IRQ overhead for workload estimation etc.
>>
>> What we could maybe do is track runtime in both rq_clock_task() and
>> rq_clock() and detect where the rq_clock based one exceeds the period
>> and then push out the deadline (and add runtime).
>>
>> Maybe something along such lines; does that make sense?
> 
> Uhm... I have to study and test your patch... I'll comment on this
> later.
> 
> 
> 
> 			Thanks,
> 				Luca
> 
> 
>>
>> ---
>>  include/linux/sched.h   |  3 +++
>>  kernel/sched/deadline.c | 53
>> ++++++++++++++++++++++++++++++++----------------- 2 files changed, 38
>> insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 8f8a5418b627..6aec81cb3d2e 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -522,6 +522,9 @@ struct sched_dl_entity {
>>  	u64				deadline;	/*
>> Absolute deadline for this instance	*/ unsigned
>> int			flags;		/* Specifying the
>> scheduler behaviour	*/ 
>> +	u64				wallstamp;
>> +	s64				walltime;
>> +
>>  	/*
>>  	 * Some bool flags:
>>  	 *
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 91e4202b0634..633c8f36c700 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -683,16 +683,7 @@ static void replenish_dl_entity(struct
>> sched_dl_entity *dl_se, if (dl_se->dl_yielded && dl_se->runtime > 0)
>>  		dl_se->runtime = 0;
>>  
>> -	/*
>> -	 * We keep moving the deadline away until we get some
>> -	 * available runtime for the entity. This ensures correct
>> -	 * handling of situations where the runtime overrun is
>> -	 * arbitrary large.
>> -	 */
>> -	while (dl_se->runtime <= 0) {
>> -		dl_se->deadline += pi_se->dl_period;
>> -		dl_se->runtime += pi_se->dl_runtime;
>> -	}
>> +	/* XXX what do we do with pi_se */
>>  
>>  	/*
>>  	 * At this point, the deadline really should be "in
>> @@ -1148,9 +1139,9 @@ static void update_curr_dl(struct rq *rq)
>>  {
>>  	struct task_struct *curr = rq->curr;
>>  	struct sched_dl_entity *dl_se = &curr->dl;
>> -	u64 delta_exec, scaled_delta_exec;
>> +	u64 delta_exec, scaled_delta_exec, delta_wall;
>>  	int cpu = cpu_of(rq);
>> -	u64 now;
>> +	u64 now, wall;
>>  
>>  	if (!dl_task(curr) || !on_dl_rq(dl_se))
>>  		return;
>> @@ -1171,6 +1162,17 @@ static void update_curr_dl(struct rq *rq)
>>  		return;
>>  	}
>>  
>> +	wall = rq_clock();
>> +	delta_wall = wall - dl_se->wallstamp;
>> +	if (delta_wall > 0) {
>> +		dl_se->walltime += delta_wall;
>> +		dl_se->wallstamp = wall;
>> +	}
>> +
>> +	/* check if rq_clock_task() has been too slow */
>> +	if (unlikely(dl_se->walltime > dl_se->period))
>> +		goto throttle;
>> +

If I got it correctly, it can be the case that we would throttle a thread that,
because of IRQs, received less CPU time than expected, right?

Thanks!
-- Daniel
