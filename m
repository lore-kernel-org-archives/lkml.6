Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF7C282CF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E45A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LQMjS8Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfA2AWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:22:21 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1993 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA2AWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:22:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4f9c920000>; Mon, 28 Jan 2019 16:21:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 16:22:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 28 Jan 2019 16:22:17 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 00:22:17 +0000
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
References: <20190114145447.GJ13316@quack2.suse.cz>
 <20190114172124.GA3702@redhat.com> <20190115080759.GC29524@quack2.suse.cz>
 <20190116113819.GD26069@quack2.suse.cz> <20190116130813.GA3617@redhat.com>
 <20190117093047.GB9378@quack2.suse.cz> <20190117151759.GA3550@redhat.com>
 <20190122152459.GG13149@quack2.suse.cz> <20190122164613.GA3188@redhat.com>
 <20190123180230.GN13149@quack2.suse.cz> <20190123190409.GF3097@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <8492163b-8c50-6ea2-8bc9-8c445495ecb4@nvidia.com>
Date:   Mon, 28 Jan 2019 16:22:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123190409.GF3097@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548721298; bh=eXjW9ZgCmCHE761hpyoN59/KnhgV4GB2zccQD4O/WZo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=LQMjS8RoqS3/FnhUI3aYVwUaiH3wqDe1XST3Cje00dOfy2lis0QZDB9LevgGgStLY
         3pEBIplqoaQMdZURWHpkcdWb6gqUFeg7Uz9p4kjfpIkN4M7ys6Ob9GVlXZJNotkoVj
         lcyAH4DUyEkgpn9mti3fF7j1keeqJ3elNandfBNk+qROPfxswxp7XgcqQvkAOBWA6G
         51axfEi0NI5f0unI59EfIhGkWgsDZ9tO02VIPF6gsGjiNmASPE4ewjYrkJON5EuEb/
         qemiASYCkDjS2zWy+lF4bAtjBHh3+LPG8fKGF2Bf01G+llMeZeXvGhEeMjKfrX2WzD
         Csp2kXu6A42RA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 11:04 AM, Jerome Glisse wrote:
