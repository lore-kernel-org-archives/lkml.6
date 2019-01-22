Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA01C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA0420879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfAVMN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:13:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52238 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfAVMN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:13:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8827CA78;
        Tue, 22 Jan 2019 04:13:26 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934103F614;
        Tue, 22 Jan 2019 04:13:23 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:13:22 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 11/16] sched/fair: Add uclamp support to
 energy_compute()
Message-ID: <20190122121321.r6mv23ao57uut3t7@queper01-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-12-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-12-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Jan 2019 at 10:15:08 (+0000), Patrick Bellasi wrote:
> The Energy Aware Scheduler (AES) estimates the energy impact of waking

s/AES/EAS :-)

[...]
> +		for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> +			cfs_util = cpu_util_next(cpu, p, dst_cpu);
> +
> +			/*
> +			 * Busy time computation: utilization clamping is not
> +			 * required since the ratio (sum_util / cpu_capacity)
> +			 * is already enough to scale the EM reported power
> +			 * consumption at the (eventually clamped) cpu_capacity.
> +			 */

Right.

> +			sum_util += schedutil_cpu_util(cpu, cfs_util, cpu_cap,
> +						       ENERGY_UTIL, NULL);
> +
> +			/*
> +			 * Performance domain frequency: utilization clamping
> +			 * must be considered since it affects the selection
> +			 * of the performance domain frequency.
> +			 */

So that actually affects the way we deal with RT I think. I assume the
idea is to say if you don't want to reflect the RT-go-to-max-freq thing
in EAS (which is what we do now) you should set the min cap for RT to 0.
Is that correct ?

I'm fine with this conceptually but maybe the specific case of RT should
be mentioned somewhere in the commit message or so ? I think it's
important to say that clearly since this patch changes the default
behaviour.

> +			cpu_util = schedutil_cpu_util(cpu, cfs_util, cpu_cap,
> +						      FREQUENCY_UTIL,
> +						      cpu == dst_cpu ? p : NULL);
> +			max_util = max(max_util, cpu_util);
>  		}
>  
>  		energy += em_pd_energy(pd->em_pd, max_util, sum_util);

Thanks,
Quentin
