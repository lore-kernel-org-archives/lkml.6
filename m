Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EF6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83D720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IAz39Aah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfAQFm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:42:28 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11892 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfAQFm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:42:27 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4015b30000>; Wed, 16 Jan 2019 21:42:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Jan 2019 21:42:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Jan 2019 21:42:26 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 17 Jan
 2019 05:42:26 +0000
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
References: <20190111165141.GB3190@redhat.com>
 <1b37061c-5598-1b02-2983-80003f1c71f2@nvidia.com>
 <20190112020228.GA5059@redhat.com>
 <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
 <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190114145447.GJ13316@quack2.suse.cz> <20190114172124.GA3702@redhat.com>
 <20190115080759.GC29524@quack2.suse.cz>
 <20190116113819.GD26069@quack2.suse.cz> <20190116130813.GA3617@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <5c6dc6ed-4c8d-bce7-df02-ee8b7785b265@nvidia.com>
Date:   Wed, 16 Jan 2019 21:42:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116130813.GA3617@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547703731; bh=jH/ZGeaaJ5XJcRXyximypMM2MYauuEjkZL8HoWgkj+s=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IAz39AahdVndTLswehanCPLtg27jr5a/mEiXImIIMtCDMj7otnpd8Ph8dQ6mSfyGl
         dYNy3lnBcH+ip9WsiWHfZlE1TVBW6oiPCp/Sdy+2UEqLwOlMscmEbtBec6jBvU+aT2
         uUkkCA4bIfcxwmbhFud8yVoF6x1mQDbbL6hqHHgsulGQ33ZLzT7NB4dAX5J4d72KZo
         3Zm12c0kmP0W1lVQHHK6N8ixjdyy77aXfydqvBYcPK+v020VBvuG5+y6wNw2dlzawP
         ZrHKQyIGfzr0CIjoi3EubednUc0Rxwb1tZelDVepZjFpD47rW8ZQ1bQ/+5lT3ZAyO+
         mHoc0hh68v1Bw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 5:08 AM, Jerome Glisse wrote:
> On Wed, Jan 16, 2019 at 12:38:19PM +0100, Jan Kara wrote:
>> On Tue 15-01-19 09:07:59, Jan Kara wrote:
>>> Agreed. So with page lock it would actually look like:
>>>
>>> get_page_pin()
>>> 	lock_page(page);
>>> 	wait_for_stable_page();
>>> 	atomic_add(&page->_refcount, PAGE_PIN_BIAS);
>>> 	unlock_page(page);
>>>
>>> And if we perform page_pinned() check under page lock, then if
>>> page_pinned() returned false, we are sure page is not and will not be
>>> pinned until we drop the page lock (and also until page writeback is
>>> completed if needed).
>>
>> After some more though, why do we even need wait_for_stable_page() and
>> lock_page() in get_page_pin()?
>>
>> During writepage page_mkclean() will write protect all page tables. So
>> there can be no new writeable GUP pins until we unlock the page as all such
>> GUPs will have to first go through fault and ->page_mkwrite() handler. And
>> that will wait on page lock and do wait_for_stable_page() for us anyway.
>> Am I just confused?
> 
> Yeah with page lock it should synchronize on the pte but you still
> need to check for writeback iirc the page is unlocked after file
> system has queue up the write and thus the page can be unlock with
> write back pending (and PageWriteback() == trye) and i am not sure
> that in that states we can safely let anyone write to that page. I
> am assuming that in some case the block device also expect stable
> page content (RAID stuff).
> 
> So the PageWriteback() test is not only for racing page_mkclean()/
> test_set_page_writeback() and GUP but also for pending write back.


That was how I thought it worked too: page_mkclean and a few other things
like page migration take the page lock, but writeback takes the lock, 
queues it up, then drops the lock, and writeback actually happens outside
that lock. 

So on the GUP end, some combination of taking the page lock, and 
wait_on_page_writeback(), is required in order to flush out the writebacks.
I think I just rephrased what Jerome said, actually. :)


> 
> 
>> That actually touches on another question I wanted to get opinions on. GUP
>> can be for read and GUP can be for write (that is one of GUP flags).
>> Filesystems with page cache generally have issues only with GUP for write
>> as it can currently corrupt data, unexpectedly dirty page etc.. DAX & memory
>> hotplug have issues with both (DAX cannot truncate page pinned in any way,
>> memory hotplug will just loop in kernel until the page gets unpinned). So
>> we probably want to track both types of GUP pins and page-cache based
>> filesystems will take the hit even if they don't have to for read-pins?
> 
> Yes the distinction between read and write would be nice. With the map
> count solution you can only increment the mapcount for GUP(write=true).
> With pin bias the issue is that a big number of read pin can trigger
> false positive ie you would do:
>     GUP(vaddr, write)
>         ...
>         if (write)
>             atomic_add(page->refcount, PAGE_PIN_BIAS)
>         else
>             atomic_inc(page->refcount)
> 
>     PUP(page, write)
>         if (write)
>             atomic_add(page->refcount, -PAGE_PIN_BIAS)
>         else
>             atomic_dec(page->refcount)
> 
> I am guessing false positive because of too many read GUP is ok as
> it should be unlikely and when it happens then we take the hit.
> 

I'm also intrigued by the point that read-only GUP is harmless, and we 
could just focus on the writeable case.

However, I'm rather worried about actually attempting it, because remember
that so far, each call site does no special tracking of each struct page. 
It just remembers that it needs to do a put_page(), not whether or
not that particular page was set up with writeable or read-only GUP. I mean,
sure, they often call set_page_dirty before put_page, indicating that it might
have been a writeable GUP call, but it seems sketchy to rely on that.

So actually doing this could go from merely lots of work, to K*(lots_of_work)...


thanks,
-- 
John Hubbard
NVIDIA