> On Wed, Jan 23, 2019 at 07:02:30PM +0100, Jan Kara wrote:
>> On Tue 22-01-19 11:46:13, Jerome Glisse wrote:
>>> On Tue, Jan 22, 2019 at 04:24:59PM +0100, Jan Kara wrote:
>>>> On Thu 17-01-19 10:17:59, Jerome Glisse wrote:
>>>>> On Thu, Jan 17, 2019 at 10:30:47AM +0100, Jan Kara wrote:
>>>>>> On Wed 16-01-19 08:08:14, Jerome Glisse wrote:
>>>>>>> On Wed, Jan 16, 2019 at 12:38:19PM +0100, Jan Kara wrote:
>>>>>>>> On Tue 15-01-19 09:07:59, Jan Kara wrote:
>>>>>>>>> Agreed. So with page lock it would actually look like:
>>>>>>>>>
>>>>>>>>> get_page_pin()
>>>>>>>>> 	lock_page(page);
>>>>>>>>> 	wait_for_stable_page();
>>>>>>>>> 	atomic_add(&page->_refcount, PAGE_PIN_BIAS);
>>>>>>>>> 	unlock_page(page);
>>>>>>>>>
>>>>>>>>> And if we perform page_pinned() check under page lock, then if
>>>>>>>>> page_pinned() returned false, we are sure page is not and will not be
>>>>>>>>> pinned until we drop the page lock (and also until page writeback is
>>>>>>>>> completed if needed).
>>>>>>>>
>>>>>>>> After some more though, why do we even need wait_for_stable_page() and
>>>>>>>> lock_page() in get_page_pin()?
>>>>>>>>
>>>>>>>> During writepage page_mkclean() will write protect all page tables. So
>>>>>>>> there can be no new writeable GUP pins until we unlock the page as all such
>>>>>>>> GUPs will have to first go through fault and ->page_mkwrite() handler. And
>>>>>>>> that will wait on page lock and do wait_for_stable_page() for us anyway.
>>>>>>>> Am I just confused?
>>>>>>>
>>>>>>> Yeah with page lock it should synchronize on the pte but you still
>>>>>>> need to check for writeback iirc the page is unlocked after file
>>>>>>> system has queue up the write and thus the page can be unlock with
>>>>>>> write back pending (and PageWriteback() == trye) and i am not sure
>>>>>>> that in that states we can safely let anyone write to that page. I
>>>>>>> am assuming that in some case the block device also expect stable
>>>>>>> page content (RAID stuff).
>>>>>>>
>>>>>>> So the PageWriteback() test is not only for racing page_mkclean()/
>>>>>>> test_set_page_writeback() and GUP but also for pending write back.
>>>>>>
>>>>>> But this is prevented by wait_for_stable_page() that is already present in
>>>>>> ->page_mkwrite() handlers. Look:
>>>>>>
>>>>>> ->writepage()
>>>>>>   /* Page is locked here */
>>>>>>   clear_page_dirty_for_io(page)
>>>>>>     page_mkclean(page)
>>>>>>       -> page tables get writeprotected
>>>>>>     /* The following line will be added by our patches */
>>>>>>     if (page_pinned(page)) -> bounce
>>>>>>     TestClearPageDirty(page)
>>>>>>   set_page_writeback(page);
>>>>>>   unlock_page(page);
>>>>>>   ...submit_io...
>>>>>>
>>>>>> IRQ
>>>>>>   - IO completion
>>>>>>   end_page_writeback()
>>>>>>
>>>>>> So if GUP happens before page_mkclean() writeprotects corresponding PTE
>>>>>> (and these two actions are synchronized on the PTE lock), page_pinned()
>>>>>> will see the increment and report the page as pinned.
>>>>>>
>>>>>> If GUP happens after page_mkclean() writeprotects corresponding PTE, it
>>>>>> will fault:
>>>>>>   handle_mm_fault()
>>>>>>     do_wp_page()
>>>>>>       wp_page_shared()
>>>>>>         do_page_mkwrite()
>>>>>>           ->page_mkwrite() - that is block_page_mkwrite() or
>>>>>> 	    iomap_page_mkwrite() or whatever filesystem provides
>>>>>> 	  lock_page(page)
>>>>>>           ... prepare page ...
>>>>>> 	  wait_for_stable_page(page) -> this blocks until IO completes
>>>>>> 	    if someone cares about pages not being modified while under IO.
>>>>>
>>>>> The case i am worried is GUP see pte with write flag set but has not
>>>>> lock the page yet (GUP is get pte first, then pte to page then lock
>>>>> page), then it locks the page but the lock page can make it wait for a
>>>>> racing page_mkclean()...write back that have not yet write protected
>>>>> the pte the GUP just read. So by the time GUP has the page locked the
>>>>> pte it read might no longer have the write flag set. Hence why you need
>>>>> to also check for write back after taking the page lock. Alternatively
>>>>> you could recheck the pte after a successful try_lock on the page.
>>>>
>>>> This isn't really possible. GUP does:
>>>>
>>>> get_user_pages()
>>>> ...
>>>>   follow_page_mask()
>>>>   ...
>>>>     follow_page_pte()
>>>>       ptep = pte_offset_map_lock()
>>>>       check permissions and page sanity
>>>>       if (flags & FOLL_GET)
>>>>         get_page(page); -> this would become
>>>> 	  atomic_add(&page->_refcount, PAGE_PIN_BIAS);
>>>>       pte_unmap_unlock(ptep, ptl);
>>>>
>>>> page_mkclean() on the other hand grabs the same pte lock to change the pte
>>>> to write-protected. So after page_mkclean() has modified the PTE we are
>>>> racing on for access, we are sure to either see increased _refcount or get
>>>> page fault from GUP.
>>>>
>>>> If we see increased _refcount, we bounce the page and are fine. If GUP
>>>> faults, we will wait for page lock (so wait until page is prepared for IO
>>>> and has PageWriteback set) while handling the fault, then enter
>>>> ->page_mkwrite, which will do wait_for_stable_page() -> wait for
>>>> outstanding writeback to complete.
>>>>
>>>> So I still conclude - no need for page lock in the GUP path at all AFAICT.
>>>> In fact we rely on the very same page fault vs page writeback synchronization
>>>> for normal user faults as well. And normal user mmap access is even nastier
>>>> than GUP access because the CPU reads page tables without taking PTE lock.
>>>
>>> For the "slow" GUP path you are right you do not need a lock as the
>>> page table lock give you the ordering. For the GUP fast path you
>>> would either need the lock or the memory barrier with the test for
>>> page write back.
>>>
>>> Maybe an easier thing is to convert GUP fast to try to take the page
>>> table lock if it fails taking the page table lock then we fall back
>>> to slow GUP path. Otherwise then we have the same garantee as the slow
>>> path.
>>
>> You're right I was looking at the wrong place for GUP_fast() path. But I
>> still don't think anything special (i.e. page lock or new barrier) is
>> necessary. GUP_fast() takes care already now that it cannot race with page
>> unmapping or write-protection (as there are other places in MM that rely on
>> this). Look, gup_pte_range() has:
>>
>>                 if (!page_cache_get_speculative(head))
>>                         goto pte_unmap;
>>
>>                 if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>>                         put_page(head);
>>                         goto pte_unmap;
>>                 }
>>
>> So that page_cache_get_speculative() will become
>> page_cache_pin_speculative() to increment refcount by PAGE_PIN_BIAS instead
>> of 1. That is atomic ordered operation so it cannot be reordered with the
>> following check that PTE stayed same. So once page_mkclean() write-protects
>> PTE, there can be no new pins from GUP_fast() and we are sure all
>> succeeding pins are visible in page->_refcount after page_mkclean()
>> completes. Again this is nothing new, other mm code already relies on
>> either seeing page->_refcount incremented or GUP fast bailing out (e.g. DAX
>> relies on this). Although strictly speaking I'm not 100% sure what prevents
>> page->_refcount load to be speculatively reordered before PTE update even
>> in current places using this but there's so much stuff inbetween that
>> there's probably something ;). But we could add smp_rmb() after
>> page_mkclean() before changing page_pinned() for the peace of mind I guess.
> 
> Yeah i think you are right, i missed the check on same pte value
> and the atomic inc in page_cache_get_speculative() is a barrier.
> I do not think the barrier would be necessary as page_mkclean is
> taking and dropping locks so those should have enough barriering.
> 

Hi Jan, Jerome,

OK, this seems to be up and running locally, but while putting together 
documentation and polishing up things, I noticed that there is one last piece 
that I don't quite understand, after all. The page_cache_get_speculative() 
existing documentation explains how refcount synchronizes these things, but I
don't see how that helps with synchronization page_mkclean and gup, in this 
situation:

    gup_fast gets the refcount and rechecks the pte hasn't changed

    meanwhile, page_mkclean...wait, how does refcount come into play here?
    page_mkclean can remove the mapping and insert a write-protected pte, 
    regardless of page refcount, correct?  Help? :)


thanks,
-- 
John Hubbard
NVIDIA
