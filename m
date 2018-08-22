Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B18C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5862150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5862150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeHVRhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:37:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:39314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbeHVRhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:37:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37617B030;
        Wed, 22 Aug 2018 14:12:14 +0000 (UTC)
Date:   Wed, 22 Aug 2018 16:12:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180822141213.GO29735@dhcp22.suse.cz>
References: <20180821213559.14694-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821213559.14694-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-08-18 14:35:57, Roman Gushchin wrote:
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
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>

Looks good to me. Two nits below.

I am not sure stable tree backport is really needed but it would be nice
to put
Fixes: ac496bf48d97 ("fork: Optimize task creation by caching two thread stacks per CPU if CONFIG_VMAP_STACK=y")

Acked-by: Michal Hocko <mhocko@suse.com>

> @@ -248,9 +253,20 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  static inline void free_thread_stack(struct task_struct *tsk)
>  {
>  #ifdef CONFIG_VMAP_STACK
> -	if (task_stack_vm_area(tsk)) {
> +	struct vm_struct *vm = task_stack_vm_area(tsk);
> +
> +	if (vm) {
>  		int i;
>  
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> +			mod_memcg_page_state(vm->pages[i],
> +					     MEMCG_KERNEL_STACK_KB,
> +					     -(int)(PAGE_SIZE / 1024));
> +
> +			memcg_kmem_uncharge(vm->pages[i],
> +					    compound_order(vm->pages[i]));

when do we have order > 0 here? Also I was wondering how come this
doesn't blow up on partially charged stacks but both
mod_memcg_page_state and memcg_kmem_uncharge check for page->mem_cgroup
so this is safe. Maybe a comment would save people from scratching their
heads.

-- 
Michal Hocko
SUSE Labs
