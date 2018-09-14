Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7AAC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20E920866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20E920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeINNAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:00:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33039 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeINNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:00:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id i10-v6so3718986oth.0;
        Fri, 14 Sep 2018 00:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrKyp6qZRzwBDgDKF/oz/lNGiw1P+ewjt4SNqsBGbQA=;
        b=QmmAAJRDx4qw1K+Jo9hmbT5kaYiGi9pZXFye+uxdGOmvuCFHYyz2ZbX9p7zHACo4Vm
         WfxH/W84CdPGxgV78yHhj/q2cBS5F6NwwkNa9L9Kr3DAQgNksGlr/DoAuVsmWmTvKELY
         ZA6Kt96VJnSbua+BMqtkEVgxIahAo2rUzcDQmvigb4+hkheRYQkO7CxHHpMhxIJ2a2jV
         OXW3hRt9Z2UHawMmwPGHIHPJbyFxhV5tdW8NlwHjvuMSIO3cMI6Zi0JtRQ3Gqzdl5AW0
         D5aRmyJJS1wQVcT4NpETR5WrQhMWjmrB/rtNihMY9YPnl86i+9zQ9p/gZpXVDNHrNHS6
         HNAg==
X-Gm-Message-State: APzg51Ac6q5eQr/SaU0mYqzCQLhME5BWdoSCqgs3bRkKAgdJrjuukPLe
        eqNXEf8ToPhvZqTppr6GBE1nYVS10jtfEWD7xDEKJQ==
X-Google-Smtp-Source: ANB0VdaKNdJ0G2TZfEKbezhCVfULdzNJy0rVX3pMcGw96wumTd14zpmCjvc50swOIEVLZCkOfg/2afxstAELZyV2D8M=
X-Received: by 2002:a9d:19e8:: with SMTP id k95-v6mr3848225otk.248.1536911259768;
 Fri, 14 Sep 2018 00:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <9611469.2z7W9akjOQ@aspire.rjw.lan> <20180914074052.GF24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180914074052.GF24124@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Sep 2018 09:47:28 +0200
Message-ID: <CAJZ5v0hnchptNz8sHxtuTDbE-f3axgfMgKMgRiasoUv2G7Z0+Q@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 14, 2018 at 08:59:03AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is a difference in behavior between suspend-to-idle and
> > suspend-to-RAM in the timekeeping handling that leads to functional
> > issues.  Namely, every iteration of the loop in s2idle_loop()
> > increases the monotinic clock somewhat, even if timekeeping_suspend()
> > and timekeeping_resume() are invoked from s2idle_enter(), and if
> > many of them are carried out in a row, the monotonic clock can grow
> > significantly while the system is regarded as suspended, which
> > doesn't happen during suspend-to-RAM and so it is unexpected and
> > leads to confusion and misbehavior in user space (similar to what
> > ensued when we tried to combine the boottime and monotonic clocks).
> >
> > To avoid that, count all iterations of the loop in s2idle_loop()
> > as "sleep time" and adjust the clock for that on exit from
> > suspend-to-idle.
> >
> > [That also covers systems on which timekeeping is not suspended
> >  by by s2idle_enter().]
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Do we want a 'warning' of sorts when the delta becomes significant (for
> whatever that is) ? That might be an indication that there are frequent
> wakeups which we might not be expecting. Of keep the number of spurious
> wakeups in a stat counter somewhere -- something to look at if the
> battery drains faster than expected.

If you echo 1 to /sys/power/pm_debug_messages, dmesg will tell you
that (with gory details). :-)

> Otherwise:
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> One minor nit below:
>
> > ---
> >  kernel/power/suspend.c |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > Index: linux-pm/kernel/power/suspend.c
> > ===================================================================
> > --- linux-pm.orig/kernel/power/suspend.c
> > +++ linux-pm/kernel/power/suspend.c
> > @@ -109,8 +109,12 @@ static void s2idle_enter(void)
> >
> >  static void s2idle_loop(void)
> >  {
> > +     ktime_t start, delta;
> > +
> >       pm_pr_dbg("suspend-to-idle\n");
> >
> > +     start = ktime_get();
> > +
> >       for (;;) {
> >               int error;
> >
> > @@ -150,6 +154,20 @@ static void s2idle_loop(void)
> >               pm_wakeup_clear(false);
> >       }
> >
> > +     /*
> > +      * If the monotonic clock difference between the start of the loop and
> > +      * this point is too large, user space may get confused about whether or
> > +      * not the system has been suspended and tasks may get killed by
> > +      * watchdogs etc., so count the loop as "sleep time" to compensate for
> > +      * that.
> > +      */
> > +     delta = ktime_sub(ktime_get(), start);
> > +     if (ktime_to_ns(delta) > 0) {
> > +             struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
> > +
> > +             timekeeping_inject_sleeptime64(&timespec64_delta);
> > +     }
> > +
> >       pm_pr_dbg("resume from suspend-to-idle\n");
> >  }
>
> Like I mentioned yesterday; I myself prefer the form:
>
>
>         u64 stamp = ktimer_get_ns();
>
>         for (;;) {
>                 /* ... */
>         }
>
>         stamp = ktime_get_ns() - stamp;
>         if (stamp)
>                 timekeeping_inject_sleeptime64(ns_to_timespec64(ns));
>
>
> Esp. since ktime_t _is_ s64 these days, there is no point in keep using
> all the weird ktime helpers that make the code harder to read.

Looks like a good idea, let me try that.
