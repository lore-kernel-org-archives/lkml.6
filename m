Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEDCC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B510C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B2tzWU6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B510C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeLNDwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:52:39 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15481 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLNDwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:52:38 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1329000000>; Thu, 13 Dec 2018 19:52:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 13 Dec 2018 19:52:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 13 Dec 2018 19:52:35 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 03:52:35 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Dave Chinner <david@fromorbit.com>,
        Jerome Glisse <jglisse@redhat.com>
CC:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
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
References: <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <20181212214641.GB29416@dastard>
 <20181212215931.GG5037@redhat.com> <20181213005119.GD29416@dastard>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
Date:   Thu, 13 Dec 2018 19:52:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213005119.GD29416@dastard>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544759552; bh=6xYVY0tXIY9tCF5suFjsryy8ZqsydFEfNMSOISwBRQg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=B2tzWU6Gx7arMwhBcjbutix2zab1z0Ae7JSjOkWdmXSamYVVriZkWw+GmMcKf6i+6
         m6HVTB9/NQrHzpH3szkxWMSBotBF32FtZnMRY+mfWAkxuVMwJpZHSRLBEMI7wvE0zR
         qA+52Ip+HvUzbeKwsDHlLXbeZ9ZlAEf0RXDz+CjrccVhX2h/B8lVgKbYNZA6u3l9hB
         6CxJPTxrOKlk6kob/inxF8xlbnXc3J+fcpQbcF/TA0oeGCtH7ARjFUTyisbxJurUg/
         GB7BFsBMHklFFWQrGD6OOUMeNPTjqTeFk+JlGZ0SQHUbb/rKCnSxFL73h3NrOeuqmR
         NJhv03ESra1Kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 4:51 PM, Dave Chinner wrote:
> On Wed, Dec 12, 2018 at 04:59:31PM -0500, Jerome Glisse wrote:
>> On Thu, Dec 13, 2018 at 08:46:41AM +1100, Dave Chinner wrote:
>>> On Wed, Dec 12, 2018 at 10:03:20AM -0500, Jerome Glisse wrote:
>>>> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
>>>>> On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
>>>>> So this approach doesn't look like a win to me over using counter in struct
>>>>> page and I'd rather try looking into squeezing HMM public page usage of
>>>>> struct page so that we can fit that gup counter there as well. I know that
>>>>> it may be easier said than done...
>>>>

