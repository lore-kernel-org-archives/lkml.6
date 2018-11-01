Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E503CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B312064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B312064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeKAO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:56:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32837 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeKAO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:56:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id f19-v6so348761wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 22:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4bco2wJgoKfyz0RdXAd67N6Qjpd34IqHZyGgDLBF3O4=;
        b=cfdZisIXwKzr3Eoc4PyaH7rqdmi6xba9yWZjZoi4Jgyckl648FwrWR9BuxgM8VN5iM
         z2cU7iEpwE85ipVfDk5o1RqudNYgQqDyVnJWwVIaXKriJo4uOs/uKCLwxoXW6lntDZcK
         tqFvAfNkmkm8sE8vOImRRRaf/PHNlnSeJR6rdffzO0SCLOfXGTHzLcAwHsjazxiF+KCq
         S22YIWqGdtyCQs4KZN2cn4OQ0iVANav6zbYdFob2qzBfTzS6rbT0Lq2c1YxTVrjn3edH
         mrpP5z0Un9KaaEUc2S9OlxipDWg2/06ilA+893IXnrSJf6m7s7Y051LUrqt/gt0IwdD0
         AQmQ==
X-Gm-Message-State: AGRZ1gLGM71j15ww24UyyxKpas94srJwCkHNnvbIksGiZkkMm26FkUl2
        YveF43F88J5AHR59tAs0z1A9MA==
X-Google-Smtp-Source: AJdET5cXZuRZ6mGS88geQw8CThw/Is4mqi41qnXUh52PCMQaboK7ZBqlZRHbyo/604GHY+jXUf0T0g==
X-Received: by 2002:a1c:b8d:: with SMTP id 135-v6mr3382009wml.128.1541051722696;
        Wed, 31 Oct 2018 22:55:22 -0700 (PDT)
Received: from localhost.localdomain ([151.35.220.192])
        by smtp.gmail.com with ESMTPSA id q185-v6sm20862861wmg.45.2018.10.31.22.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 22:55:21 -0700 (PDT)
Date:   Thu, 1 Nov 2018 06:55:12 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
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
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181101055512.GO18091@localhost.localdomain>
References: <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
 <20181030120804.2f30c2da@sweethome>
 <2942706f-db18-6d38-02f7-ef21205173ca@redhat.com>
 <20181031164009.GM18091@localhost.localdomain>
 <027899c5-c5ca-b214-2a87-abe17579724a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027899c5-c5ca-b214-2a87-abe17579724a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/18 18:58, Daniel Bristot de Oliveira wrote:
