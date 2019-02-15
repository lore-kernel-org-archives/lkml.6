Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1282222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DW/4HFBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbfBOSbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:31:38 -0500
Received: from a9-31.smtp-out.amazonses.com ([54.240.9.31]:45704 "EHLO
        a9-31.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbfBOSbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1550255496;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=FL49OqYV7AJ7BdfqMIiruaHQ/KIj/D+PCy38BhKpJ8M=;
        b=DW/4HFBWl7QxvxO7+RPK0EnTWciRC6KBevIyCX844sINXkFtro9foTj9NAy+yYNH
        KkrA17PnOuoFvHC503Pq6MYSRDKVdvWqqN3P0WOo5yW2T+28qcy/csPN+XvNkMyOgJ1
        hDFPRkfFHIw71VRLb6JkcoK1iXbQB5k8exBjyM/I=
Date:   Fri, 15 Feb 2019 18:31:36 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Dave Chinner <david@fromorbit.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <20190215180852.GJ12668@bombadil.infradead.org>
Message-ID: <01000168f26d9e0c-aef3255a-5059-4657-b241-dae66663bbea-000000@email.amazonses.com>
References: <20190208111028.GD6353@quack2.suse.cz> <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com> <20190211102402.GF19029@quack2.suse.cz> <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com> <20190211180654.GB24692@ziepe.ca>
 <20190214202622.GB3420@redhat.com> <20190214205049.GC12668@bombadil.infradead.org> <20190214213922.GD3420@redhat.com> <20190215011921.GS20493@dastard> <01000168f1d25e3a-2857236c-a7cc-44b8-a5f3-f51c2cfe6ce4-000000@email.amazonses.com>
 <20190215180852.GJ12668@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.15-54.240.9.31
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019, Matthew Wilcox wrote:

> > Since RDMA is something similar: Can we say that a file that is used for
> > RDMA should not use the page cache?
>
> That makes no sense.  The page cache is the standard synchronisation point
> for filesystems and processes.  The only problems come in for the things
> which bypass the page cache like O_DIRECT and DAX.

It makes a lot of sense since the filesystems play COW etc games with the
pages and RDMA is very much like O_DIRECT in that the pages are modified
directly under I/O. It also bypasses the page cache in case you have
not noticed yet.

Both filesysetms and RDMA acting on a page cache at
the same time lead to the mess that we are trying to solve.


