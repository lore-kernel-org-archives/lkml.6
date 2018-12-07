Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125B620700
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125B620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLGUU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:20:29 -0500
Received: from foss.arm.com ([217.140.101.70]:53712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeLGUU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:20:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6B1C15AB;
        Fri,  7 Dec 2018 12:20:28 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A923F614;
        Fri,  7 Dec 2018 12:20:26 -0800 (PST)
Subject: Re: [PATCH v4 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-4-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9253783d-d53f-9587-61eb-2505bca5fc0c@arm.com>
Date:   Fri, 7 Dec 2018 20:20:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544131696-2888-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 06/12/2018 21:28, Steve Sistare wrote:
[...]
> @@ -1621,7 +1626,22 @@ static void __sdt_free(const struct cpumask *cpu_map)
>  
>  static int sd_llc_alloc(struct sched_domain *sd)
>  {
> -	/* Allocate sd->shared data here. Empty for now. */
> +	struct sched_domain_shared *sds = sd->shared;
> +	struct cpumask *span = sched_domain_span(sd);
> +	int nid = cpu_to_node(cpumask_first(span));
> +	int flags = __GFP_ZERO | GFP_KERNEL;
> +	struct sparsemask *mask;
> +
> +	/*
> +	 * Allocate the bitmap if not already allocated.  This is called for
> +	 * every CPU in the LLC but only allocates once per sd_llc_shared.
> +	 */
> +	if (!sds->cfs_overload_cpus) {
> +		mask = sparsemask_alloc_node(nr_cpu_ids, 3, flags, nid);
                                             ^^^^^^^^^^ ^^^
                                                 (1)    (2)

(1): Is this necessary? Wouldn't cpumask_weight(span) suffice?

(2): Could this get a name somewhere? In v3 this was
SPARSEMASK_DENSITY_DEFAULT, I think it'd make sense to have it in
sched/sparsemask.c

> +		if (!mask)
> +			return 1;
> +		sds->cfs_overload_cpus = mask;
> +	}
>  
>  	return 0;
>  }
> @@ -1633,7 +1653,8 @@ static void sd_llc_free(struct sched_domain *sd)
>  	if (!sds)
>  		return;
>  
> -	/* Free data here. Empty for now. */
> +	sparsemask_free(sds->cfs_overload_cpus);
> +	sds->cfs_overload_cpus = NULL;
>  }
>  
>  static int sd_llc_alloc_all(const struct cpumask *cpu_map, struct s_data *d)
> 
