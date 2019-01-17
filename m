Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E758620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfAQJEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:04:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:42304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbfAQJEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:04:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58AA7AC9C;
        Thu, 17 Jan 2019 09:04:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C880C1E1580; Thu, 17 Jan 2019 10:04:06 +0100 (CET)
Date:   Thu, 17 Jan 2019 10:04:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
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
Message-ID: <20190117090406.GA9378@quack2.suse.cz>
References: <20190111165141.GB3190@redhat.com>
 <1b37061c-5598-1b02-2983-80003f1c71f2@nvidia.com>
 <20190112020228.GA5059@redhat.com>
 <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
 <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190114145447.GJ13316@quack2.suse.cz>
 <20190114172124.GA3702@redhat.com>
 <20190115080759.GC29524@quack2.suse.cz>
 <76788484-d5ec-91f2-1f66-141764ba0b1e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76788484-d5ec-91f2-1f66-141764ba0b1e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-01-19 21:25:05, John Hubbard wrote:
> On 1/15/19 12:07 AM, Jan Kara wrote:
> >>>>> [...]
> >>> Also there is one more idea I had how to record number of pins in the page:
> >>>
> >>> #define PAGE_PIN_BIAS	1024
> >>>
> >>> get_page_pin()
> >>> 	atomic_add(&page->_refcount, PAGE_PIN_BIAS);
> >>>
> >>> put_page_pin();
> >>> 	atomic_add(&page->_refcount, -PAGE_PIN_BIAS);
> >>>
> >>> page_pinned(page)
> >>> 	(atomic_read(&page->_refcount) - page_mapcount(page)) > PAGE_PIN_BIAS
> >>>
> >>> This is pretty trivial scheme. It still gives us 22-bits for page pins
> >>> which should be plenty (but we should check for that and bail with error if
> >>> it would overflow). Also there will be no false negatives and false
> >>> positives only if there are more than 1024 non-page-table references to the
> >>> page which I expect to be rare (we might want to also subtract
> >>> hpage_nr_pages() for radix tree references to avoid excessive false
> >>> positives for huge pages although at this point I don't think they would
> >>> matter). Thoughts?
> 
> Some details, sorry I'm not fully grasping your plan without more
> explanation:
> 
> Do I read it correctly that this uses the lower 10 bits for the original
> page->_refcount, and the upper 22 bits for gup-pinned counts? If so, I'm
> surprised, because gup-pinned is going to be less than or equal to the
> normal (get_page-based) pin count. And 1024 seems like it might be
> reached in a large system with lots of processes and IPC.
> 
> Are you just allowing the lower 10 bits to overflow, and that's why the 
> subtraction of mapcount? Wouldn't it be better to allow more than 10 bits, 
> instead?

I'm not really dividing the page->_refcount counter, that's a wrong way how
to think about it I believe. Normal get_page() simply increments the
_refcount by 1, get_page_pin() will increment by 1024 (or 999 or whatever -
that's PAGE_PIN_BIAS). The choice of value of PAGE_PIN_BIAS is essentially
a tradeoff between how many page pins you allow and how likely
page_pinned() is to return false positive. Large PAGE_PIN_BIAS means lower
amount of false positives but also less page pins allowed for the page
before _refcount would overflow.

Now the trick with subtracting of page_mapcount() is following: We know
that certain places hold references to the page. Common holders of
page references are page table entries. So if we subtract page_mapcount()
from _refcount, we'll get more accurate view how many other references
(including pins) are there and thus reduce the number of false positives.

> Another question: do we just allow other kernel code to observe this biased
> _refcount, or do we attempt to filter it out?  In other words, do you expect 
> problems due to some kernel code checking the _refcount and finding a large 
> number there, when it expected, say, 3? I recall some code tries to do 
> that...in fact, ZONE_DEVICE is 1-based, instead of zero-based, with respect 
> to _refcount, right?

I would just allow other places to observe biased refcount. Sure there are
places that do comparions on exact refcount value but if such place does
not exclude page pins, it cannot really depend on whether there's just one
or thousand of them. Generally such places try to detect whether they are
the only owner of the page (besides page cache radix tree, LRU, etc.). So
they want to bail if any page pin exists and that check remains the same
regardless whether we increment _refcount by 1 or by 1024 when pinning the
page.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
