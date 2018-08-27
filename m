Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684D8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE62208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE62208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH1AuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:50:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1AuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:50:02 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5BA90CE9;
        Mon, 27 Aug 2018 21:01:44 +0000 (UTC)
Date:   Mon, 27 Aug 2018 14:01:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] mm: rework memcg kernel stack accounting
Message-Id: <20180827140143.98b65bc7cb32f50245eb9114@linux-foundation.org>
In-Reply-To: <20180827162621.30187-1-guro@fb.com>
References: <20180827162621.30187-1-guro@fb.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 09:26:19 -0700 Roman Gushchin <guro@fb.com> wrote:

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

OK, but this doesn't describe how the patch addresses this issue?

>
> ...
>
> @@ -371,6 +382,35 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
>  	}
>  }
>  
> +static int memcg_charge_kernel_stack(struct task_struct *tsk)
> +{
> +#ifdef CONFIG_VMAP_STACK
> +	struct vm_struct *vm = task_stack_vm_area(tsk);
> +	int ret;
> +
> +	if (vm) {
> +		int i;
> +
> +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {

Can we ever have THREAD_SIZE < PAGE_SIZE?  64k pages?

> +			/*
> +			 * If memcg_kmem_charge() fails, page->mem_cgroup
> +			 * pointer is NULL, and both memcg_kmem_uncharge()
> +			 * and mod_memcg_page_state() in free_thread_stack()
> +			 * will ignore this page. So it's safe.
> +			 */
> +			ret = memcg_kmem_charge(vm->pages[i], GFP_KERNEL, 0);
> +			if (ret)
> +				return ret;
> +
> +			mod_memcg_page_state(vm->pages[i],
> +					     MEMCG_KERNEL_STACK_KB,
> +					     PAGE_SIZE / 1024);
> +		}
> +	}
> +#endif
> +	return 0;
> +}
>
> ...
>