Agreed. After all the discussion this week, I'm thinking that the original idea
of a per-struct-page counter is better. Fortunately, we can do the moral equivalent 
of that, unless I'm overlooking something: Jerome had another proposal that he
described, off-list, for doing that counting, and his idea avoids the problem of 
finding space in struct page. (And in fact, when I responded yesterday, I initially 
thought that's where he was going with this.)

So how about this hybrid solution:

1. Stay with the basic RFC approach of using a per-page counter, but actually
store the counter(s) in the mappings instead of the struct page. We can use
!PageAnon and page_mapping to look up all the mappings, stash the dma_pinned_count
there. So the total pinned count is scattered across mappings. Probably still need
a PageDmaPinned bit.

Thanks again to Jerome for coming up with that idea, and I hope I haven't missed
a critical point or misrepresented it.

2. put_user_page() would still restrict itself to managing PageDmaPinned and
dma_pinned_count, as before. No messing with page_mkwrite or anything that
requires lock_page():

void put_user_page(struct page *page)
{
	if (PageAnon(page))
		put_page(page);
	else {
		/* Approximately: Check PageDmaPinned, look up dma_pinned_count
		 * via page_mapping's, decrement the appropriate
		 * mapping's dma_pinned_count. Clear PageDmaPinned
		 * if dma_pinned_count hits zero.
		 */

	...
}

I'm not sure how tricky finding the "appropriate" mapping is, but it seems 
like just comparing current->mm information with the mappings should do it.

3. And as before, use PageDmaPinned to decide what to do in page_mkclean() and
try_to_unmap().

Maybe here is the part where someone says, "you should have created the actual
patchset, instead of typing all those words". But I'm still hoping to get some
consensus first. :)

one more note below...

>>>> So i want back to the drawing board and first i would like to ascertain
>>>> that we all agree on what the objectives are:
>>>>
>>>>     [O1] Avoid write back from a page still being written by either a
>>>>          device or some direct I/O or any other existing user of GUP.
> 
> IOWs, you need to mark pages being written to by a GUP as
> PageWriteback, so all attempts to write the page will block on
> wait_on_page_writeback() before trying to write the dirty page.
> 
>>>>          This would avoid possible file system corruption.
> 
> This isn't a filesystem corruption vector. At worst, it could cause
> torn data writes due to updating the page while it is under IO. We
> have a name for this: "stable pages". This is designed to prevent
> updates to pages via mmap writes from causing corruption of things
> like MD RAID due to modification of the data during RAID parity
> calculations. Hence we have wait_for_stable_page() calls in all
> ->page_mkwrite implementations so that new mmap writes block until
> writeback IO is complete on the devices that require stable pages
> to prevent corruption.
> 
> IOWs, we already deal with this "delay new modification while
> writeback is in progress" problem in the mmap/filesystem world and
> have infrastructure to handle it. And the ->page_mkwrite code
> already deals with it.
> 
>>>>
>>>>     [O2] Avoid crash when set_page_dirty() is call on a page that is
>>>>          considered clean by core mm (buffer head have been remove and
>>>>          with some file system this turns into an ugly mess).
>>>
>>> I think that's wrong. This isn't an "avoid a crash" case, this is a
>>> "prevent data and/or filesystem corruption" case. The primary goal
>>> we have here is removing our exposure to potential corruption, which
>>> has the secondary effect of avoiding the crash/panics that currently
>>> occur as a result of inconsistent page/filesystem state.
>>
>> This is O1 avoid corruption is O1
> 
> It's "avoid a specific instance of data corruption", not a general
> mechanism for avoiding data/filesystem corruption.
> 
> Calling set_page_dirty() on a file backed page which has not been
> correctly prepared can cause data corruption, filesystem coruption
> and shutdowns, etc because we have dirty data over a region that is
> not correctly mapped. Yes, it can also cause a crash (because we
> really, really suck at validation and error handling in generic code
> paths), but there's so, so much more that can go wrong than crash
> the kernel when we do stupid shit like this.
> 
>>> i.e. The goal is to have ->page_mkwrite() called on the clean page
>>> /before/ the file-backed page is marked dirty, and hence we don't
>>> expose ourselves to potential corruption or crashes that are a
>>> result of inappropriately calling set_page_dirty() on clean
>>> file-backed pages.
>>
>> Yes and this would be handle by put_user_page ie:
> 
> No, put_user_page() is too late - it's after the DMA has completed,
> but we have to ensure the file has backing store allocated and the
> pages are in the correct state /before/ the DMA is done.
> 
> Think ENOSPC - that has to be handled before we do the DMA, not
> after. Before the DMA it is a recoverable error, after the DMA it is
> data loss/corruption failure.
> 
>> put_user_page(struct page *page, bool dirty)
>> {
>>     if (!PageAnon(page)) {
>>         if (dirty) {
>>             // Do the whole dance ie page_mkwrite and all before
>>             // calling set_page_dirty()
>>         }
>>         ...
>>     }
>>     ...
>> }
> 
> Essentially, doing this would require a whole new "dirty a page"
> infrastructure because it is in the IO path, not the page fault
> path.
> 
> And, for hardware that does it's own page faults for DMA, this whole
> post-DMA page setup is broken because the pages will have already
> gone through ->page_mkwrite() and be set up correctly already.
> 
>>>> For [O2] i believe we can handle that case in the put_user_page()
>>>> function to properly dirty the page without causing filesystem
>>>> freak out.
>>>
>>> I'm pretty sure you can't call ->page_mkwrite() from
>>> put_user_page(), so I don't think this is workable at all.
>>
>> Hu why ? i can not think of any reason whike you could not. User of
> 
> It's not a fault path, you can't safely lock pages, you can't take
> fault-path only locks in the IO path (mmap_sem inversion problems),
> etc.
> 

Yes, I looked closer at ->page_mkwrite (ext4_page_mkwrite, for example),
and it's clearly doing lock_page(), so it does seem like this particular
detail (calling page_mkwrite from put_user_page) is dead.

> /me has a nagging feeling this was all explained in a previous
> discussions of this patchset...
> 

Yes, lots of related discussion definitely happened already, for example
this October thread covered page_mkwrite and interactions with gup:

https://lore.kernel.org/r/20181001061127.GQ31060@dastard

...but so far, this is the first time I recall seeing a proposal to call
page_mkwrite from put_user_page. 


thanks,
-- 
John Hubbard
NVIDIA
