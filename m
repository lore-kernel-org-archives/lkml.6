Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2919FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A5C21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A5C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeJDCcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeJDCcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:32:20 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC06E20652;
        Wed,  3 Oct 2018 19:42:31 +0000 (UTC)
Date:   Wed, 3 Oct 2018 15:42:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 4/5] sched/core: Prevent race condition between
 cpuset and __sched_setscheduler()
Message-ID: <20181003154230.4b8792fb@gandalf.local.home>
In-Reply-To: <20180903142801.20046-5-juri.lelli@redhat.com>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
        <20180903142801.20046-5-juri.lelli@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Sep 2018 16:28:00 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:


> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5b43f482fa0f..8dc26005bb1e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2410,6 +2410,24 @@ void __init cpuset_init_smp(void)
>  	BUG_ON(!cpuset_migrate_mm_wq);
>  }
>  
> +/**
> + * cpuset_read_only_lock - Grab the callback_lock from another subsysytem
> + *
> + * Description: Gives the holder read-only access to cpusets.
> + */
> +void cpuset_read_only_lock(void)
> +{
> +	raw_spin_lock(&callback_lock);

This was confusing to figure out why grabbing a spinlock gives read
only access. So I read the long comment above the definition of
callback_lock. A couple of notes.

1) The above description needs to go into more detail as to why
grabbing a spinlock is "read only".

2) The comment above the callback_lock needs to incorporate this, as
reading that comment alone will not give anyone an idea that this
exists.

Other than that, I don't see any issue with this patch.

-- Steve


> +}
> +
> +/**
> + * cpuset_read_only_unlock - Release the callback_lock from another subsysytem
> + */
> +void cpuset_read_only_unlock(void)
> +{
> +	raw_spin_unlock(&callback_lock);
> +}
> +
>  /**
>   * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
>   * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 22f5622cba69..ac11ee599968 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4228,6 +4228,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  	rq = task_rq_lock(p, &rf);
>  	update_rq_clock(rq);
>  
> +	/*
> +	 * Make sure we don't race with the cpuset subsystem where root
> +	 * domains can be rebuilt or modified while operations like DL
> +	 * admission checks are carried out.
> +	 */
> +	cpuset_read_only_lock();
> +
>  	/*
>  	 * Changing the policy of the stop threads its a very bad idea:
>  	 */
> @@ -4289,6 +4296,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  	/* Re-check policy now with rq lock held: */
>  	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
>  		policy = oldpolicy = -1;
> +		cpuset_read_only_unlock();
>  		task_rq_unlock(rq, p, &rf);
>  		goto recheck;
>  	}
> @@ -4346,6 +4354,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  
>  	/* Avoid rq from going away on us: */
>  	preempt_disable();
> +	cpuset_read_only_unlock();
>  	task_rq_unlock(rq, p, &rf);
>  
>  	if (pi)
> @@ -4358,6 +4367,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  	return 0;
>  
>  unlock:
> +	cpuset_read_only_unlock();
>  	task_rq_unlock(rq, p, &rf);
>  	return retval;
>  }

