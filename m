Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbeCFMxI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:53:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeCFMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:53:06 -0500
Date: Tue, 6 Mar 2018 04:53:04 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 3/3] mm/free_pcppages_bulk: prefetch buddy while not
 holding lock
Message-ID: <20180306125303.GA13722@bombadil.infradead.org>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301140044.GK15057@dhcp22.suse.cz>
 <cb158b3d-c992-6679-24df-b37d2bb170e0@suse.cz>
 <20180305114159.GA32573@intel.com>
 <bdec481f-b402-64b6-75b0-350b370f3eac@suse.cz>
 <20180306122733.GA9664@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306122733.GA9664@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 08:27:33PM +0800, Aaron Lu wrote:
> On Tue, Mar 06, 2018 at 08:55:57AM +0100, Vlastimil Babka wrote:
> > So the adjacent line prefetch might be disabled? Could you check bios or
> > the MSR mentioned in
> > https://software.intel.com/en-us/articles/disclosure-of-hw-prefetcher-control-on-some-intel-processors
> 
> root@lkp-bdw-ep2 ~# rdmsr 0x1a4
> 0

Technically 0x1a4 is per-core, so you should run rdmsr -a 0x1a4 in order to
check all the cores.  But I can't imagine they're being set differently on
each core.

> > instructions (calculated from itlb misses and insns-per-itlb-miss) shows
> > less than 1% increase, so dunno. And the improvement comes from reduced
> > dTLB-load-misses? That makes no sense for order-0 buddy struct pages
> > which always share a page. And the memmap mapping should use huge pages.
> 
> THP is disabled to stress order 0 pages(should have mentioned this in
> patch's description, sorry about this).

THP isn't related to memmap; the kernel uses huge pages (usually the 1G
pages) in order to map its own memory.
