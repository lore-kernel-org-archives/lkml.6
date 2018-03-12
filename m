Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeCLUEN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:04:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLUEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:04:12 -0400
Date: Mon, 12 Mar 2018 13:04:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [v5 1/2] mm: disable interrupts while initializing deferred
 pages
Message-Id: <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
In-Reply-To: <20180309220807.24961-2-pasha.tatashin@oracle.com>
References: <20180309220807.24961-1-pasha.tatashin@oracle.com>
        <20180309220807.24961-2-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 17:08:06 -0500 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> Vlastimil Babka reported about a window issue during which when deferred
> pages are initialized, and the current version of on-demand initialization
> is finished, allocations may fail.  While this is highly unlikely scenario,
> since this kind of allocation request must be large, and must come from
> interrupt handler, we still want to cover it.
> 
> We solve this by initializing deferred pages with interrupts disabled, and
> holding node_size_lock spin lock while pages in the node are being
> initialized. The on-demand deferred page initialization that comes later
> will use the same lock, and thus synchronize with deferred_init_memmap().
> 
> It is unlikely for threads that initialize deferred pages to be
> interrupted.  They run soon after smp_init(), but before modules are
> initialized, and long before user space programs. This is why there is no
> adverse effect of having these threads running with interrupts disabled.
> 
> ...
>
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
>  
> +#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_DEFERRED_STRUCT_PAGE_INIT)
> +/*
> + * pgdat resizing functions
> + */
> +static inline
> +void pgdat_resize_lock(struct pglist_data *pgdat, unsigned long *flags)
> +{
> +	spin_lock_irqsave(&pgdat->node_size_lock, *flags);
> +}
> +static inline
> +void pgdat_resize_unlock(struct pglist_data *pgdat, unsigned long *flags)
> +{
> +	spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
> +}
> +static inline
> +void pgdat_resize_init(struct pglist_data *pgdat)
> +{
> +	spin_lock_init(&pgdat->node_size_lock);
> +}
> +
> +/* Disable interrupts and save previous IRQ state in flags before locking */
> +static inline
> +void pgdat_resize_lock_irq(struct pglist_data *pgdat, unsigned long *flags)
> +{
> +	unsigned long tmp_flags;
> +
> +	local_irq_save(*flags);
> +	local_irq_disable();
> +	pgdat_resize_lock(pgdat, &tmp_flags);
> +}

As far as I can tell, this ugly-looking thing is identical to
pgdat_resize_lock().

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1506,7 +1506,6 @@ static void __init deferred_free_pages(int nid, int zid, unsigned long pfn,
>  		} else if (!(pfn & nr_pgmask)) {
>  			deferred_free_range(pfn - nr_free, nr_free);
>  			nr_free = 1;
> -			cond_resched();
>  		} else {
>  			nr_free++;

And how can we simply remove these cond_resched()s?  I assume this is
being done because interrupts are now disabled?  But those were there
for a reason, weren't they?
