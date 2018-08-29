Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16595C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38F120846
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38F120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeH2OAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:00:50 -0400
Received: from foss.arm.com ([217.140.101.70]:51446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbeH2OAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:00:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B53D80D;
        Wed, 29 Aug 2018 03:04:42 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56D7E3F5BD;
        Wed, 29 Aug 2018 03:04:38 -0700 (PDT)
Date:   Wed, 29 Aug 2018 11:04:35 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20180829100435.GP2960@e110439-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820094420.26590-4-quentin.perret@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,
few possible optimizations related to the (simplified) following
code:

On 20-Aug 10:44, Quentin Perret wrote:

[...]

> +struct em_perf_domain {
> +	struct em_cap_state *table; /* Capacity states, in ascending order. */
> +	int nr_cap_states;
> +	unsigned long cpus[0]; /* CPUs of the frequency domain. */
> +};

[...]

> +static DEFINE_PER_CPU(struct em_perf_domain *, em_data);

[...]

> +struct em_perf_domain *em_cpu_get(int cpu)
> +{
> +	return READ_ONCE(per_cpu(em_data, cpu));
> +}

[...]

> +int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
> +						struct em_data_callback *cb)
> +{

[...]

> +	mutex_lock(&em_pd_mutex);
> +
[...]

> +     for_each_cpu(cpu, span) {
> +             if (READ_ONCE(per_cpu(em_data, cpu))) {
> +                     ret = -EEXIST;
> +                     goto unlock;
> +             }

[...]

> +	for_each_cpu(cpu, span) {
> +		/*
> +		 * The per-cpu array can be concurrently accessed from
> +		 * em_cpu_get().
> +		 */
> +		smp_store_release(per_cpu_ptr(&em_data, cpu), pd);
> +	}

[...]

> +unlock:
> +	mutex_unlock(&em_pd_mutex);
> +}


In the loop above we use smp_store_release() to propagate the pointer
setting in a PER_CPU(em_data), which ultimate goal is to protect
em_register_perf_domain() from multiple clients registering the same
power domain.

I think there are two possible optimizations there:

1. use of a single memory barrier

   Since we are already em_pd_mutex protected, i.e. there cannot be a
   concurrent writers, we can use one single memory barrier after the
   loop, i.e.

        for_each_cpu(cpu, span)
                WRITE_ONCE()
        smp_wmb()

   which should be just enough to ensure that all other CPUs will see
   the pointer set once we release the mutex

2. avoid using PER_CPU variables

   Apart from the initialization code, i.e. boot time, the em_data is
   expected to be read only, isn't it?

   If that's the case, I think that using PER_CPU variables is not
   strictly required while it unnecessarily increases the cache pressure.

   In the worst case we can end up with one cache line for each CPU to
   host just an 8B pointer, instead of using that single cache line to host
   up to 8 pointers if we use just an array, i.e.

        struct em_perf_domain *em_data[NR_CPUS]
                ____cacheline_aligned_in_smp __read_mostly;

   Consider also that: up to 8 pointers in a single cache line means
   also that single cache line can be enough to access the EM from all
   the CPUs of almost every modern mobile phone SoC.

   Note entirely sure if PER_CPU uses less overall memory in case you
   have much less CPUs then the compile time defined NR_CPUS.
   But still, if the above makes sense, you still have a 8x gain
   factor between number Write allocated .data..percp sections and
   the value of NR_CPUS. Meaning that in the worst case we allocate
   the same amount of memory using NR_CPUS=64 (the default on arm64)
   while running on an 8 CPUs system... but still we should get less
   cluster caches pressure at run-time with the array approach, 1
   cache line vs 4.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
