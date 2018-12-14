Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F19EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051EC20449
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbeLNPUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNPUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:20:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CC1B30039A5;
        Fri, 14 Dec 2018 15:20:43 +0000 (UTC)
Received: from redhat.com (ovpn-125-82.rdu2.redhat.com [10.10.125.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C39C429ADB;
        Fri, 14 Dec 2018 15:20:40 +0000 (UTC)
Date:   Fri, 14 Dec 2018 10:20:38 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        david <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181214152038.GB3645@redhat.com>
References: <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181212215931.GG5037@redhat.com>
 <20181213005119.GD29416@dastard>
 <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
 <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
 <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 14 Dec 2018 15:20:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:11:09PM -0800, John Hubbard wrote:
> On 12/13/18 9:21 PM, Dan Williams wrote:
> > On Thu, Dec 13, 2018 at 7:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >>
> >> On 12/12/18 4:51 PM, Dave Chinner wrote:
> >>> On Wed, Dec 12, 2018 at 04:59:31PM -0500, Jerome Glisse wrote:
> >>>> On Thu, Dec 13, 2018 at 08:46:41AM +1100, Dave Chinner wrote:
> >>>>> On Wed, Dec 12, 2018 at 10:03:20AM -0500, Jerome Glisse wrote:
> >>>>>> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> >>>>>>> On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> >>>>>>> So this approach doesn't look like a win to me over using counter in struct
> >>>>>>> page and I'd rather try looking into squeezing HMM public page usage of
> >>>>>>> struct page so that we can fit that gup counter there as well. I know that
> >>>>>>> it may be easier said than done...
> >>>>>>
> >>
> >> Agreed. After all the discussion this week, I'm thinking that the original idea
> >> of a per-struct-page counter is better. Fortunately, we can do the moral equivalent
> >> of that, unless I'm overlooking something: Jerome had another proposal that he
> >> described, off-list, for doing that counting, and his idea avoids the problem of
> >> finding space in struct page. (And in fact, when I responded yesterday, I initially
> >> thought that's where he was going with this.)
> >>
> >> So how about this hybrid solution:
> >>
> >> 1. Stay with the basic RFC approach of using a per-page counter, but actually
> >> store the counter(s) in the mappings instead of the struct page. We can use
> >> !PageAnon and page_mapping to look up all the mappings, stash the dma_pinned_count
> >> there. So the total pinned count is scattered across mappings. Probably still need
> >> a PageDmaPinned bit.
> > 
> > How do you safely look at page->mapping from the get_user_pages_fast()
> > path? You'll be racing invalidation disconnecting the page from the
> > mapping.
> > 
> 
> I don't have an answer for that, so maybe the page->mapping idea is dead already. 
> 
> So in that case, there is still one more way to do all of this, which is to
> combine ZONE_DEVICE, HMM, and gup/dma information in a per-page struct, and get
> there via basically page->private, more or less like this:

The page mapcount idea does work to get a pin count. So i believe
that this is what should be pursue, if no one wants to try it i
will do patches. Anything else is too invasive and requires too
much changes. Note that in all the discussion that happened in the
mapcount having a separate pin count would not have help one bit
nor would it solve the page_mkwrite issue.

So we need to audit put_user_page call place and see if they can
sleep and call mkwrite without issue. I believe the answer will be
yes for many ... maybe all.

Cheers,
Jérôme
