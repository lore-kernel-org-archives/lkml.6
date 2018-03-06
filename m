Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeCFVJL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:09:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeCFVJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:09:09 -0500
X-Google-Smtp-Source: AG47ELshoxLRbwqi2m+UdEM638+P5FdpAAcrmsxUtm4nLkAqW4dVzerT1pX3+nUTqFElQlt2ugigYcl5kkBIFWIueZI=
MIME-Version: 1.0
In-Reply-To: <20180306125604.c394a25a50cae0e36c546855@linux-foundation.org>
References: <20180306192022.28289-1-pasha.tatashin@oracle.com>
 <20180306123655.957e5b6b20b200505544ea7a@linux-foundation.org>
 <CAGM2rea1raxsXDkqZgmmdBiuywp1M3y1p++=J893VJDgGDWLnQ@mail.gmail.com> <20180306125604.c394a25a50cae0e36c546855@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 6 Mar 2018 16:04:06 -0500
X-Gmail-Original-Message-ID: <CAGM2rebb9FdceEBO2GfJ7BKf=fEf8p86Yc1vCq4eZyyB0Me+DA@mail.gmail.com>
Message-ID: <CAGM2rebb9FdceEBO2GfJ7BKf=fEf8p86Yc1vCq4eZyyB0Me+DA@mail.gmail.com>
Subject: Re: [PATCH] mm: might_sleep warning
To: Andrew Morton <akpm@linux-foundation.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >       spin_lock(&deferred_zone_grow_lock);
> > > > -     static_branch_disable(&deferred_pages);
> > > > +     deferred_zone_grow = false;
> > > >       spin_unlock(&deferred_zone_grow_lock);
> > > > +     static_branch_disable(&deferred_pages);
> > > >
> > > >       /* There will be num_node_state(N_MEMORY) threads */
> > > >       atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
> > >
> > > Kinda ugly, but I can see the logic behind the decisions.
> > >
> > > Can we instead turn deferred_zone_grow_lock into a mutex?
>
> (top-posting repaired.  Please don't top-post).
>
> > [CCed everyone]
> >
> > Hi Andrew,
> >
> > I afraid we cannot change this spinlock to mutex
> > because deferred_grow_zone() might be called from an interrupt context if
> > interrupt thread needs to allocate memory.
> >
>
> OK.  But if deferred_grow_zone() can be called from interrupt then
> page_alloc_init_late() should be using spin_lock_irq(), shouldn't it?
> I'm surprised that lockdep didn't detect that.

No, page_alloc_init_late()  cannot be called from interrupt, it is
called straight from:
kernel_init_freeable(). But, I believe deferred_grow_zone(): can be called:

get_page_from_freelist()
 _deferred_grow_zone()
   deferred_grow_zone()


>
>
>
> --- a/mm/page_alloc.c~mm-initialize-pages-on-demand-during-boot-fix-4-fix
> +++ a/mm/page_alloc.c
> @@ -1689,9 +1689,9 @@ void __init page_alloc_init_late(void)
>          * context. Since, spin_lock() disables preemption, we must use an
>          * extra boolean deferred_zone_grow.
>          */
> -       spin_lock(&deferred_zone_grow_lock);
> +       spin_lock_irq(&deferred_zone_grow_lock);
>         deferred_zone_grow = false;
> -       spin_unlock(&deferred_zone_grow_lock);
> +       spin_unlock_irq(&deferred_zone_grow_lock);
>         static_branch_disable(&deferred_pages);
>
>         /* There will be num_node_state(N_MEMORY) threads */
> _
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
