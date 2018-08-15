Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DF5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5534421501
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5534421501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeHOKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:01:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbeHOKB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:01:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D09E1ADE8;
        Wed, 15 Aug 2018 07:10:58 +0000 (UTC)
Date:   Wed, 15 Aug 2018 09:10:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180815071058.GL32645@dhcp22.suse.cz>
References: <20180815003620.15678-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815003620.15678-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-08-18 17:36:19, Roman Gushchin wrote:
> If CONFIG_VMAP_STACK is set, kernel stacks are allocated
> using __vmalloc_node_range() with __GFP_ACCOUNT. So kernel
> stack pages are charged against corresponding memory cgroups
> on allocation and uncharged on releasing them.
> 
> The problem is that we do cache kernel stacks in small
> per-cpu caches and do reuse them for new tasks, which can
> belong to different memory cgroups.
> 
> Each stack page still holds a reference to the original cgroup,
> so the cgroup can't be released until the vmap area is released.
> 
> To make this happen we need more than two subsequent exits
> without forks in between on the current cpu, which makes it
> very unlikely to happen. As a result, I saw a significant number
> of dying cgroups (in theory, up to 2 * number_of_cpu +
> number_of_tasks), which can't be released even by significant
> memory pressure.
> 
> As a cgroup structure can take a significant amount of memory
> (first of all, per-cpu data like memcg statistics), it leads
> to a noticeable waste of memory.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Fixes: ac496bf48d97 ("fork: Optimize task creation by caching two thread stacks per CPU if CONFIG_VMAP_STACK=y")
AFAICS

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>

Yes this is the right way to do accounting here.
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  kernel/fork.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 69b6fea5a181..91872b2b37bd 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		return s->addr;
>  	}
>  
> +	/*
> +	 * Allocated stacks are cached and later reused by new threads,
> +	 * so memcg accounting is performed manually on assigning/releasing
> +	 * stacks to tasks. Drop __GFP_ACCOUNT.
> +	 */
>  	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
>  				     VMALLOC_START, VMALLOC_END,
> -				     THREADINFO_GFP,
> +				     THREADINFO_GFP & ~__GFP_ACCOUNT,
>  				     PAGE_KERNEL,
>  				     0, node, __builtin_return_address(0));
>  
> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  #endif
>  }
>  
> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> +{
> +#ifdef CONFIG_VMAP_STACK
> +	struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +	if (vm) {
> +		int i;
> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +			memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> +					  compound_order(vm->pages[i]));
> +
> +		/* All stack pages belong to the same memcg. */
> +		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> +				     THREAD_SIZE / 1024);
> +	}
> +#endif
> +}
> +
>  static inline void free_thread_stack(struct task_struct *tsk)
>  {
>  #ifdef CONFIG_VMAP_STACK
> -	if (task_stack_vm_area(tsk)) {
> +	struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +	if (vm) {
>  		int i;
>  
> +		/* All stack pages belong to the same memcg. */
> +		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> +				     -(int)(THREAD_SIZE / 1024));
> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> +			memcg_kmem_uncharge(vm->pages[i],
> +					  compound_order(vm->pages[i]));
> +
>  		for (i = 0; i < NR_CACHED_STACKS; i++) {
>  			if (this_cpu_cmpxchg(cached_stacks[i],
>  					NULL, tsk->stack_vm_area) != NULL)
> @@ -352,10 +386,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  					    NR_KERNEL_STACK_KB,
>  					    PAGE_SIZE / 1024 * account);
>  		}
> -
> -		/* All stack pages belong to the same memcg. */
> -		mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> -				     account * (THREAD_SIZE / 1024));
>  	} else {
>  		/*
>  		 * All stack pages are in the same zone and belong to the
> @@ -809,6 +839,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  	if (!stack)
>  		goto free_tsk;
>  
> +	memcg_charge_kernel_stack(tsk);
> +
>  	stack_vm_area = task_stack_vm_area(tsk);
>  
>  	err = arch_dup_task_struct(tsk, orig);
> -- 
> 2.14.4

-- 
Michal Hocko
SUSE Labs
