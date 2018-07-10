Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0913C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C5F20878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C5F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbeGJIcK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:32:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeGJIcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:32:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975D680D;
        Tue, 10 Jul 2018 01:32:08 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ABDB3F318;
        Tue, 10 Jul 2018 01:32:04 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:32:03 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Message-ID: <20180710083202.GD17598@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <4341d199-8018-21e1-c2ce-9af8f7719297@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4341d199-8018-21e1-c2ce-9af8f7719297@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 Jul 2018 at 20:07:31 (+0200), Dietmar Eggemann wrote:
> On 06/28/2018 01:40 PM, Quentin Perret wrote:
> This em_rescale_cpu_capacity() function is still very much specific to
> systems with asymmetric cpu capacity (Arm big.Little/DynamIQ). Only after
> cpufreq is up we can determine the capacity of a CPU, hence we need this one
> to set the CPU capacity values for the individual performance states.

The abstraction is that this function is needed by all systems where the
capacities of CPUs are discovered late, or can be changed at run-time.
But yeah, AFAICT this applies mainly to Arm big.LITTLE and/or DynamIQ
systems, at least for now.

> 
> Can you not calculate capacity 'on the fly' just using freq and max freq as
> well as arch_scale_cpu_capacity() which gives you max capacity?
> 
> capacity = arch_scale_cpu_capacity() * freq / max_freq
> 
> In this case we could get rid of the 'ugly' EM rescaling infrastructure.

Indeed, having 'capacity' values in the EM framework is just an
optimization for the scheduler, so that it doesn't need to compute them
in the wake-up path. I could get rid of the whole
em_rescale_cpu_capacity() mess (and by the same occasion the RCU
protection of the tables ...) if I removed the 'capacity' values from
the EM. But that means a slightly higher complexity on the scheduler side.

As you said, the capacity of a CPU at a specific OPP is:

    cap(opp) = freq(opp) * scale_cpu / max_freq

Now, we estimate the energy consumed by this CPU as:

    nrg = power(opp) * util / cap(opp)

because 'util / cap(opp)' represents its percentage of busy time. If I
inject the first equation in the second, I get:

    nrg =  power(opp) * util * max_freq / (scale_cpu * freq(opp))

and this can be re-arranged as:

    nrg = (power(opp) * max_freq / freq(opp)) * (util / scale_cpu)

In the above equation, the first term between () is static so I could
pre-compute it as a 'cost' for that OPP and store it in the EM table:

    cost(opp) = power(opp) * max_freq / freq(opp)

And then the energy calculation would be something like:

   nrg = cost(opp) * util / scale_cpu

If 'scale_cpu' was static, I could fold it into 'cost' and avoid the cost
of the division. But it's not really, so I can either re-do the division
all the time on the scheduler side, or play with RCU to cache the result
of the division in the EM framework.

(I now realize that the current implementation of em_fd_energy() does
'cs->power * sum_util / cs->capacity' but the power / capacity ratio is
constant so, if we decide to keep the capacity values in the EM, I
should still cache 'power / capacity' in the EM tables and actually save
the division ...)

This is really a performance vs. code complexity trade-off. I made the
choice of performance since we're talking about the scheduler here, but
I'm not sure how much we really save by saving this division TBH.

Thoughts ?

Thanks,
Quentin
