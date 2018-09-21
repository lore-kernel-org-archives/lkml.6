Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3459C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACDD2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACDD2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbeIVByL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:54:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:26225 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391089AbeIVByK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:54:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 13:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,286,1534834800"; 
   d="scan'208";a="74961313"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.152]) ([10.7.198.152])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2018 13:03:44 -0700
Subject: Re: [PATCH v4 3/5] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Cc:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222758.19464.83992.stgit@localhost.localdomain>
 <2254cfe1-5cd3-eedc-1f24-8e011dcf3575@microsoft.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <f4d5ace6-9657-746b-9448-064a4b7cfb8d@linux.intel.com>
Date:   Fri, 21 Sep 2018 13:03:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2254cfe1-5cd3-eedc-1f24-8e011dcf3575@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2018 12:50 PM, Pasha Tatashin wrote:
> 
> 
> On 9/20/18 6:29 PM, Alexander Duyck wrote:
>> The ZONE_DEVICE pages were being initialized in two locations. One was with
>> the memory_hotplug lock held and another was outside of that lock. The
>> problem with this is that it was nearly doubling the memory initialization
>> time. Instead of doing this twice, once while holding a global lock and
>> once without, I am opting to defer the initialization to the one outside of
>> the lock. This allows us to avoid serializing the overhead for memory init
>> and we can instead focus on per-node init times.
>>
>> One issue I encountered is that devm_memremap_pages and
>> hmm_devmmem_pages_create were initializing only the pgmap field the same
>> way. One wasn't initializing hmm_data, and the other was initializing it to
>> a poison value. Since this is something that is exposed to the driver in
>> the case of hmm I am opting for a third option and just initializing
>> hmm_data to 0 since this is going to be exposed to unknown third party
>> drivers.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
>> +void __ref memmap_init_zone_device(struct zone *zone,
>> +				   unsigned long start_pfn,
>> +				   unsigned long size,
>> +				   struct dev_pagemap *pgmap)
>> +{
>> +	unsigned long pfn, end_pfn = start_pfn + size;
>> +	struct pglist_data *pgdat = zone->zone_pgdat;
>> +	unsigned long zone_idx = zone_idx(zone);
>> +	unsigned long start = jiffies;
>> +	int nid = pgdat->node_id;
>> +
>> +	if (WARN_ON_ONCE(!pgmap || !is_dev_zone(zone)))
>> +		return;
>> +
>> +	/*
>> +	 * The call to memmap_init_zone should have already taken care
>> +	 * of the pages reserved for the memmap, so we can just jump to
>> +	 * the end of that region and start processing the device pages.
>> +	 */
>> +	if (pgmap->altmap_valid) {
>> +		struct vmem_altmap *altmap = &pgmap->altmap;
>> +
>> +		start_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
>> +		size = end_pfn - start_pfn;
>> +	}
>> +
>> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>> +		struct page *page = pfn_to_page(pfn);
>> +
>> +		__init_single_page(page, pfn, zone_idx, nid);
>> +
>> +		/*
>> +		 * Mark page reserved as it will need to wait for onlining
>> +		 * phase for it to be fully associated with a zone.
>> +		 *
>> +		 * We can use the non-atomic __set_bit operation for setting
>> +		 * the flag as we are still initializing the pages.
>> +		 */
>> +		__SetPageReserved(page);
>> +
>> +		/*
>> +		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
>> +		 * pointer and hmm_data.  It is a bug if a ZONE_DEVICE
>> +		 * page is ever freed or placed on a driver-private list.
>> +		 */
>> +		page->pgmap = pgmap;
>> +		page->hmm_data = 0;
> 
> __init_single_page()
>    mm_zero_struct_page()
> 
> Takes care of zeroing, no need to do another store here.

The problem is __init_singe_page also calls INIT_LIST_HEAD which I 
believe sets the prev pointer which overlaps with hmm_data.

> 
> Looks good otherwise.
> 
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> 

Thanks for the review.
