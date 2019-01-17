Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B120C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1719520856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfAQPSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:18:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfAQPSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:18:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAFB9C0C05AA;
        Thu, 17 Jan 2019 15:18:05 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FD68611A1;
        Thu, 17 Jan 2019 15:18:01 +0000 (UTC)
Date:   Thu, 17 Jan 2019 10:17:59 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20190117151759.GA3550@redhat.com>
References: <20190112020228.GA5059@redhat.com>
 <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
 <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190114145447.GJ13316@quack2.suse.cz>
 <20190114172124.GA3702@redhat.com>
 <20190115080759.GC29524@quack2.suse.cz>
 <20190116113819.GD26069@quack2.suse.cz>
 <20190116130813.GA3617@redhat.com>
 <20190117093047.GB9378@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190117093047.GB9378@quack2.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 17 Jan 2019 15:18:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:30:47AM +0100, Jan Kara wrote:
> On Wed 16-01-19 08:08:14, Jerome Glisse wrote:
> > On Wed, Jan 16, 2019 at 12:38:19PM +0100, Jan Kara wrote:
> > > On Tue 15-01-19 09:07:59, Jan Kara wrote:
> > > > Agreed. So with page lock it would actually look like:
> > > > 
> > > > get_page_pin()
> > > > 	lock_page(page);
> > > > 	wait_for_stable_page();
> > > > 	atomic_add(&page->_refcount, PAGE_PIN_BIAS);
> > > > 	unlock_page(page);
> > > > 
> > > > And if we perform page_pinned() check under page lock, then if
> > > > page_pinned() returned false, we are sure page is not and will not be
> > > > pinned until we drop the page lock (and also until page writeback is
> > > > completed if needed).
> > > 
> > > After some more though, why do we even need wait_for_stable_page() and
> > > lock_page() in get_page_pin()?
> > > 
> > > During writepage page_mkclean() will write protect all page tables. So
> > > there can be no new writeable GUP pins until we unlock the page as all such
> > > GUPs will have to first go through fault and ->page_mkwrite() handler. And
> > > that will wait on page lock and do wait_for_stable_page() for us anyway.
> > > Am I just confused?
> > 
> > Yeah with page lock it should synchronize on the pte but you still
> > need to check for writeback iirc the page is unlocked after file
> > system has queue up the write and thus the page can be unlock with
> > write back pending (and PageWriteback() == trye) and i am not sure
> > that in that states we can safely let anyone write to that page. I
> > am assuming that in some case the block device also expect stable
> > page content (RAID stuff).
> > 
> > So the PageWriteback() test is not only for racing page_mkclean()/
> > test_set_page_writeback() and GUP but also for pending write back.
> 
> But this is prevented by wait_for_stable_page() that is already present in
> ->page_mkwrite() handlers. Look:
> 
> ->writepage()
>   /* Page is locked here */
>   clear_page_dirty_for_io(page)
>     page_mkclean(page)
>       -> page tables get writeprotected
>     /* The following line will be added by our patches */
>     if (page_pinned(page)) -> bounce
>     TestClearPageDirty(page)
>   set_page_writeback(page);
>   unlock_page(page);
>   ...submit_io...
> 
> IRQ
>   - IO completion
>   end_page_writeback()
> 
> So if GUP happens before page_mkclean() writeprotects corresponding PTE
> (and these two actions are synchronized on the PTE lock), page_pinned()
> will see the increment and report the page as pinned.
> 
> If GUP happens after page_mkclean() writeprotects corresponding PTE, it
> will fault:
>   handle_mm_fault()
>     do_wp_page()
>       wp_page_shared()
>         do_page_mkwrite()
>           ->page_mkwrite() - that is block_page_mkwrite() or
> 	    iomap_page_mkwrite() or whatever filesystem provides
> 	  lock_page(page)
>           ... prepare page ...
> 	  wait_for_stable_page(page) -> this blocks until IO completes
> 	    if someone cares about pages not being modified while under IO.

The case i am worried is GUP see pte with write flag set but has not
lock the page yet (GUP is get pte first, then pte to page then lock
page), then it locks the page but the lock page can make it wait for a
racing page_mkclean()...write back that have not yet write protected
the pte the GUP just read. So by the time GUP has the page locked the
pte it read might no longer have the write flag set. Hence why you need
to also check for write back after taking the page lock. Alternatively
you could recheck the pte after a successful try_lock on the page.

You can optimize out by checking also before trying to lock the page
to bail out early and avoid unecessary lock wait. But that is an
optimization. For correctness you need to check after taking the page
lock.

> 
> > > That actually touches on another question I wanted to get opinions on. GUP
> > > can be for read and GUP can be for write (that is one of GUP flags).
> > > Filesystems with page cache generally have issues only with GUP for write
> > > as it can currently corrupt data, unexpectedly dirty page etc.. DAX & memory
> > > hotplug have issues with both (DAX cannot truncate page pinned in any way,
> > > memory hotplug will just loop in kernel until the page gets unpinned). So
> > > we probably want to track both types of GUP pins and page-cache based
> > > filesystems will take the hit even if they don't have to for read-pins?
> > 
> > Yes the distinction between read and write would be nice. With the map
> > count solution you can only increment the mapcount for GUP(write=true).
> 
> Well, but if we track only pins for write, DAX or memory hotplug will not
> be able to use this mechanism. So at this point I'm more leaning towards
> tracking all pins. It will cost some performance needlessly for read pins
> and filesystems using page cache when bouncing such pages but it's not like
> writeback of pinned pages is some performance critical operation... But I
> wanted to spell this out so that people are aware of this.

No they would know for regular pin, it is just as page migrate code. If
the refcount + (extra_ref_by_the_code_checking) > mapcount then you know
someone has extra reference on your page.

Those extra references are either some regular fs event taking place (some
code doing find_get_page for instance) or a GUP reference (wether it is a
write pin or a read pin).

So the only issue is false positive, ie thinking the page is under GUP
while it has just elevated refcount because of some other regular fs/mm
event. To minimize false positive for a more accurate pin test (write or
read) you can enforce few thing:

    1 - first page lock
    2 - then freeze the page with expected counted

With that it should minimize false positive. In the end even with the bias
case you can also have false positive.

Cheers,
Jérôme
