Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0BFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426EC242A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LiM0zkhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426EC242A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeFVN0i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:26:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFVN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5ar/Vx2yrQ8WlQEFQZKc05qbmR8uflTmIltrEwNYQVg=; b=LiM0zkhkw+KE22Ymt1Zgst0cM
        GRoXocdfFI6AQUi1AgSfo67t/bVyM45G9/2QC6i9V9QJQKy27LGFaqhaa1J8y87/QO5Essj+HW6at
        tZhTZHnOv96tZnrZ5dljURfgszprawditzzyqUA3EFIBbELja1QP6Dk/V+hYs52N4M+ststuk7SPd
        nhD/RUeaiNZ0pVSJ65MPDEN1tbOdELwIqBR1mCheQojlliU+UZ8GO+mIXuCabB2E8IM+VmQ8hbDRT
        hSvLVLDtW6uNyKOWZ5c1OaDSPQVbo2ARY6B9on5+ho8dkAD0WUJlppgcua6wEXZpHku/HHtsogqig
        H8mIupB9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWM54-0004nf-Hw; Fri, 22 Jun 2018 13:26:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 870982029FA0E; Fri, 22 Jun 2018 15:26:24 +0200 (CEST)
Date:   Fri, 22 Jun 2018 15:26:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622132624.GL2494@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
 <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:23:22PM +0200, Vincent Guittot wrote:
> On Fri, 22 Jun 2018 at 13:37, Peter Zijlstra <peterz@infradead.org> wrote:
> > I suppose we can make it more complicated, something like:
> >
> >              u           u
> >   f := u + (--- - u) * (---)^n
> >             1-r         1-r
> >
> > Where: u := cfs util
> >        r := \Sum !cfs util
> >        f := frequency request
> >
> > That would still satisfy all criteria I think:
> >
> >   r = 0      -> f := u
> >   u = (1-r)  -> f := 1
> >
> > and in particular:
> >
> >   u << (1-r) -> f ~= u
> >
> > which casuses less inflation than the linear thing where there is idle
> > time.

> And we are not yet at the right value for quentin's example as we need
> something around 0.75 for is example

$ bc -l
define f (u,r,n) { return u + ((u/(1-r)) - u) * (u/(1-r))^n; }
f(.2,.7,0)
.66666666666666666666
f(.2,.7,2)
.40740740740740740739
f(.2,.7,4)
.29218106995884773661

So at 10% idle time, we've only inflated what should be 20% to 40%, that
is entirely reasonable I think. The linear case gave us 66%.  But feel
free to increase @n if you feel that helps, 4 is only one mult more than
2 and gets us down to 29%.

> The non linearity only comes from dl so if we want to use the equation
> above, u should be (cfs + rt) and r = dl

Right until we allow RT to run at anything other than f=1. Once we allow
rt util capping, either through Patrick's thing or CBS servers or
whatever, we get:

  f = min(1, f_rt + f_dl + f_cfs)

And then u_rt does want to be part of r. And while we do run RT at f=1,
it doesn't matter either way around I think.

> But this also means that we will start to inflate the utilization to
> get higher OPP even if there is idle time and lost the interest of
> using dl bw

You get _some_ inflation, but only if there is actual cfs utilization to
begin with.

And that is my objection to that straight sum thing; there the dl util
distorts the computed dl bandwidth thing even if there is no cfs
utilization.

