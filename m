Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423E8C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0612243F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q63WcyxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0612243F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeFVOsx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:48:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeFVOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UWaNFfzOD2nkSKqyik0RLJt8nhRlUwcEbHVOAv6qUMY=; b=q63WcyxA1OM5FfmBabY3WYX9p
        PenBf8jDXlOhMWtrpAJVzb44fa5VuK7gH7n7OWCU8H9HxTdv9DN8HucxBzASoGwHDqZK0u9C4A+DA
        t9Se8NuuLS3LVEzZZfkM08RaBrNf0mMsbh+Rr76IPBzxJNHhmDylYEBBaFBF24s/JBKCio7WJAcBQ
        XYMYIW9lE73L4dB0HYwCdINyH//Jsh+39T7HtjB8SV9zCFfdeGvdVrCJ94oyjnWNQSQU1ti1caxkG
        TJ26khXqEt81JBwp/IYoeuSOntOL0+WHI1VqdonFZ+dRWDWBp9/R0E/HInCeWZf6Rnojz4RQM4BTh
        FtxJxwJUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWNMg-0000pE-SP; Fri, 22 Jun 2018 14:48:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 769742029FA0E; Fri, 22 Jun 2018 16:48:40 +0200 (CEST)
Date:   Fri, 22 Jun 2018 16:48:40 +0200
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
Message-ID: <20180622144840.GE2512@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
 <CAKfTPtC5HLD=3W-w0XgwMrzhLfgE8onE4RmGTXyCWx6F=-uVhw@mail.gmail.com>
 <20180622132624.GL2494@hirez.programming.kicks-ass.net>
 <CAKfTPtA+QwUL5c0kqacEYtqONem6_PedMcmq0PAb0RQbi_bRjQ@mail.gmail.com>
 <20180622141159.GN2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622141159.GN2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:11:59PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 22, 2018 at 03:54:24PM +0200, Vincent Guittot wrote:
> > On Fri, 22 Jun 2018 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > define f (u,r,n) { return u + ((u/(1-r)) - u) * (u/(1-r))^n; }

> > I'm a bit lost with your example.
> > u = 0.2 (for cfs) and r=0.7 (let say for rt) in your example and idle is 0.1
> > 
> > For rt task, we run 0.7 of the time at f=1 then we will select f=0.4
> > for run cfs task with u=0.2 but u is the utilization at f=1 which
> > means that it will take 250% of normal time to execute at f=0.4 which
> > means 0.5  time instead of 0.2 at f=1 so we are going out of time. In
> > order to have enough time to run r and u we must run at least  f=0.666
> > for cfs = 0.2/(1-0.7). 
> 
> Argh.. that is n=0. So clearly I went off the rails somewhere.

Aah, I think the number I've been computing is a 'corrected' u. Not an
f. It made sure that 0 idle got u=1, but no more.

