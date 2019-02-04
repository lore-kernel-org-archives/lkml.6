Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD0C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB83520821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="eqqPaLK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfBDSVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:21:40 -0500
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:50222 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727917AbfBDSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549304499;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=nirpWIDcnC5D/gqeHhqZEfTAwTpOapalA6vQSFEJlrg=;
        b=eqqPaLK753ERyVHOui9AhXNyEHkliLZNsy0bLhnJAXqdnvCX6SuwvNdVR6Ayg24Q
        BMtaV4Me15la7/pns5BOfhHu4OT8QcohddOIF2e3YaiR8izR0bS9HIiZjS5MZ13ecWq
        lMZeDm9mAAnkNvmVPhAU+QYsBOA41g0I/8sjbvd8=
Date:   Mon, 4 Feb 2019 18:21:39 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
In-Reply-To: <20190204175110.GA10237@ziepe.ca>
Message-ID: <01000168b9be8b5a-3b4f8036-50c8-4180-b39f-9ef28cb60cce-000000@email.amazonses.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com> <01000168b980e880-a7d8e0db-84fb-4398-8269-149c66b701b4-000000@email.amazonses.com> <20190204175110.GA10237@ziepe.ca>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.04-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019, Jason Gunthorpe wrote:

> On Mon, Feb 04, 2019 at 05:14:19PM +0000, Christopher Lameter wrote:
> > Frankly I still think this does not solve anything.
> >
> > Concurrent write access from two sources to a single page is simply wrong.
> > You cannot make this right by allowing long term RDMA pins in a filesystem
> > and thus the filesystem can never update part of its files on disk.
>
> Fundamentally this patch series is fixing O_DIRECT to not crash the
> kernel in extreme cases.. RDMA has the same problem, but it is much
> easier to hit.

O_DIRECT is the same issue. O_DIRECT addresses always have been in
anonymous memory or special file systems.
