Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD3BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8892E2133D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8892E2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeKJDUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:20:14 -0500
Received: from foss.arm.com ([217.140.101.70]:35532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbeKJDUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:20:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33AEA78;
        Fri,  9 Nov 2018 09:38:38 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67E353F718;
        Fri,  9 Nov 2018 09:38:36 -0800 (PST)
Subject: Re: [PATCH v3 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b103563e-fdf3-62a1-473e-cde1cd7e2d5d@arm.com>
Date:   Fri, 9 Nov 2018 17:38:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 09/11/2018 12:50, Steve Sistare wrote:
[...]
> @@ -482,6 +484,10 @@ static void update_top_cache_domain(int cpu)
>  	dirty_sched_domain_sysctl(cpu);
>  	destroy_sched_domains(tmp);
>  
> +	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
> +	cfs_overload_cpus = (sd ? sd->shared->cfs_overload_cpus : NULL);
> +	rcu_assign_pointer(rq->cfs_overload_cpus, cfs_overload_cpus);
> +

Why not do this in update_top_cache_domain() where we also look for the
highest SD_SHARE_PKG_RESOURCES and setup shortcut pointers?

>  	update_top_cache_domain(cpu);
>  }
>  
> @@ -1619,9 +1625,19 @@ static void __sdt_free(const struct cpumask *cpu_map)
>  	}
>  }
>  
> +#define ZALLOC_MASK(maskp, nelems, node)				  \
> +	(!*(maskp) && !zalloc_sparsemask_node(maskp, nelems,		  \
> +					      SPARSEMASK_DENSITY_DEFAULT, \
> +					      GFP_KERNEL, node))	  \
> +
>  static int sd_llc_alloc(struct sched_domain *sd)
>  {
> -	/* Allocate sd->shared data here. Empty for now. */
> +	struct sched_domain_shared *sds = sd->shared;
> +	struct cpumask *span = sched_domain_span(sd);
> +	int nid = cpu_to_node(cpumask_first(span));
> +
> +	if (ZALLOC_MASK(&sds->cfs_overload_cpus, nr_cpu_ids, nid))

Mmm so this is called once on every CPU, but the !*(maskp) check in the
macro makes it so there is only one allocation per sd_llc_shared.

I wouldn't mind having that called out in a comment, or having the
pointer check done explicitly outside of the macro.

[...]
