Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCZDCr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 23:02:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:19598 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbeCZDCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 23:02:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,363,1517904000";
   d="scan'208";a="45249143"
Date: Mon, 26 Mar 2018 11:03:45 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 2/3] mm/free_pcppages_bulk: do not hold lock when
 picking pages to free
Message-ID: <20180326030344.GA30075@intel.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-3-aaron.lu@intel.com>
 <9cad642d-9fe5-b2c3-456c-279065c32337@suse.cz>
 <20180313033453.GB13782@intel.com>
 <20180322151719.GA28468@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322151719.GA28468@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 08:17:19AM -0700, Matthew Wilcox wrote:
> On Tue, Mar 13, 2018 at 11:34:53AM +0800, Aaron Lu wrote:
> > I wish there is a data structure that has the flexibility of list while
> > at the same time we can locate the Nth element in the list without the
> > need to iterate. That's what I'm looking for when developing clustered
> > allocation for order 0 pages. In the end, I had to use another place to
> > record where the Nth element is. I hope to send out v2 of that RFC
> > series soon but I'm still collecting data for it. I would appreciate if
> > people could take a look then :-)
> 
> Sorry, I missed this.  There is such a data structure -- the IDR, or
> possibly a bare radix tree, or we can build a better data structure on
> top of the radix tree (I talked about one called the XQueue a while ago).
> 
> The IDR will automatically grow to whatever needed size, it stores
> pointers, you can find out quickly where the last allocated index is,
> you can remove from the middle of the array.  Disadvantage is that it
> requires memory allocation to store the array of pointers, *but* it
> can always hold at least one entry.  So if you have no memory, you can
> always return the one element in your IDR to the free pool and allocate
> from that page.

Thanks for the pointer, will take a look later.
Currently I'm focusing on finding real workloads that have zone lock
contention issue.
