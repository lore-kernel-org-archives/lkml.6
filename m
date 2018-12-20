Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88ABC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CCB20869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeLTQuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:50:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeLTQuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:50:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A4F8420A4;
        Thu, 20 Dec 2018 16:50:36 +0000 (UTC)
Received: from redhat.com (ovpn-123-95.rdu2.redhat.com [10.10.123.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC5BE6B644;
        Thu, 20 Dec 2018 16:50:33 +0000 (UTC)
Date:   Thu, 20 Dec 2018 11:50:31 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20181220165030.GC3963@redhat.com>
References: <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181217181148.GA3341@redhat.com>
 <20181217183443.GO10600@bombadil.infradead.org>
 <20181218093017.GB18032@quack2.suse.cz>
 <9f43d124-2386-7bfd-d90b-4d0417f51ccd@nvidia.com>
 <20181219020723.GD4347@redhat.com>
 <20181219110856.GA18345@quack2.suse.cz>
 <8e98d553-7675-8fa1-3a60-4211fc836ed9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e98d553-7675-8fa1-3a60-4211fc836ed9@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 20 Dec 2018 16:50:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 02:54:49AM -0800, John Hubbard wrote:
> On 12/19/18 3:08 AM, Jan Kara wrote:
> > On Tue 18-12-18 21:07:24, Jerome Glisse wrote:
> >> On Tue, Dec 18, 2018 at 03:29:34PM -0800, John Hubbard wrote:
> >>> OK, so let's take another look at Jerome's _mapcount idea all by itself (using
> >>> *only* the tracking pinned pages aspect), given that it is the lightest weight
> >>> solution for that.  
> >>>
> >>> So as I understand it, this would use page->_mapcount to store both the real
> >>> mapcount, and the dma pinned count (simply added together), but only do so for
> >>> file-backed (non-anonymous) pages:
> >>>
> >>>
> >>> __get_user_pages()
> >>> {
> >>> 	...
> >>> 	get_page(page);
> >>>
> >>> 	if (!PageAnon)
> >>> 		atomic_inc(page->_mapcount);
> >>> 	...
> >>> }
> >>>
> >>> put_user_page(struct page *page)
> >>> {
> >>> 	...
> >>> 	if (!PageAnon)
> >>> 		atomic_dec(&page->_mapcount);
> >>>
> >>> 	put_page(page);
> >>> 	...
> >>> }
> >>>
> >>> ...and then in the various consumers of the DMA pinned count, we use page_mapped(page)
> >>> to see if any mapcount remains, and if so, we treat it as DMA pinned. Is that what you 
> >>> had in mind?
> >>
> >> Mostly, with the extra two observations:
> >>     [1] We only need to know the pin count when a write back kicks in
> >>     [2] We need to protect GUP code with wait_for_write_back() in case
> >>         GUP is racing with a write back that might not the see the
> >>         elevated mapcount in time.
> >>
> >> So for [2]
> >>
> >> __get_user_pages()
> >> {
> >>     get_page(page);
> >>
> >>     if (!PageAnon) {
> >>         atomic_inc(page->_mapcount);
> >> +       if (PageWriteback(page)) {
> >> +           // Assume we are racing and curent write back will not see
> >> +           // the elevated mapcount so wait for current write back and
> >> +           // force page fault
> >> +           wait_on_page_writeback(page);
> >> +           // force slow path that will fault again
> >> +       }
> >>     }
> >> }
> > 
> > This is not needed AFAICT. __get_user_pages() gets page reference (and it
> > should also increment page->_mapcount) under PTE lock. So at that point we
> > are sure we have writeable PTE nobody can change. So page_mkclean() has to
> > block on PTE lock to make PTE read-only and only after going through all
> > PTEs like this, it can check page->_mapcount. So the PTE lock provides
> > enough synchronization.
> > 
> >> For [1] only needing pin count during write back turns page_mkclean into
> >> the perfect spot to check for that so:
> >>
> >> int page_mkclean(struct page *page)
> >> {
> >>     int cleaned = 0;
> >> +   int real_mapcount = 0;
> >>     struct address_space *mapping;
> >>     struct rmap_walk_control rwc = {
> >>         .arg = (void *)&cleaned,
> >>         .rmap_one = page_mkclean_one,
> >>         .invalid_vma = invalid_mkclean_vma,
> >> +       .mapcount = &real_mapcount,
> >>     };
> >>
> >>     BUG_ON(!PageLocked(page));
> >>
> >>     if (!page_mapped(page))
> >>         return 0;
> >>
> >>     mapping = page_mapping(page);
> >>     if (!mapping)
> >>         return 0;
> >>
> >>     // rmap_walk need to change to count mapping and return value
> >>     // in .mapcount easy one
> >>     rmap_walk(page, &rwc);
> >>
> >>     // Big fat comment to explain what is going on
> >> +   if ((page_mapcount(page) - real_mapcount) > 0) {
> >> +       SetPageDMAPined(page);
> >> +   } else {
> >> +       ClearPageDMAPined(page);
> >> +   }
> > 
> > This is the detail I'm not sure about: Why cannot rmap_walk_file() race
> > with e.g. zap_pte_range() which decrements page->_mapcount and thus the
> > check we do in page_mkclean() is wrong?
> 
> Right. This looks like a dead end, after all. We can't lock a whole chunk 
> of "all these are mapped, hold still while we count you" pages. It's not
> designed to allow that at all.
> 
> IMHO, we are now back to something like dynamic_page, which provides an
> independent dma pinned count. 

I will keep looking because allocating a structure for every GUP is
insane to me they are user out there that are GUPin GigaBytes of data
and it gonna waste tons of memory just to fix crappy hardware.

Cheers,
Jérôme
