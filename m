Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D512320684
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfBVLAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:00:06 -0500
Received: from foss.arm.com ([217.140.101.70]:57738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfBVLAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:00:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857DAA78;
        Fri, 22 Feb 2019 03:00:05 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519F63F5C1;
        Fri, 22 Feb 2019 03:00:04 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:59:59 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Wang <vincent.wang@unisoc.com>,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V4] sched/cpufreq: initialize iowait_boost_max and
 iowait_boost with cpu capacity
Message-ID: <20190222105957.wxhlcmoag5f3i4fi@queper01-lin>
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 Feb 2019 at 18:37:46 (+0800), Chunyan Zhang wrote:
> @@ -823,6 +823,8 @@ static int sugov_start(struct cpufreq_policy *policy)
>  {
>  	struct sugov_policy *sg_policy = policy->governor_data;
>  	unsigned int cpu;
> +	unsigned long max_cap = arch_scale_cpu_capacity(NULL, policy->cpu);
> +	unsigned long min_cap = max_cap * policy->min / policy->cpuinfo.max_freq;
>  
>  	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
>  	sg_policy->last_freq_update_time	= 0;
> @@ -837,7 +839,9 @@ static int sugov_start(struct cpufreq_policy *policy)
>  		memset(sg_cpu, 0, sizeof(*sg_cpu));
>  		sg_cpu->cpu			= cpu;
>  		sg_cpu->sg_policy		= sg_policy;
> -		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
> +		sg_cpu->max			= max_cap;
> +		sg_cpu->min			= min_cap;
> +		sg_cpu->iowait_boost_max	= max_cap;

Unfortunately, I don't think you can do that only here. The return value
of arch_scale_cpu_capacity() can change at run time. And it does on arm64,
see drivers/base/arch_topology.c.

>  	}
>  
>  	for_each_cpu(cpu, policy->cpus) {
> -- 
> 2.17.1
> 

Thanks,
Quentin
