Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4077FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F421872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfADRHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:07:49 -0500
Received: from foss.arm.com ([217.140.101.70]:46424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfADRHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:07:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C154CEBD;
        Fri,  4 Jan 2019 09:07:47 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AED23F5D4;
        Fri,  4 Jan 2019 09:07:46 -0800 (PST)
Date:   Fri, 4 Jan 2019 17:07:41 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Wang <vincent.wang@unisoc.com>,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] sched/cpufreq: calculate util / max firstly in
 get_next_freq()
Message-ID: <20190104170741.h7bm6yivjf4z3tbd@queper01-lin>
References: <1545634747-22401-1-git-send-email-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545634747-22401-1-git-send-email-chunyan.zhang@unisoc.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 24 Dec 2018 at 14:59:07 (+0800), Chunyan Zhang wrote:
> From: Vincent Wang <vincent.wang@unisoc.com>
> 
> When a task that is in_iowait state is enqueued, cpufreq_update_util() will
> be invoked with SCHED_CPUFREQ_IOWAIT flag. In this case,the value of util
> and max, which are parameters used in get_next_freq(), will be cpu
> frequency, instead of cpu util or capactiy.
> 
> For some 32bit architectures, the size of unsigned long is 32. When
> calculating freq, there may be an overflow error in this expression:
> 
> freq = (freq + (freq >> 2)) * util / max;

This has moved to a different file recently -- see 938e5e4b0d15
("sched/cpufreq: Prepare schedutil for Energy Aware Scheduling") so you
probably want to rebase this patch :-)

> 
> This patch will fix this overflow risk by calulating util / max firstly,
> whether they be frequency or util.
> 
> Signed-off-by: Vincent Wang <vincent.wang@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 3fffad3..7c372db1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -166,8 +166,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	unsigned int freq = arch_scale_freq_invariant() ?
>  				policy->cpuinfo.max_freq : policy->cur;
> +	unsigned int ratio = util * 100 / max;
>  
> -	freq = (freq + (freq >> 2)) * util / max;
> +	freq = (freq + (freq >> 2)) * ratio / 100;

Maybe shift by SCHED_CAPACITY_SCALE instead of doing divisions ? Or you
could also just keep the original structure and use proper u64 types
instead of adding (useless) extra steps for 64 bits.

Thanks,
Quentin
