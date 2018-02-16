Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbeBPXi0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 18:38:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeBPXiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 18:38:25 -0500
Date: Fri, 16 Feb 2018 15:38:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Huang\, Ying" <ying.huang@intel.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>, Shaohua Li <shli@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, jglisse@redhat.com,
        Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Jiang <dave.jiang@intel.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH -mm -v5 RESEND] mm, swap: Fix race between swapoff and
 some swap operations
Message-Id: <20180216153823.ad74f1d2c157adc67ed2c970@linux-foundation.org>
In-Reply-To: <87fu64jthz.fsf@yhuang-dev.intel.com>
References: <20180213014220.2464-1-ying.huang@intel.com>
        <20180213154123.9f4ef9e406ea8365ca46d9c5@linux-foundation.org>
        <87fu64jthz.fsf@yhuang-dev.intel.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018 08:38:00 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Tue, 13 Feb 2018 09:42:20 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> >
> >> From: Huang Ying <ying.huang@intel.com>
> >> 
> >> When the swapin is performed, after getting the swap entry information
> >> from the page table, system will swap in the swap entry, without any
> >> lock held to prevent the swap device from being swapoff.  This may
> >> cause the race like below,
> >
> > Sigh.  In terms of putting all the work into the swapoff path and
> > avoiding overheads in the hot paths, I guess this is about as good as
> > it will get.
> >
> > It's a very low-priority fix so I'd prefer to keep the patch in -mm
> > until Hugh has had an opportunity to think about it.
> >
> >> ...
> >>  
> >> +/*
> >> + * Check whether swap entry is valid in the swap device.  If so,
> >> + * return pointer to swap_info_struct, and keep the swap entry valid
> >> + * via preventing the swap device from being swapoff, until
> >> + * put_swap_device() is called.  Otherwise return NULL.
> >> + */
> >> +struct swap_info_struct *get_swap_device(swp_entry_t entry)
> >> +{
> >> +	struct swap_info_struct *si;
> >> +	unsigned long type, offset;
> >> +
> >> +	if (!entry.val)
> >> +		goto out;
> >> +	type = swp_type(entry);
> >> +	if (type >= nr_swapfiles)
> >> +		goto bad_nofile;
> >> +	si = swap_info[type];
> >> +
> >> +	preempt_disable();
> >
> > This preempt_disable() is later than I'd expect.  If a well-timed race
> > occurs, `si' could now be pointing at a defunct entry.  If that
> > well-timed race include a swapoff AND a swapon, `si' could be pointing
> > at the info for a new device?
> 
> struct swap_info_struct pointed to by swap_info[] will never be freed.
> During swapoff, we only free the memory pointed to by the fields of
> struct swap_info_struct.  And when swapon, we will always reuse
> swap_info[type] if it's not NULL.  So it should be safe to dereference
> swap_info[type] with preemption enabled.

That's my point.  If there's a race window during which there is a
parallel swapoff+swapon, this swap_info_struct may now be in use for a
different device?
