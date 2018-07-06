Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1701C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34EA20779
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34EA20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeGFREv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:04:51 -0400
Received: from foss.arm.com ([217.140.101.70]:40366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932746AbeGFREu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:04:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D93F718A;
        Fri,  6 Jul 2018 10:04:49 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E58563F2EA;
        Fri,  6 Jul 2018 10:04:45 -0700 (PDT)
Date:   Fri, 6 Jul 2018 18:04:44 +0100
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
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706154949.GO2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 Jul 2018 at 17:49:49 (+0200), Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 04:12:12PM +0100, Quentin Perret wrote:
> > On Friday 06 Jul 2018 at 15:12:43 (+0200), Peter Zijlstra wrote:
> 
> > > Did you want to use sugov_get_util() here? There is no way we're going
> > > to duplicate all that.
> > 
> > I need to look into how we can do that ... Sugov looks at the current
> > util landscape while EAS tries to predict the _future_ util landscape.
> > Merging the two means I need to add a task and a dst_cpu as parameters
> > of sugov_get_util() and call cpu_util_next() from there, which doesn't
> > feel so clean ...
> 
> Just pass in the util_cfs as computed by cpu_util_next(), then schedutil
> will pass in cpu_util_cfs(), the rest is all the same I think.
> 
> See below.
> 
> > Also, if we merge sugov_get_util() and sugov_aggregate_util() with
> > Vincent's patch-set I'll need to make sure to return two values with
> > sugov_get_util(): 1) the sum of the util of all classes; and 2) the util
> > that will be used to request an OPP. 1) should be used in sum_util and
> > 2) could (but I don't think it's is a good idea) be used for max_util.
> 
> I am confused, the max/sum thing is composed of the same values, just a
> different operator. Both take 'util':
> 
> 
> +	util = schedutil_get_util(cpu, cpu_util_next(cpu, p, dst_cpu))
> +	max_util = max(util, max_util);
> +	sum_util += util;

'max_util' is basically the util we use to request an OPP. 'sum_util' is
how long the CPUs will be running. For now it's the same thing because I
just used the util of the different classes and assumed that OPPs follow
utilization, but if we start using sugov_get_util() things will become
more complex, especially because of RT tasks.

In your example, schedutil_get_util() will return arch_scale_cpu_capacity()
if a RT task is running. We're going to select an OPP with that so
that's what you want to put in max_util. But we also need to know how
long we are going to run at that OPP to compute the energy, and in this
case arch_scale_cpu_capacity is probably _not_ what you want to account in
sum_util ...

Now, I'm not sure if accounting the RT-go-to-max thing here is really
going to help us. This is really an ON/OFF thing, so depending on 'luck',
the OPP landscape that you'll observe in compute_energy() can be very
different depending on whether or not a RT task is running in a FD. And
that will change abruptly when the RT task goes to sleep.

What I'm proposing is to predict in compute_energy() what is the OPP at
which CFS tasks run (cfs_util + dl_util +rt_util, to make it simple),
and ignore the oddity of having an RT task running. But that makes it
harder to factorize things with schedutil more than they are, that is
true ...

I hope that makes sense

Thanks,
Quentin
