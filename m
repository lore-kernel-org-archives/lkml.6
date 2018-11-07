Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F03F2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F03F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeKGTmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:42:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33065 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGTmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:42:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id f19-v6so11019978wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4OgvPrY1caCfnNCJvRr2OXxnlIinYS+l/rgyw+UWyTw=;
        b=OLye7cS5oq04PTBKAZ+t/nWtGXBg2ytO6uyOeqV5096Pvwhlhzk7cxl/FTBauV8kim
         1ehqZvlUE7rjrVUkhZESbRqWLKimNoz1sXPs9TE74lhMjwcwfIxfgHdnVRZTEuJUwK9G
         MgMKTewZihwgaZoHCOFvfUibP13e9NnWL+jLU8YISUaGq+sgA3ZbeK+aQ/R1HL16rmbh
         ynrIwBXtwrxhuvUbKsdDFcnBypnrXg377uMElR7vtADv8LGQ3H8XFIzsVWoIzRogwwE/
         9M/AFN4KFW1OgcG4ixE54/Pj+Q2NXn7gDy1kFdy8/kb06ebALAOAgTMdGlHdl2Q52qbi
         347w==
X-Gm-Message-State: AGRZ1gJUQbiu+rVjmJe3AiNsHjIkMLB5J0unZE2CPybd50Us0CzfXpUK
        gdBLOPdpzWvzUcUJYbV6ciQWkg==
X-Google-Smtp-Source: AJdET5ezyxD/JLzpPRr0jclNHr1BjVMJWLpXreVxoKkygfNKNFxuNLreKZ8sHa6SZjdYV2jwlvKzrg==
X-Received: by 2002:a1c:a8c:: with SMTP id 134-v6mr1431182wmk.81.1541585539776;
        Wed, 07 Nov 2018 02:12:19 -0800 (PST)
Received: from t460s.bristot.redhat.com ([87.18.205.191])
        by smtp.gmail.com with ESMTPSA id g1-v6sm876118wmg.2.2018.11.07.02.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:12:19 -0800 (PST)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
References: <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
 <20181030120804.2f30c2da@sweethome>
 <2942706f-db18-6d38-02f7-ef21205173ca@redhat.com>
 <20181031164009.GM18091@localhost.localdomain>
 <027899c5-c5ca-b214-2a87-abe17579724a@redhat.com>
 <20181101055512.GO18091@localhost.localdomain>
 <1bf857dc-d6ac-e505-82bd-dd28449d3a60@redhat.com>
 <20181105105538.GQ18091@localhost.localdomain>
Message-ID: <340703c1-56ae-cd13-60ec-9f727ac28705@redhat.com>
Date:   Wed, 7 Nov 2018 11:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105105538.GQ18091@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 11:55 AM, Juri Lelli wrote:
> On 02/11/18 11:00, Daniel Bristot de Oliveira wrote:
>> On 11/1/18 6:55 AM, Juri Lelli wrote:
>>>> I meant, I am not against the/a fix, i just think that... it is more complicated
>>>> that it seems.
>>>>
>>>> For example: Let's assume that we have a non-rt bad thread A in CPU 0 generating
>>>> IPIs because of static key update, and a good dl thread B in the CPU 1.
>>>>
>>>> In this case, the thread B could run less than what was reserved for it, but it
>>>> was not causing the interrupts. It is not fair to put a penalty in the thread B.
>>>>
>>>> The same is valid for a dl thread running in the same CPU that is receiving a
>>>> lot of network packets to another application, and other legit cases.
>>>>
>>>> In the end, if we want to avoid non-rt threads starving, we need to prioritize
>>>> them some time, but in this case, we return to the DL server for non-rt threads.
>>>>
>>>> Thoughts?
>>> And I see your point. :-)
>>>
>>> I'd also add (maybe you mentioned this as well) that it seems the same
>>> could happen with RT throttling safety measure, as we are using
>>> clock_task there as well to account runtime and throttle stuff.
>>
>> Yes! The same problem can happen with rt scheduler as well! I saw this problem
>> first with the rt throttling mechanism when I was trying to make it work in the
>> microseconds granularity (it is only enforced in the schedule tick, so it is in
>> an ms granularity in practice). After using hr timers to do the enforcement in
>> the microseconds granularity, I was trying to let just fewer us for the non-rt.
>> But as the IRQ runtime was higher than these fewer us, the rt_rq was never
>> throttled. It is the same/similar behavior we see here.
>>
>> As we think in the rt throttling as "avoiding rt workload to consume more than
>> rt_runtime/rt_period", and considering that IRQs are a level of task with a
>> fixed priority higher than all the real-time related schedulers, i.e., deadline
>> and rt, we can safely argue that we can consider the IRQ time into the pool of
>> rt workload and account it in the rt_runtime. The easiest way to do it is to use
>> the rq_clock() in the measurement. I agree.
>>
>> The point is that the CBS has a dual goal: it avoids a task running for more
>> than its runtime (a throttling behavior), but it also is used as a guarantee of
>> runtime for the case in which the task behaves, and the system is not
>> overloaded. Considering we can have more load than we can schedule in a
>> multiprocessor - but that is another story.
>>
>> The the obvious reasoning here is: Ok boy, but the system IS overloaded in this
>> case, we have a RCU stall! And that is true if you look at the processor
>> starving RCU. But if the system has mode than one CPU, it could have CPU time
>> available in another CPU. So, we could just move the dl task from one CPU to
>> another.
> 
> Mmm, only that in this particular case I believe IRQ load will move
> together with the migrating task and problem won't really be solved. :-/

