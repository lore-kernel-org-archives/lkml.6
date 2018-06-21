Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F798C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB0321A5C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DCRxsVU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0321A5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeFUS5U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:57:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeFUS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AnVC3KLNKApe38ml3rmsDOgF8AByKHygKBexbMQTpb0=; b=DCRxsVU9IuwwEwU2evAdiFeHR
        5rmjW/vOBdBeMtuASK96mSO9U4ovra2B83oA+Pbcx3MyDNj5mdszp56aFVm0UPsTQLLHGWfI/lBot
        kXSnEaeKKFmCOAHBTKdgMvvM5e2Q2e/Yh7OsJ4+4qyOLayIvlUnlwakNrr4NUC/6Jkmv5DLP6cZJz
        epZxs9ZHLbatIeeO25ybXJi0hphIapvspQvZj/sNKyI5ACO6PWmMD6mrka4EXe32xZD24iHDOMM+D
        tfihs5oerFvLMfFrbCe3nMzZBUSaMUtemCXopWKwqp2UM2x/VPJGhx6w/XAM0pmukhYom197bREwR
        CzIK+SNgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW4lY-0000sj-9c; Thu, 21 Jun 2018 18:57:08 +0000
Received: by worktop (Postfix, from userid 1000)
        id DA0E26E093A; Thu, 21 Jun 2018 20:57:06 +0200 (CEST)
Date:   Thu, 21 Jun 2018 20:57:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180621185706.GA4900@worktop.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621184524.GB27616@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:45:24PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 08, 2018 at 02:09:47PM +0200, Vincent Guittot wrote:
> >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +	unsigned long util;
> >  
> >  	if (rq->rt.rt_nr_running)
> >  		return sg_cpu->max;
> >  
> > +	util = sg_cpu->util_dl;
> > +	util += sg_cpu->util_cfs;
> > +	util += sg_cpu->util_rt;
> > +
> >  	/*
> >  	 * Utilization required by DEADLINE must always be granted while, for
> >  	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
> > @@ -197,7 +204,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> >  	 * ready for such an interface. So, we only do the latter for now.
> >  	 */
> > -	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> > +	return min(sg_cpu->max, util);
> >  }
> 
> So this (and the dl etc. equivalents) result in exactly the problems
> complained about last time, no?
> 
> What I proposed was something along the lines of:
> 
> 	util = 1024 * sg_cpu->util_cfs;
> 	util /= (1024 - (sg_cpu->util_rt + sg_cpu->util_dl + ...));
> 
> 	return min(sg_cpu->max, util + sg_cpu->bw_dl);
> 
> Where we, instead of directly adding the various util signals.

That looks unfinished; I think that wants to include: "we renormalize
the CFS signal".

> I now see an email from Quentin asking if these things are not in fact
> the same, but no, they are not. The difference is that the above only
> affects the CFS signal and will re-normalize the utilization of an
> 'always' running task back to 1 by compensating for the stolen capacity.
> 
> But it will not, like these here patches, affect the OPP selection of
> other classes. If there is no CFS utilization (or very little), then the
> renormalization will not matter, and the existing DL bandwidth
> compuation will be unaffected.
> 
