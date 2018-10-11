Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B8C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD8220835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD8220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJLGwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:52:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:4228 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbeJLGwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:52:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 16:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,370,1534834800"; 
   d="scan'208";a="99531901"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.157]) ([10.7.198.157])
  by orsmga002.jf.intel.com with ESMTP; 11 Oct 2018 16:22:30 -0700
Subject: Re: [mm PATCH v2 4/6] mm: Do not set reserved flag for hotplug memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Miller <davem@davemloft.net>,
        Zhang Yi <yi.z.zhang@linux.intel.com>, khalid.aziz@oracle.com,
        rppt@linux.vnet.ibm.com, Vlastimil Babka <vbabka@suse.cz>,
        sparclinux@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20181011221237.1925.85591.stgit@localhost.localdomain>
 <20181011221351.1925.67694.stgit@localhost.localdomain>
 <CAPcyv4gw4YRJXZrXHunKwqbhXPekiNU6jsYkrpoBtznv0Py-sg@mail.gmail.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <0b7001f8-3653-d100-4218-3d9b06ff8b3a@linux.intel.com>
Date:   Thu, 11 Oct 2018 16:22:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gw4YRJXZrXHunKwqbhXPekiNU6jsYkrpoBtznv0Py-sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 3:58 PM, Dan Williams wrote:
> On Thu, Oct 11, 2018 at 3:18 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
>>
>> The general suspicion at this point is that the setting of the reserved bit
>> is not really needed for hotplug memory. In addition the setting of this
>> bit results in issues for DAX in that it is not possible to assign the
>> region to KVM if the reserved bit is set in each page.
>>
>> For now we can try just not setting the bit since we suspect it isn't
>> adding value in setting it. If at a later time we find that it is needed we
>> can come back through and re-add it for the hotplug paths.
>>
>> Suggested-by: Michael Hocko <mhocko@suse.com>
>> Reported-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> ---
>>   mm/page_alloc.c |   11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3603d5444865..e435223e2ddb 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5571,8 +5571,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>
>>                  page = pfn_to_page(pfn);
>>                  __init_single_page(page, pfn, zone, nid);
>> -               if (context == MEMMAP_HOTPLUG)
>> -                       __SetPageReserved(page);
> 
> At a minimum I think we need to do this before removing PageReserved,
> to make sure zone_device pages are not tracked in the hibernation
> image.
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 3d37c279c090..c0613137d726 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1285,6 +1285,9 @@ static struct page *saveable_page(struct zone
> *zone, unsigned long pfn)
>          if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
>                  return NULL;
> 
> +       if (is_zone_device_page(page))
> +               return NULL;
> +
>          if (PageReserved(page)
>              && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>                  return NULL;
> 

Yeah, I am pretty sure I broke hotplug in general with this too since it 
seems like it checks for the reserved flag before bringing a range 
online in online_pages_range.

I think I will drop this patch and go back to what I had before. There 
was a slight performance gain to be had for not setting the bit at all, 
but I think we are probably looking at yet another patch set if we want 
to go through and drop the need for the reserved bit to be set.

- Alex