The thread would move to another CPU. Allowing the (pinned) non-rt tasks to have
time to run. Later, the bad dl task would be able to return, to avoid the
problem of the deadline task doing the wrong thing in the other CPU. In this
way, non-rt threads would be able to run, avoiding RCU stall/softlockup.

That is the idea of the rt throttling.

>> Btw, that is another point. We have the AC with the sum of the utilization of
>> all CPUs. But we do no enforcement for per-cpu utilization. If one set a single
>> thread with runtime=deadline=period  (in a system with more than one CPU), and
>> run in a busy-loop, we will eventually have an RCU stall as well (I just did on
>> my box, I got a soft lockup). I know this is a different problem. But, maybe,
>> there is a general solution for both issues:
> 
> This is true. However, the single 100% bandwidth task problem can be
> solved by limiting the maximum bandwidth a single entity can ask for. Of
> course we can get again to a similar sort of problem if multiple
> entities are then co-scheduled on the same CPU, for which we would need
> (residual) capacity awareness. This should happen less likely though, as
> there is a general tendency to spread tasks.

Limiting the U of a task does not solve the problem. Moreover, a U = 1 task is
not exactly a problem, if the proper way to avoid the starvation of non-rt
thread exists. A U = 1 task can exist without causing damage by moving the
thread between two CPUs, for instance. I know this is very controversial, but
there are many use cases for it. For instance, NFV polling to NIC,
high-frequency trading -rt-users use polling mechanism as well (the discussion
of whether it is right or wrong is another chapter). In practice, these cases
are a significant part of -rt-users.

Still, the problem can happen even if you limit the U per task. You just need
two U = 0.5 tasks to fulfill the CPU. The global scheduler tends to spread the
load (because it migrates the threads very often), I agree. But the problem can
happen, and it will, sooner or later it always happens.

>> For instance, if the sum of the execution time of all "task" with priority
>> higher than the OTHER class (rt, dl, stop_machine, IRQs, NMIs, Hypervisor?) in a
>> CPU is higher than rt_runtime in the rt_period, we need to avoid what is
>> "avoidable" by trying to move rt and dl threads away from that CPU. Another
>> possibility is to bump the priority of the OTHER class (and we are back to the
>> DL server).
> 
> Kind of weird though having to migrate RT (everything higher than OTHER)
> only to make some room for non-RT stuff.

It is not. That is the idea of the RT throttling. The rq is throttle, to avoid
starving (per-cpu) non-rt threads that need to run. One can prevent migrating rt
threads, but this is not correct for a global scheduler, as it would break the
working conserving properties.

> Also because one can introduce
> unwanted side effects on high prio workloads (cache related overheads,
> etc.).

Considering one thread will have to migrate once per rt_period (1ms by default),
only if an rq becomes overloaded, we can say that this is barely insignificant,
given the amount of migrations we have in the global scheduler. Well, global has
a tendency to spread tasks by migrating them anyway.

> OTHER has also already have some knowledge about higher prio
> activities (rt,dl,irq PELT). So this seems to really leave us with
> affined tasks, of all priorities and kinds (real vs. irq).

I am not an expert in PELT, how does PELT deal with RT throttling?

>>
>> - Dude, would not be easy just changing the CBS?
>>
>> Yeah, but by changing the CBS, we may end up breaking the algorithms/properties
>> that rely on CBS... like GRUB, user-space/kernel-space synchronization...
>>
>>> OTOH, when something like you describe happens, guarantees are probably
>>> already out of the window and we should just do our best to at least
>>> keep the system "working"? (maybe only to warn the user that something
>>> bad has happened)
>>
>> Btw, don't get me wrong, I am not against changing CBS: I am just trying to
>> raise other viewpoints to avoid touching in the base of the DL scheduler, and
>> avoid punishing a thread that behaves well.
>>
>> Anyway, notifying that dl+rt+IRQ time is higher than the rt_runtime is another
>> good thing to do as well. We will be notified anyway, either by RCU or
>> softlockup... but they are side effects warning. By notifying that we have an
>> overload of rt or higher workload we will be pointing to the cause.
> 
> Right. It doesn't solve the problem, but I guess it could help debugging.
I did not say it was a solution.

I was having a look at the reproducer, and... well, a good part of the problem
can be bounded in the other part of the equation. The reproducer enables perf
sampling, and it is known that perf sampling can cause problems, and that is why
we have limits for it.

The limits point to a 25 percent of CPU time for perf sampling... considering
throttling imprecision because of HZ... we can clearly see that the system is
with > 100% of CPU usage for dl + IRQ.

Again: don't get me wrong, I am aware and agree that there is another problem,
about the "readjustment of the period/runtime considering the drift in the
execution of the task caused by IRQs." What I am pointing here is that there are
more general problems w.r.t. the possibility of causing starvation of per-cpu
housekeeping threads needed by the system (for instance, RCU).

There are many open issues w.r.t the throttling mechanism, for instance:

1) We need to take the imprecision in the account of runtime in the AC.
2) The throttling needs to be designed in such a way that we try not to starve
non-rt threads in a CPU/rq - rather than the system (accounting per CPU).
3) We need to consider the IRQ workload as well to avoid RT+DL+IRQ to use all
the CPU time.

... among other things.

-- Daniel
