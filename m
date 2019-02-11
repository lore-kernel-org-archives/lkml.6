Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F200DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D85214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBKVIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6051 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfBKVIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:08:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 092C65D61C;
        Mon, 11 Feb 2019 21:08:30 +0000 (UTC)
Received: from redhat.com (ovpn-123-21.rdu2.redhat.com [10.10.123.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DE6A60A9A;
        Mon, 11 Feb 2019 21:08:27 +0000 (UTC)
Date:   Mon, 11 Feb 2019 16:08:24 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190211210824.GH3908@redhat.com>
References: <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 11 Feb 2019 21:08:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:19:22AM -0800, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 11:06:54AM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 09:22:58AM -0800, Dan Williams wrote:
> > 
> > > I honestly don't like the idea that random subsystems can pin down
> > > file blocks as a side effect of gup on the result of mmap. Recall that
> > > it's not just RDMA that wants this guarantee. It seems safer to have
> > > the file be in an explicit block-allocation-immutable-mode so that the
> > > fallocate man page can describe this error case. Otherwise how would
> > > you describe the scenarios under which FALLOC_FL_PUNCH_HOLE fails?
> > 
> > I rather liked CL's version of this - ftruncate/etc is simply racing
> > with a parallel pwrite - and it doesn't fail.
> > 
> > But it also doesnt' trucate/create a hole. Another thread wrote to it
> > right away and the 'hole' was essentially instantly reallocated. This
> > is an inherent, pre-existing, race in the ftrucate/etc APIs.
> 
> I kind of like it as well, except Christopher did not answer my question:
> 
> What if user space then writes to the end of the file with a regular write?
> Does that write end up at the point they truncated to or off the end of the
> mmaped area (old length)?
> 
> To make this work I think it has to be the later.  And as you say the semantic
> is as if another thread wrote to the file first (but in this case the other
> thread is the RDMA device).
> 
> In addition I'm not sure what the overall work is for this case?
> 
> John's patches will indicate to the FS that the page is gup pinned.  But they
> will not indicate longterm vs not "shorterm".  A shortterm pin could be handled
> as a "real truncate".  So, are we back to needing a longterm "bit" in struct
> page to indicate a longterm pin and allow the FS to perform this "virtual
> write" after truncate?
> 
> Or is it safe to consider all gup pinned pages this way?

So i have been working on several patchset to convert all user that can
abide to mmu notifier to HMM mirror which does not pin pages ie does not
take reference on the page. So all the left over GUP users would be the
long term problematic one with few exceptions: direct I/O, KVM (i
think xen too but i am less familiar with that), virtio.

For direct I/O i believe the ignore the truncate solution would work too.
For KVM and virtio i think it only does GUP on anonymous memory.

So the answer would be that it is safe to consider all pin pages as being
longterm pin.

Cheers,
Jérôme
