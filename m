Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBWBlx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:41:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:14249 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbeBWBlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:41:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,381,1515484800";
   d="scan'208";a="177406629"
Date: Fri, 23 Feb 2018 09:42:46 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/2] free_pcppages_bulk: do not hold lock when picking
 pages to free
Message-ID: <20180223014245.GB4338@intel.com>
References: <20180124023050.20097-1-aaron.lu@intel.com>
 <20180124163926.c7ptagn655aeiut3@techsingularity.net>
 <20180125072144.GA27678@intel.com>
 <20180215124644.GA12360@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215124644.GA12360@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:46:44AM -0800, Matthew Wilcox wrote:
> On Thu, Jan 25, 2018 at 03:21:44PM +0800, Aaron Lu wrote:
> > When freeing a batch of pages from Per-CPU-Pages(PCP) back to buddy,
> > the zone->lock is held and then pages are chosen from PCP's migratetype
> > list. While there is actually no need to do this 'choose part' under
> > lock since it's PCP pages, the only CPU that can touch them is us and
> > irq is also disabled.
> 
> I have no objection to this patch.  If you're looking for ideas for
> future improvement though, I wonder whether using a LIST_HEAD is the
> best way to store these pages temporarily.  If you batch them into a
> pagevec and then free the entire pagevec, the CPU should be a little
> faster scanning a short array than walking a linked list.

Thanks for the suggestion.

> It would also puts a hard boundary on how long zone->lock is held, as
> you'd drop it and go back for another batch after 15 pages.  That might
> be bad, of course.

Yes that's a concern.
As Mel reponded in another email, I think I'll just keep using list
here.

> 
> Another minor change I'd like to see is free_pcpages_bulk updating
> pcp->count itself; all of the callers do it currently.

Sounds good, I'll prepare a separate patch for this, thanks!
