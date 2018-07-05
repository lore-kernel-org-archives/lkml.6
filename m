Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0529924037
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0529924037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeGENbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:31:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753194AbeGENbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:31:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65EF018A;
        Thu,  5 Jul 2018 06:31:46 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72623F5AD;
        Thu,  5 Jul 2018 06:31:44 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:31:43 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gaku.inami.xh@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 11/12] sched/core: Disable SD_ASYM_CPUCAPACITY for
 root_domains without asymmetry
Message-ID: <20180705133142.GD32579@e108498-lin.cambridge.arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-12-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530699470-29808-12-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morten,

On Wednesday 04 Jul 2018 at 11:17:49 (+0100), Morten Rasmussen wrote:
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 71330e0e41db..29c186961345 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1160,6 +1160,26 @@ sd_init(struct sched_domain_topology_level *tl,
>  	sd_id = cpumask_first(sched_domain_span(sd));
>  
>  	/*
> +	 * Check if cpu_map eclipses cpu capacity asymmetry.
> +	 */
> +
> +	if (sd->flags & SD_ASYM_CPUCAPACITY) {
> +		int i;
> +		bool disable = true;
> +		long capacity = arch_scale_cpu_capacity(NULL, sd_id);
> +
> +		for_each_cpu(i, sched_domain_span(sd)) {
> +			if (capacity != arch_scale_cpu_capacity(NULL, i)) {
> +				disable = false;
> +				break;
> +			}
> +		}
> +
> +		if (disable)
> +			sd->flags &= ~SD_ASYM_CPUCAPACITY;
> +	}
> +
> +	/*
>  	 * Convert topological properties into behaviour.
>  	 */

If SD_ASYM_CPUCAPACITY means that some CPUs have different
arch_scale_cpu_capacity() values, we could also automatically _set_
the flag in sd_init() no ? Why should we let the arch set it and just
correct it later ?

I understand the moment at which we know the capacities of CPUs varies
from arch to arch, but the arch code could just call
rebuild_sched_domain when the capacities of CPUs change and let the
scheduler detect things automatically. I mean, even if the arch code
sets the flag in its topology level table, it will have to rebuild
the sched domains anyway ...

What do you think ?

Thanks,
Quentin
