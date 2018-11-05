Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C19C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA8B20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA8B20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbeKEUOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:14:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39779 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:14:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so8976451wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ul6by3fmSldDSfX7W9kuvkwhNgBOYUMWaj1PrW4aBd4=;
        b=X5PUoE+IhbtdvdCOl8xEpZfEdtwDYob4kOVzhnfGw54F+C8GNLh+VoQVOcUGzeGqbI
         7dRgs8sMih4aWFJVeH+jt/50Cvu9+lNgJeFubfY7Rqii1GLTLAvmj6f8xrLHpuswAl2X
         GgeYK+LriIJJPGf7CHW41soggsZ6YHPN1jHYO6k+XKb7SLd3oUY5/XV8IPRfl/vmH6Fc
         cH4Eqvea2aeriH82Vx1fBes4r3ybZhz/hqMwOjj5Vr3UHDP2B5oCmT3IU1vExknr6rVQ
         JvYEq6KhC9Z2xd33rVKesljlaSNIwVZDni40TKYSA0Mw2D1lq/ygnPoyWOGqAVDZ0JuX
         f+qg==
X-Gm-Message-State: AGRZ1gJLRz1N2ldbwdYTGi8XIC9yz3e7GBexFZO3XX8dH0Di2nFsz6/G
        Tb09f+HRx8pyQUKerHNUuJLCyA==
X-Google-Smtp-Source: AJdET5fufxddH8jPXZlar1i7Vbl8LGrbYknYly5+UNe61gWMQvQt6eDKOg+xivU1UA71mAuWP1/mdA==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18-v6mr19869276wrt.168.1541415344244;
        Mon, 05 Nov 2018 02:55:44 -0800 (PST)
Received: from localhost.localdomain ([151.35.141.200])
        by smtp.gmail.com with ESMTPSA id b66-v6sm2261036wmb.21.2018.11.05.02.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 02:55:43 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:55:38 +0100
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
Message-ID: <20181105105538.GQ18091@localhost.localdomain>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf857dc-d6ac-e505-82bd-dd28449d3a60@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/18 11:00, Daniel Bristot de Oliveira wrote:
> On 11/1/18 6:55 AM, Juri Lelli wrote:
> >> I meant, I am not against the/a fix, i just think that... it is more complicated
> >> that it seems.
> >>
> >> For example: Let's assume that we have a non-rt bad thread A in CPU 0 generating
> >> IPIs because of static key update, and a good dl thread B in the CPU 1.
> >>
> >> In this case, the thread B could run less than what was reserved for it, but it
> >> was not causing the interrupts. It is not fair to put a penalty in the thread B.
> >>
> >> The same is valid for a dl thread running in the same CPU that is receiving a
> >> lot of network packets to another application, and other legit cases.
> >>
> >> In the end, if we want to avoid non-rt threads starving, we need to prioritize
> >> them some time, but in this case, we return to the DL server for non-rt threads.
> >>
> >> Thoughts?
> > And I see your point. :-)
> > 
> > I'd also add (maybe you mentioned this as well) that it seems the same
> > could happen with RT throttling safety measure, as we are using
> > clock_task there as well to account runtime and throttle stuff.
> 
> Yes! The same problem can happen with rt scheduler as well! I saw this problem
> first with the rt throttling mechanism when I was trying to make it work in the
> microseconds granularity (it is only enforced in the schedule tick, so it is in
> an ms granularity in practice). After using hr timers to do the enforcement in
> the microseconds granularity, I was trying to let just fewer us for the non-rt.
> But as the IRQ runtime was higher than these fewer us, the rt_rq was never
> throttled. It is the same/similar behavior we see here.
> 
> As we think in the rt throttling as "avoiding rt workload to consume more than
> rt_runtime/rt_period", and considering that IRQs are a level of task with a
> fixed priority higher than all the real-time related schedulers, i.e., deadline
> and rt, we can safely argue that we can consider the IRQ time into the pool of
> rt workload and account it in the rt_runtime. The easiest way to do it is to use
> the rq_clock() in the measurement. I agree.
> 
> The point is that the CBS has a dual goal: it avoids a task running for more
> than its runtime (a throttling behavior), but it also is used as a guarantee of
> runtime for the case in which the task behaves, and the system is not
> overloaded. Considering we can have more load than we can schedule in a
> multiprocessor - but that is another story.
> 
> The the obvious reasoning here is: Ok boy, but the system IS overloaded in this
> case, we have a RCU stall! And that is true if you look at the processor
> starving RCU. But if the system has mode than one CPU, it could have CPU time
> available in another CPU. So, we could just move the dl task from one CPU to
> another.

Mmm, only that in this particular case I believe IRQ load will move
together with the migrating task and problem won't really be solved. :-/

> Btw, that is another point. We have the AC with the sum of the utilization of
> all CPUs. But we do no enforcement for per-cpu utilization. If one set a single
> thread with runtime=deadline=period  (in a system with more than one CPU), and
> run in a busy-loop, we will eventually have an RCU stall as well (I just did on
> my box, I got a soft lockup). I know this is a different problem. But, maybe,
> there is a general solution for both issues:

This is true. However, the single 100% bandwidth task problem can be
solved by limiting the maximum bandwidth a single entity can ask for. Of
course we can get again to a similar sort of problem if multiple
entities are then co-scheduled on the same CPU, for which we would need
(residual) capacity awareness. This should happen less likely though, as
there is a general tendency to spread tasks.

> For instance, if the sum of the execution time of all "task" with priority
> higher than the OTHER class (rt, dl, stop_machine, IRQs, NMIs, Hypervisor?) in a
> CPU is higher than rt_runtime in the rt_period, we need to avoid what is
> "avoidable" by trying to move rt and dl threads away from that CPU. Another
> possibility is to bump the priority of the OTHER class (and we are back to the
> DL server).

Kind of weird though having to migrate RT (everything higher than OTHER)
only to make some room for non-RT stuff. Also because one can introduce
unwanted side effects on high prio workloads (cache related overheads,
etc.). OTHER has also already have some knowledge about higher prio
activities (rt,dl,irq PELT). So this seems to really leave us with
affined tasks, of all priorities and kinds (real vs. irq).

> 
> - Dude, would not be easy just changing the CBS?
> 
> Yeah, but by changing the CBS, we may end up breaking the algorithms/properties
> that rely on CBS... like GRUB, user-space/kernel-space synchronization...
> 
> > OTOH, when something like you describe happens, guarantees are probably
> > already out of the window and we should just do our best to at least
> > keep the system "working"? (maybe only to warn the user that something
> > bad has happened)
> 
> Btw, don't get me wrong, I am not against changing CBS: I am just trying to
> raise other viewpoints to avoid touching in the base of the DL scheduler, and
> avoid punishing a thread that behaves well.
> 
> Anyway, notifying that dl+rt+IRQ time is higher than the rt_runtime is another
> good thing to do as well. We will be notified anyway, either by RCU or
> softlockup... but they are side effects warning. By notifying that we have an
> overload of rt or higher workload we will be pointing to the cause.

Right. It doesn't solve the problem, but I guess it could help debugging.
