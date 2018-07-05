Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32725240E3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32725240E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753749AbeGERsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:48:20 -0400
Received: from foss.arm.com ([217.140.101.70]:54570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753442AbeGERsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:48:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD0D018A;
        Thu,  5 Jul 2018 10:48:18 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A65523F2EA;
        Thu,  5 Jul 2018 10:48:14 -0700 (PDT)
Date:   Thu, 5 Jul 2018 18:48:09 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 05/12] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180705174809.GA21903@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-6-quentin.perret@arm.com>
 <20180705172922.GQ2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705172922.GQ2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 Jul 2018 at 19:29:22 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:36PM +0100, Quentin Perret wrote:
> >  static void free_rootdomain(struct rcu_head *rcu)
> >  {
> >  	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
> > @@ -211,6 +224,9 @@ static void free_rootdomain(struct rcu_head *rcu)
> >  	free_cpumask_var(rd->rto_mask);
> >  	free_cpumask_var(rd->online);
> >  	free_cpumask_var(rd->span);
> > +#ifdef CONFIG_ENERGY_MODEL
> > +	free_fd(rd->fd);
> > +#endif
> 
> If you provide a stub function, you can reduce #ifdef.

I cannot just stub free_fd since the 'fd' member of the root_domain is
also defined only for CONFIG_ENERGY_MODEL=y.

But I can introduce a free_rd_fd(fd) function that will be stubbed if
you think that's better. Or make sure to have 'fd' attached to the
root_domain even for CONFIG_ENERGY_MODEL=n.

> 
> >  	kfree(rd);
> >  }
> >  
> > @@ -1635,6 +1651,104 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
> >  	return sd;
> >  }
> >  
> > +#ifdef CONFIG_ENERGY_MODEL
> 
>   < snip content >
> 
> > +#endif
> 
> And is there any reason this #ifdef cannot be merged with the one above?

Not really, it was just easier to keep build_freq_domains() close to
partition_sched_domains() while writing/reading the code but that is
a very weak argument, I agree. I'll move all of that to the ifdef above.

> That is, try and do a pass of #ifdef reduction on this file.

Ok I'll look into that.

Thanks,
Quentin
