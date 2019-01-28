Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A689C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6809214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfA1UEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:04:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1UEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:04:32 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC7C92477;
        Mon, 28 Jan 2019 20:04:30 +0000 (UTC)
Date:   Mon, 28 Jan 2019 12:04:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 2/2] mm: add priority threshold to
 __purge_vmap_area_lazy()
Message-Id: <20190128120429.17819bd348753c2d7ed3a7b9@linux-foundation.org>
In-Reply-To: <20190124115648.9433-3-urezki@gmail.com>
References: <20190124115648.9433-1-urezki@gmail.com>
        <20190124115648.9433-3-urezki@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 12:56:48 +0100 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> commit 763b218ddfaf ("mm: add preempt points into
> __purge_vmap_area_lazy()")
> 
> introduced some preempt points, one of those is making an
> allocation more prioritized over lazy free of vmap areas.
> 
> Prioritizing an allocation over freeing does not work well
> all the time, i.e. it should be rather a compromise.
> 
> 1) Number of lazy pages directly influence on busy list length
> thus on operations like: allocation, lookup, unmap, remove, etc.
> 
> 2) Under heavy stress of vmalloc subsystem i run into a situation
> when memory usage gets increased hitting out_of_memory -> panic
> state due to completely blocking of logic that frees vmap areas
> in the __purge_vmap_area_lazy() function.
> 
> Establish a threshold passing which the freeing is prioritized
> back over allocation creating a balance between each other.

It would be useful to credit the vmalloc test driver for this
discovery, and perhaps to identify specifically which test triggered
the kernel misbehaviour.  Please send along suitable words and I'll add
them.


> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -661,23 +661,27 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  	struct llist_node *valist;
>  	struct vmap_area *va;
>  	struct vmap_area *n_va;
> -	bool do_free = false;
> +	int resched_threshold;
>  
>  	lockdep_assert_held(&vmap_purge_lock);
>  
>  	valist = llist_del_all(&vmap_purge_list);
> +	if (unlikely(valist == NULL))
> +		return false;

Why this change?

> +	/*
> +	 * TODO: to calculate a flush range without looping.
> +	 * The list can be up to lazy_max_pages() elements.
> +	 */

How important is this?

>  	llist_for_each_entry(va, valist, purge_list) {
>  		if (va->va_start < start)
>  			start = va->va_start;
>  		if (va->va_end > end)
>  			end = va->va_end;
> -		do_free = true;
>  	}
>  
> -	if (!do_free)
> -		return false;
> -
>  	flush_tlb_kernel_range(start, end);
> +	resched_threshold = (int) lazy_max_pages() << 1;

Is the typecast really needed?

Perhaps resched_threshold shiould have unsigned long type and perhaps
vmap_lazy_nr should be atomic_long_t?

>  	spin_lock(&vmap_area_lock);
>  	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
> @@ -685,7 +689,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  
>  		__free_vmap_area(va);
>  		atomic_sub(nr, &vmap_lazy_nr);
> -		cond_resched_lock(&vmap_area_lock);
> +
> +		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
> +			cond_resched_lock(&vmap_area_lock);
>  	}
>  	spin_unlock(&vmap_area_lock);
>  	return true;

