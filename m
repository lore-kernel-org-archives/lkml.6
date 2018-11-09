Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35105C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62F020883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IPjHIHNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62F020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeKJJJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:09:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33715 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeKJJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:09:44 -0500
Received: by mail-qk1-f195.google.com with SMTP id o89so4642980qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m9PAnTOd08pSiQIPc3bviF7/DRAFlnQ3yDM0KRJ7Syo=;
        b=IPjHIHNXY/knYtykIhU8zUpfubWHNMb5g2aXH27RAX7667/k0Su6u3C0HGJW0GOFtR
         hWb1X8/xSPWiYeOaAHOH0iy92HrODevp6JBx24gcqLuBGtcx086o1BCJMlDsCQ4qHIBQ
         MH/zpDR9XNZ5JFh4dFQeQCRvoyCF8k+z7/jx9Ipbph7lbW7fODfkF/AE4e2NdS71jdYG
         orNq8I3g43mPmHhQxokRq9NfyNwfffuVjwxlG4aBzss5qk+ySlZgL7i4u17a7WILS4LD
         m3uLMThutlWaJFB8ndw0muJcW06oaTRCeN9SCrXU8yjOIyCFd2if3KhAtR5JybFEx1QV
         8VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9PAnTOd08pSiQIPc3bviF7/DRAFlnQ3yDM0KRJ7Syo=;
        b=pyjzKcugdRuO7tQ7QzGFGgyQZuF8Y9SDz1NM30YOnQqTVivh/pl2ds1lk10QJ36WzO
         1kbByFkrreEG62trUcXwc1ChakcbpYCekzLslolqP23fgiK3AsStSRb5+MpoyjgalktD
         MViIJrvoOTTaSmlVYIET9T3qSQ/BZHVSRW/3zumZdVFUVlAsAb5PW8TPyarpww0zRw1p
         UjLZU8PMeqn5S30Um6RsRR8mcu4ssQYqlIm2JqScjKr1QKtIL3/mHWawIFFOXfIe/UEu
         h3idIIVKgn5Lh/0dWpnU2u7wK+Dd0yp8yAmu6qU7NE62efGlD9VHrfYM35WRFubX5EyL
         TzPg==
X-Gm-Message-State: AGRZ1gIlUBUveVGk+0XwatGflV0aybjWGYMIj3O1jVu7EyKfO3yhzyHp
        9CIHhxikpN6Nl5cP6i8BSLZauA==
X-Google-Smtp-Source: AJdET5fSR0yXcOwiPXz9u5/Fp+71Wl5VHt6DP5hWgHgF5iBkFpTav6prLZbVc/nm+G48zoSPgQrwnQ==
X-Received: by 2002:a37:a7c3:: with SMTP id q186mr10409917qke.89.1541806017501;
        Fri, 09 Nov 2018 15:26:57 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i65sm6725824qkh.49.2018.11.09.15.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 15:26:55 -0800 (PST)
Date:   Fri, 9 Nov 2018 18:26:54 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 3/7] mm: Implement new zone specific memblock
 iterator
Message-ID: <20181109232654.bi37bdkrqbogbdcx@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145278071.30046.9022571960145979137.stgit@ahduyck-desk1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154145278071.30046.9022571960145979137.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/**
> + * for_each_free_mem_range_in_zone - iterate through zone specific free
> + * memblock areas
> + * @i: u64 used as loop variable
> + * @zone: zone in which all of the memory blocks reside
> + * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
> + *
> + * Walks over free (memory && !reserved) areas of memblock in a specific
> + * zone. Available as soon as memblock is initialized.
> + */
> +#define for_each_free_mem_pfn_range_in_zone(i, zone, p_start, p_end)	\
> +	for (i = 0,							\
> +	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end);	\
> +	     i != (u64)ULLONG_MAX;					\
> +	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
> +#endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */

Use U64_MAX instead of ULLONG_MAX, and avoid u64 cast. I know other
places in this file use UULONG_MAX with cast, but I think U64_MAX is
better.

> +
>  /**
>   * for_each_free_mem_range - iterate through free memblock areas
>   * @i: u64 used as loop variable
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7df468c8ebc8..f1d1fbfd1ae7 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1239,6 +1239,69 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
>  	return 0;
>  }
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +/**
> + * __next_mem_pfn_range_in_zone - iterator for for_each_*_range_in_zone()
> + *
> + * @idx: pointer to u64 loop variable
> + * @zone: zone in which all of the memory blocks reside
> + * @out_start: ptr to ulong for start pfn of the range, can be %NULL
> + * @out_end: ptr to ulong for end pfn of the range, can be %NULL
> + *
> + * This function is meant to be a zone/pfn specific wrapper for the
> + * for_each_mem_range type iterators. Specifically they are used in the
> + * deferred memory init routines and as such we were duplicating much of
> + * this logic throughout the code. So instead of having it in multiple
> + * locations it seemed like it would make more sense to centralize this to
> + * one new iterator that does everything they need.
> + */
> +void __init_memblock
> +__next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
> +			     unsigned long *out_spfn, unsigned long *out_epfn)
> +{
> +	int zone_nid = zone_to_nid(zone);
> +	phys_addr_t spa, epa;
> +	int nid;
> +
> +	__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
> +			 &memblock.memory, &memblock.reserved,
> +			 &spa, &epa, &nid);
> +
> +	while (*idx != ULLONG_MAX) {

Ditto, use U64_MAX

> +		unsigned long epfn = PFN_DOWN(epa);
> +		unsigned long spfn = PFN_UP(spa);
> +
> +		/*
> +		 * Verify the end is at least past the start of the zone and
> +		 * that we have at least one PFN to initialize.
> +		 */
> +		if (zone->zone_start_pfn < epfn && spfn < epfn) {
> +			/* if we went too far just stop searching */
> +			if (zone_end_pfn(zone) <= spfn)
> +				break;

Set *idx = U64_MAX here, then break. This way after we are outside this
while loop idx is always equals to U64_MAX.

> +
> +			if (out_spfn)
> +				*out_spfn = max(zone->zone_start_pfn, spfn);
> +			if (out_epfn)
> +				*out_epfn = min(zone_end_pfn(zone), epfn);

Don't we need to verify after adjustment that out_spfn != out_epfn, so
there is at least one PFN to initialize?

The rest looks good. Once the above is fixed:

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
