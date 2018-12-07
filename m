Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E819DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92192083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92192083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeLGUU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:20:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53736 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeLGUU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:20:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B743C15AB;
        Fri,  7 Dec 2018 12:20:56 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2F43F614;
        Fri,  7 Dec 2018 12:20:54 -0800 (PST)
Subject: Re: [PATCH v4 04/10] sched/fair: Dynamically update cfs_overload_cpus
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-5-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3ec57357-dc4e-be1b-963f-abcf760ecc5a@arm.com>
Date:   Fri, 7 Dec 2018 20:20:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544131696-2888-5-git-send-email-steven.sistare@oracle.com>
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
> @@ -3724,6 +3725,28 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  	rq->misfit_task_load = task_h_load(p);
>  }
>  
> +static void overload_clear(struct rq *rq)

Nitpicky nit: cfs_overload_{clear, set} might be a bit better, just to
explicitly differentiate this from rq->rd->overload. Although I suppose
the naming problem will show up again if/when you try to expand this to
other classes...

> +{
> +	struct sparsemask *overload_cpus;
> +
> +	rcu_read_lock();
> +	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
> +	if (overload_cpus)
> +		sparsemask_clear_elem(overload_cpus, rq->cpu);
> +	rcu_read_unlock();
> +}
> +
> +static void overload_set(struct rq *rq)
> +{
> +	struct sparsemask *overload_cpus;
> +
> +	rcu_read_lock();
> +	overload_cpus = rcu_dereference(rq->cfs_overload_cpus);
> +	if (overload_cpus)
> +		sparsemask_set_elem(overload_cpus, rq->cpu);
> +	rcu_read_unlock();
> +}
> +
>  #else /* CONFIG_SMP */
>  
>  #define UPDATE_TG	0x0
[...]
> @@ -4468,8 +4495,12 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  			dequeue = 0;
>  	}
>  
> -	if (!se)
> +	if (!se) {
>  		sub_nr_running(rq, task_delta);
> +		if (prev_nr >= 2 && prev_nr - task_delta < 2)
> +			overload_clear(rq);
> +
> +	}

Eventually it'd be nice to squash those into {add, sub}_nr_running(), but
you already mentioned wanting to stick to CFS for now, so I don't think
it's *too* much of a big deal.

>  
>  	cfs_rq->throttled = 1;
>  	cfs_rq->throttled_clock = rq_clock(rq);
> @@ -4499,6 +4530,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
[...]
