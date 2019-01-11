Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F0BC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52C920872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MS6kIQAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfAKC7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:59:35 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13642 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAKC7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:59:35 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3806820001>; Thu, 10 Jan 2019 18:59:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 18:59:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 10 Jan 2019 18:59:32 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 02:59:31 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jerome Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>
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
References: <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard> <20181217181148.GA3341@redhat.com>
 <20181217183443.GO10600@bombadil.infradead.org>
 <20181218093017.GB18032@quack2.suse.cz>
 <9f43d124-2386-7bfd-d90b-4d0417f51ccd@nvidia.com>
 <20181219020723.GD4347@redhat.com> <20181219110856.GA18345@quack2.suse.cz>
 <20190103015533.GA15619@redhat.com> <20190103092654.GA31370@quack2.suse.cz>
 <20190103144405.GC3395@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a79b259b-3982-b271-025a-0656f70506f4@nvidia.com>
Date:   Thu, 10 Jan 2019 18:59:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190103144405.GC3395@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547175554; bh=8T7sWNsDeGtmRKP2KvNypFF/LerYK2UzqASBF7f1s24=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MS6kIQAsnALSdgIUSgQ14qtpQ1F413ka8tuh9Tdgyayy0/22RF2Pu20W9SddvVkIy
         PsAMHm5eMVjWGM0EOd0g6Ep1dMBq8yHaY3V7ka1126LtF1H/n0pjLCJPXjxiqLbUeA
         JVDP34jTz3taqXoFwsuOL0dkGBjBVYRqlpGBvwxGbv41BGL9pNFC6UCGfy8E1IT4q2
         bl4gyvCLvHU3yvgxMCKwtZiwewLuNirmAdBnl2fLjdkfSG0o3TapCvvJrJ6WZBG3+Z
         tSY5k5W2FSSY2Ws9wIUhw7ZxOMMDFVFn7q2/n6YX6fudbZPxlJ12rTueXDCDko2gMC
         FKWEgTnggJFMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 6:44 AM, Jerome Glisse wrote:
