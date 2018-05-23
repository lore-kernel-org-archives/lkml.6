Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932288AbeEWJz4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:55:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43623 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbeEWJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:55:53 -0400
X-Google-Smtp-Source: AB8JxZpLUOaqrS7Kkznt9g12HXLjr4HcowSeSC10eWDOVHa3I+Le7NMKWs9fbFrd3rjZUQe4ATBHcA==
Date: Wed, 23 May 2018 15:25:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [PATCH V3] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180523095549.mbit5plvqoppnasu@vireshk-i7>
References: <1526655056-24592-1-git-send-email-daniel.lezcano@linaro.org>
 <20180521103223.asejwsaf7pnrs777@vireshk-i7>
 <7ff0d7d4-be5e-2384-1201-df8616519892@linaro.org>
 <20180523054154.fvhnwgvq34ihivdj@vireshk-i7>
 <61c2b628-6c38-463a-c6b5-5e5b7eeee1ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c2b628-6c38-463a-c6b5-5e5b7eeee1ab@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 10:00, Daniel Lezcano wrote:
> On 23/05/2018 07:41, Viresh Kumar wrote:
> > Right and that's why I said "Which is fine" in my comment above. My
> > question was more on why we error out in idle_injection_start() if
> > run_duration_ms is 0.
> > 
> > Just for my understanding, is it a valid usecase where we want to run
> > the idle loop only once ? i.e. set idle_duration_ms to a non-zero
> > value but run_duration_ms to 0 ? In that case we shouldn't check for
> > zero run_duration_ms in idle_injection_start().
> 
> Yes, that could be a valid use case if we want to synchronously inject
> idle cycles without period.
> 
> IOW, call play_idle() on a set of cpus at the same time. And the caller
> of start is the one with the control of the period.
> 
> If you want this usecase, we need to implement more things:

Well I was trying to understand the use case you have in mind. Nothing
else. So this stuff isn't required anymore.

> >>>> +void idle_injection_set_duration(struct idle_injection_device *ii_dev,
> >>>> +				 unsigned int run_duration_ms,
> >>>> +				 unsigned int idle_duration_ms)
> >>>> +{
> >>>> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
> >>>> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
> >>>
> >>> You check for valid values of these in idle_injection_start() but not
> >>> here, why ?
> >>
> >> By checking against a zero values in the start function is a way to make
> >> sure we are not starting the idle injection with uninitialized values
> >> and by setting the duration to zero is a way to stop the idle injection.
> > 
> > Why do we need two ways of stopping the idle injection thread ? Why
> > isn't just calling idle_injection_stop() the right thing to do in that
> > case ?
> 
> How do we prevent the last kthread in the idle_injection_fn to set the
> timer ?

Okay, I get the problem now. But this doesn't stop the kthread in a
guaranteed way and we probably need a different solution. More later..

> >>>> +void idle_injection_stop(struct idle_injection_device *ii_dev)
> >>>> +{
> >>>> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
> >>>> +		 cpumask_pr_args(ii_dev->cpumask));
> >>>> +
> >>>> +	hrtimer_cancel(&ii_dev->timer);
> >>>
> >>> How are we sure that idle_injection_fn() isn't running at this point
> >>> and it would start the timer cancelled here again ?
> >>
> >> Nothing will ensure that. We will have an extra idle injection in this
> >> case. We can invert the set_duration(0,0) and the timer cancellation to
> >> reduce to reduce the window.
> > 
> > That's what I thought and so its racy. If someone calls
> > idle_injection_unregister(), then we call this routine and then free
> > the data structures while they are still getting used by the thread :(
> 
> Yes, we need to make the framework single-user, a refcount should be
> enough. However, register() returns a pointer and the caller of
> unregister must have this pointer. If it is the case, then register and
> unregister code collaborate, if the one calling unregister cuts the
> branch of the user of the idle_injection then we have braindead code.
> 
> We can handle this case by adding locks or we can have a single-user of
> the framework without lock. We don't expect a lot of idle injection
> users (I see only two right now and they are mutually exclusive), so
> having lockless code is ok for me.

Maybe I wasn't able to explain the problem I see, but lemme retry
that. Assume that there is only one use and that id cpu-idle-cooling.
We are currently running the idle loop with idle duration X and run
duration Y.

Now lets say the cooling device gets unregistered itself (maybe module
removal, etc). And it calls idle_injection_unregister() with a valid
pointer. Not sure if the thermal framework will call set_cur_state
anymore. But the problem will remain even if it does that.

We call idle_injection_stop() from unregister, which will cancel
hrtimer, set durations as 0 and return. Then we free the iidev. It is
certainly possible at this point of time that the kthread is still
running the idle loop which it may have started before unregister was
called. And so after the idle loop is finished it will try to access
ii_dev, which is already freed.

So, idle_injection_stop() needs to guarantee that the kthread and the
hrtimer are all stopped now and no one is using the ii_dev structure
anymore.

Perhaps you need some completion stuff here to give confirmation here,
etc.

-- 
viresh
