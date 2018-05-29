Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965679AbeE2R4K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:56:10 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:52604 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965605AbeE2R4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:56:08 -0400
Date: Tue, 29 May 2018 13:58:06 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 0/5] kmalloc-reclaimable caches
Message-ID: <20180529175806.GA28689@cmpxchg.org>
References: <20180524110011.1940-1-vbabka@suse.cz>
 <20180524153225.GA7329@cmpxchg.org>
 <fcdcf7be-afd1-9747-d97e-51cd071d3f5c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcdcf7be-afd1-9747-d97e-51cd071d3f5c@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:15:46AM +0200, Vlastimil Babka wrote:
> On 05/24/2018 05:32 PM, Johannes Weiner wrote:
> > On Thu, May 24, 2018 at 01:00:06PM +0200, Vlastimil Babka wrote:
> >> - the vmstat/meminfo counter name is rather general and might suggest it also
> >>   includes reclaimable page caches, which it doesn't
> >>
> >> Suggestions welcome for all three points. For the last one, we might also keep
> >> the counter separate from nr_slab_reclaimable, not superset. I did a superset
> >> as IIRC somebody suggested that in the older threads or at LSF.
> > 
> > Yeah, the "reclaimable" name is too generic. How about KReclaimable?
> > 
> > The counter being a superset sounds good to me. We use this info for
> > both load balancing and manual debugging. For load balancing code it's
> > nice not having to worry about finding all the counters that hold
> > reclaimable memory depending on kernel version; it's always simply
> > user cache + user anon + kernel reclaimable. And for debugging, we can
> > always add more specific subset counters later on if we need them.
> 
> Hm, Christoph in his reply to patch 4/5 expressed a different opinion.
> It's true that updating two counters has extra overhead, especially if
> there are two separate critical sections:
> 
> mod_lruvec_page_state(page, NR_SLAB_RECLAIMABLE, nr_pages);
> mod_node_page_state(page_pgdat(page), NR_RECLAIMABLE, nr_pages);
> 
> The first disables irq for CONFIG_MEMCG or defers to
> mod_node_page_state() otherwise.
> mod_node_page_state() is different depending on CONFIG_SMP and
> CONFIG_HAVE_CMPXCHG_LOCAL.
> 
> I don't see an easy way to make this optimal? Different counter would be
> indeed simpler. /proc/vmstat would then print separate counters, but we
> could have both separate and summary counter in /proc/meminfo. Would
> that be enough?

Yeah, that works just as well.
