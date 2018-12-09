Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B99C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C759020855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544392158;
	bh=1ciSh5z+7rdXn4fA+iU1Q2BmJuW1SZwytZluMLXjSWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ht0WsB9re3cPNtOkougunP+v3wACZsbyp3ZDMQWAFGTQEuG2a7RnimTTnmP00jHyU
	 pCVsRJUydyrOClLW0VQw92wyf6isaDEof4iiqcR0eR1FJ0RJia8p1lIE3KQBj72QfU
	 cul64Cf7ggNv5kJIyibmRIwmF5DFT/CRgaffvJbg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C759020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeLIVtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:49:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39722 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:49:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so8633813otl.6;
        Sun, 09 Dec 2018 13:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxc1SH8d2bzeeZeVs1nLkE3aDJ6fkBALoEeEOAbX9RI=;
        b=CXl2gG6qqRAdEIzpjLI5qg3R4WONWSXAe5LSm/M23Udrtm9bw2AfygxbICMTP4XIv/
         tquysNo3NuqAPuXqvrWe5UXr85x5y4mZbzCWlzZtO0h+JTZMFtVe/2pp3yRz3RpAxOBa
         wyTLbGIpA8jsvXrLPVMQ2kQvjE4LSRN+5zU3ucSsxQeG0R3s/IUxLILJHmwOUo7pZrFl
         diNL/aaDmmRKSW8B3EGp2QvhpHmoatRKGzEdXlYM/kCgawKxi5jtdQGBa2RPFd5UoqXo
         jcsQvZioS5sqRpEiI1YVVRK0CkZ19EDj3P8Fi+DYc0KU1+hE9fxRPX6zj9p+zki/sPan
         hKqg==
X-Gm-Message-State: AA+aEWb2Rg7Huz3RKYtaNRDjG2nNBbcgPxDxDnF0+DrauYbxw0kuZUkD
        hJ/cjCwOTvgTTKhGLeBe6mpw3lUY33pc99/Xh0M=
X-Google-Smtp-Source: AFSGD/Wibporwm63DMyn8vom1wXOjbwEOoG55o8Ex9LqiZI4wKywwO8lPQW3ypUT6ruPmBvr8rwoNj3YXDF5aVJz1xQ=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr6757360otn.200.1544392154931;
 Sun, 09 Dec 2018 13:49:14 -0800 (PST)
MIME-Version: 1.0
References: <1688146.Dmze7u1T7F@aspire.rjw.lan> <20181207125700.GA20256@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181207125700.GA20256@e107981-ln.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 9 Dec 2018 22:49:03 +0100
Message-ID: <CAJZ5v0h5-BOzPmBAMUChTxb74XO9VxQdv1RL0yj2d3VYvd1yOA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Add 'above' and 'below' idle state metrics
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 1:57 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 07, 2018 at 12:57:00PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpuidle: Add 'above' and 'below' idle state metrics
> >
> > Add two new metrics for CPU idle states, "above" and "below", to count
> > the number of times the given state had been asked for (or entered
> > from the kernel's perspective), but the observed idle duration turned
> > out to be too short or too long for it (respectively).
> >
> > These mertics help to estimate the quality of the CPU idle governor
>
> s/mertics/metrics

Right, thanks!

> > in use.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is a replacement for https://patchwork.kernel.org/patch/10714995/ with
> > the metrics renamed and some documentation confusion cleaned up.  Thanks!
> >
> > ---
> >  Documentation/ABI/testing/sysfs-devices-system-cpu |    7 ++++
> >  Documentation/admin-guide/pm/cpuidle.rst           |   10 ++++++
> >  drivers/cpuidle/cpuidle.c                          |   31 ++++++++++++++++++++-
> >  drivers/cpuidle/sysfs.c                            |    6 ++++
> >  include/linux/cpuidle.h                            |    2 +
> >  5 files changed, 55 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/cpuidle/cpuidle.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> > +++ linux-pm/drivers/cpuidle/cpuidle.c
> > @@ -202,7 +202,6 @@ int cpuidle_enter_state(struct cpuidle_d
> >       struct cpuidle_state *target_state = &drv->states[index];
> >       bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
> >       ktime_t time_start, time_end;
> > -     s64 diff;
> >
> >       /*
> >        * Tell the time framework to switch to a broadcast timer because our
> > @@ -248,6 +247,9 @@ int cpuidle_enter_state(struct cpuidle_d
> >               local_irq_enable();
> >
> >       if (entered_state >= 0) {
> > +             s64 diff, delay = drv->states[entered_state].exit_latency;
>
> I am probably pointing out something that has been already debated,
> apologies if so.
>
> exit_latency is the *worst* case exit latency for idle states that involve
> multiple CPUs, we can't say for certain it is the latency that was
> actually experienced by the idle state exit.

Right.

> It can be microseconds (eg CPU resume) vs milliseconds (eg groups of
> cpus resume).
>
> I think the current approach (which may only understimate the "below" by
> substracting the worst case value) is reasonable but I pointed this out
> since I do not know how these stats will be used.

This is on purpose.

I want to count the cases when the selected state has been off for certain.

Thanks,
Rafael
