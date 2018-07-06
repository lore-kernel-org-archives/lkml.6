Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE24C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6150623E4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6150623E4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeGFPMV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:12:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38646 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932726AbeGFPMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:12:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12B1AED1;
        Fri,  6 Jul 2018 08:12:18 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6B13F2EA;
        Fri,  6 Jul 2018 08:12:13 -0700 (PDT)
Date:   Fri, 6 Jul 2018 16:12:12 +0100
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
Message-ID: <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706131243.GV2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 Jul 2018 at 15:12:43 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:40PM +0100, Quentin Perret wrote:
> > +static long 
>    compute_energy(struct task_struct *p, int dst_cpu, struct freq_domain *fd)
> > +{
> > +	long util, max_util, sum_util, energy = 0;
> > +	int cpu;
> > +
> > +	while (fd) {
> > +		max_util = sum_util = 0;
> > +		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
> 
> I had a wee little wtf moment when I realized this crosses root_domain
> boundaries but that that is actually desired. A comment might be in
> order.

Indeed, the selection of CPU candidates is guaranteed to be within the
root_domain, but the boundaries for the energy calculation can be
different. The OPP in a FD can be driven by a CPU outside of the
root_domain we're currently looking at ... I'll add a comment about
that.

I guess it is also worth mentioning that in the case mentioned above the
scheduling decisions made inside one root domain can indirectly be
impacted by the scheduling decisions made in another root domain. Some
CPUs inside one root domain might look expensive to use simply because
they run at a high OPP because of other CPUs of the same FD being
over-used in another root domain.

This is arguably not desirable, but I'm not sure if this is a problem.
It would be wise for users not to split a frequency domain in multiple
root domains IMO but we can't really prevent them from doing so ...

Another solution would be to ignore the CPUs outside of the root_domain
and to accept that this can lead to sub-optimal scheduling decisions
from an energy standpoint.

> 
> > +			util = cpu_util_next(cpu, p, dst_cpu);
> > +			util += cpu_util_dl(cpu_rq(cpu));
> > +			/* XXX: add RT util_avg when available. */
> > +
> > +			max_util = max(util, max_util);
> > +			sum_util += util;
> 
> Did you want to use sugov_get_util() here? There is no way we're going
> to duplicate all that.

I need to look into how we can do that ... Sugov looks at the current
util landscape while EAS tries to predict the _future_ util landscape.
Merging the two means I need to add a task and a dst_cpu as parameters
of sugov_get_util() and call cpu_util_next() from there, which doesn't
feel so clean ...

Also, if we merge sugov_get_util() and sugov_aggregate_util() with
Vincent's patch-set I'll need to make sure to return two values with
sugov_get_util(): 1) the sum of the util of all classes; and 2) the util
that will be used to request an OPP. 1) should be used in sum_util and
2) could (but I don't think it's is a good idea) be used for max_util.

This probably won't be pretty :/
