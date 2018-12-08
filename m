Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F33C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A6E20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bw6Nx7rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A6E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLHAwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:52:46 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18799 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLHAwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:52:46 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0b15da0000>; Fri, 07 Dec 2018 16:52:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Dec 2018 16:52:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Dec 2018 16:52:43 -0800
Received: from [10.2.174.74] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Dec
 2018 00:52:42 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        <tom@talpey.com>, Al Viro <viro@zeniv.linux.org.uk>,
        <benve@cisco.com>, Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
Date:   Fri, 7 Dec 2018 16:52:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181207191620.GD3293@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544230363; bh=O1CsolTRdVsJWOGgyKNIfTwcwwkP1Vlc+CMECC9GAE8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Bw6Nx7rlfQ+6eW33BvBW2QbKgAE4VYE7BErYAGcvrfO60ziHDbUrwDfKTiX/F3BPJ
         WQ2MqwwRnheuBGAeZJvEDRH1W+nI+TIlC/Qjkor8Jey71wSIU16WlDP59zM7QHEora
         rCMMBW8hZUgG6ewIkqRlSy0xlTKx/I9g00qLIIDPj2WIsgnGvCvGcvj64KsSaoARNg
         nfMQltv/5GuCHJcU7r9Qqt7BRclZpBzsVFcnPvHs2SAC5MyA0F+cXx/7BsaKI4WI/y
         sFCpHJjHbrvNtdDr93k4QLeOJIeaTcObQABBpGckjDNtAA08I8q+2jFxVauy2DMZOE
         psNQYo1tDIt3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 11:16 AM, Jerome Glisse wrote:
> On Thu, Dec 06, 2018 at 06:45:49PM -0800, John Hubbard wrote:
>> On 12/4/18 5:57 PM, John Hubbard wrote:
>>> On 12/4/18 5:44 PM, Jerome Glisse wrote:
>>>> On Tue, Dec 04, 2018 at 05:15:19PM -0800, Matthew Wilcox wrote:
>>>>> On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
>>>>>> On 12/4/18 3:03 PM, Dan Williams wrote:
>>>>>>> Except the LRU fields are already in use for ZONE_DEVICE pages... how
>>>>>>> does this proposal interact with those?
>>>>>>
>>>>>> Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
>>>>>> use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
>>>>>> way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
>>>>>>
>>>>>> If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole 
>>>>>> LRU field approach is unusable.
>>>>>
>>>>> We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
>>>>> damage:
>>>>>
>>>>> +++ b/include/linux/mm_types.h
>>>>> @@ -151,10 +151,12 @@ struct page {
>>>>>  #endif
>>>>>                 };
>>>>>                 struct {        /* ZONE_DEVICE pages */
>>>>> +                       unsigned long _zd_pad_2;        /* LRU */
>>>>> +                       unsigned long _zd_pad_3;        /* LRU */
>>>>> +                       unsigned long _zd_pad_1;        /* uses mapping */
>>>>>                         /** @pgmap: Points to the hosting device page map. */
>>>>>                         struct dev_pagemap *pgmap;
>>>>>                         unsigned long hmm_data;
>>>>> -                       unsigned long _zd_pad_1;        /* uses mapping */
>>>>>                 };
>>>>>  
>>>>>                 /** @rcu_head: You can use this to free a page by RCU. */
>>>>>
>>>>> You don't use page->private or page->index, do you Dan?
>>>>
>>>> page->private and page->index are use by HMM DEVICE page.
>>>>
>>>
>>> OK, so for the ZONE_DEVICE + HMM case, that leaves just one field remaining for 
>>> dma-pinned information. Which might work. To recap, we need:
>>>
>>> -- 1 bit for PageDmaPinned
>>> -- 1 bit, if using LRU field(s), for PageDmaPinnedWasLru.
>>> -- N bits for a reference count
>>>
>>> Those *could* be packed into a single 64-bit field, if really necessary.
>>>
>>
>> ...actually, this needs to work on 32-bit systems, as well. And HMM is using a lot.
>> However, it is still possible for this to work.
>>
>> Matthew, can I have that bit now please? I'm about out of options, and now it will actually
>> solve the problem here.
>>
>> Given:
>>
>> 1) It's cheap to know if a page is ZONE_DEVICE, and ZONE_DEVICE means not on the LRU.
>> That, in turn, means only 1 bit instead of 2 bits (in addition to a counter) is required, 
>> for that case. 
>>
>> 2) There is an independent bit available (according to Matthew). 
>>
>> 3) HMM uses 4 of the 5 struct page fields, so only one field is available for a counter 
>>    in that case.
> 
> To expend on this, HMM private page are use for anonymous page
> so the index and mapping fields have the value you expect for
> such pages. Down the road i want also to support file backed
> page with HMM private (mapping, private, index).
> 
> For HMM public both anonymous and file back page are supported
> today (HMM public is only useful on platform with something like
> OpenCAPI, CCIX or NVlink ... so PowerPC for now).
> 
>> 4) get_user_pages() must work on ZONE_DEVICE and HMM pages.
> 
> get_user_pages() only need to work with HMM public page not the
> private one as we can not allow _anyone_ to pin HMM private page.
> So on get_user_pages() on HMM private we get a page fault and
> it is migrated back to regular memory.
> 
> 
>> 5) For a proper atomic counter for both 32- and 64-bit, we really do need a complete
>> unsigned long field.
>>
>> So that leads to the following approach:
>>
>> -- Use a single unsigned long field for an atomic reference count for the DMA pinned count.
>> For normal pages, this will be the *second* field of the LRU (in order to avoid PageTail bit).
>>
>> For ZONE_DEVICE pages, we can also line up the fields so that the second LRU field is 
>> available and reserved for this DMA pinned count. Basically _zd_pad_1 gets move up and
>> optionally renamed:
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 017ab82e36ca..b5dcd9398cae 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -90,8 +90,8 @@ struct page {
>>                                  * are in use.
>>                                  */
>>                                 struct {
>> -                                       unsigned long dma_pinned_flags;
>> -                                       atomic_t      dma_pinned_count;
>> +                                       unsigned long dma_pinned_flags; /* LRU.next */
>> +                                       atomic_t      dma_pinned_count; /* LRU.prev */
>>                                 };
>>                         };
>>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
>> @@ -161,9 +161,9 @@ struct page {
>>                 };
>>                 struct {        /* ZONE_DEVICE pages */
>>                         /** @pgmap: Points to the hosting device page map. */
>> -                       struct dev_pagemap *pgmap;
>> -                       unsigned long hmm_data;
>> -                       unsigned long _zd_pad_1;        /* uses mapping */
>> +                       struct dev_pagemap *pgmap;      /* LRU.next */
>> +                       unsigned long _zd_pad_1;        /* LRU.prev or dma_pinned_count */
>> +                       unsigned long hmm_data;         /* uses mapping */
> 
> This breaks HMM today as hmm_data would alias with mapping field.
> hmm_data can only be in LRU.prev
> 

I see. OK, HMM has done an efficient job of mopping up unused fields, and now we are
completely out of space. At this point, after thinking about it carefully, it seems clear
that it's time for a single, new field:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..1c789e324da8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -182,6 +182,9 @@ struct page {
        /* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
        atomic_t _refcount;
 
+       /* DMA usage count. See get_user_pages*(), put_user_page*(). */
+       atomic_t _dma_pinned_count;
+
 #ifdef CONFIG_MEMCG
        struct mem_cgroup *mem_cgroup;
 #endif


...because after all, the reason this is so difficult is that this fix has to work
in pretty much every configuration. get_user_pages() use is widespread, it's a very
general facility, and...it needs fixing.  And we're out of space. 

I'm going to send out an updated RFC that shows the latest, and I think it's going
to include the above.

-- 
thanks,
John Hubbard
NVIDIA

