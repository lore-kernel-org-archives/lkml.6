Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5976E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5976E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbeKVBGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:06:25 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:41079 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728283AbeKVBGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:06:25 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id E09D71C2292
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:31:42 +0000 (GMT)
Received: (qmail 25382 invoked from network); 21 Nov 2018 14:31:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Nov 2018 14:31:42 -0000
Date:   Wed, 21 Nov 2018 14:31:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm, page_alloc: Spread allocations across zones
 before introducing fragmentation
Message-ID: <20181121143141.GJ23260@techsingularity.net>
References: <20181121101414.21301-1-mgorman@techsingularity.net>
 <20181121101414.21301-2-mgorman@techsingularity.net>
 <7c053d34-fd3f-ca10-6ad7-a9d85652626f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7c053d34-fd3f-ca10-6ad7-a9d85652626f@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 03:18:28PM +0100, Vlastimil Babka wrote:
> > 1-socket Skylake machine
> > config-global-dhp__workload_thpfioscale XFS (no special madvise)
> > 4 fio threads, 1 THP allocating thread
> > --------------------------------------
> > 
> > 4.20-rc1 extfrag events < order 9:  1023463
> > 4.20-rc1+patch:                      358574 (65% reduction)
> 
> It would be nice to have also breakdown of what kind of extfrag events,
> mainly distinguish number of unmovable/reclaimable allocations
> fragmenting movable pageblocks, as those are the most critical ones.
> 

I can include that but bear in mind that the volume of data is already
extremely high. FWIW, the bulk of the fallbacks in this particular case
happen to be movable.

> > @@ -3253,6 +3268,36 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
> >  }
> >  #endif	/* CONFIG_NUMA */
> >  
> > +#ifdef CONFIG_ZONE_DMA32
> > +/*
> > + * The restriction on ZONE_DMA32 as being a suitable zone to use to avoid
> > + * fragmentation is subtle. If the preferred zone was HIGHMEM then
> > + * premature use of a lower zone may cause lowmem pressure problems that
> > + * are wose than fragmentation. If the next zone is ZONE_DMA then it is
> > + * probably too small. It only makes sense to spread allocations to avoid
> > + * fragmentation between the Normal and DMA32 zones.
> > + */
> > +static inline unsigned int alloc_flags_nofragment(struct zone *zone)
> > +{
> > +	if (zone_idx(zone) != ZONE_NORMAL)
> > +		return 0;
> > +
> > +	/*
> > +	 * If ZONE_DMA32 exists, assume it is the one after ZONE_NORMAL and
> > +	 * the pointer is within zone->zone_pgdat->node_zones[].
> > +	 */
> > +	if (!populated_zone(--zone))
> > +		return 0;
> 
> How about something along:
> BUILD_BUG_ON(ZONE_NORMAL - ZONE_DMA32 != 1);
> 

Good plan.

> Also is this perhaps going against your earlier efforts of speeding up
> the fast path, and maybe it would be faster to just stick a bool into
> struct zone, which would be set true once during zonelist build, only
> for a ZONE_NORMAL with ZONE_DMA32 in the same node?
> 

It does somewhat go against the previous work on the fast path but
we really did hit the limits of the microoptimisations there and the
longer-term consequences of fragmentation are potentially worse than a
few cycles in each fast path. The speedup we need for extremely high
network devices is much larger than a few cycles so I think we can take
the hit -- at least until a better idea comes along.

> > +
> > +	return ALLOC_NOFRAGMENT;
> > +}
> > +#else
> > +static inline unsigned int alloc_flags_nofragment(struct zone *zone)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  /*
> >   * get_page_from_freelist goes through the zonelist trying to allocate
> >   * a page.
> > @@ -3264,11 +3309,14 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
> >  	struct zoneref *z = ac->preferred_zoneref;
> >  	struct zone *zone;
> >  	struct pglist_data *last_pgdat_dirty_limit = NULL;
> > +	bool no_fallback;
> >  
> > +retry:
> 
> Ugh, I think 'z = ac->preferred_zoneref' should be moved here under
> retry. AFAICS without that, the preference of local node to
> fragmentation avoidance doesn't work?
> 

Yup, you're right!

In the event of fragmentation of both normal and dma32 zone, it doesn't
restart on the local node and instead falls over to the remote node
prematurely. This is obviously not desirable. I'll give it and thanks
for spotting it.

-- 
Mel Gorman
SUSE Labs
