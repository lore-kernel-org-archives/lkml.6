Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36089C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E189324159
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y367eCua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E189324159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeFVLlr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:41:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeFVLlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5MN0SZgppIDiwe/mlbWis94Yafr8/1ciCK+E11wzIig=; b=Y367eCuadrKBvA2ybeYrbDOTd
        mAyh8s4DMkeQaoqpyr7XASif+Jv/XRDba7jeK2rFrGukf2kvdtH6HKzfILnxZoEffMA2bYDdn+nD+
        aeGhD08TzMUzz5K6tJRnpqMlRRccdDPidrSviNXwuPgKAcQxMQmzOlpXPW80xYGInXk9I0wmIwKh/
        ElfF3RinH+afIfbPQdh9Bk5mNhbI3oFoiq1TA4iPeDqCRGEbpzVNXFe9vLDdNdA3pVuIql+DSnqso
        NYSF9y8z5Fn6Rgl1A9GRCG661sLzanSYfAz0ecTLqPeGqn1slJOfFQjAK8iohjr05JXiyaaqHd44S
        +V/MEWyOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWKRf-0006oB-DS; Fri, 22 Jun 2018 11:41:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34BBA2029FA0A; Fri, 22 Jun 2018 13:41:38 +0200 (CEST)
Date:   Fri, 22 Jun 2018 13:41:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
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
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622114138.GK2494@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180621185706.GA4900@worktop.programming.kicks-ass.net>
 <CAKfTPtA=iWQc3RB2dgJf2LT2e0XezLzGKbQNx=w1xYEPFDEsQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA=iWQc3RB2dgJf2LT2e0XezLzGKbQNx=w1xYEPFDEsQQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 10:10:32AM +0200, Vincent Guittot wrote:
> On Thu, 21 Jun 2018 at 20:57, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > So this (and the dl etc. equivalents) result in exactly the problems
> > > complained about last time, no?
> > >
> > > What I proposed was something along the lines of:
> > >
> > >       util = 1024 * sg_cpu->util_cfs;
> > >       util /= (1024 - (sg_cpu->util_rt + sg_cpu->util_dl + ...));
> > >
> > >       return min(sg_cpu->max, util + sg_cpu->bw_dl);
> 
> I see that you use sg_cpu->util_dl and sg_cpu->bw_dl in your equation
> above but this patch 04 only adds rt util_avg and the dl util_avg has
> not been added yet.
>  dl util_avg is added in patch 6
> So for this patch, we are only using sg_cpu->bw_dl

Yeah, not the point really.

It is about how we're going to use the (rt,dl,irq etc..) util values,
more than which particular one was introduced here.

I'm just not a big fan of the whole: freq := cfs_util + rt_util thing
(as would be obvious by now). 
