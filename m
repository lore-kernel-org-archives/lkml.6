Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA02C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DA12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DA12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937493AbeFSJxr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:53:47 -0400
Received: from foss.arm.com ([217.140.101.70]:46118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936108AbeFSJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:53:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2D5F1435;
        Tue, 19 Jun 2018 02:53:45 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDC583F25D;
        Tue, 19 Jun 2018 02:53:41 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:53:40 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 07/10] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180619095340.GS17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-8-quentin.perret@arm.com>
 <20180619095140.GE9208@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619095140.GE9208@codeaurora.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jun 2018 at 15:21:40 (+0530), Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:02PM +0100, Quentin Perret wrote:
> 
> <snip>
> 
> >  
> > +/*
> > + * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
> > + */
> > +static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
> > +{
> > +	unsigned long util, util_est;
> > +	struct cfs_rq *cfs_rq;
> > +
> > +	/* Task is where it should be, or has no impact on cpu */
> > +	if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
> > +		return cpu_util(cpu);
> > +
> > +	cfs_rq = &cpu_rq(cpu)->cfs;
> > +	util = READ_ONCE(cfs_rq->avg.util_avg);
> > +
> > +	if (dst_cpu == cpu)
> > +		util += task_util(p);
> > +	else
> > +		util = max_t(long, util - task_util(p), 0);
> > +
> > +	if (sched_feat(UTIL_EST)) {
> > +		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +		if (dst_cpu == cpu)
> > +			util_est += _task_util_est(p);
> > +		else
> > +			util_est = max_t(long, util_est - _task_util_est(p), 0);
> 
> For UTIL_EST case, the waking task will not have any contribution in the
> previous CPU's util_est. So we can just use the previous CPU util_est as is.

Right, good catch, I actually spotted that one as well and already fixed it
for v4 ;-)
