Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FBCC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13E820675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfAPEfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:35:02 -0500
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:50043 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728227AbfAPEfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:35:01 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl6.internode.on.net with ESMTP; 16 Jan 2019 15:04:57 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gjcul-00023Y-IG; Wed, 16 Jan 2019 15:34:55 +1100
Date:   Wed, 16 Jan 2019 15:34:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190116043455.GP4205@dastard>
References: <20190114145447.GJ13316@quack2.suse.cz>
 <20190114172124.GA3702@redhat.com>
 <20190115080759.GC29524@quack2.suse.cz>
 <20190115171557.GB3696@redhat.com>
 <752839e6-6cb3-a6aa-94cb-63d3d4265934@nvidia.com>
 <20190115221205.GD3696@redhat.com>
 <99110c19-3168-f6a9-fbde-0a0e57f67279@nvidia.com>
 <20190116015610.GH3696@redhat.com>
 <CAPcyv4h2hX_CJ=Ffzip4YzryOX0NPo9yy+yDsSPnyp20xat94Q@mail.gmail.com>
 <20190116022312.GJ3696@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116022312.GJ3696@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:23:12PM -0500, Jerome Glisse wrote:
> On Tue, Jan 15, 2019 at 06:01:09PM -0800, Dan Williams wrote:
> > On Tue, Jan 15, 2019 at 5:56 PM Jerome Glisse <jglisse@redhat.com> wrote:
> > > On Tue, Jan 15, 2019 at 04:44:41PM -0800, John Hubbard wrote:
> > [..]
> > > To make it clear.
> > >
> > > Lock code:
> > >     GUP()
> > >         ...
> > >         lock_page(page);
> > >         if (PageWriteback(page)) {
> > >             unlock_page(page);
> > >             wait_stable_page(page);
> > >             goto retry;
> > >         }
> > >         atomic_add(page->refcount, PAGE_PIN_BIAS);
> > >         unlock_page(page);
> > >
> > >     test_set_page_writeback()
> > >         bool pinned = false;
> > >         ...
> > >         pinned = page_is_pin(page); // could be after TestSetPageWriteback
> > >         TestSetPageWriteback(page);
> > >         ...
> > >         return pinned;
> > >
> > > Memory barrier:
> > >     GUP()
> > >         ...
> > >         atomic_add(page->refcount, PAGE_PIN_BIAS);
> > >         smp_mb();
> > >         if (PageWriteback(page)) {
> > >             atomic_add(page->refcount, -PAGE_PIN_BIAS);
> > >             wait_stable_page(page);
> > >             goto retry;
> > >         }
> > >
> > >     test_set_page_writeback()
> > >         bool pinned = false;
> > >         ...
> > >         TestSetPageWriteback(page);
> > >         smp_wmb();
> > >         pinned = page_is_pin(page);
> > >         ...
> > >         return pinned;
> > >
> > >
> > > One is not more complex than the other. One can contend, the other
> > > will _never_ contend.
> > 
> > The complexity is in the validation of lockless algorithms. It's
> > easier to reason about locks than barriers for the long term
> > maintainability of this code. I'm with Jan and John on wanting to
> > explore lock_page() before a barrier-based scheme.
> 
> How is the above hard to validate ?

Well, if you think it's so easy, then please write the test cases so
we can add them to fstests and make sure that we don't break it in
future.

If you can't write filesystem test cases that exercise these race
conditions reliably, then the answer to your question is "it is
extremely hard to validate" and the correct thing to do is to start
with the simple lock_page() based algorithm.

Premature optimisation in code this complex is something we really,
really need to avoid.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
