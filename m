Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D03C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4C42098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4C42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeIYUmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:42:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40343 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbeIYUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:42:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id o2-v6so7317024wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 07:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qazRuhdbjkSr9Nymv8zznvOWVZ3gtpNtiOXwc/Imt7o=;
        b=kBPwe5zDeo2TEKe1vRQTFO9GNoR/DxVr059xLgdxswaSG8AafzbXSSetHQ0FyiFCQc
         wip73VDwM4z/JbVG3Dj5UrgXCOdtzurV4qgc2hZWB8TU9xPyPvmH2gcNuJDlsmpNyr6k
         3vdsLQpCmKV9IcI+u4tziX1F7jk1lV55jPIoC6rc0r+Sl1wHYUp9yaP7ULOrIER9GXka
         3hJG4JjBV1VAC4MnvteMrGKd71s3bW+MMNPNc9oDg+s0PwjoXCNLG+7YtEwY5z/mzXs2
         grEIoPylz2wWj3AxUQIkNx6TJy6BFL4u/rWPVdetlg1YiX0S2HdZqxyw7Gm5huSd5M/T
         ZRUg==
X-Gm-Message-State: ABuFfoj5We7s9zW34KCy8ALs3f4SjvsAgmeXuzfAKIgV52uqDnCaq7WG
        fEWD3LuXCrDVFBsivXY+e6U4lg==
X-Google-Smtp-Source: ACcGV60wkqB/1967ii9Xx3uCrffN120hl81CqSb6gCwBAVfBuB5lf8kkoQUi73ZyDVNWvS2TH73zHg==
X-Received: by 2002:a1c:d141:: with SMTP id i62-v6mr1006719wmg.113.1537886063274;
        Tue, 25 Sep 2018 07:34:23 -0700 (PDT)
Received: from localhost.localdomain ([151.82.116.90])
        by smtp.gmail.com with ESMTPSA id z3-v6sm637668wrh.49.2018.09.25.07.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 07:34:22 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:34:16 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     lizefan@huawei.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org
