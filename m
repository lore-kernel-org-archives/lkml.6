Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8282075C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8282075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKJJli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:41:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:65099 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbeKJJli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:41:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 15:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,485,1534834800"; 
   d="scan'208";a="90911917"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2018 15:58:42 -0800
Message-ID: <d511ee6a18da13b9543557db783e6ff3327ca87b.camel@linux.intel.com>
Subject: Re: [mm PATCH v5 3/7] mm: Implement new zone specific memblock
 iterator
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Date:   Fri, 09 Nov 2018 15:58:42 -0800
In-Reply-To: <20181109232654.bi37bdkrqbogbdcx@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
         <154145278071.30046.9022571960145979137.stgit@ahduyck-desk1.jf.intel.com>
         <20181109232654.bi37bdkrqbogbdcx@xakep.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-09 at 18:26 -0500, Pavel Tatashin wrote:
> > +/**
> > + * for_each_free_mem_range_in_zone - iterate through zone specific free
> > + * memblock areas
> > + * @i: u64 used as loop variable
> > + * @zone: zone in which all of the memory blocks reside
> > + * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
> > + * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
> > + *
> > + * Walks over free (memory && !reserved) areas of memblock in a specific
> > + * zone. Available as soon as memblock is initialized.
> > + */
> > +#define for_each_free_mem_pfn_range_in_zone(i, zone, p_start, p_end)	\
> > +	for (i = 0,							\
> > +	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end);	\
> > +	     i != (u64)ULLONG_MAX;					\
> > +	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
> > +#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
> 
> Use U64_MAX instead of ULLONG_MAX, and avoid u64 cast. I know other
> places in this file use UULONG_MAX with cast, but I think U64_MAX is
> better.

Okay, maybe I will submit a follow up that just cleans all of these up.

> > +
> >  /**
> >   * for_each_free_mem_range - iterate through free memblock areas
> >   * @i: u64 used as loop variable
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 7df468c8ebc8..f1d1fbfd1ae7 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1239,6 +1239,69 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
> >  	return 0;
> >  }
> >  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > +/**
> > + * __next_mem_pfn_range_in_zone - iterator for for_each_*_range_in_zone()
> > + *
> > + * @idx: pointer to u64 loop variable
> > + * @zone: zone in which all of the memory blocks reside
> > + * @out_start: ptr to ulong for start pfn of the range, can be %NULL
> > + * @out_end: ptr to ulong for end pfn of the range, can be %NULL
> > + *
> > + * This function is meant to be a zone/pfn specific wrapper for the
> > + * for_each_mem_range type iterators. Specifically they are used in the
> > + * deferred memory init routines and as such we were duplicating much of
> > + * this logic throughout the code. So instead of having it in multiple
> > + * locations it seemed like it would make more sense to centralize this to
> > + * one new iterator that does everything they need.
> > + */
> > +void __init_memblock
> > +__next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
> > +			     unsigned long *out_spfn, unsigned long *out_epfn)
> > +{
> > +	int zone_nid = zone_to_nid(zone);
> > +	phys_addr_t spa, epa;
> > +	int nid;
> > +
> > +	__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
> > +			 &memblock.memory, &memblock.reserved,
> > +			 &spa, &epa, &nid);
> > +
> > +	while (*idx != ULLONG_MAX) {
> 
> Ditto, use U64_MAX

Same here.

> > +		unsigned long epfn = PFN_DOWN(epa);
> > +		unsigned long spfn = PFN_UP(spa);
> > +
> > +		/*
> > +		 * Verify the end is at least past the start of the zone and
> > +		 * that we have at least one PFN to initialize.
> > +		 */
> > +		if (zone->zone_start_pfn < epfn && spfn < epfn) {
> > +			/* if we went too far just stop searching */
> > +			if (zone_end_pfn(zone) <= spfn)
> > +				break;
> 
> Set *idx = U64_MAX here, then break. This way after we are outside this
> while loop idx is always equals to U64_MAX.

Actually I think what you are asking for is the logic that is outside
of the while loop we are breaking out of. So if you check at the end of
the function there is the bit of code with the comment "signal end of
iteration" where I end up setting *idx to ULLONG_MAX, *out_spfn to
ULONG_MAX, and *out_epfn to 0.

The general idea I had with the function is that you could use either
the index or spfn < epfn checks to determine if you keep going or not.

> 
> > +
> > +			if (out_spfn)
> > +				*out_spfn = max(zone->zone_start_pfn, spfn);
> > +			if (out_epfn)
> > +				*out_epfn = min(zone_end_pfn(zone), epfn);
> 
> Don't we need to verify after adjustment that out_spfn != out_epfn, so
> there is at least one PFN to initialize?

We have a few checks that I believe prevent that. Before we get to this
point we have verified the following:
	zone->zone_start < epfn
	spfn < epfn

The other check that should be helping to prevent that is the break
statement above that is forcing us to exit if spfn is somehow already
past the end of the zone, that essentially maps out:
	spfn < zone_end_pfn(zone)

So the only check we don't have is:
	zone->zone_start < zone_end_pfn(zone)

If I am not mistaken that is supposed to be a given is it not? I would
assume we don't have any zones that are completely empty or inverted
that would be called here do we?

> The rest looks good. Once the above is fixed:
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Thank you,
> Pasha

Thanks for the feedback.

- Alex

