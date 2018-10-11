Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F307C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25740213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25740213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeJKXGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:33590 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 08:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="91159768"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.157]) ([10.7.198.157])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2018 08:38:56 -0700
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
 <20181010095838.GG5873@dhcp22.suse.cz>
 <f97de51c-67dd-99b2-754e-0685cac06699@linux.intel.com>
 <20181010172451.GK5873@dhcp22.suse.cz>
 <CAPcyv4inUwyYEEQ_qh5GTRxUo+JLt+caz_3mtg79DpfQSUdG5Q@mail.gmail.com>
 <20181011083953.GB51021@tiger-server>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <ded6694d-a283-2954-c61a-001800c000df@linux.intel.com>
Date:   Thu, 11 Oct 2018 08:38:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181011083953.GB51021@tiger-server>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 1:39 AM, Yi Zhang wrote:
> On 2018-10-10 at 11:18:49 -0700, Dan Williams wrote:
>> On Wed, Oct 10, 2018 at 10:30 AM Michal Hocko <mhocko@kernel.org> wrote:
>>>
>>> On Wed 10-10-18 09:39:08, Alexander Duyck wrote:
>>>> On 10/10/2018 2:58 AM, Michal Hocko wrote:
>>>>> On Tue 09-10-18 13:26:41, Alexander Duyck wrote:
>>>>> [...]
>>>>>> I would think with that being the case we still probably need the call to
>>>>>> __SetPageReserved to set the bit with the expectation that it will not be
>>>>>> cleared for device-pages since the pages are not onlined. Removing the call
>>>>>> to __SetPageReserved would probably introduce a number of regressions as
>>>>>> there are multiple spots that use the reserved bit to determine if a page
>>>>>> can be swapped out to disk, mapped as system memory, or migrated.
>>>>>
>>>>> PageReserved is meant to tell any potential pfn walkers that might get
>>>>> to this struct page to back off and not touch it. Even though
>>>>> ZONE_DEVICE doesn't online pages in traditional sense it makes those
>>>>> pages available for further use so the page reserved bit should be
>>>>> cleared.
>>>>
>>>> So from what I can tell that isn't necessarily the case. Specifically if the
>>>> pagemap type is MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_PUBLIC both are
>>>> special cases where the memory may not be accessible to the CPU or cannot be
>>>> pinned in order to allow for eviction.
>>>
>>> Could you give me an example please?
>>>
>>>> The specific case that Dan and Yi are referring to is for the type
>>>> MEMORY_DEVICE_FS_DAX. For that type I could probably look at not setting the
>>>> reserved bit. Part of me wants to say that we should wait and clear the bit
>>>> later, but that would end up just adding time back to initialization. At
>>>> this point I would consider the change more of a follow-up optimization
>>>> rather than a fix though since this is tailoring things specifically for DAX
>>>> versus the other ZONE_DEVICE types.
>>>
>>> I thought I have already made it clear that these zone device hacks are
>>> not acceptable to the generic hotplug code. If the current reserve bit
>>> handling is not correct then give us a specific reason for that and we
>>> can start thinking about the proper fix.
>>>
>>
>> Right, so we're in a situation where a hack is needed for KVM's
>> current interpretation of the Reserved flag relative to dax mapped
>> pages. I'm arguing to push that knowledge / handling as deep as
>> possible into the core rather than hack the leaf implementations like
>> KVM, i.e. disable the Reserved flag for all non-MEMORY_DEVICE_*
>> ZONE_DEVICE types.
>>
>> Here is the KVM thread about why they need a change:
>>
>>      https://lkml.org/lkml/2018/9/7/552
>>
>> ...and where I pushed back on a KVM-local hack:
>>
>>      https://lkml.org/lkml/2018/9/19/154
> Yeah, Thank Dan, I think I can going on with something like this:
> 
> @@ -5589,6 +5589,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   		struct page *page = pfn_to_page(pfn);
>   
>   		__init_single_page(page, pfn, zone_idx, nid);
> +		/* Could we move this a little bit earlier as I can
> +		 * direct use is_dax_page(page), or something else?
> +		 */
> +		page->pgmap = pgmap;
>   
>   		/*
>   		 * Mark page reserved as it will need to wait for onlining
> @@ -5597,14 +5598,14 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   		 * We can use the non-atomic __set_bit operation for setting
>   		 * the flag as we are still initializing the pages.
>   		 */
> -		__SetPageReserved(page);
> +		 if(!is_dax_page(page))
> +			__SetPageReserved(page);
>   
>   		/*
>   		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
>   		 * pointer and hmm_data.  It is a bug if a ZONE_DEVICE
>   		 * page is ever freed or placed on a driver-private list.
>   		 */
> -		page->pgmap = pgmap;
>   		page->hmm_data = 0;
> 
> 
> After Alex's patch merged.

So I am not a huge fan of splitting up the pgmap init from the hmm_data, 
but I suppose this is just for your proof-of-concept?

I already have another patch set outstanding that may actually make this 
change easier[1]. What I could do is add the logic there based on the 
pgmap.type as an additional patch since I pass a boolean to determine if 
I am setting the reserved bit or not.

[1] 
https://lore.kernel.org/lkml/20181005151006.17473.83040.stgit@localhost.localdomain/

