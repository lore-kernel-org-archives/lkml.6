Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CEFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F242184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dSUi+k5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeLRX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:29:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18683 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeLRX3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:29:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1982d60000>; Tue, 18 Dec 2018 15:29:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Dec 2018 15:29:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 15:29:35 -0800
Received: from [10.2.165.33] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 23:29:34 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
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
References: <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz> <20181216215819.GC10644@dastard>
 <20181217181148.GA3341@redhat.com>
 <20181217183443.GO10600@bombadil.infradead.org>
 <20181218093017.GB18032@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9f43d124-2386-7bfd-d90b-4d0417f51ccd@nvidia.com>
Date:   Tue, 18 Dec 2018 15:29:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181218093017.GB18032@quack2.suse.cz>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545175766; bh=2TfDXwNT47vgNfw8MvfnpjdCFl0Z+qp69nHDp3I2aOY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dSUi+k5T3gQFPL/MBmnEJ0P6Mx6jwC8E1nn5j2ExlEL1xQwHUcn5NeTQgdOgBFapa
         X2ikwz1UqGs2Ceyo7ShKm5Idda/j5J9tlNyfSBMhrPWaiz2I/cLIetjgiUJv0hmBZD
         rKvC/a+iYvB8pg1b6+OQkuGxYDmBkBdvmkPZTFAk+sg//ZCWpd+T3k1HN+MA1SxkMl
         GBIIwG2aGleT6Bm8ODrcokuXsNlGc+eT3vAZSfefoq/jviBMJ+T1gaxzOOeXE+S1yV
         tMKGWOJTkuBYEvxNuBbUJoGbQSl7TMrJJy1hybQm3OwVyFEv6RTfgfKtOzqn4byVrz
         gkSWBFAXDdfbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 1:30 AM, Jan Kara wrote:
> On Mon 17-12-18 10:34:43, Matthew Wilcox wrote:
>> On Mon, Dec 17, 2018 at 01:11:50PM -0500, Jerome Glisse wrote:
>>> On Mon, Dec 17, 2018 at 08:58:19AM +1100, Dave Chinner wrote:
>>>> Sure, that's a possibility, but that doesn't close off any race
>>>> conditions because there can be DMA into the page in progress while
>>>> the page is being bounced, right? AFAICT this ext3+DIF/DIX case is
>>>> different in that there is no 3rd-party access to the page while it
>>>> is under IO (ext3 arbitrates all access to it's metadata), and so
>>>> nothing can actually race for modification of the page between
>>>> submission and bouncing at the block layer.
>>>>
>>>> In this case, the moment the page is unlocked, anyone else can map
>>>> it and start (R)DMA on it, and that can happen before the bio is
>>>> bounced by the block layer. So AFAICT, block layer bouncing doesn't
>>>> solve the problem of racing writeback and DMA direct to the page we
>>>> are doing IO on. Yes, it reduces the race window substantially, but
>>>> it doesn't get rid of it.
>>>
>>> So the event flow is:
>>>     - userspace create object that match a range of virtual address
>>>       against a given kernel sub-system (let's say infiniband) and
>>>       let's assume that the range is an mmap() of a regular file
>>>     - device driver do GUP on the range (let's assume it is a write
>>>       GUP) so if the page is not already map with write permission
>>>       in the page table than a page fault is trigger and page_mkwrite
>>>       happens
>>>     - Once GUP return the page to the device driver and once the
>>>       device driver as updated the hardware states to allow access
>>>       to this page then from that point on hardware can write to the
>>>       page at _any_ time, it is fully disconnected from any fs event
>>>       like write back, it fully ignore things like page_mkclean
>>>
>>> This is how it is to day, we allowed people to push upstream such
>>> users of GUP. This is a fact we have to live with, we can not stop
>>> hardware access to the page, we can not force the hardware to follow
>>> page_mkclean and force a page_mkwrite once write back ends. This is
>>> the situation we are inheriting (and i am personnaly not happy with
>>> that).
>>>
>>> >From my point of view we are left with 2 choices:
>>>     [C1] break all drivers that do not abide by the page_mkclean and
>>>          page_mkwrite
>>>     [C2] mitigate as much as possible the issue
>>>
>>> For [C2] the idea is to keep track of GUP per page so we know if we
>>> can expect the page to be written to at any time. Here is the event
>>> flow:
>>>     - driver GUP the page and program the hardware, page is mark as
>>>       GUPed
>>>     ...
>>>     - write back kicks in on the dirty page, lock the page and every
>>>       thing as usual , sees it is GUPed and inform the block layer to
>>>       use a bounce page
>>
>> No.  The solution John, Dan & I have been looking at is to take the
>> dirty page off the LRU while it is pinned by GUP.  It will never be
>> found for writeback.
>>
>> That's not the end of the story though.  Other parts of the kernel (eg
>> msync) also need to be taught to stay away from pages which are pinned
>> by GUP.  But the idea is that no page gets written back to storage while
>> it's pinned by GUP.  Only when the last GUP ends is the page returned
>> to the list of dirty pages.
> 
> We've been through this in:
> 
> https://lore.kernel.org/lkml/20180709194740.rymbt2fzohbdmpye@quack2.suse.cz/
> 
> back in July. You cannot just skip pages for fsync(2). So as I wrote above -
> memory cleaning writeback can skip pinned pages. Data integrity writeback
> must be able to write pinned pages. And bouncing is one reasonable way how
> to do that.
> 
> This writeback decision is pretty much independent from the mechanism by
> which we are going to identify pinned pages. Whether that's going to be
> separate counter in struct page, using page->_mapcount, or separately
> allocated data structure as you know promote.
> 
> I currently like the most the _mapcount suggestion from Jerome but I'm not
> really attached to any solution as long as it performs reasonably and
> someone can make it working :) as I don't have time to implement it at
> least till January.
> 

OK, so let's take another look at Jerome's _mapcount idea all by itself (using
*only* the tracking pinned pages aspect), given that it is the lightest weight
solution for that.  

So as I understand it, this would use page->_mapcount to store both the real
mapcount, and the dma pinned count (simply added together), but only do so for
file-backed (non-anonymous) pages:


__get_user_pages()
{
	...
	get_page(page);

	if (!PageAnon)
		atomic_inc(page->_mapcount);
	...
}

put_user_page(struct page *page)
{
	...
	if (!PageAnon)
		atomic_dec(&page->_mapcount);

	put_page(page);
	...
}

...and then in the various consumers of the DMA pinned count, we use page_mapped(page)
to see if any mapcount remains, and if so, we treat it as DMA pinned. Is that what you 
had in mind?


-- 
thanks,
John Hubbard
NVIDIA