> On 10/31/18 5:40 PM, Juri Lelli wrote:
> > On 31/10/18 17:18, Daniel Bristot de Oliveira wrote:
> >> On 10/30/18 12:08 PM, luca abeni wrote:
> >>> Hi Peter,
> >>>
> >>> On Tue, 30 Oct 2018 11:45:54 +0100
> >>> Peter Zijlstra <peterz@infradead.org> wrote:
> >>> [...]
> >>>>>  2. This is related to perf_event_open syscall reproducer does
> >>>>> before becoming DEADLINE and entering the busy loop. Enabling of
> >>>>> perf swevents generates lot of hrtimers load that happens in the
> >>>>>     reproducer task context. Now, DEADLINE uses rq_clock() for
> >>>>> setting deadlines, but rq_clock_task() for doing runtime
> >>>>> enforcement. In a situation like this it seems that the amount of
> >>>>> irq pressure becomes pretty big (I'm seeing this on kvm, real hw
> >>>>> should maybe do better, pain point remains I guess), so rq_clock()
> >>>>> and rq_clock_task() might become more a more skewed w.r.t. each
> >>>>> other. Since rq_clock() is only used when setting absolute
> >>>>> deadlines for the first time (or when resetting them in certain
> >>>>> cases), after a bit the replenishment code will start to see
> >>>>> postponed deadlines always in the past w.r.t. rq_clock(). And this
> >>>>> brings us back to the fact that the task is never stopped, since it
> >>>>> can't keep up with rq_clock().
> >>>>>
> >>>>>     - Not sure yet how we want to address this [1]. We could use
> >>>>>       rq_clock() everywhere, but tasks might be penalized by irq
> >>>>>       pressure (theoretically this would mandate that irqs are
> >>>>>       explicitly accounted for I guess). I tried to use the skew
> >>>>> between the two clocks to "fix" deadlines, but that puts us at
> >>>>> risks of de-synchronizing userspace and kernel views of deadlines.  
> >>>>
> >>>> Hurm.. right. We knew of this issue back when we did it.
> >>>> I suppose now it hurts and we need to figure something out.
> >>>>
> >>>> By virtue of being a real-time class, we do indeed need to have
> >>>> deadline on the wall-clock. But if we then don't account runtime on
> >>>> that same clock, but on a potentially slower clock, we get the
> >>>> problem that we can run longer than our period/deadline, which is
> >>>> what we're running into here I suppose.
> >>>
> >>> I might be hugely misunderstanding something here, but in my impression
> >>> the issue is just that if the IRQ time is not accounted to the
> >>> -deadline task, then the non-deadline tasks might be starved.
> >>>
> >>> I do not see this as a skew between two clocks, but as an accounting
> >>> thing:
> >>> - if we decide that the IRQ time is accounted to the -deadline
> >>>   task (this is what happens with CONFIG_IRQ_TIME_ACCOUNTING disabled),
> >>>   then the non-deadline tasks are not starved (but of course the
> >>>   -deadline tasks executes for less than its reserved time in the
> >>>   period); 
> >>> - if we decide that the IRQ time is not accounted to the -deadline task
> >>>   (this is what happens with CONFIG_IRQ_TIME_ACCOUNTING enabled), then
> >>>   the -deadline task executes for the expected amount of time (about
> >>>   60% of the CPU time), but an IRQ load of 40% will starve non-deadline
> >>>   tasks (this is what happens in the bug that triggered this discussion)
> >>>
> >>> I think this might be seen as an adimission control issue: when
> >>> CONFIG_IRQ_TIME_ACCOUNTING is disabled, the IRQ time is accounted for
> >>> in the admission control (because it ends up in the task's runtime),
> >>> but when CONFIG_IRQ_TIME_ACCOUNTING is enabled the IRQ time is not
> >>> accounted for in the admission test (the IRQ handler becomes some sort
> >>> of entity with a higher priority than -deadline tasks, on which no
> >>> accounting or enforcement is performed).
> >>>
> >>
> >> I am sorry for taking to long to join in the discussion.
> >>
> >> I agree with Luca. I've seem this behavior two time before. Firstly when we were
> >> trying to make the rt throttling to have a very short runtime for non-rt
> >> threads, and then in the proof of concept of the semi-partitioned scheduler.
> >>
> >> Firstly, I started thinking on this as a skew between both clocks and disabled
> >> IRQ_TIME_ACCOUNTING. But by ignoring IRQ accounting, we are assuming that the
> >> IRQ runtime will be accounted as the thread's runtime. In other words, we are
> >> just sweeping the trash under the rug, where the rug is the worst case execution
> >> time estimation/definition (which is an even more complex problem). In the
> >> Brazilian part of the Ph.D we are dealing with probabilistic worst case
> >> execution time, and to be able to use probabilistic methods, we need to remove
> >> the noise of the IRQs in the execution time [1]. So, IMHO, using
> >> CONFIG_IRQ_TIME_ACCOUNTING is a good thing.
> >>
> >> The fact that we have barely no control of the execution of IRQs, at first
> >> glance, let us think that the idea of considering an IRQ as a task seems to be
> >> absurd. But, it is not. The IRQs run a piece of code that is, in the vast
> >> majority of the case, not related to the current thread, so it runs another
> >> "task". In the occurrence of more than one IRQ concurrently, the processor
> >> serves the IRQ in a predictable order [2], so the processor schedules the IRQs
> >> as a "task". Finally, there are precedence constraints among threads and IRQs.
> >> For instance, the latency can be seen as the response time of the timer IRQ
> >> handler, plus the delta of the return of the handler and the starting of the
> >> execution of cyclictest [3]. In the theory, the idea of precedence constraints
> >> is also about "task".
> >>
> >> So IMHO, IRQs can be considered as a task (I am considering in my model), and
> >> the place to account this would be in the admission test.
> >>
> >> The problem is that, for the best of my knowledge, there is no admissions test
> >> for such task model/system:
> >>
> >> Two level of schedulers. A high priority scheduler that schedules a non
> >> preemptive task set (IRQ) under a fixed priority (the processor scheduler do it,
> >> and on intel it is a fixed priority). A lower priority task set (threads)
> >> scheduled by the OS.
> >>
> >> But assuming that our current admission control is more about a safe guard than
> >> an exact admission control - that is, for multiprocessor it is necessary, but
> >> not sufficient. (Theoretically, it works for uniprocessor, but... there is a
> >> paper of Rob Davis somewhere that shows that if we have "context switch" (and so
> >> scheduler for our case)) with different costs, the many things does not hold
> >> true, for instance, Deadline Monotonic is not optimal... but I will have to read
> >> more to enter in this point, anyway, multiprocessor is only necessary).
> >>
> >> With this in mind: we do *not* use/have an exact admission test for all cases.
> >> By not having an exact admission test, we assume the user knows what he/she is
> >> doing. In this case, if they have a high load of IRQs... they need to know that:
> >>
> >> 1) Their periods should be consistent with the "interference" they might receive.
> >> 2) Their tasks can miss the deadline because of IRQs (and there is no way to
> >> avoid this without "throttling" IRQs...)
> >>
> >> So, is it worth to put a duct tape for this case?
> >>
> >> My fear is that, by putting a duct tape here, we would turn things prone to more
> >> complex errors/undeterminism... so...
> >>
> >> I think we have another point to add to the discussion at plumbers, Juri.
> > 
> > Yeah, sure. My fear in a case like this though is that the task that
> > ends up starving other is "creating" IRQ overhead on itself. Kind of
> > DoS, no?
> 
> I see your point.
> 
> But how about a non-rt thread that creates a lot of timers, then a DL task
> arrives and preempts it, receiving the interfere from interrupts that were
> caused by the previous thread?
> 
> Actually, enabling/disabling sched stats in a loop generates a IPI storm on all
> (other) CPUs because of updates in jump labels (we will reduce/bound that with
> the batch of jump label update, but still, the problem will exist). But not
> only, iirc we can cause this with a madvise to cause the flush of pages.
> 
> > I'm seeing something along the lines of what Peter suggested as a last
> > resort measure we probably still need to put in place.
> 
> I meant, I am not against the/a fix, i just think that... it is more complicated
> that it seems.
> 
> For example: Let's assume that we have a non-rt bad thread A in CPU 0 generating
> IPIs because of static key update, and a good dl thread B in the CPU 1.
> 
> In this case, the thread B could run less than what was reserved for it, but it
> was not causing the interrupts. It is not fair to put a penalty in the thread B.
> 
> The same is valid for a dl thread running in the same CPU that is receiving a
> lot of network packets to another application, and other legit cases.
> 
> In the end, if we want to avoid non-rt threads starving, we need to prioritize
> them some time, but in this case, we return to the DL server for non-rt threads.
> 
> Thoughts?

And I see your point. :-)

I'd also add (maybe you mentioned this as well) that it seems the same
could happen with RT throttling safety measure, as we are using
clock_task there as well to account runtime and throttle stuff.

OTOH, when something like you describe happens, guarantees are probably
already out of the window and we should just do our best to at least
keep the system "working"? (maybe only to warn the user that something
bad has happened)
