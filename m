Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5109EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175C820864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175C820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbeGISHl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:07:41 -0400
Received: from foss.arm.com ([217.140.101.70]:36064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933824AbeGISHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:07:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 373967A9;
        Mon,  9 Jul 2018 11:07:39 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9270E3F318;
        Mon,  9 Jul 2018 11:07:33 -0700 (PDT)
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
To:     Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4341d199-8018-21e1-c2ce-9af8f7719297@arm.com>
Date:   Mon, 9 Jul 2018 20:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628114043.24724-4-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 01:40 PM, Quentin Perret wrote:

[...]

> +/**
> + * em_rescale_cpu_capacity() - Re-scale capacity values of the Energy Model
> + *
> + * This re-scales the capacity values for all capacity states of all frequency
> + * domains of the Energy Model. This should be used when the capacity values
> + * of the CPUs are updated at run-time, after the EM was registered.
> + */
> +void em_rescale_cpu_capacity(void)
> +{
> +	struct em_cs_table *old_table, *new_table;
> +	struct em_freq_domain *fd;
> +	int nr_states, cpu;
> +
> +	mutex_lock(&em_fd_mutex);
> +	rcu_read_lock();
> +	for_each_possible_cpu(cpu) {
> +		/* Re-scale only once per frequency domain. */
> +		fd = READ_ONCE(per_cpu(em_data, cpu));
> +		if (!fd || cpu != cpumask_first(to_cpumask(fd->cpus)))
> +			continue;
> +
> +		/* Copy the existing table. */
> +		old_table = rcu_dereference(fd->cs_table);
> +		nr_states = old_table->nr_cap_states;
> +		new_table = alloc_cs_table(nr_states);
> +		if (!new_table)
> +			goto out;
> +		memcpy(new_table->state, old_table->state,
> +					nr_states * sizeof(*new_table->state));
> +
> +		/* Re-scale the capacity values of the copy. */
> +		fd_update_cs_table(new_table,
> +					cpumask_first(to_cpumask(fd->cpus)));
> +
> +		/* Replace the fd table with the re-scaled version. */
> +		rcu_assign_pointer(fd->cs_table, new_table);
> +		call_rcu(&old_table->rcu, rcu_free_cs_table);
> +	}
> +out:
> +	rcu_read_unlock();
> +	mutex_unlock(&em_fd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(em_rescale_cpu_capacity);

This em_rescale_cpu_capacity() function is still very much specific to 
systems with asymmetric cpu capacity (Arm big.Little/DynamIQ). Only 
after cpufreq is up we can determine the capacity of a CPU, hence we 
need this one to set the CPU capacity values for the individual 
performance states.

Can you not calculate capacity 'on the fly' just using freq and max freq 
as well as arch_scale_cpu_capacity() which gives you max capacity?

capacity = arch_scale_cpu_capacity() * freq / max_freq

In this case we could get rid of the 'ugly' EM rescaling infrastructure.

[...]