> On Thu, Jan 03, 2019 at 10:26:54AM +0100, Jan Kara wrote:
>> On Wed 02-01-19 20:55:33, Jerome Glisse wrote:
>>> On Wed, Dec 19, 2018 at 12:08:56PM +0100, Jan Kara wrote:
>>>> On Tue 18-12-18 21:07:24, Jerome Glisse wrote:
>>>>> On Tue, Dec 18, 2018 at 03:29:34PM -0800, John Hubbard wrote:
>>>>>> OK, so let's take another look at Jerome's _mapcount idea all by itself (using
>>>>>> *only* the tracking pinned pages aspect), given that it is the lightest weight
>>>>>> solution for that.  
>>>>>>
>>>>>> So as I understand it, this would use page->_mapcount to store both the real
>>>>>> mapcount, and the dma pinned count (simply added together), but only do so for
>>>>>> file-backed (non-anonymous) pages:
>>>>>>
>>>>>>
>>>>>> __get_user_pages()
>>>>>> {
>>>>>> 	...
>>>>>> 	get_page(page);
>>>>>>
>>>>>> 	if (!PageAnon)
>>>>>> 		atomic_inc(page->_mapcount);
>>>>>> 	...
>>>>>> }
>>>>>>
>>>>>> put_user_page(struct page *page)
>>>>>> {
>>>>>> 	...
>>>>>> 	if (!PageAnon)
>>>>>> 		atomic_dec(&page->_mapcount);
>>>>>>
>>>>>> 	put_page(page);
>>>>>> 	...
>>>>>> }
>>>>>>
>>>>>> ...and then in the various consumers of the DMA pinned count, we use page_mapped(page)
>>>>>> to see if any mapcount remains, and if so, we treat it as DMA pinned. Is that what you 
>>>>>> had in mind?
>>>>>
>>>>> Mostly, with the extra two observations:
>>>>>     [1] We only need to know the pin count when a write back kicks in
>>>>>     [2] We need to protect GUP code with wait_for_write_back() in case
>>>>>         GUP is racing with a write back that might not the see the
>>>>>         elevated mapcount in time.
>>>>>
>>>>> So for [2]
>>>>>
>>>>> __get_user_pages()
>>>>> {
>>>>>     get_page(page);
>>>>>
>>>>>     if (!PageAnon) {
>>>>>         atomic_inc(page->_mapcount);
>>>>> +       if (PageWriteback(page)) {
>>>>> +           // Assume we are racing and curent write back will not see
>>>>> +           // the elevated mapcount so wait for current write back and
>>>>> +           // force page fault
>>>>> +           wait_on_page_writeback(page);
>>>>> +           // force slow path that will fault again
>>>>> +       }
>>>>>     }
>>>>> }
>>>>
>>>> This is not needed AFAICT. __get_user_pages() gets page reference (and it
>>>> should also increment page->_mapcount) under PTE lock. So at that point we
>>>> are sure we have writeable PTE nobody can change. So page_mkclean() has to
>>>> block on PTE lock to make PTE read-only and only after going through all
>>>> PTEs like this, it can check page->_mapcount. So the PTE lock provides
>>>> enough synchronization.
>>>>
>>>>> For [1] only needing pin count during write back turns page_mkclean into
>>>>> the perfect spot to check for that so:
>>>>>
>>>>> int page_mkclean(struct page *page)
>>>>> {
>>>>>     int cleaned = 0;
>>>>> +   int real_mapcount = 0;
>>>>>     struct address_space *mapping;
>>>>>     struct rmap_walk_control rwc = {
>>>>>         .arg = (void *)&cleaned,
>>>>>         .rmap_one = page_mkclean_one,
>>>>>         .invalid_vma = invalid_mkclean_vma,
>>>>> +       .mapcount = &real_mapcount,
>>>>>     };
>>>>>
>>>>>     BUG_ON(!PageLocked(page));
>>>>>
>>>>>     if (!page_mapped(page))
>>>>>         return 0;
>>>>>
>>>>>     mapping = page_mapping(page);
>>>>>     if (!mapping)
>>>>>         return 0;
>>>>>
>>>>>     // rmap_walk need to change to count mapping and return value
>>>>>     // in .mapcount easy one
>>>>>     rmap_walk(page, &rwc);
>>>>>
>>>>>     // Big fat comment to explain what is going on
>>>>> +   if ((page_mapcount(page) - real_mapcount) > 0) {
>>>>> +       SetPageDMAPined(page);
>>>>> +   } else {
>>>>> +       ClearPageDMAPined(page);
>>>>> +   }
>>>>
>>>> This is the detail I'm not sure about: Why cannot rmap_walk_file() race
>>>> with e.g. zap_pte_range() which decrements page->_mapcount and thus the
>>>> check we do in page_mkclean() is wrong?
>>>>
>>>
>>> Ok so i found a solution for that. First GUP must wait for racing
>>> write back. If GUP see a valid write-able PTE and the page has
>>> write back flag set then it must back of as if the PTE was not
>>> valid to force fault. It is just a race with page_mkclean and we
>>> want ordering between the two. Note this is not strictly needed
>>> so we can relax that but i believe this ordering is better to do
>>> in GUP rather then having each single user of GUP test for this
>>> to avoid the race.
>>>
>>> GUP increase mapcount only after checking that it is not racing
>>> with writeback it also set a page flag (SetPageDMAPined(page)).
>>>
>>> When clearing a write-able pte we set a special entry inside the
>>> page table (might need a new special swap type for this) and change
>>> page_mkclean_one() to clear to 0 those special entry.
>>>
>>>
>>> Now page_mkclean:
>>>
>>> int page_mkclean(struct page *page)
>>> {
>>>     int cleaned = 0;
>>> +   int real_mapcount = 0;
>>>     struct address_space *mapping;
>>>     struct rmap_walk_control rwc = {
>>>         .arg = (void *)&cleaned,
>>>         .rmap_one = page_mkclean_one,
>>>         .invalid_vma = invalid_mkclean_vma,
>>> +       .mapcount = &real_mapcount,
>>>     };
>>> +   int mapcount1, mapcount2;
>>>
>>>     BUG_ON(!PageLocked(page));
>>>
>>>     if (!page_mapped(page))
>>>         return 0;
>>>
>>>     mapping = page_mapping(page);
>>>     if (!mapping)
>>>         return 0;
>>>
>>> +   mapcount1 = page_mapcount(page);
>>>     // rmap_walk need to change to count mapping and return value
>>>     // in .mapcount easy one
>>>     rmap_walk(page, &rwc);
>>
>> So what prevents GUP_fast() to grab reference here and the test below would
>> think the page is not pinned? Or do you assume that every page_mkclean()
>> call will be protected by PageWriteback (currently it is not) so that
>> GUP_fast() blocks / bails out?

Continuing this thread, still focusing only on the "how to maintain a PageDmaPinned
for each page" question (ignoring, for now, what to actually *do* in response to 
that flag being set):

1. Jan's point above is still a problem: PageWriteback != "page_mkclean is happening".
This is probably less troubling than the next point, but it does undermine all the 
complicated schemes involving PageWriteback, that try to synchronize gup() with
page_mkclean().

2. Also, the mapcount approach here still does not reliably avoid false negatives
(that is, a page may have been gup'd, but page_mkclean could miss that): gup()
can always jump in and increment the mapcount, while page_mkclean is in the middle
of making (wrong) decisions based on that mapcount. There's no lock to prevent that.

Again: mapcount can go up *or* down, so I'm not seeing a true solution yet.

> 
> So GUP_fast() becomes:
> 
> GUP_fast_existing() { ... }
> GUP_fast()
> {
>     GUP_fast_existing();
> 
>     for (i = 0; i < npages; ++i) {
>         if (PageWriteback(pages[i])) {
>             // need to force slow path for this page
>         } else {
>             SetPageDmaPinned(pages[i]);
>             atomic_inc(pages[i]->mapcount);
>         }
>     }
> }
> 
> This is a minor slow down for GUP fast and it takes care of a
> write back race on behalf of caller. This means that page_mkclean
> can not see a mapcount value that increase. This simplify thing
> we can relax that. Note that what this is doing is making sure
> that GUP_fast never get lucky :) ie never GUP a page that is in
> the process of being write back but has not yet had its pte
> updated to reflect that.
> 
> 
>> But I think that detecting pinned pages with small false positive rate is
>> OK. The extra page bouncing will cost some performance but if it is rare,
>> then we are OK. So I think we can go for the simple version of detecting
>> pinned pages as you mentioned in some earlier email. We just have to be
>> sure there are no false negatives.
> 

Agree with that sentiment, but there are still false negatives and I'm not
yet seeing any solutions for that.

thanks,
-- 
John Hubbard
NVIDIA

