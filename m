Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CEDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A91823E84
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A91823E84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeFVH66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:58:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59314 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeFVH65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:58:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CE71435;
        Fri, 22 Jun 2018 00:58:57 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC0663F557;
        Fri, 22 Jun 2018 00:58:54 -0700 (PDT)
Date:   Fri, 22 Jun 2018 08:58:53 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621184524.GB27616@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thursday 21 Jun 2018 at 20:45:24 (+0200), Peter Zijlstra wrote:
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
> 
> I now see an email from Quentin asking if these things are not in fact
> the same, but no, they are not. The difference is that the above only
> affects the CFS signal and will re-normalize the utilization of an
> 'always' running task back to 1 by compensating for the stolen capacity.
> 
> But it will not, like these here patches, affect the OPP selection of
> other classes. If there is no CFS utilization (or very little), then the
> renormalization will not matter, and the existing DL bandwidth
> compuation will be unaffected.

Right, thinking more carefully about this re-scaling, the two things are
indeed not the same, but I'm still not sure if this is what we want.

Say we have 50% of the capacity stolen by RT, and a 25% CFS task
running. If we re-scale, we'll end up with a 50% request for CFS
(util==512 for your code above). But if we want to see a little bit
of idle time in the system, we should really request an OPP for 75%+ of
capacity no ? Or am I missing something ?

And also, I think Juri had concerns when we use the util_dl (as a PELT
signal) for OPP selection since that kills the benefit of DL for long
running DL tasks. Or can we assume that DL tasks with very long
runtime/periods are a corner case we can ignore ?

Thanks,
Quentin
