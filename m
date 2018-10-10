Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C652C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9BE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9BE2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJWup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:50:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:14158 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJJWup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:50:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 08:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,364,1534834800"; 
   d="scan'208";a="98198130"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.156]) ([10.7.198.156])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2018 08:27:59 -0700
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Dan Williams <dan.j.williams@intel.com>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
 <CAPcyv4gZV_V=iY0mHiiAWwbynqtPxLTwdZ0j0vQ0F95ZZ4nTZg@mail.gmail.com>
 <20181010125211.GA45572@tiger-server>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <deb1264e-5a42-3467-9073-e829b8eab8ca@linux.intel.com>
Date:   Wed, 10 Oct 2018 08:27:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181010125211.GA45572@tiger-server>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2018 5:52 AM, Yi Zhang wrote:
> On 2018-10-09 at 14:19:32 -0700, Dan Williams wrote:
>> On Tue, Oct 9, 2018 at 1:34 PM Alexander Duyck
>> <alexander.h.duyck@linux.intel.com> wrote:
>>>
>>> On 10/9/2018 11:04 AM, Dan Williams wrote:
>>>> On Tue, Oct 9, 2018 at 3:21 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
>> [..]
>>>> That comment is incorrect, device-pages are never onlined. So I think
>>>> we can just skip that call to __SetPageReserved() unless the memory
>>>> range is MEMORY_DEVICE_{PRIVATE,PUBLIC}.
>>>>
>>>
>>> When pages are "onlined" via __free_pages_boot_core they clear the
>>> reserved bit, that is the reason for the comment. The reserved bit is
>>> meant to indicate that the page cannot be swapped out or moved based on
>>> the description of the bit.
>>
>> ...but ZONE_DEVICE pages are never onlined so I would expect
>> memmap_init_zone_device() to know that detail.
>>
>>> I would think with that being the case we still probably need the call
>>> to __SetPageReserved to set the bit with the expectation that it will
>>> not be cleared for device-pages since the pages are not onlined.
>>> Removing the call to __SetPageReserved would probably introduce a number
>>> of regressions as there are multiple spots that use the reserved bit to
>>> determine if a page can be swapped out to disk, mapped as system memory,
>>> or migrated.
> 
> Another things, it seems page_init/set_reserved already been done in the
> move_pfn_range_to_zone
>      |-->memmap_init_zone
>      	|-->for_each_page_in_pfn
> 		|-->__init_single_page
> 		|-->SetPageReserved
> 
> Why we haven't remove these redundant initial in memmap_init_zone?
> 
> Correct me if I missed something.

In this case it isn't redundant as only the vmmemmap pages are 
initialized in memmap_init_zone now. So all of the pages that are going 
to be used as device pages are not initialized until the call to 
memmap_init_zone_device. What I did is split the initialization of the 
pages into two parts in order to allow us to initialize the pages 
outside of the hotplug lock.

>>
>> Right, this is what Yi is working on... the PageReserved flag is
>> problematic for KVM. Auditing those locations it seems as long as we
>> teach hibernation to avoid ZONE_DEVICE ranges we can safely not set
>> the reserved flag for DAX pages. What I'm trying to avoid is a local
>> KVM hack to check for DAX pages when the Reserved flag is not
>> otherwise needed.
> Thanks Dan. Provide the patch link.
> 
> https://lore.kernel.org/lkml/cover.1536342881.git.yi.z.zhang@linux.intel.com

So it looks like your current logic is just working around the bit then 
since it just allows for reserved DAX pages.


