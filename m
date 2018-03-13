Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934395AbeCMQFx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:05:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37352 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934168AbeCMQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:05:36 -0400
Date: Tue, 13 Mar 2018 12:04:30 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [v5 1/2] mm: disable interrupts while initializing deferred pages
Message-ID: <20180313160430.hbjnyiazadt3jwa6@xakep.localdomain>
References: <20180309220807.24961-1-pasha.tatashin@oracle.com>
 <20180309220807.24961-2-pasha.tatashin@oracle.com>
 <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=780
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> > +/* Disable interrupts and save previous IRQ state in flags before locking */
> > +static inline
> > +void pgdat_resize_lock_irq(struct pglist_data *pgdat, unsigned long *flags)
> > +{
> > +	unsigned long tmp_flags;
> > +
> > +	local_irq_save(*flags);
> > +	local_irq_disable();
> > +	pgdat_resize_lock(pgdat, &tmp_flags);
> > +}
> 
> As far as I can tell, this ugly-looking thing is identical to
> pgdat_resize_lock().

I will get rid of it, and use pgdat_resize_lock(). My confusion was that I
thought that local_irq_save() only saves the IRQ flags does not disable
them.

> 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1506,7 +1506,6 @@ static void __init deferred_free_pages(int nid, int zid, unsigned long pfn,
> >  		} else if (!(pfn & nr_pgmask)) {
> >  			deferred_free_range(pfn - nr_free, nr_free);
> >  			nr_free = 1;
> > -			cond_resched();
> >  		} else {
> >  			nr_free++;
> 
> And how can we simply remove these cond_resched()s?  I assume this is
> being done because interrupts are now disabled?  But those were there
> for a reason, weren't they?

We must remove cond_resched() because we can't sleep anymore. They were
added to fight NMI timeouts, so I will replace them with
touch_nmi_watchdog() in a follow-up fix.

Thank you for your review,
Pavel
