Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752476AbeCMSzw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:55:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCMSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:55:51 -0400
Date: Tue, 13 Mar 2018 11:55:49 -0700
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
Message-Id: <20180313115549.7badec1c6b85eb5a1cf21eb6@linux-foundation.org>
In-Reply-To: <20180313160430.hbjnyiazadt3jwa6@xakep.localdomain>
References: <20180309220807.24961-1-pasha.tatashin@oracle.com>
        <20180309220807.24961-2-pasha.tatashin@oracle.com>
        <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
        <20180313160430.hbjnyiazadt3jwa6@xakep.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 12:04:30 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> > 
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1506,7 +1506,6 @@ static void __init deferred_free_pages(int nid, int zid, unsigned long pfn,
> > >  		} else if (!(pfn & nr_pgmask)) {
> > >  			deferred_free_range(pfn - nr_free, nr_free);
> > >  			nr_free = 1;
> > > -			cond_resched();
> > >  		} else {
> > >  			nr_free++;
> > 
> > And how can we simply remove these cond_resched()s?  I assume this is
> > being done because interrupts are now disabled?  But those were there
> > for a reason, weren't they?
> 
> We must remove cond_resched() because we can't sleep anymore. They were
> added to fight NMI timeouts, so I will replace them with
> touch_nmi_watchdog() in a follow-up fix.

This makes no sense.  Any code section where we can add cond_resched()
was never subject to NMI timeouts because that code cannot be running with
disabled interrupts.
