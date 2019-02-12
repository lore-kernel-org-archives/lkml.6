Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B7C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3389217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfBLQ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:28:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:37936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbfBLQ2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:28:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38887B60F;
        Tue, 12 Feb 2019 16:28:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 904741E09C5; Tue, 12 Feb 2019 17:28:32 +0100 (CET)
Date:   Tue, 12 Feb 2019 17:28:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190212162832.GC19076@quack2.suse.cz>
References: <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211180654.GB24692@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-02-19 11:06:54, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 09:22:58AM -0800, Dan Williams wrote:
> 
> > I honestly don't like the idea that random subsystems can pin down
> > file blocks as a side effect of gup on the result of mmap. Recall that
> > it's not just RDMA that wants this guarantee. It seems safer to have
> > the file be in an explicit block-allocation-immutable-mode so that the
> > fallocate man page can describe this error case. Otherwise how would
> > you describe the scenarios under which FALLOC_FL_PUNCH_HOLE fails?
> 
> I rather liked CL's version of this - ftruncate/etc is simply racing
> with a parallel pwrite - and it doesn't fail.

The problem is page pins are not really like pwrite(). They are more like
mmap access. And that will just SIGBUS after truncate. So from user point
of view I agree the result may not be that surprising (it would seem just
as if somebody did additional pwrite) but from filesystem point of view it
is very different and it would mean a special handling in lots of places.
So I think that locking down the file before allowing gup_longterm() looks
like a more viable alternative.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
