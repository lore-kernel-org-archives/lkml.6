Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97ACC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B1D20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B1D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJXUbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:31:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56265 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeJXUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:31:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so3043597wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 05:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B8doBJD3/qjC/J7Sor+IGfoF6mcAkBs44PxfDbMFYSw=;
        b=lRtGk+qIxYjlgsRZ7533u49FPFKXigwRBaEiiE5voZhzqJnwndcO0yAuBJz7YWR/DI
         6w2DMDz7tZD5EfMFbt0xJcb8biVLEMrLTkqEdvURvyEpzK8ZGNIwE98oGKWh0+Lq0Ivl
         1CFPWa2wdle3Q7GP3R5HVJ9pq8eA2uccxAJpjtu/OV54fc/FbivypSXhfiCm6HSlheep
         XY08fzrCI+rDZ8JZ8jBulhGndNzJOgPMwpGmf1nZBez4/wEKWjueICtmuL4h++4IFZz9
         5L22OZA+5ii8dsK5qoyXlg7JDWDHqYvGuuPWgwu+ZAhm9mPuejVmZ9MB2nLHZQ3hdKBj
         Uy8A==
X-Gm-Message-State: AGRZ1gILtTb/s4Z2cbcKsQ+Z8NhbdKmhgPep+4186x+4VPdMrnDmmpd1
        mqyB0eTNuXRkUD55vme57X/Iyg==
X-Google-Smtp-Source: AJdET5dF15/y2Vwk0xD24qxhcIO+MSnznBVKh0nuwbxmft6mRSQevAuSjBpe8kPFBk0QTWTCVBd5hw==
X-Received: by 2002:a1c:b504:: with SMTP id e4-v6mr2318387wmf.134.1540382620821;
        Wed, 24 Oct 2018 05:03:40 -0700 (PDT)
Received: from localhost.localdomain (bo-18-130-187.service.infuturo.it. [151.18.130.187])
        by smtp.gmail.com with ESMTPSA id e21-v6sm7010624wma.8.2018.10.24.05.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 05:03:39 -0700 (PDT)
Date:   Wed, 24 Oct 2018 14:03:35 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181024120335.GE29272@localhost.localdomain>
References: <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019225005.61707c64@nowhere>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/18 22:50, luca abeni wrote:
> On Fri, 19 Oct 2018 13:39:42 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Oct 18, 2018 at 01:08:11PM +0200, luca abeni wrote:
> > > Ok, I see the issue now: the problem is that the "while
> > > (dl_se->runtime <= 0)" loop is executed at replenishment time, but
> > > the deadline should be postponed at enforcement time.
> > > 
> > > I mean: in update_curr_dl() we do:
> > > 	dl_se->runtime -= scaled_delta_exec;
> > > 	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > 		...
> > > 		enqueue replenishment timer at dl_next_period(dl_se)
> > > But dl_next_period() is based on a "wrong" deadline!
> > > 
> > > 
> > > I think that inserting a
> > >         while (dl_se->runtime <= -pi_se->dl_runtime) {
> > >                 dl_se->deadline += pi_se->dl_period;
> > >                 dl_se->runtime += pi_se->dl_runtime;
> > >         }
> > > immediately after "dl_se->runtime -= scaled_delta_exec;" would fix
> > > the problem, no?  
> > 
> > That certainly makes sense to me.
> 
> Good; I'll try to work on this idea in the weekend.

So, we (me and Luca) managed to spend some more time on this and found a
few more things worth sharing. I'll try to summarize what we have got so
far (including what already discussed) because impression is that each
point might deserve a fix or at least consideration (just amazing how a
simple random fuzzer thing can highlight all that :). Apologies for the
long email.

Reproducer runs on a CONFIG_HZ=100, CONFIG_IRQ_TIME_ACCOUNTING kernel
and does something like this (only the bits that seems to matter here)

int main(void)
{
  [...]
  [setup stuff at 0x2001d000]
  syscall(__NR_perf_event_open, 0x2001d000, 0, -1, -1, 0);
  *(uint32_t*)0x20000000 = 0;
  *(uint32_t*)0x20000004 = 6;
  *(uint64_t*)0x20000008 = 0;
  *(uint32_t*)0x20000010 = 0;
  *(uint32_t*)0x20000014 = 0;
  *(uint64_t*)0x20000018 = 0x9917; <-- ~40us
  *(uint64_t*)0x20000020 = 0xffff; <-- ~65us (~60% bandwidth)
  *(uint64_t*)0x20000028 = 0;
  syscall(__NR_sched_setattr, 0, 0x20000000, 0);
  [busy loop]
  return 0;
}

And this causes problems because the task is actually never throttled.

Pain points:

 1. Granularity of enforcement (at each tick) is huge compared with
    the task runtime. This makes starting the replenishment timer,
    when runtime is depleted, always to fail (because old deadline
    is way in the past). So, the task is fully replenished and put
    back to run.

    - Luca's proposal should help here, since the deadline is postponed
      at throttling time, and replenishment timer set to that (and it
      should be in the future)

 1.1 Even if we fix 1. in a configuration like this, the task would
     still be able to run for ~10ms (worst case) and potentially starve
     other tasks. It doesn't seem a too big interval maybe, but there
     might be other very short activities that might miss an occasion
     to run "quickly".

     - Might be fixed by imposing (via sysctl) reasonable defaults for
       minimum runtime (w.r.t. HZ, like HZ/2) and maximum for period
       (as also a very small bandwidth task can have a big runtime if
       period is big as well)

 (1.2) When runtime becomes very negative (because delta_exec was big)
       we seem to spend lot of time inside the replenishment loop.

       - Not sure it's such a big problem, might need more profiling.
         Feeling is that once the other points will be addressed this
	 won't matter anymore

 2. This is related to perf_event_open syscall reproducer does before
    becoming DEADLINE and entering the busy loop. Enabling of perf
    swevents generates lot of hrtimers load that happens in the
    reproducer task context. Now, DEADLINE uses rq_clock() for setting
    deadlines, but rq_clock_task() for doing runtime enforcement.
    In a situation like this it seems that the amount of irq pressure
    becomes pretty big (I'm seeing this on kvm, real hw should maybe do
    better, pain point remains I guess), so rq_clock() and
    rq_clock_task() might become more a more skewed w.r.t. each other.
    Since rq_clock() is only used when setting absolute deadlines for
    the first time (or when resetting them in certain cases), after a
    bit the replenishment code will start to see postponed deadlines
    always in the past w.r.t. rq_clock(). And this brings us back to the
    fact that the task is never stopped, since it can't keep up with
    rq_clock().

    - Not sure yet how we want to address this [1]. We could use
      rq_clock() everywhere, but tasks might be penalized by irq
      pressure (theoretically this would mandate that irqs are
      explicitly accounted for I guess). I tried to use the skew between
      the two clocks to "fix" deadlines, but that puts us at risks of
      de-synchronizing userspace and kernel views of deadlines.

 3. HRTICK is not started for new entities.
 
    - Already got a patch for it.

This should be it, I hope. Luca (thanks a lot for your help) and please
add or correct me if I was wrong.

Thoughts?

Best,

- Juri

1 - https://elixir.bootlin.com/linux/latest/source/kernel/sched/deadline.c#L1162
