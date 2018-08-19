Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0EC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C6C20C0A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 07:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C6C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeHSLIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 07:08:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44529 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 07:08:11 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so20836952oih.11;
        Sun, 19 Aug 2018 00:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyY448l/O1sOJQvdZkMVlrpEC9JqXgG41Hm/u4AXybU=;
        b=cUkPKvOiDHdDIR/3kc3GoH3dVC+DyvAwLV4MjCoF2Sw8CoA35DEvif7m5ZdnLNmoaE
         AMKUjVI1blV/7RpdTkTeoHyLs8r9YOBc2mtgWwEw8r5luKBeYuYGXEZUH/xq6O8BoLqd
         ifttYe9boaHVKPyRJCXbnuccqde1Mi8A7VTYhegrYZAADgzLmxO2Hy5TNDZBqRcmsmt3
         qibAwLV+MyJ+eVCWaIdPA8YpJ/biNeu1efL8nF6OH76VP29zmcGK2TlI/uWtWTs0M1Eh
         MB2i1Tr0kvv68KoR3kIeDK+hMVtKQibx3pa+km3IuVI+zWDsWde2XuwHE14kXeZWFFv/
         NZBA==
X-Gm-Message-State: AOUpUlG6QITgUCyJTNer0Ug0I9uxIZ+vqL6cJLnwtiNQsOfHlkTIVyCE
        tX2NVbE3jcqwq9KHsc1PMLwoeHzmhSqEdafMjhQ=
X-Google-Smtp-Source: AA+uWPwq6TjKEGV0sQPki+3HIn6Y7Xn9Qb/KDS+5D6IGXtaE1QgCB/zXZn2DyGkLOefQJxD+ihEyPzWjYmItU4vC/Yc=
X-Received: by 2002:aca:190d:: with SMTP id l13-v6mr9340939oii.216.1534665453237;
 Sun, 19 Aug 2018 00:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <2161372.IsD4PDzmmY@aspire.rjw.lan> <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan> <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com> <20180819003632.GA11280@leoy-ThinkPad-X240s>
In-Reply-To: <20180819003632.GA11280@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 19 Aug 2018 09:57:21 +0200
Message-ID: <CAJZ5v0hTRkwE3SwOD3qW9qe0xFQ42yGXNnMpKYXMdiRh2FirsA@mail.gmail.com>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been stopped
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 2:36 AM <leo.yan@linaro.org> wrote:
>
> On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:
>
> [...]
>
> > > > > Otherwise we can have something like this:
> > > > >
> > > > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > > > index da9455a..408c985 100644
> > > > > --- a/kernel/time/tick-sched.c
> > > > > +++ b/kernel/time/tick-sched.c
> > > > > @@ -806,6 +806,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> > > > >  static void tick_nohz_retain_tick(struct tick_sched *ts)
> > > > >  {
> > > > >     ts->timer_expires_base = 0;
> > > > > +
> > > > > +   if (ts->tick_stopped)
> > > > > +           tick_nohz_restart(ts, ktime_get());
> > > > >  }
> > > > >
> > > > >  #ifdef CONFIG_NO_HZ_FULL
> > > > >
> > > >
> > > > We could do that, but my concern with that approach is that we may end up
> > > > stopping and starting the tick back and forth without exiting the loop
> > > > in do_idle() just because somebody uses a periodic timer behind our
> > > > back and the governor gets confused.
> > > >
> > > > Besides, that would be a change in behavior, while the $subject patch
> > > > simply fixes a mistake in the original design.
> > >
> > > Ok, let's take the safe approach for now as this is a fix and it should even be
> > > routed to stable.
> >
> > Right.  I'll queue up this patch, then.
> >
> > > But then in the longer term, perhaps cpuidle_select() should think that
> > > through.
> >
> > So I have given more consideration to this and my conclusion is that
> > restarting the tick between cpuidle_select() and call_cpuidle() is a
> > bad idea.
> >
> > First off, if need_resched() is "false", the primary reason for
> > running the tick on the given CPU is not there, so it only might be
> > useful as a "backup" timer to wake up the CPU from an inadequate idle
> > state.
> >
> > Now, in general, there are two reasons for the idle governor (whatever
> > it is) to select an idle state with a target residency below the tick
> > period length.  The first reason is when the governor knows that the
> > closest timer event is going to occur in this time frame, but in that
> > case (as stated above), it is not necessary to worry about the tick,
> > because the other timer will trigger soon enough anyway.  The second
> > reason is when the governor predicts a wakeup which is not by a timer
> > in this time frame and it is quite arguable what the governor should
> > do then.  IMO it at least is not unreasonable to throw the prediction
> > away and still go for the closest timer event in that case (which is
> > the current approach).
> >
> > There's more, though.  Restarting the tick between cpuidle_select()
> > and call_cpuidle() might introduce quite a bit of latency into that
> > point and that would mess up with the idle state selection (e.g.
> > selecting a very shallow idle state might not make a lot of sense if
> > that latency was high enough, because the expected wakeup might very
> > well take place when the tick was being restarted), so it should
> > rather be avoided IMO.
>
> I expect the idle governor doesn't introduce many restarting tick
> operations, the reason is if there have a close timer event than idle
> governor can trust it to wake up CPU so in this case the idle governor
> will not restart tick;  if the the timer event is long delta and the
> shallow state selection is caused by factors (e.g. typical pattern),
> then we need restart tick to avoid powernightmares, for this case we
> can restart tick only once at the beginning for the typical pattern
> interrupt events; after the typical pattern interrupt doesn't continue
> then we can rely on the tick to rescue the idle state to deep one.

No, we don't need to restart the tick at all.  We just need to require
the governor to disregard "typical patterns" (which are not
timer-induced, mind you) when it knows that the tick has been stopped
already.

Unfortunately, the menu governor cannot distinguish a timer-induced
"typical" pattern from one related to device interrupts, but I don't
really see a reason to worry about the latter when the CPU is idle and
with stopped tick (which means that the workload can tolerate extra
latency from deep idle states anyway).
