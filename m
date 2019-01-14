Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84543C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B3A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfANRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfANRVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:21:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9FD3811D9;
        Mon, 14 Jan 2019 17:21:30 +0000 (UTC)
Received: from redhat.com (ovpn-124-246.rdu2.redhat.com [10.10.124.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BEEF5C1B4;
        Mon, 14 Jan 2019 17:21:27 +0000 (UTC)
Date:   Mon, 14 Jan 2019 12:21:25 -0500
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
Message-ID: <20190114172124.GA3702@redhat.com>
References: <20190103092654.GA31370@quack2.suse.cz>
 <20190103144405.GC3395@redhat.com>
 <a79b259b-3982-b271-025a-0656f70506f4@nvidia.com>
 <20190111165141.GB3190@redhat.com>
 <1b37061c-5598-1b02-2983-80003f1c71f2@nvidia.com>
 <20190112020228.GA5059@redhat.com>
 <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
 <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190114145447.GJ13316@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114145447.GJ13316@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 14 Jan 2019 17:21:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:54:47PM +0100, Jan Kara wrote:
> On Fri 11-01-19 19:06:08, John Hubbard wrote:
> > On 1/11/19 6:46 PM, Jerome Glisse wrote:
> > > On Fri, Jan 11, 2019 at 06:38:44PM -0800, John Hubbard wrote:
> > > [...]
> > > 
> > >>>> The other idea that you and Dan (and maybe others) pointed out was a debug
> > >>>> option, which we'll certainly need in order to safely convert all the call
> > >>>> sites. (Mirror the mappings at a different kernel offset, so that put_page()
> > >>>> and put_user_page() can verify that the right call was made.)  That will be
> > >>>> a separate patchset, as you recommended.
> > >>>>
> > >>>> I'll even go as far as recommending the page lock itself. I realize that this 
> > >>>> adds overhead to gup(), but we *must* hold off page_mkclean(), and I believe
> > >>>> that this (below) has similar overhead to the notes above--but is *much* easier
> > >>>> to verify correct. (If the page lock is unacceptable due to being so widely used,
> > >>>> then I'd recommend using another page bit to do the same thing.)
> > >>>
> > >>> Please page lock is pointless and it will not work for GUP fast. The above
> > >>> scheme do work and is fine. I spend the day again thinking about all memory
> > >>> ordering and i do not see any issues.
> > >>>
> > >>
> > >> Why is it that page lock cannot be used for gup fast, btw?
> > > 
> > > Well it can not happen within the preempt disable section. But after
> > > as a post pass before GUP_fast return and after reenabling preempt then
> > > it is fine like it would be for regular GUP. But locking page for GUP
> > > is also likely to slow down some workload (with direct-IO).
> > > 
> > 
> > Right, and so to crux of the matter: taking an uncontended page lock
> > involves pretty much the same set of operations that your approach does.
> > (If gup ends up contended with the page lock for other reasons than these
> > paths, that seems surprising.) I'd expect very similar performance.
> > 
> > But the page lock approach leads to really dramatically simpler code (and
> > code reviews, let's not forget). Any objection to my going that
> > direction, and keeping this idea as a Plan B? I think the next step will
> > be, once again, to gather some performance metrics, so maybe that will
> > help us decide.
> 
> FWIW I agree that using page lock for protecting page pinning (and thus
> avoid races with page_mkclean()) looks simpler to me as well and I'm not
> convinced there will be measurable difference to the more complex scheme
> with barriers Jerome suggests unless that page lock contended. Jerome is
> right that you cannot just do lock_page() in gup_fast() path. There you
> have to do trylock_page() and if that fails just bail out to the slow gup
> path.
> 
> Regarding places other than page_mkclean() that need to check pinned state:
> Definitely page migration will want to check whether the page is pinned or
> not so that it can deal differently with short-term page references vs
> longer-term pins.
> 
> Also there is one more idea I had how to record number of pins in the page:
> 
> #define PAGE_PIN_BIAS	1024
> 
> get_page_pin()
> 	atomic_add(&page->_refcount, PAGE_PIN_BIAS);
> 
> put_page_pin();
> 	atomic_add(&page->_refcount, -PAGE_PIN_BIAS);
> 
> page_pinned(page)
> 	(atomic_read(&page->_refcount) - page_mapcount(page)) > PAGE_PIN_BIAS
> 
> This is pretty trivial scheme. It still gives us 22-bits for page pins
> which should be plenty (but we should check for that and bail with error if
> it would overflow). Also there will be no false negatives and false
> positives only if there are more than 1024 non-page-table references to the
> page which I expect to be rare (we might want to also subtract
> hpage_nr_pages() for radix tree references to avoid excessive false
> positives for huge pages although at this point I don't think they would
> matter). Thoughts?

Racing PUP are as likely to cause issues:

CPU0                        | CPU1       | CPU2
                            |            |
                            | PUP()      |
    page_pinned(page)       |            |
      (page_count(page) -   |            |
       page_mapcount(page)) |            |
                            |            | GUP()

So here the refcount snap-shot does not include the second GUP and
we can have a false negative ie the page_pinned() will return false
because of the PUP happening just before on CPU1 despite the racing
GUP on CPU2 just after.

I believe only either lock or memory ordering with barrier can
guarantee that we do not miss GUP ie no false negative. Still the
bias idea might be usefull as with it we should not need a flag.

So to make the above safe it would still need the page write back
double check that i described so that GUP back-off if it raced with
page_mkclean,clear_page_dirty_for_io and the fs write page call back
which call test_set_page_writeback() (yes it is very unlikely but
might still happen).


I still need to ponder some more on all the races.


Cheers,
Jérôme
