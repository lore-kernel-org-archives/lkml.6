Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD54C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190CA2148D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190CA2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJCW5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:57:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbeJCW5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:57:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A797AD4A;
        Wed,  3 Oct 2018 16:08:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A8BF11E3613; Wed,  3 Oct 2018 18:08:36 +0200 (CEST)
Date:   Wed, 3 Oct 2018 18:08:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/4] get_user_pages*() and RDMA: first steps
Message-ID: <20181003160836.GF24030@quack2.suse.cz>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928152958.GA3321@redhat.com>
 <4c884529-e2ff-3808-9763-eb0e71f5a616@nvidia.com>
 <20180928214934.GA3265@redhat.com>
 <dfa6aaef-b97e-ebd4-6cc8-c907a7b3f9bb@nvidia.com>
 <20180929084608.GA3188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929084608.GA3188@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 29-09-18 04:46:09, Jerome Glisse wrote:
> On Fri, Sep 28, 2018 at 07:28:16PM -0700, John Hubbard wrote:
> > Actually, the latest direction on that discussion was toward periodically
> > writing back, even while under RDMA, via bounce buffers:
> > 
> >   https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz
> > 
> > I still think that's viable. Of course, there are other things besides 
> > writeback (see below) that might also lead to waiting.
> 
> Write back under bounce buffer is fine, when looking back at links you
> provided the solution that was discuss was blocking in page_mkclean()
> which is horrible in my point of view.

Yeah, after looking into it for some time, we figured that waiting for page
pins in page_mkclean() isn't really going to fly due to deadlocks. So we
came up with the bounce buffers idea which should solve that nicely.

> > > With the solution put forward here you can potentialy wait _forever_ for
> > > the driver that holds a pin to drop it. This was the point i was trying to
> > > get accross during LSF/MM. 
> > 
> > I agree that just blocking indefinitely is generally unacceptable for kernel
> > code, but we can probably avoid it for many cases (bounce buffers), and
> > if we think it is really appropriate (file system unmounting, maybe?) then
> > maybe tolerate it in some rare cases.  
> > 
> > >You can not fix broken hardware that decided to
> > > use GUP to do a feature they can't reliably do because their hardware is
> > > not capable to behave.
> > > 
> > > Because code is easier here is what i was meaning:
> > > 
> > > https://cgit.freedesktop.org/~glisse/linux/commit/?h=gup&id=a5dbc0fe7e71d347067579f13579df372ec48389
> > > https://cgit.freedesktop.org/~glisse/linux/commit/?h=gup&id=01677bc039c791a16d5f82b3ef84917d62fac826
> > > 
> > 
> > While that may work sometimes, I don't think it is reliable enough to trust for
> > identifying pages that have been gup-pinned. There's just too much overloading of
> > other mechanisms going on there, and if we pile on top with this constraint of "if you
> > have +3 refcounts, and this particular combination of page counts and mapcounts, then
> > you're definitely a long-term pinned page", I think users will find a lot of corner
> > cases for us that break that assumption. 
> 
> So the mapcount == refcount (modulo extra reference for mapping and
> private) should holds, here are the case when it does not:
>     - page being migrated
>     - page being isolated from LRU
>     - mempolicy changes against the page
>     - page cache lookup
>     - some file system activities
>     - i likely miss couples here i am doing that from memory
> 
> What matter is that all of the above are transitory, the extra reference
> only last for as long as it takes for the action to finish (migration,
> mempolicy change, ...).
> 
> So skipping those false positive page while reclaiming likely make sense,
> the blocking free buffer maybe not.

Well, as John wrote, these page refcount are fragile (and actually
filesystem dependent as some filesystems hold page reference from their
page->private data and some don't). So I think we really need a new
reliable mechanism for tracking page references from GUP. And John works
towards that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
