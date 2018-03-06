Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeCFUg7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:36:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeCFUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:36:58 -0500
Date: Tue, 6 Mar 2018 12:36:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: might_sleep warning
Message-Id: <20180306123655.957e5b6b20b200505544ea7a@linux-foundation.org>
In-Reply-To: <20180306192022.28289-1-pasha.tatashin@oracle.com>
References: <20180306192022.28289-1-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Mar 2018 14:20:22 -0500 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> Robot reported this issue:
> https://lkml.org/lkml/2018/2/27/851
> 
> That is introduced by:
> mm: initialize pages on demand during boot
> 
> The problem is caused by changing static branch value within spin lock.
> Spin lock disables preemption, and changing static branch value takes
> mutex lock in its path, and thus may sleep.
> 
> The fix is to add another boolean variable to avoid the need to change
> static branch within spinlock.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1579,6 +1579,7 @@ static int __init deferred_init_memmap(void *data)
>   * page_alloc_init_late() soon after smp_init() is complete.
>   */
>  static __initdata DEFINE_SPINLOCK(deferred_zone_grow_lock);
> +static bool deferred_zone_grow __initdata = true;
>  static DEFINE_STATIC_KEY_TRUE(deferred_pages);
>  
>  /*
> @@ -1616,7 +1617,7 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  	 * Bail if we raced with another thread that disabled on demand
>  	 * initialization.
>  	 */
> -	if (!static_branch_unlikely(&deferred_pages)) {
> +	if (!static_branch_unlikely(&deferred_pages) || !deferred_zone_grow) {
>  		spin_unlock_irqrestore(&deferred_zone_grow_lock, flags);
>  		return false;
>  	}
> @@ -1683,10 +1684,15 @@ void __init page_alloc_init_late(void)
>  	/*
>  	 * We are about to initialize the rest of deferred pages, permanently
>  	 * disable on-demand struct page initialization.
> +	 *
> +	 * Note: it is prohibited to modify static branches in non-preemptible
> +	 * context. Since, spin_lock() disables preemption, we must use an
> +	 * extra boolean deferred_zone_grow.
>  	 */
>  	spin_lock(&deferred_zone_grow_lock);
> -	static_branch_disable(&deferred_pages);
> +	deferred_zone_grow = false;
>  	spin_unlock(&deferred_zone_grow_lock);
> +	static_branch_disable(&deferred_pages);
>  
>  	/* There will be num_node_state(N_MEMORY) threads */
>  	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));

Kinda ugly, but I can see the logic behind the decisions.

Can we instead turn deferred_zone_grow_lock into a mutex?