Subject: Re: [PATCH v5 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20180925143416.GD25664@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-4-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903142801.20046-4-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li Zefan and Tejun Heo,

It would be great if you could please have a look at the proposed change
below (and the rest of the set of course :-).

Another bit that I'd be more comfortable after hearing your word on it
is this one (discussed over 5/5):

https://lore.kernel.org/lkml/20180925130750.GA25664@localhost.localdomain/

Best,

- Juri

On 03/09/18 16:27, Juri Lelli wrote:
> callback_lock grants the holder read-only access to cpusets.  For fixing
> a synchronization issue between cpusets and scheduler core, it is now
> required to make callback_lock available to core scheduler code.
> 
> Convert callback_lock to raw_spin_lock, so that it will be always safe
> to acquire it from atomic context.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 66 +++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 266f10cb7222..5b43f482fa0f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -288,7 +288,7 @@ static struct cpuset top_cpuset = {
>   */
>  
>  static DEFINE_MUTEX(cpuset_mutex);
> -static DEFINE_SPINLOCK(callback_lock);
> +static DEFINE_RAW_SPINLOCK(callback_lock);
>  
>  static struct workqueue_struct *cpuset_migrate_mm_wq;
>  
> @@ -922,9 +922,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
>  			continue;
>  		rcu_read_unlock();
>  
> -		spin_lock_irq(&callback_lock);
> +		raw_spin_lock_irq(&callback_lock);
>  		cpumask_copy(cp->effective_cpus, new_cpus);
> -		spin_unlock_irq(&callback_lock);
> +		raw_spin_unlock_irq(&callback_lock);
>  
>  		WARN_ON(!is_in_v2_mode() &&
>  			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
> @@ -989,9 +989,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>  	if (retval < 0)
>  		return retval;
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  
>  	/* use trialcs->cpus_allowed as a temp variable */
>  	update_cpumasks_hier(cs, trialcs->cpus_allowed);
> @@ -1175,9 +1175,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
>  			continue;
>  		rcu_read_unlock();
>  
> -		spin_lock_irq(&callback_lock);
> +		raw_spin_lock_irq(&callback_lock);
>  		cp->effective_mems = *new_mems;
> -		spin_unlock_irq(&callback_lock);
> +		raw_spin_unlock_irq(&callback_lock);
>  
>  		WARN_ON(!is_in_v2_mode() &&
>  			!nodes_equal(cp->mems_allowed, cp->effective_mems));
> @@ -1245,9 +1245,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>  	if (retval < 0)
>  		goto done;
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  	cs->mems_allowed = trialcs->mems_allowed;
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  
>  	/* use trialcs->mems_allowed as a temp variable */
>  	update_nodemasks_hier(cs, &trialcs->mems_allowed);
> @@ -1338,9 +1338,9 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
>  	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
>  			|| (is_spread_page(cs) != is_spread_page(trialcs)));
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  	cs->flags = trialcs->flags;
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  
>  	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
>  		rebuild_sched_domains_locked();
> @@ -1755,7 +1755,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
>  	cpuset_filetype_t type = seq_cft(sf)->private;
>  	int ret = 0;
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  
>  	switch (type) {
>  	case FILE_CPULIST:
> @@ -1774,7 +1774,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
>  		ret = -EINVAL;
>  	}
>  
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  	return ret;
>  }
>  
> @@ -1989,12 +1989,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  
>  	cpuset_inc();
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  	if (is_in_v2_mode()) {
>  		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
>  		cs->effective_mems = parent->effective_mems;
>  	}
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  
>  	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
>  		goto out_unlock;
> @@ -2021,12 +2021,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  	}
>  	rcu_read_unlock();
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  	cs->mems_allowed = parent->mems_allowed;
>  	cs->effective_mems = parent->mems_allowed;
>  	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
>  	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  out_unlock:
>  	mutex_unlock(&cpuset_mutex);
>  	return 0;
> @@ -2065,7 +2065,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
>  static void cpuset_bind(struct cgroup_subsys_state *root_css)
>  {
>  	mutex_lock(&cpuset_mutex);
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  
>  	if (is_in_v2_mode()) {
>  		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
> @@ -2076,7 +2076,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
>  		top_cpuset.mems_allowed = top_cpuset.effective_mems;
>  	}
>  
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  	mutex_unlock(&cpuset_mutex);
>  }
>  
> @@ -2174,12 +2174,12 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>  {
>  	bool is_empty;
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  	cpumask_copy(cs->cpus_allowed, new_cpus);
>  	cpumask_copy(cs->effective_cpus, new_cpus);
>  	cs->mems_allowed = *new_mems;
>  	cs->effective_mems = *new_mems;
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  
>  	/*
>  	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
> @@ -2216,10 +2216,10 @@ hotplug_update_tasks(struct cpuset *cs,
>  	if (nodes_empty(*new_mems))
>  		*new_mems = parent_cs(cs)->effective_mems;
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  	cpumask_copy(cs->effective_cpus, new_cpus);
>  	cs->effective_mems = *new_mems;
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  
>  	if (cpus_updated)
>  		update_tasks_cpumask(cs);
> @@ -2312,21 +2312,21 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
>  
>  	/* synchronize cpus_allowed to cpu_active_mask */
>  	if (cpus_updated) {
> -		spin_lock_irq(&callback_lock);
> +		raw_spin_lock_irq(&callback_lock);
>  		if (!on_dfl)
>  			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
>  		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
> -		spin_unlock_irq(&callback_lock);
> +		raw_spin_unlock_irq(&callback_lock);
>  		/* we don't mess with cpumasks of tasks in top_cpuset */
>  	}
>  
>  	/* synchronize mems_allowed to N_MEMORY */
>  	if (mems_updated) {
> -		spin_lock_irq(&callback_lock);
> +		raw_spin_lock_irq(&callback_lock);
>  		if (!on_dfl)
>  			top_cpuset.mems_allowed = new_mems;
>  		top_cpuset.effective_mems = new_mems;
> -		spin_unlock_irq(&callback_lock);
> +		raw_spin_unlock_irq(&callback_lock);
>  		update_tasks_nodemask(&top_cpuset);
>  	}
>  
> @@ -2425,11 +2425,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&callback_lock, flags);
> +	raw_spin_lock_irqsave(&callback_lock, flags);
>  	rcu_read_lock();
>  	guarantee_online_cpus(task_cs(tsk), pmask);
>  	rcu_read_unlock();
> -	spin_unlock_irqrestore(&callback_lock, flags);
> +	raw_spin_unlock_irqrestore(&callback_lock, flags);
>  }
>  
>  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> @@ -2477,11 +2477,11 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>  	nodemask_t mask;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&callback_lock, flags);
> +	raw_spin_lock_irqsave(&callback_lock, flags);
>  	rcu_read_lock();
>  	guarantee_online_mems(task_cs(tsk), &mask);
>  	rcu_read_unlock();
> -	spin_unlock_irqrestore(&callback_lock, flags);
> +	raw_spin_unlock_irqrestore(&callback_lock, flags);
>  
>  	return mask;
>  }
> @@ -2573,14 +2573,14 @@ bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
>  		return true;
>  
>  	/* Not hardwall and node outside mems_allowed: scan up cpusets */
> -	spin_lock_irqsave(&callback_lock, flags);
> +	raw_spin_lock_irqsave(&callback_lock, flags);
>  
>  	rcu_read_lock();
>  	cs = nearest_hardwall_ancestor(task_cs(current));
>  	allowed = node_isset(node, cs->mems_allowed);
>  	rcu_read_unlock();
>  
> -	spin_unlock_irqrestore(&callback_lock, flags);
> +	raw_spin_unlock_irqrestore(&callback_lock, flags);
>  	return allowed;
>  }
>  
> -- 
> 2.17.1
> 
