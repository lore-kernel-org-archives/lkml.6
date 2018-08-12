Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A697EC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BF22088E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BF22088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeHLNuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:50:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42529 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeHLNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:50:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id b16-v6so22767867oic.9;
        Sun, 12 Aug 2018 04:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QG+2jBa5t9hBMFZTStjhowZ6kdG76HrHZWcXH57hxGg=;
        b=okm+DVr2VEL+ZRWr6XBs+SRFom6VURswasXdFSdkwMlgdasIpfDavgqBHMcFIhUl2L
         34ejvjS/JVURCNGbx0QUcYNH4od10EWm9oRul9UO3PRewyZ5eXYmyFwxDKSrHPdeV5X0
         +T3yenpJyI6EZ6XUw5gfeJOo1yb0d1SSL0iyJp+/46MsQ8GySiJpF8U38l0RHMjpjgRV
         vEycCnZGq/MBlvqt5ZV0PnxbPpZNeEEokK+QXe4csAZTOjFXAzZgRlQQhLuxpd5tcFRI
         Rx8/zYX+EvrbZ5DifjOa30w0PnU3YMzrWYSIdKPbfZfLbPI6r8K90qhMeu+Nm2HCRO9M
         ltXg==
X-Gm-Message-State: AOUpUlH4NQMapqJKtRX04pyyezYQG1nwf28psvJvJdnfsBSI3b/Y1eMt
        IqvPAXWsexmfI5VxPqXcMxPJQPRjiq/3EHt++rMyOz39
X-Google-Smtp-Source: AA+uWPypDqMpfjgeUyIwjQR2h8riVXePCh04Wc+fU74MlEUH4p3UM9PsnOnxwKc6fFNpPmrEm3g1YfYcDfg3muFFhM4=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr13053934oib.120.1534072373243;
 Sun, 12 Aug 2018 04:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org> <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s> <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s> <20180810090327.GE11817@leoy-ThinkPad-X240s>
In-Reply-To: <20180810090327.GE11817@leoy-ThinkPad-X240s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 12 Aug 2018 13:12:41 +0200
Message-ID: <CAJZ5v0gM+PNnMH=Myn5yRLYg4SVV3JnF-htO_gueJp4odivT6w@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:03 AM <leo.yan@linaro.org> wrote:
>
> On Fri, Aug 10, 2018 at 04:49:06PM +0800, Leo Yan wrote:
> > On Fri, Aug 10, 2018 at 09:22:10AM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 10, 2018 at 9:13 AM,  <leo.yan@linaro.org> wrote:
> > > > On Thu, Aug 09, 2018 at 10:47:17PM +0200, Rafael J. Wysocki wrote:
> > > >> On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > [cut]
> > >
> > > >> And that will cause the tick to be stopped unnecessarily in certain
> > > >> situations, so why is this better?
> > > >
> > > > Let's see below two cases, the first one case we configure
> > > > TICK_USEC=1000 (1ms) and the second case we configure TICK_USEC=4000
> > > > (4ms).
> > > >
> > > > Let's assume we do the testing one the same platform and have two runs,
> > > > in the Case 1 we configure HZ=1000 so TICK_USEC=1ms, expected_interval
> > > > is 3ms and deepest idle state target residency is 2ms, finally the idle
> > > > governor will choose the deepest state and skip to calibrate to shallow
> > > > state caused by 'expected_interval' > TICK_USEC;
> > > >
> > > > In the Case 2 we configure HZ=250 so TICK_USE=4ms, expected_interval
> > > > (3ms) and deepest idle state target residency (2ms) are same with the
> > > > Case 1; but because expected_interval < TICK_USEC so the idle governor
> > > > will do calibration to select a shallower state.  If we image on one
> > > > platform, the deepest idle state's target residency is smaller value,
> > > > then it has bigger gap with TICK_USEC, the deepest idle state is harder
> > > > to be selected due 'expected_interval' can be easily hit the range
> > > > [Deepest target residency..TICK_USEC).
> > > >
> > > > This patch has no any change for Case 1 and it wants to optimize for
> > > > Case 2 so Case 2 has chance to stay in deepest idle state.  I
> > > > understand from the performance pespective, we need to avoid to stop
> > > > tick for shallow states; on the other hand we cannot prevent CPU run
> > > > into deepest idle state just only we want to keep the tick running,
> > > > especially the expected interval is longer than the deepest state
> > > > target residency.
> > > >
> > > > Case 1:
> > > >       Deepest idle state's target residency=2ms
> > > >                      |
> > > >                      V
> > > > |--------------------------------------------------------> time (ms)
> > > >       ^                              ^
> > > >       |                              |
> > > > TICK_USEC=1ms           expected_interval=3ms
> > > >
> > > >
> > > > Case 2:
> > > >       Deepest idle state's target residency = 2ms
> > > >                      |
> > > >                      V
> > > > |--------------------------------------------------------> time (ms)
> > > >                                      ^                  ^
> > > >                                      |                  |
> > > >                           expected_interval = 3ms   TICK_USEC = 4ms
> > > >
> > > >
> > > >
> > > >> >                 unsigned int delta_next_us = ktime_to_us(delta_next);
> > > >> >
> > > >> >                 *stop_tick = false;
> > > >> > --
> > >
> > > Well, I don't quite agree with the approach here, then.
> > >
> > > As I said in the previous reply, IMO restarting the stopped tick
> > > before leaving the loop in do_idle() is pointless overhead.  It is not
> > > necessary to do that to avoid leaving CPUs in shallow idle states for
> > > too long (I'll send an alternative patch to fix this issue shortly).
> > >
> > > While you may think that pointless overhead is not a problem, I don't
> > > quite agree with that.
> >
> > I disagree this patch will introduce any extra overhead.
> >
> > Firstly, the idle loop doesn't support restarting tick even this patch
> > tells idle loop to restart the tick;

I'm not talking about restarting the tick, but about stopping it more
often on average.

> > secondly this patch is mainly to
> > resolve issue for the CPU cannot stay in deepest state in Case 2,

I understand what you are trying to achieve here, but I don't agree with it.

The condition modified by this patch is not about how much time the
CPU can potentially be idle, but about when it is expected to wake up.
The "expected" part is really key here.

The governor has gone through the effort of making an idle duration
prediction and it now it has a certain expectation regarding when the
CPU will wake up.  If the governor's prediction is any good at all and
this expectation is in the tick range, the CPU will be woken up by
something close enough to the tick in the majority of cases, so there
is no need to stop the tick.  Not because the CPU cannot be idle
longer, but because it is expected to wake up early enough anyway (and
yes, you can argue that 2 times the tick range may still be "early
enough" and so on, but then I'd like to see numbers in support of
that).

Now, if the governor is junk and its predictions are useless, the
above will not be the case any more, but then I'm not sure what the
benefit from using that governor at all is. :-)

> > as a side effect it also can tell idle loop to restart the tick for case 3
> > in below, actually IMHO this makes sense to tell the idle loop to
> > enable the tick but idle loop can ignore this info.
> >
> > Furthermore, we have another thread for the patch to always stop
> > tick after the the tick has been stopped in the idle loop.
> >
> > So this patch is still valid.
>
> Correct for Case 3 as below, actually this case will disappear if we
> force to set expected_interval=ktime_to_us(delta_next) in another
> proposaled patch.  If so, this patch will have no any chance to
> introduce extra ticks.

Yes, it will or at least it may.

Assuming shot noise wakeups, if
drv->states[drv->state_count-1].target_residency is less than
TICK_USEC, the tick will be stopped for CPUs more often on average
with the patch applied (simply because the idle duration range for
which it will not be stopped is narrower then).
