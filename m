Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbeCBVXh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 16:23:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933732AbeCBVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 16:23:34 -0500
Date: Fri, 2 Mar 2018 13:23:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 2/3] mm/free_pcppages_bulk: do not hold lock when
 picking pages to free
Message-Id: <20180302132332.2c69559686ff24d15ff44ae8@linux-foundation.org>
In-Reply-To: <20180302080125.GB6356@intel.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
        <20180301062845.26038-3-aaron.lu@intel.com>
        <20180301160105.aca958fac871998d582307d4@linux-foundation.org>
        <20180302080125.GB6356@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018 16:01:25 +0800 Aaron Lu <aaron.lu@intel.com> wrote:

> On Thu, Mar 01, 2018 at 04:01:05PM -0800, Andrew Morton wrote:
> > On Thu,  1 Mar 2018 14:28:44 +0800 Aaron Lu <aaron.lu@intel.com> wrote:
> > 
> > > When freeing a batch of pages from Per-CPU-Pages(PCP) back to buddy,
> > > the zone->lock is held and then pages are chosen from PCP's migratetype
> > > list. While there is actually no need to do this 'choose part' under
> > > lock since it's PCP pages, the only CPU that can touch them is us and
> > > irq is also disabled.
> > > 
> > > Moving this part outside could reduce lock held time and improve
> > > performance. Test with will-it-scale/page_fault1 full load:
> > > 
> > > kernel      Broadwell(2S)  Skylake(2S)   Broadwell(4S)  Skylake(4S)
> > > v4.16-rc2+  9034215        7971818       13667135       15677465
> > > this patch  9536374 +5.6%  8314710 +4.3% 14070408 +3.0% 16675866 +6.4%
> > > 
> > > What the test does is: starts $nr_cpu processes and each will repeatedly
> > > do the following for 5 minutes:
> > > 1 mmap 128M anonymouse space;
> > > 2 write access to that space;
> > > 3 munmap.
> > > The score is the aggregated iteration.
> > 
> > But it's a loss for uniprocessor systems: it adds more code and adds an
> > additional pass across a list.
> 
> Performance wise, I assume the loss is pretty small and can not
> be measured.
> 
> On my Sandybridge desktop, with will-it-scale/page_fault1/single process
> run to emulate uniprocessor system, the score is(average of 3 runs):
> 
> base(patch 1/3):	649710 
> this patch:		653554 +0.6%

Does that mean we got faster or slower?

> prefetch(patch 3/3):	650336 (in noise range compared to base)
> 
> On 4 sockets Intel Broadwell with will-it-scale/page_fault1/single
> process run:
> 
> base(patch 1/3):	498649
> this patch:		504171 +1.1%
> prefetch(patch 3/3): 	506334 +1.5% (compared to base)
> 
> It looks like we don't need to worry too much about performance for
> uniprocessor system.

Well.  We can say that of hundreds of patches.  And we end up with a
fatter and slower kernel than we otherwise would.

Please take a look, see if there's a tidy way of avoiding this. 
Probably there isn't, in which case oh well.  But let's at least try.
