Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2082CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91222087E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SExJJbxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91222087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934430AbeFLP64 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:58:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53152 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933363AbeFLP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YZG4hNRXa1wRPlvCZTAJonMB9re/azLfZgiiOcOFB4E=; b=SExJJbxjrjCCgkuuGhZiJLaQH
        LCpQhn2PvrW3v1hZHyfPnJ4AALXRcMTRAcnDwy7jD7jB/y/3vKuhgphYAj2wZK2WljdCNxgqajZJf
        H1MNehou56m4aj4NUVdwVo8FXLZBz4MBh+kOumJlrVPCtZLQisC0mR7B9WyQX2yrTEYXj8tIRhJK5
        VZZpALkvTb22wFOJ9xr0QhnORXzooI5Bf2T6231Qlg2QPoRBKtvpRG39xINZ2puGoMpr4BTNmD+gq
        tcpTlf+KfaztlyyJk1V6giqqAaiIKUzGtPDxctJhb0916B0LL/6IaGNBZK3jZZmBjo16BfwpWFpKv
        nO+35ueHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSlgy-0004cg-Q5; Tue, 12 Jun 2018 15:58:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA58A201EA7A5; Tue, 12 Jun 2018 17:58:41 +0200 (CEST)
Date:   Tue, 12 Jun 2018 17:58:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180612155841.GT12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:37:17PM +0200, Daniel Lezcano wrote:
> On 12/06/2018 16:06, Peter Zijlstra wrote:
> > On Tue, Jun 12, 2018 at 03:02:14PM +0200, Daniel Lezcano wrote:
> >> On 12/06/2018 14:52, Peter Zijlstra wrote:
> >>> In this case, you can do:
> >>
> >> That is what we had before but we change the code to set the count
> >> before waking up the task, so compute the cpumask_weight of the
> >> resulting AND right before this loop.
> >>
> >>> +       for_each_cpu_and(cpu, &ii_dev->cpumask, cpu_online_mask) {
> >>> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
> >>> +               iit->should_run = 1;
> >>> +               wake_up_process(iit->tsk);
> >>> +       }
> > 
> > 
> > Ah, I see, but since you do:
> > 
> > 	if (atomic_dec_and_test())
> > 	  last_man()
> > 
> > where that last_man() thing will start a timer, there is no real problem
> > with doing atomic_inc() with before wake_up_process().
> 
> Viresh was worried about the scenario:
> 
> https://lkml.org/lkml/2018/6/5/276

Ah, but I think you have more races, for instance look at wakeup vs
park, what if wakeup sets should_run after you've just checked it?

Then you have an inc without a dec.

> > Also, last_man() uses @run_duration, but the way I read it, the timer is
> > for waking things up again, this means it is in fact the sleep duration,
> > no?
> 
> No, it is the next idle injection deadline, meanwhile we let the system
> continue running.
> 
> The sleep duration is managed by another timer in play_idle().

No, that's the idle duration. Maybe avoid the issue entire by having a
{period,idle} tuple, where your old run := period - idle.

> > Furthermore, should you not be using hrtimer_forward(&timer,
> > idle_duration + run_duration) instead? AFAICT the current scheme is
> > prone to drifting.
> 
> (I assume you meant setting the timer in the wakeup task function).
> 
> Yes, drifting is not an issue if that happens. This scheme is simpler
> and safer than setting the timer ahead before waking up the tasks with
> the risk it expires before all the tasks ended their idle cycles.

sloppy though..
