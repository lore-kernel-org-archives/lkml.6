Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754019AbeCFU4H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:56:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:32990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeCFU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:56:06 -0500
Date: Tue, 6 Mar 2018 12:56:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: might_sleep warning
Message-Id: <20180306125604.c394a25a50cae0e36c546855@linux-foundation.org>
In-Reply-To: <CAGM2rea1raxsXDkqZgmmdBiuywp1M3y1p++=J893VJDgGDWLnQ@mail.gmail.com>
References: <20180306192022.28289-1-pasha.tatashin@oracle.com>
        <20180306123655.957e5b6b20b200505544ea7a@linux-foundation.org>
        <CAGM2rea1raxsXDkqZgmmdBiuywp1M3y1p++=J893VJDgGDWLnQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 15:48:26 -0500 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> On Tue, Mar 6, 2018 at 3:36 PM, Andrew Morton <akpm@linux-foundation.org>
> wrote:
> 
> > On Tue,  6 Mar 2018 14:20:22 -0500 Pavel Tatashin <
> > pasha.tatashin@oracle.com> wrote:
> >
> > >       spin_lock(&deferred_zone_grow_lock);
> > > -     static_branch_disable(&deferred_pages);
> > > +     deferred_zone_grow = false;
> > >       spin_unlock(&deferred_zone_grow_lock);
> > > +     static_branch_disable(&deferred_pages);
> > >
> > >       /* There will be num_node_state(N_MEMORY) threads */
> > >       atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
> >
> > Kinda ugly, but I can see the logic behind the decisions.
> >
> > Can we instead turn deferred_zone_grow_lock into a mutex?

(top-posting repaired.  Please don't top-post).

> [CCed everyone]
> 
> Hi Andrew,
> 
> I afraid we cannot change this spinlock to mutex
> because deferred_grow_zone() might be called from an interrupt context if
> interrupt thread needs to allocate memory.
> 

OK.  But if deferred_grow_zone() can be called from interrupt then
page_alloc_init_late() should be using spin_lock_irq(), shouldn't it? 
I'm surprised that lockdep didn't detect that.


--- a/mm/page_alloc.c~mm-initialize-pages-on-demand-during-boot-fix-4-fix
+++ a/mm/page_alloc.c
@@ -1689,9 +1689,9 @@ void __init page_alloc_init_late(void)
 	 * context. Since, spin_lock() disables preemption, we must use an
 	 * extra boolean deferred_zone_grow.
 	 */
-	spin_lock(&deferred_zone_grow_lock);
+	spin_lock_irq(&deferred_zone_grow_lock);
 	deferred_zone_grow = false;
-	spin_unlock(&deferred_zone_grow_lock);
+	spin_unlock_irq(&deferred_zone_grow_lock);
 	static_branch_disable(&deferred_pages);
 
 	/* There will be num_node_state(N_MEMORY) threads */
_
