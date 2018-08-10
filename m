Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B62C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ABB208BA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mb7esq4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ABB208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeHJJmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:42:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39660 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:42:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so7333914wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZK5meauMLplnNqpi9RLokd/RrZNV6UDoClA+ltSwqpM=;
        b=Mb7esq4C5zB9S+KyfF+fEe0E5bjB1ZiZO9yvXW++kfVmW1hi8fSJxS/UW1rO40R3X0
         HFfsG4z16YO1tlBEZIXHFH/prmUpvLv7bu2Tr23gweXh5lZQnYixRFLWB9jMOftwVCxn
         VJUcomkmjHKiyupLw4mEKYIl/bPje+VbbFWyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZK5meauMLplnNqpi9RLokd/RrZNV6UDoClA+ltSwqpM=;
        b=jeOD+BVrHO8IQdKmotMI2sC3d9W+IA8QvmBqbqZv0ixQvpz2ZkZA9NGROD78zWzUWm
         5PW+SS8ln8u40z0HOAc5oBJDm7Gqd6rEptFrz3fL0Zin3M80UrYci2QXK5wa6Q/a6x37
         asUWniCdmqDlAwkN99OfBnpfpTKjGb/C6yIk6j5lDfbpuUo6ShHgwNOo18O6Sr5eTn5E
         yfWoM1juXXXks9+ouDiRbYPGXIztozgyHOqpjhhkefsk3G0rrQUJtao9i2PnJtsFeHwD
         hIF/VFjJUI28sm+nVUYHEVuLOF71RL3YqvqeBksRnegZDGW2RytVn7L+Il/T8OKfut8Y
         lDzw==
X-Gm-Message-State: AOUpUlGPAdIoiRpie1PkWelKsAqq3rWU0kZg0Z/H3ebBd2jOtTRMkY1g
        HSL1ez5UBAFA3/0LMLf+gzmsIA==
X-Google-Smtp-Source: AA+uWPwJ+SFvmivIk4NlPHA2fTybZqMyPHJz0o7XasX4gaVOPTt5gLCsFaLi8b7LBN7+pYYQPxzHag==
X-Received: by 2002:adf:bf10:: with SMTP id p16-v6mr3308386wrh.235.1533885210792;
        Fri, 10 Aug 2018 00:13:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id f132-v6sm981800wme.24.2018.08.10.00.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 00:13:29 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:13:21 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
Message-ID: <20180810071321.GC11817@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 10:47:17PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > The criteria for keeping tick running is the prediction duration is less
> > than TICK_USEC,
> 
> Yes, because if the predicted idle duration is less than the tick
> period, stopping the tick is pointless overhead (if the governor
> predicts a CPU wakeup within the tick period length range, it may as
> well let the tick run, because the CPU will be woken up relatively
> shortly anyway).
> 
> > the mainline kernel configures HZ=250 so TICK_USEC equals
> 
> To be precise, other values of HZ may be used too, depending on how
> the kernel is configured.
> 
> > to 4000us, so any prediction is less than 4000us will not stop tick and
> > the idle state will be fixed up to one shallow state.  On the other hand,
> > let's use 96boards Hikey (CA53 octa-CPUs) as an example, the platform has
> > the deepest C-state is cluster off state which its 'target_residency' is
> > 2700us, if the 'menu' governor predicts the next idle duration is any
> > value fallen into the range [2700us, 4000us), then the 'menu' governor
> > will keep sched tick running and and roll back to a shallow CPU off state
> > rather than cluster off state.
> 
> Which is as expected.
> 
> > Finally we can see the CPU has much less
> > chance to run into deepest state when a task repeatedly running on it
> > with 5000us period and 40% duty cycle (so the task runs for 2000us and
> > then sleep for 3000us in every period).  In theory, we should permit the
> > CPU to stay in cluster off state due the CPU sleeping time 3000us is
> > over its 'target_residency' 2700us.
> 
> For every particular choice of the criteria you can find a particular
> case in which it will be suboptimal.

But this patch wants to resolve a common case rather than the
particular case on Arm board; this issue is possible to happen cross
different platforms.  I will demonstrate in below comments.

[...]

> > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> > index 30ab759..2ce4068 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -294,6 +294,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >         unsigned int expected_interval;
> >         unsigned long nr_iowaiters, cpu_load;
> >         ktime_t delta_next;
> > +       unsigned int stop_tick_point;
> >
> >         if (data->needs_update) {
> >                 menu_update(drv, dev);
> > @@ -406,11 +407,47 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >                 idx = 0; /* No states enabled. Must use 0. */
> >
> >         /*
> > +        * Decide the time point for tick stopping, if the prediction is before
> > +        * this time point it's better to keep the tick enabled and after the
> > +        * time point it means the CPU can stay in idle state for enough long
> > +        * time so should stop the tick.  This point needs to consider two
> > +        * factors: the first one is tick period and the another factor is the
> > +        * maximum target residency.
> > +        *
> > +        * We can divide into below cases:
> > +        *
> > +        * The first case is the prediction is shorter than the maximum target
> > +        * residency and also shorter than tick period, this means the
> > +        * prediction isn't to use deepest idle state and it's suppose the CPU
> > +        * will be waken up within tick period, for this case we should keep
> > +        * the tick to be enabled;
> > +        *
> > +        * The second case is the prediction is shorter than the maximum target
> > +        * residency and longer than tick period, for this case the idle state
> > +        * selection has already based on the prediction for shallow state and
> > +        * we will expect some events can arrive later than tick to wake up the
> > +        * CPU; another thinking for this case is the CPU is likely to stay in
> > +        * the expected idle state for long while (which should be longer than
> > +        * tick period), so it's reasonable to stop the tick.
> > +        *
> > +        * The third case is the prediction is longer than the maximum target
> > +        * residency, but weather it's longer or shorter than tick period; for
> > +        * this case we have selected the deepest idle state so it's pointless
> > +        * to enable tick to wake up CPU from deepest state.
> > +        *
> > +        * To summary upper cases, we use the value of min(TICK_USEC,
> > +        * maximum_target_residency) as the critical point to decide if need to
> > +        * stop tick.
> > +        */
> > +       stop_tick_point = min_t(unsigned int, TICK_USEC,
> > +                       drv->states[drv->state_count-1].target_residency);
> > +
> > +       /*
> >          * Don't stop the tick if the selected state is a polling one or if the
> > -        * expected idle duration is shorter than the tick period length.
> > +        * expected idle duration is shorter than the estimated stop tick point.
> >          */
> >         if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > -           expected_interval < TICK_USEC) {
> > +           expected_interval < stop_tick_point) {
> 
> And that will cause the tick to be stopped unnecessarily in certain
> situations, so why is this better?

Let's see below two cases, the first one case we configure
TICK_USEC=1000 (1ms) and the second case we configure TICK_USEC=4000
(4ms).

Let's assume we do the testing one the same platform and have two runs,
in the Case 1 we configure HZ=1000 so TICK_USEC=1ms, expected_interval
is 3ms and deepest idle state target residency is 2ms, finally the idle
governor will choose the deepest state and skip to calibrate to shallow
state caused by 'expected_interval' > TICK_USEC;

In the Case 2 we configure HZ=250 so TICK_USE=4ms, expected_interval
(3ms) and deepest idle state target residency (2ms) are same with the
Case 1; but because expected_interval < TICK_USEC so the idle governor
will do calibration to select a shallower state.  If we image on one
platform, the deepest idle state's target residency is smaller value,
then it has bigger gap with TICK_USEC, the deepest idle state is harder
to be selected due 'expected_interval' can be easily hit the range
[Deepest target residency..TICK_USEC).

This patch has no any change for Case 1 and it wants to optimize for
Case 2 so Case 2 has chance to stay in deepest idle state.  I
understand from the performance pespective, we need to avoid to stop
tick for shallow states; on the other hand we cannot prevent CPU run
into deepest idle state just only we want to keep the tick running,
especially the expected interval is longer than the deepest state
target residency.

Case 1:
      Deepest idle state's target residency=2ms
                     |
                     V
|--------------------------------------------------------> time (ms)
      ^                              ^
      |                              |
TICK_USEC=1ms           expected_interval=3ms


Case 2:
      Deepest idle state's target residency = 2ms
                     |
                     V
|--------------------------------------------------------> time (ms)
                                     ^                  ^
                                     |                  |
                          expected_interval = 3ms   TICK_USEC = 4ms



> >                 unsigned int delta_next_us = ktime_to_us(delta_next);
> >
> >                 *stop_tick = false;
> > --
