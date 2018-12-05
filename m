Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82DDC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EC320851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WOzdZqKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EC320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeLEB5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:57:35 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12558 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLEB5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:57:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c07308c0000>; Tue, 04 Dec 2018 17:57:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Dec 2018 17:57:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Dec 2018 17:57:30 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 01:57:30 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
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
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
Date:   Tue, 4 Dec 2018 17:57:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181205014441.GA3045@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543975052; bh=riutGdtVqEoopeJXr4KEyjyCI8UUnSy/FhmO6CvEnG8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WOzdZqKfxzIIXSxp1blMM9mM7ba/s1YiJ6raIFhBnvsnmS8kdEj5y6vvMVNp04ulu
         R3JzAfIXDNvXGooki7lzL4TtU2sFfGwgojlZQCmx3R9Eo4xGoVp6MnlwxFs51fgEpV
         Gf2kSDh+H+Dp+ZHgv3OEzmnfy3i+PJDNSCpNZpJ0tVO0ehGsXvCs6JhuoUkYLFSC+A
         ST5DFr4slAsaX3cLYp3rC/ZsAjvOgj0seYrz7eWKppMncYy4+yP+tLr4xfzSDxo80K
         pgXcaP9k0AzUcRUCOqmvOWpeE5+8E8ei4H7j3WL722zf1H1rCsStTqIe3x7iiOuvGt
         BkvQH2ADevo5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 5:44 PM, Jerome Glisse wrote:
> On Tue, Dec 04, 2018 at 05:15:19PM -0800, Matthew Wilcox wrote:
>> On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
>>> On 12/4/18 3:03 PM, Dan Williams wrote:
>>>> Except the LRU fields are already in use for ZONE_DEVICE pages... how
>>>> does this proposal interact with those?
>>>
>>> Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
>>> use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
>>> way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
>>>
>>> If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole 
>>> LRU field approach is unusable.
>>
>> We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
>> damage:
>>
>> +++ b/include/linux/mm_types.h
>> @@ -151,10 +151,12 @@ struct page {
>>  #endif
>>                 };
>>                 struct {        /* ZONE_DEVICE pages */
>> +                       unsigned long _zd_pad_2;        /* LRU */
>> +                       unsigned long _zd_pad_3;        /* LRU */
>> +                       unsigned long _zd_pad_1;        /* uses mapping */
>>                         /** @pgmap: Points to the hosting device page map. */
>>                         struct dev_pagemap *pgmap;
>>                         unsigned long hmm_data;
>> -                       unsigned long _zd_pad_1;        /* uses mapping */
>>                 };
>>  
>>                 /** @rcu_head: You can use this to free a page by RCU. */
>>
>> You don't use page->private or page->index, do you Dan?
> 
> page->private and page->index are use by HMM DEVICE page.
> 

OK, so for the ZONE_DEVICE + HMM case, that leaves just one field remaining for 
dma-pinned information. Which might work. To recap, we need:

-- 1 bit for PageDmaPinned
-- 1 bit, if using LRU field(s), for PageDmaPinnedWasLru.
-- N bits for a reference count

Those *could* be packed into a single 64-bit field, if really necessary.


thanks,
-- 
John Hubbard
NVIDIA

