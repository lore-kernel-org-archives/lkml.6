Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52490C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BB3217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Usjgz8dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbeLTKyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:54:53 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11171 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbeLTKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:54:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1b74f00000>; Thu, 20 Dec 2018 02:54:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Dec 2018 02:54:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Dec 2018 02:54:50 -0800
Received: from [10.2.167.233] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 20 Dec
 2018 10:54:50 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz> <20181216215819.GC10644@dastard>
 <20181217181148.GA3341@redhat.com>
 <20181217183443.GO10600@bombadil.infradead.org>
 <20181218093017.GB18032@quack2.suse.cz>
 <9f43d124-2386-7bfd-d90b-4d0417f51ccd@nvidia.com>
 <20181219020723.GD4347@redhat.com> <20181219110856.GA18345@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8e98d553-7675-8fa1-3a60-4211fc836ed9@nvidia.com>
Date:   Thu, 20 Dec 2018 02:54:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181219110856.GA18345@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545303280; bh=gUB33G4I8Kn0nCUd1t/wdYqHhzS834HZBOXF/wjwMGw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Usjgz8dydyIWquetSS0VR7eqhrfalgnjXEpcHJu/+pctTBq8ZlQgtBcRPMVoVMGp5
         pndIUPe1yllJ6TYB7qnNZWKLr+eNoK+pMakdcn0TXYKq+u8bO1kGA+mBugPkPWibhV
         vUEWdNTTy7TQ6OoxFnZ5zVZMBF+PZolAToKB1FTZBMVnGKg//pdi3ZDSQhzt6HGYd2
         AMKLivBOKLzE6Wzm7ruWSQEhDu66eexGksoIBit2XfG1HUmFqmEFQEPD7He8nWtYlm
         ISNEkrFUe4T/MkArDPSxjovRv4wk0f80IMyNzZeFDLBWRE0mWpTYnOAWx8NEsmsHGl
         rZBqt1LGEul2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 3:08 AM, Jan Kara wrote:
> On Tue 18-12-18 21:07:24, Jerome Glisse wrote:
>> On Tue, Dec 18, 2018 at 03:29:34PM -0800, John Hubbard wrote:
>>> OK, so let's take another look at Jerome's _mapcount idea all by itself (using
>>> *only* the tracking pinned pages aspect), given that it is the lightest weight
>>> solution for that.  
>>>
>>> So as I understand it, this would use page->_mapcount to store both the real
>>> mapcount, and the dma pinned count (simply added together), but only do so for
>>> file-backed (non-anonymous) pages:
>>>
>>>
>>> __get_user_pages()
>>> {
>>> 	...
>>> 	get_page(page);
>>>
>>> 	if (!PageAnon)
>>> 		atomic_inc(page->_mapcount);
>>> 	...
>>> }
>>>
>>> put_user_page(struct page *page)
>>> {
>>> 	...
>>> 	if (!PageAnon)
>>> 		atomic_dec(&page->_mapcount);
>>>
>>> 	put_page(page);
>>> 	...
>>> }
>>>
>>> ...and then in the various consumers of the DMA pinned count, we use page_mapped(page)
>>> to see if any mapcount remains, and if so, we treat it as DMA pinned. Is that what you 
>>> had in mind?
>>
>> Mostly, with the extra two observations:
>>     [1] We only need to know the pin count when a write back kicks in
>>     [2] We need to protect GUP code with wait_for_write_back() in case
>>         GUP is racing with a write back that might not the see the
>>         elevated mapcount in time.
>>
>> So for [2]
>>
>> __get_user_pages()
>> {
>>     get_page(page);
>>
>>     if (!PageAnon) {
>>         atomic_inc(page->_mapcount);
>> +       if (PageWriteback(page)) {
>> +           // Assume we are racing and curent write back will not see
>> +           // the elevated mapcount so wait for current write back and
>> +           // force page fault
>> +           wait_on_page_writeback(page);
>> +           // force slow path that will fault again
>> +       }
>>     }
>> }
> 
> This is not needed AFAICT. __get_user_pages() gets page reference (and it
> should also increment page->_mapcount) under PTE lock. So at that point we
> are sure we have writeable PTE nobody can change. So page_mkclean() has to
> block on PTE lock to make PTE read-only and only after going through all
> PTEs like this, it can check page->_mapcount. So the PTE lock provides
> enough synchronization.
> 
>> For [1] only needing pin count during write back turns page_mkclean into
>> the perfect spot to check for that so:
>>
>> int page_mkclean(struct page *page)
>> {
>>     int cleaned = 0;
>> +   int real_mapcount = 0;
>>     struct address_space *mapping;
>>     struct rmap_walk_control rwc = {
>>         .arg = (void *)&cleaned,
>>         .rmap_one = page_mkclean_one,
>>         .invalid_vma = invalid_mkclean_vma,
>> +       .mapcount = &real_mapcount,
>>     };
>>
>>     BUG_ON(!PageLocked(page));
>>
>>     if (!page_mapped(page))
>>         return 0;
>>
>>     mapping = page_mapping(page);
>>     if (!mapping)
>>         return 0;
>>
>>     // rmap_walk need to change to count mapping and return value
>>     // in .mapcount easy one
>>     rmap_walk(page, &rwc);
>>
>>     // Big fat comment to explain what is going on
>> +   if ((page_mapcount(page) - real_mapcount) > 0) {
>> +       SetPageDMAPined(page);
>> +   } else {
>> +       ClearPageDMAPined(page);
>> +   }
> 
> This is the detail I'm not sure about: Why cannot rmap_walk_file() race
> with e.g. zap_pte_range() which decrements page->_mapcount and thus the
> check we do in page_mkclean() is wrong?

Right. This looks like a dead end, after all. We can't lock a whole chunk 
of "all these are mapped, hold still while we count you" pages. It's not
designed to allow that at all.

IMHO, we are now back to something like dynamic_page, which provides an
independent dma pinned count. 

-- 
thanks,
John Hubbard
NVIDIA
