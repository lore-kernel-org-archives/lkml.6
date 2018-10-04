Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38049C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0464A2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0464A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeJDQiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:38:24 -0400
Received: from foss.arm.com ([217.140.101.70]:33538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbeJDQiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:38:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6936E7A9;
        Thu,  4 Oct 2018 02:45:56 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C0003F5D3;
        Thu,  4 Oct 2018 02:45:52 -0700 (PDT)
Date:   Thu, 4 Oct 2018 10:45:47 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 08/14] sched/topology: Disable EAS on inappropriate
 platforms
Message-ID: <20181004094545.ajkpxmvabfgbdy3y@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-9-quentin.perret@arm.com>
 <20181003162719.GB19252@hirez.programming.kicks-ass.net>
 <20181004091046.7nn2odqrjy7tp5vx@queper01-lin>
 <20181004093848.GM19272@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004093848.GM19272@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Oct 2018 at 11:38:48 (+0200), Peter Zijlstra wrote:
> On Thu, Oct 04, 2018 at 10:10:48AM +0100, Quentin Perret wrote:
> > On Wednesday 03 Oct 2018 at 18:27:19 (+0200), Peter Zijlstra wrote:
> > > On Wed, Sep 12, 2018 at 10:13:03AM +0100, Quentin Perret wrote:
> > > > @@ -288,6 +321,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
> > > >  			goto free;
> > > >  		tmp->next = pd;
> > > >  		pd = tmp;
> > > > +
> > > > +		/*
> > > > +		 * Count performance domains and capacity states for the
> > > > +		 * complexity check.
> > > > +		 */
> > > > +		nr_pd++;
> > > > +		nr_cs += em_pd_nr_cap_states(pd->obj);
> > > > +	}
> > > > +
> > > > +	/* Bail out if the Energy Model complexity is too high. */
> > > > +	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
> > > > +		if (sched_debug())
> > > > +			pr_info("rd %*pbl: EM complexity is too high\n ",
> > > > +						cpumask_pr_args(cpu_map));
> > > > +		goto free;
> > > >  	}
> > > 
> > > I would make than an unconditional WARN, we do not really expect that to
> > > trigger, but then it does, we really don't want to hide it.
> > 
> > OTOH that also means that some people with big asymmetric machines can
> > get a WARN message every time they boot, and even if they don't want to
> > use EAS.
> > 
> > Now, that shouldn't happen any time soon, so it's maybe a good thing if
> > we get reports when/if people start to hit that one, so why not ...
> 
> Right, and if becomes a real problem we can think of a solution (like
> maybe a DT thingy that says to not use EAS, or a 'better' EAS
> algorithm).

That works for me. I'll switch to a plain WARN in v8.

Thanks,
Quentin
