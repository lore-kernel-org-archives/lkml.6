Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E092436D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZIQosbmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E092436D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeFVOMH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:12:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F+pgIOycYzIYBC6ZdclLSQhD4JDlNcOUI8EDPuRcFZg=; b=ZIQosbmopCq9m4jQA7OAoIP/k
        CDldm4A5gzJzGD26Cc6SxnQGLmr+F2EqA6YS4g+47/3ESNHQlL+79pyERAgOnhGJx5forlDHQnJ8l
        MxehXjih5ierkAHgNQBrJ4pca2vDGu9FXLCBY49pSoVuvGnd8rTtARoD6vfw4b7EjWxSkUWbLnmDV
        1pXoQjKTRcZobDb0vPqa+i/UXtTf8JPjDHS+yjCM7fkfIQmsQsKdRADkMr7LlHFZgyMCxaXdIYEbl
        mCmcW4BGSfUcaEQQIKI+tVYLzPegdyyOqJAb1SHslvxQoq6xHLf93tCB6dsBO6PogH2ohmJtkhLwg
        fn9IK539Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWMnB-0005r5-EZ; Fri, 22 Jun 2018 14:12:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4AF02029F1D9; Fri, 22 Jun 2018 16:11:59 +0200 (CEST)
Date:   Fri, 22 Jun 2018 16:11:59 +0200
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
Message-ID: <20180622141159.GN2494@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
 <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
 <20180622132624.GL2494@hirez.programming.kicks-ass.net>
 <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:54:24PM +0200, Vincent Guittot wrote:
> On Fri, 22 Jun 2018 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:

> > $ bc -l
> > define f (u,r,n) { return u + ((u/(1-r)) - u) * (u/(1-r))^n; }
> > f(.2,.7,0)
> > .66666666666666666666
> > f(.2,.7,2)
> > .40740740740740740739
> > f(.2,.7,4)
> > .29218106995884773661
> >
> > So at 10% idle time, we've only inflated what should be 20% to 40%, that
> > is entirely reasonable I think. The linear case gave us 66%.  But feel
> > free to increase @n if you feel that helps, 4 is only one mult more than
> > 2 and gets us down to 29%.
> 
> I'm a bit lost with your example.
> u = 0.2 (for cfs) and r=0.7 (let say for rt) in your example and idle is 0.1
> 
> For rt task, we run 0.7 of the time at f=1 then we will select f=0.4
> for run cfs task with u=0.2 but u is the utilization at f=1 which
> means that it will take 250% of normal time to execute at f=0.4 which
> means 0.5  time instead of 0.2 at f=1 so we are going out of time. In
> order to have enough time to run r and u we must run at least  f=0.666
> for cfs = 0.2/(1-0.7). 

Argh.. that is n=0. So clearly I went off the rails somewhere.

