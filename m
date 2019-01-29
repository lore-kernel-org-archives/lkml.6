Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D80FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA2F2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfA2KMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:12:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:36912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbfA2KMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:12:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AA14B036;
        Tue, 29 Jan 2019 10:12:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D8741E3FEA; Tue, 29 Jan 2019 11:12:25 +0100 (CET)
Date:   Tue, 29 Jan 2019 11:12:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190129101225.GB29981@quack2.suse.cz>
References: <20190116130813.GA3617@redhat.com>
 <20190117093047.GB9378@quack2.suse.cz>
 <20190117151759.GA3550@redhat.com>
 <20190122152459.GG13149@quack2.suse.cz>
 <20190122164613.GA3188@redhat.com>
 <20190123180230.GN13149@quack2.suse.cz>
 <20190123190409.GF3097@redhat.com>
 <8492163b-8c50-6ea2-8bc9-8c445495ecb4@nvidia.com>
 <20190129012312.GB3359@redhat.com>
 <3c3bb2a3-907b-819d-83ee-2b29802a5bda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3bb2a3-907b-819d-83ee-2b29802a5bda@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 22:41:41, John Hubbard wrote:
> On 1/28/19 5:23 PM, Jerome Glisse wrote:
> > On Mon, Jan 28, 2019 at 04:22:16PM -0800, John Hubbard wrote:
> > > On 1/23/19 11:04 AM, Jerome Glisse wrote:
> > > > On Wed, Jan 23, 2019 at 07:02:30PM +0100, Jan Kara wrote:
> > > > > On Tue 22-01-19 11:46:13, Jerome Glisse wrote:
> > > > > > On Tue, Jan 22, 2019 at 04:24:59PM +0100, Jan Kara wrote:
> > > > > > > On Thu 17-01-19 10:17:59, Jerome Glisse wrote:
> > > > > > > > On Thu, Jan 17, 2019 at 10:30:47AM +0100, Jan Kara wrote:
> > > > > > > > > On Wed 16-01-19 08:08:14, Jerome Glisse wrote:
> > > > > > > > > > On Wed, Jan 16, 2019 at 12:38:19PM +0100, Jan Kara wrote:
> > > > > > > > > > > On Tue 15-01-19 09:07:59, Jan Kara wrote:
> > > > > > > > > > > > Agreed. So with page lock it would actually look like:
> > > > > > > > > > > > 
> > > > > > > > > > > > get_page_pin()
> > > > > > > > > > > > 	lock_page(page);
> > > > > > > > > > > > 	wait_for_stable_page();
> > > > > > > > > > > > 	atomic_add(&page->_refcount, PAGE_PIN_BIAS);
> > > > > > > > > > > > 	unlock_page(page);
> > > > > > > > > > > > 
> > > > > > > > > > > > And if we perform page_pinned() check under page lock, then if
> > > > > > > > > > > > page_pinned() returned false, we are sure page is not and will not be
> > > > > > > > > > > > pinned until we drop the page lock (and also until page writeback is
> > > > > > > > > > > > completed if needed).
> > > > > > > > > > > 
> > > > > > > > > > > After some more though, why do we even need wait_for_stable_page() and
> > > > > > > > > > > lock_page() in get_page_pin()?
> > > > > > > > > > > 
> > > > > > > > > > > During writepage page_mkclean() will write protect all page tables. So
> > > > > > > > > > > there can be no new writeable GUP pins until we unlock the page as all such
> > > > > > > > > > > GUPs will have to first go through fault and ->page_mkwrite() handler. And
> > > > > > > > > > > that will wait on page lock and do wait_for_stable_page() for us anyway.
> > > > > > > > > > > Am I just confused?
> > > > > > > > > > 
> > > > > > > > > > Yeah with page lock it should synchronize on the pte but you still
> > > > > > > > > > need to check for writeback iirc the page is unlocked after file
> > > > > > > > > > system has queue up the write and thus the page can be unlock with
> > > > > > > > > > write back pending (and PageWriteback() == trye) and i am not sure
> > > > > > > > > > that in that states we can safely let anyone write to that page. I
> > > > > > > > > > am assuming that in some case the block device also expect stable
> > > > > > > > > > page content (RAID stuff).
> > > > > > > > > > 
> > > > > > > > > > So the PageWriteback() test is not only for racing page_mkclean()/
> > > > > > > > > > test_set_page_writeback() and GUP but also for pending write back.
> > > > > > > > > 
> > > > > > > > > But this is prevented by wait_for_stable_page() that is already present in
> > > > > > > > > ->page_mkwrite() handlers. Look:
> > > > > > > > > 
> > > > > > > > > ->writepage()
> > > > > > > > >    /* Page is locked here */
> > > > > > > > >    clear_page_dirty_for_io(page)
> > > > > > > > >      page_mkclean(page)
> > > > > > > > >        -> page tables get writeprotected
> > > > > > > > >      /* The following line will be added by our patches */
> > > > > > > > >      if (page_pinned(page)) -> bounce
> > > > > > > > >      TestClearPageDirty(page)
> > > > > > > > >    set_page_writeback(page);
> > > > > > > > >    unlock_page(page);
> > > > > > > > >    ...submit_io...
> > > > > > > > > 
> > > > > > > > > IRQ
> > > > > > > > >    - IO completion
> > > > > > > > >    end_page_writeback()
> > > > > > > > > 
> > > > > > > > > So if GUP happens before page_mkclean() writeprotects corresponding PTE
> > > > > > > > > (and these two actions are synchronized on the PTE lock), page_pinned()
> > > > > > > > > will see the increment and report the page as pinned.
> > > > > > > > > 
> > > > > > > > > If GUP happens after page_mkclean() writeprotects corresponding PTE, it
> > > > > > > > > will fault:
> > > > > > > > >    handle_mm_fault()
> > > > > > > > >      do_wp_page()
> > > > > > > > >        wp_page_shared()
> > > > > > > > >          do_page_mkwrite()
> > > > > > > > >            ->page_mkwrite() - that is block_page_mkwrite() or
> > > > > > > > > 	    iomap_page_mkwrite() or whatever filesystem provides
> > > > > > > > > 	  lock_page(page)
> > > > > > > > >            ... prepare page ...
> > > > > > > > > 	  wait_for_stable_page(page) -> this blocks until IO completes
> > > > > > > > > 	    if someone cares about pages not being modified while under IO.
> > > > > > > > 
> > > > > > > > The case i am worried is GUP see pte with write flag set but has not
> > > > > > > > lock the page yet (GUP is get pte first, then pte to page then lock
> > > > > > > > page), then it locks the page but the lock page can make it wait for a
> > > > > > > > racing page_mkclean()...write back that have not yet write protected
> > > > > > > > the pte the GUP just read. So by the time GUP has the page locked the
> > > > > > > > pte it read might no longer have the write flag set. Hence why you need
> > > > > > > > to also check for write back after taking the page lock. Alternatively
> > > > > > > > you could recheck the pte after a successful try_lock on the page.
> > > > > > > 
> > > > > > > This isn't really possible. GUP does:
> > > > > > > 
> > > > > > > get_user_pages()
> > > > > > > ...
> > > > > > >    follow_page_mask()
> > > > > > >    ...
> > > > > > >      follow_page_pte()
> > > > > > >        ptep = pte_offset_map_lock()
> > > > > > >        check permissions and page sanity
> > > > > > >        if (flags & FOLL_GET)
> > > > > > >          get_page(page); -> this would become
> > > > > > > 	  atomic_add(&page->_refcount, PAGE_PIN_BIAS);
> > > > > > >        pte_unmap_unlock(ptep, ptl);
> > > > > > > 
> > > > > > > page_mkclean() on the other hand grabs the same pte lock to change the pte
> > > > > > > to write-protected. So after page_mkclean() has modified the PTE we are
> > > > > > > racing on for access, we are sure to either see increased _refcount or get
> > > > > > > page fault from GUP.
> > > > > > > 
> > > > > > > If we see increased _refcount, we bounce the page and are fine. If GUP
> > > > > > > faults, we will wait for page lock (so wait until page is prepared for IO
> > > > > > > and has PageWriteback set) while handling the fault, then enter
> > > > > > > ->page_mkwrite, which will do wait_for_stable_page() -> wait for
> > > > > > > outstanding writeback to complete.
> > > > > > > 
> > > > > > > So I still conclude - no need for page lock in the GUP path at all AFAICT.
> > > > > > > In fact we rely on the very same page fault vs page writeback synchronization
> > > > > > > for normal user faults as well. And normal user mmap access is even nastier
> > > > > > > than GUP access because the CPU reads page tables without taking PTE lock.
> > > > > > 
> > > > > > For the "slow" GUP path you are right you do not need a lock as the
> > > > > > page table lock give you the ordering. For the GUP fast path you
> > > > > > would either need the lock or the memory barrier with the test for
> > > > > > page write back.
> > > > > > 
> > > > > > Maybe an easier thing is to convert GUP fast to try to take the page
> > > > > > table lock if it fails taking the page table lock then we fall back
> > > > > > to slow GUP path. Otherwise then we have the same garantee as the slow
> > > > > > path.
> > > > > 
> > > > > You're right I was looking at the wrong place for GUP_fast() path. But I
> > > > > still don't think anything special (i.e. page lock or new barrier) is
> > > > > necessary. GUP_fast() takes care already now that it cannot race with page
> > > > > unmapping or write-protection (as there are other places in MM that rely on
> > > > > this). Look, gup_pte_range() has:
> > > > > 
> > > > >                  if (!page_cache_get_speculative(head))
> > > > >                          goto pte_unmap;
> > > > > 
> > > > >                  if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > > > >                          put_page(head);
> > > > >                          goto pte_unmap;
> > > > >                  }
> > > > > 
> > > > > So that page_cache_get_speculative() will become
> > > > > page_cache_pin_speculative() to increment refcount by PAGE_PIN_BIAS instead
> > > > > of 1. That is atomic ordered operation so it cannot be reordered with the
> > > > > following check that PTE stayed same. So once page_mkclean() write-protects
> > > > > PTE, there can be no new pins from GUP_fast() and we are sure all
> > > > > succeeding pins are visible in page->_refcount after page_mkclean()
> > > > > completes. Again this is nothing new, other mm code already relies on
> > > > > either seeing page->_refcount incremented or GUP fast bailing out (e.g. DAX
> > > > > relies on this). Although strictly speaking I'm not 100% sure what prevents
> > > > > page->_refcount load to be speculatively reordered before PTE update even
> > > > > in current places using this but there's so much stuff inbetween that
> > > > > there's probably something ;). But we could add smp_rmb() after
> > > > > page_mkclean() before changing page_pinned() for the peace of mind I guess.
> > > > 
> > > > Yeah i think you are right, i missed the check on same pte value
> > > > and the atomic inc in page_cache_get_speculative() is a barrier.
> > > > I do not think the barrier would be necessary as page_mkclean is
> > > > taking and dropping locks so those should have enough barriering.
> > > > 
> > > 
> > > Hi Jan, Jerome,
> > > 
> > > OK, this seems to be up and running locally, but while putting together
> > > documentation and polishing up things, I noticed that there is one last piece
> > > that I don't quite understand, after all. The page_cache_get_speculative()
> > > existing documentation explains how refcount synchronizes these things, but I
> > > don't see how that helps with synchronization page_mkclean and gup, in this
> > > situation:
> > > 
> > >      gup_fast gets the refcount and rechecks the pte hasn't changed
> > > 
> > >      meanwhile, page_mkclean...wait, how does refcount come into play here?
> > >      page_mkclean can remove the mapping and insert a write-protected pte,
> > >      regardless of page refcount, correct?  Help? :)
> > 
> > Correct, page_mkclean() does not check the refcount and do not need to
> > check it. We need to check for the page pin after the page_mkclean when
> > code is done prepping the page for io (clear_page_dirty_for_io).
> > 
> > The race Jan and I were discussing was about wether we needed to lock
> > the page or not and we do not. For slow path page_mkclean and GUP_slow
> > will synchronize on the page table lock. For GUP_fast the fast code will
> > back off if the pte is not the same and thus either we see the pin after
> > page_mkclean() or GUP_fast back off. You will never have code that miss
> > the pin after page_mkclean() and GUP_fast that did not back off.
> 
> Here is the case I'm wondering about:
> 
> thread A                             thread B
> --------                             --------
>                                      gup_fast
> page_mkclean
>     is page gup-pinned?(no)
>                                          page_cache_get_speculative
>                                              (gup-pins the page here)
>                                          check pte_val unchanged (yes)
>        set_pte_at()
> 
> ...and now thread A has created a read-only PTE, after gup_fast walked
> the page tables and found a writeable entry. And so far, thread A has
> not seen that the page is pinned.
> 
> What am I missing here? The above seems like a problem even before we
> change anything.

Your implementation of page_mkclean() is wrong :) It needs to first call
set_pte_at() and only after that ask "is page gup pinned?". In fact,
page_mkclean() probably has no bussiness in checking for page pins
whatsoever. It is clear_page_dirty_for_io() that cares, so that should
check for page pins after page_mkclean() has returned.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
