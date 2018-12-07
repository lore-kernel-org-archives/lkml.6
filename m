Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EFC2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eTi8abiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EFC2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGCpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:45:53 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13813 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:45:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c09ded30000>; Thu, 06 Dec 2018 18:45:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Dec 2018 18:45:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Dec 2018 18:45:50 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 7 Dec
 2018 02:45:50 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
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
X-Nvconfidentiality: public
Message-ID: <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
Date:   Thu, 6 Dec 2018 18:45:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544150740; bh=LaX0+2IU5rWANDqZ8zQGftDp1otyHanUuEU1Zp6B9cg=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eTi8abiJ70IRdR7JcO3Fth36VBJ+IyHedXL3yxdINXubk4JecUq+pI18SAWbwusYV
         sfyZTKMN5e474lpEAyz7XuW4e4dXeOnIIMnqi2gHWLDfaI3rtBf5Gx8fDkHIwfcZ8m
         YbTug1659Y9hfZin/Ys//DXxJr+hvcOiVkXNjLgPiBv3C3auzgojp7dNIH5syZLZ7U
         TgmTNumYJkMyAhxinesJRXVKNVel6nDaYXlMwUJphnrgQ/ImOBEt6R/ob/FL2Z3tQm
         V0gQrr3snlF3aZ+biS8GFfYtrh77Yw3293ufgzZOHroV8+kwbr8CacwztRGlpfVeXW
         1105ztsX0Chqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 5:57 PM, John Hubbard wrote:
> On 12/4/18 5:44 PM, Jerome Glisse wrote:
>> On Tue, Dec 04, 2018 at 05:15:19PM -0800, Matthew Wilcox wrote:
>>> On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
>>>> On 12/4/18 3:03 PM, Dan Williams wrote:
>>>>> Except the LRU fields are already in use for ZONE_DEVICE pages... how
>>>>> does this proposal interact with those?
>>>>
>>>> Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
>>>> use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
>>>> way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
>>>>
>>>> If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole 
>>>> LRU field approach is unusable.
>>>
>>> We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
>>> damage:
>>>
>>> +++ b/include/linux/mm_types.h
>>> @@ -151,10 +151,12 @@ struct page {
>>>  #endif
>>>                 };
>>>                 struct {        /* ZONE_DEVICE pages */
>>> +                       unsigned long _zd_pad_2;        /* LRU */
>>> +                       unsigned long _zd_pad_3;        /* LRU */
>>> +                       unsigned long _zd_pad_1;        /* uses mapping */
>>>                         /** @pgmap: Points to the hosting device page map. */
>>>                         struct dev_pagemap *pgmap;
>>>                         unsigned long hmm_data;
>>> -                       unsigned long _zd_pad_1;        /* uses mapping */
>>>                 };
>>>  
>>>                 /** @rcu_head: You can use this to free a page by RCU. */
>>>
>>> You don't use page->private or page->index, do you Dan?
>>
>> page->private and page->index are use by HMM DEVICE page.
>>
> 
> OK, so for the ZONE_DEVICE + HMM case, that leaves just one field remaining for 
> dma-pinned information. Which might work. To recap, we need:
> 
> -- 1 bit for PageDmaPinned
> -- 1 bit, if using LRU field(s), for PageDmaPinnedWasLru.
> -- N bits for a reference count
> 
> Those *could* be packed into a single 64-bit field, if really necessary.
> 

...actually, this needs to work on 32-bit systems, as well. And HMM is using a lot.
However, it is still possible for this to work.

Matthew, can I have that bit now please? I'm about out of options, and now it will actually
solve the problem here.

Given:

1) It's cheap to know if a page is ZONE_DEVICE, and ZONE_DEVICE means not on the LRU.
That, in turn, means only 1 bit instead of 2 bits (in addition to a counter) is required, 
for that case. 

2) There is an independent bit available (according to Matthew). 

3) HMM uses 4 of the 5 struct page fields, so only one field is available for a counter 
   in that case.

4) get_user_pages() must work on ZONE_DEVICE and HMM pages.

5) For a proper atomic counter for both 32- and 64-bit, we really do need a complete
unsigned long field.

So that leads to the following approach:

-- Use a single unsigned long field for an atomic reference count for the DMA pinned count.
For normal pages, this will be the *second* field of the LRU (in order to avoid PageTail bit).

For ZONE_DEVICE pages, we can also line up the fields so that the second LRU field is 
available and reserved for this DMA pinned count. Basically _zd_pad_1 gets move up and
optionally renamed:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 017ab82e36ca..b5dcd9398cae 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -90,8 +90,8 @@ struct page {
                                 * are in use.
                                 */
                                struct {
-                                       unsigned long dma_pinned_flags;
-                                       atomic_t      dma_pinned_count;
+                                       unsigned long dma_pinned_flags; /* LRU.next */
+                                       atomic_t      dma_pinned_count; /* LRU.prev */
                                };
                        };
                        /* See page-flags.h for PAGE_MAPPING_FLAGS */
@@ -161,9 +161,9 @@ struct page {
                };
                struct {        /* ZONE_DEVICE pages */
                        /** @pgmap: Points to the hosting device page map. */
-                       struct dev_pagemap *pgmap;
-                       unsigned long hmm_data;
-                       unsigned long _zd_pad_1;        /* uses mapping */
+                       struct dev_pagemap *pgmap;      /* LRU.next */
+                       unsigned long _zd_pad_1;        /* LRU.prev or dma_pinned_count */
+                       unsigned long hmm_data;         /* uses mapping */
                };
 
                /** @rcu_head: You can use this to free a page by RCU. */



-- Use an additional, fully independent page bit (from Matthew) for PageDmaPinned.


thanks,
-- 
John Hubbard
NVIDIA
