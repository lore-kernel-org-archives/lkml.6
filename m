Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162721AbeCAWzw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:55:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162589AbeCAWzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:55:51 -0500
Date: Thu, 1 Mar 2018 14:55:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <guro@fb.com>
Cc: <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC] mm: indirectly reclaimable memory and dcache
Message-Id: <20180301145549.8ff621a708ccd8fb59d924f7@linux-foundation.org>
In-Reply-To: <20180301221713.25969-1-guro@fb.com>
References: <20180301221713.25969-1-guro@fb.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 22:17:13 +0000 Roman Gushchin <guro@fb.com> wrote:

> I was reported about suspicious growth of unreclaimable slabs
> on some machines. I've found that it happens on machines
> with low memory pressure, and these unreclaimable slabs
> are external names attached to dentries.
> 
> External names are allocated using generic kmalloc() function,
> so they are accounted as unreclaimable. But they are held
> by dentries, which are reclaimable, and they will be reclaimed
> under the memory pressure.
> 
> In particular, this breaks MemAvailable calculation, as it
> doesn't take unreclaimable slabs into account.
> This leads to a silly situation, when a machine is almost idle,
> has no memory pressure and therefore has a big dentry cache.
> And the resulting MemAvailable is too low to start a new workload.
> 
> To resolve this issue, a new mm counter is introduced:
> NR_INDIRECTLY_RECLAIMABLE_BYTES .
> Since it's not possible to count such objects on per-page basis,
> let's make the unit obvious (by analogy to NR_KERNEL_STACK_KB).
> 
> The counter is increased in dentry allocation path, if an external
> name structure is allocated; and it's decreased in dentry freeing
> path. I believe, that it's not the only case in the kernel, when
> we do have such indirectly reclaimable memory, so I expect more
> use cases to be added.
> 
> This counter is used to adjust MemAvailable calculations:
> indirectly reclaimable memory is considered as available.
> 
> To reproduce the problem I've used the following Python script:
>   import os
> 
>   for iter in range (0, 10000000):
>       try:
>           name = ("/some_long_name_%d" % iter) + "_" * 220
>           os.stat(name)
>       except Exception:
>           pass
> 
> Without this patch:
>   $ cat /proc/meminfo | grep MemAvailable
>   MemAvailable:    7811688 kB
>   $ python indirect.py
>   $ cat /proc/meminfo | grep MemAvailable
>   MemAvailable:    2753052 kB
> 
> With the patch:
>   $ cat /proc/meminfo | grep MemAvailable
>   MemAvailable:    7809516 kB
>   $ python indirect.py
>   $ cat /proc/meminfo | grep MemAvailable
>   MemAvailable:    7749144 kB
> 
> Also, this patch adds a corresponding entry to /proc/vmstat:
> 
>   $ cat /proc/vmstat | grep indirect
>   nr_indirectly_reclaimable 5117499104
> 
>   $ echo 2 > /proc/sys/vm/drop_caches
> 
>   $ cat /proc/vmstat | grep indirect
>   nr_indirectly_reclaimable 7104

hm, I guess so...

I wonder if it should be more general, as there are probably other
potential users of NR_INDIRECTLY_RECLAIMABLE_BYTES.  And they might be
using alloc_pages() or even vmalloc()?  Whereas
NR_INDIRECTLY_RECLAIMABLE_BYTES is pretty closely tied to kmalloc, at
least in the code comments.

If we're really OK with the "only for kmalloc" concept then why create
NR_INDIRECTLY_RECLAIMABLE_BYTES at all?  Could we just use
NR_SLAB_RECLAIMABLE to account the external names?  After all, kmalloc
is slab.
