Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EC3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DBA20815
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeLSLfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:35:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:38322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbeLSLfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:35:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59555ACB5;
        Wed, 19 Dec 2018 11:35:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DF6251E1463; Wed, 19 Dec 2018 12:35:40 +0100 (CET)
Date:   Wed, 19 Dec 2018 12:35:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181219113540.GC18345@quack2.suse.cz>
References: <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181218103306.GC18032@quack2.suse.cz>
 <20181218234254.GC31274@dastard>
 <20181219030329.GI21992@ziepe.ca>
 <20181219102825.GN6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219102825.GN6311@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-12-18 21:28:25, Dave Chinner wrote:
> On Tue, Dec 18, 2018 at 08:03:29PM -0700, Jason Gunthorpe wrote:
> > On Wed, Dec 19, 2018 at 10:42:54AM +1100, Dave Chinner wrote:
> > 
> > > Essentially, what we are talking about is how to handle broken
> > > hardware. I say we should just brun it with napalm and thermite
> > > (i.e. taint the kernel with "unsupportable hardware") and force
> > > wait_for_stable_page() to trigger when there are GUP mappings if
> > > the underlying storage doesn't already require it.
> > 
> > If you want to ban O_DIRECT/etc from writing to file backed pages,
> > then just do it.
> 
> O_DIRECT IO *isn't the problem*.

That is not true. O_DIRECT IO is a problem. In some aspects it is easier
than the problem with RDMA but currently O_DIRECT IO can crash your machine
or corrupt data the same way RDMA can. Just the race window is much
smaller. So we have to fix the generic GUP infrastructure to make O_DIRECT
IO work. I agree that fixing RDMA will likely require even more work like
revokable leases or what not.

> iO_DIRECT IO uses a short term pin that the existing prefaulting
> during GUP works just fine for. The problem we have is the long term
> pins where pages can be cleaned while the pages are pinned. i.e. the
> use case we current have to disable for DAX because *we can't make
> it work sanely* without either revokable file leases and/or hardware
> that is able to trigger page faults when they need write access to a
> clean page.

I would like to find a solution to the O_DIRECT IO problem while making the
infractructure reusable also for solving the problems with RDMA... Because
nobody wants to go through those couple hundred get_user_pages() users in
the kernel twice...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
