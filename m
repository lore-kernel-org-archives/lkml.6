Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C0E218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeLSLTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:19:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbeLSLTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:19:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1FC3B0A5;
        Wed, 19 Dec 2018 11:19:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 049DB1E1463; Wed, 19 Dec 2018 12:19:22 +0100 (CET)
Date:   Wed, 19 Dec 2018 12:19:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181219111921.GB18345@quack2.suse.cz>
References: <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181218103306.GC18032@quack2.suse.cz>
 <20181218234254.GC31274@dastard>
 <20181219030329.GI21992@ziepe.ca>
 <CAPcyv4h=j=Kc=uOzdbfoYvmJ54aqSq6tHra2QZQwtpE+80WkVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h=j=Kc=uOzdbfoYvmJ54aqSq6tHra2QZQwtpE+80WkVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 21:26:28, Dan Williams wrote:
> On Tue, Dec 18, 2018 at 7:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
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
> >
> > Otherwise I'm not sure demanding some unrealistic HW design is
> > reasonable. ie nvme drives are not likely to add page faulting to
> > their IO path any time soon.
> >
> > A SW architecture that relies on page faulting is just not going to
> > support real world block IO devices.
> >
> > GPUs and one RDMA are about the only things that can do this today,
> > and they are basically irrelevant to O_DIRECT.
> 
> Yes.
> 
> I'm missing why a bounce buffer is needed. If writeback hits a
> DMA-writable page why can't that path just turn around and trigger
> another mkwrite notifcation on behalf of hardware that will never send
> it? "Nice try writeback, this page is dirty again".

You are conflating two things here. Bounce buffer (or a way to stop DMA
from happening) is needed because think what happens when RAID5 computes
its stripe checksum while someone modifies the data through DMA. Checksum
mismatch and all fun arising from that.

Notifying filesystem about the fact that the page didn't get cleaned by the
writeback and still can be modified by the DMA is a different thing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
