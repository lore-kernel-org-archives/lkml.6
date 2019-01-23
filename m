Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0D1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A1E217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfAWOdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:33:33 -0500
Received: from foss.arm.com ([217.140.101.70]:42070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfAWOdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:33:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9180A78;
        Wed, 23 Jan 2019 06:33:32 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C250A3F237;
        Wed, 23 Jan 2019 06:33:29 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:33:27 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190123143327.whlyx2223xzchbkl@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
 <20190123102821.GW27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123102821.GW27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Jan 11:28, Peter Zijlstra wrote:
> On Tue, Jan 15, 2019 at 10:15:06AM +0000, Patrick Bellasi wrote:
> > -	util = (type == ENERGY_UTIL)
> > -		? util_cfs
> > -		: uclamp_util(rq, util_cfs);
> > -	util += cpu_util_rt(rq);
> > +	util = cpu_util_rt(rq);
> > +	if (type == FREQUENCY_UTIL) {
> > +		util += cpu_util_cfs(rq);
> > +		util  = uclamp_util(rq, util);
> > +	} else {
> > +		util += util_cfs;
> > +	}
> 
> Or the combined thing:
> 
> -       util = util_cfs;
> -       util += cpu_util_rt(rq);
> +       util = cpu_util_rt(rq);
> +       if (type == FREQUENCY_UTIL) {
> +               util += cpu_util_cfs(rq);
> +               util  = uclamp_util(rq, util);
> +       } else {
> +               util += util_cfs;
> +       }
> 
> 
> Leaves me confused.
> 
> When type == FREQ, util_cfs should already be cpu_util_cfs(), per
> sugov_get_util().
> 
> So should that not end up like:
> 
> 	util = util_cfs;
> 	util += cpu_util_rt(rq);
> +	if (type == FREQUENCY_UTIL)
> +		util = uclamp_util(rq, util);
> 
> instead?

You right, I get to that core after the patches which integrate
compute_energy(). The chuck above was the version before the EM got
merged but I missed to backport the change once I rebased on
tip/sched/core with the EM in.

Sorry for the confusion, will fix in v7.

Cheers

-- 
#include <best/regards.h>

Patrick Bellasi
