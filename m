Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001EC4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF15B20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DcdwDK8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfBHPdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:33:50 -0500
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:56292 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727473AbfBHPdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549640028;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=YzFUGu859kPEo2hZyafj6+czbU6iIrLvVd2hSFt0EA0=;
        b=DcdwDK8GKlrlp+j/BPj49Ohwy5qY4VbMcl1vFGR69Au2TBSk47MucreBAWCc/qIM
        oKa96zjU9ZDlHhlf3j+o6aYmPUWAjAuZnFWwo6Ln1lLfSreZPnALHsN9wQvK0WYnnUV
        eEb2bAdYLQaF0V1pEq/QP6B5FwSq0xolmm5GhEI4=
Date:   Fri, 8 Feb 2019 15:33:48 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dave Chinner <david@fromorbit.com>
cc:     Doug Ledford <dledford@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <20190208044302.GA20493@dastard>
Message-ID: <01000168cdbe520b-2b2be741-8ceb-4a5d-92f2-9f68795d7db3-000000@email.amazonses.com>
References: <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com> <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com> <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca> <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com> <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com> <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com> <20190208044302.GA20493@dastard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.08-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019, Dave Chinner wrote:

> On Thu, Feb 07, 2019 at 04:55:37PM +0000, Christopher Lameter wrote:
> > One approach that may be a clean way to solve this:
> > 3. Filesystems that allow bypass of the page cache (like XFS / DAX) will
> >    provide the virtual mapping when the PIN is done and DO NO OPERATIONS
> >    on the longterm pinned range until the long term pin is removed.
>
> So, ummm, how do we do block allocation then, which is done on
> demand during writes?

If a memory region is mapped by RDMA then this is essentially a long
write. The allocation needs to happen then.

> IOWs, this requires the application to set up the file in the
> correct state for the filesystem to lock it down so somebody else
> can write to it.  That means the file can't be sparse, it can't be
> preallocated (i.e. can't contain unwritten extents), it must have zeroes
> written to it's full size before being shared because otherwise it
> exposes stale data to the remote client (secure sites are going to
> love that!), they can't be extended, etc.

Yes. That is required.

> IOWs, once the file is prepped and leased out for RDMA, it becomes
> an immutable for the purposes of local access.

The contents are mutable but the mapping to the physical medium is
immutable.


> Which, essentially we can already do. Prep the file, map it
> read/write, mark it immutable, then pin it via the longterm gup
> interface which can do the necessary checks.
>
> Simple to implement, the reasons for errors trying to modify the
> file are already documented and queriable, and it's hard for
> applications to get wrong.

Yup. Why not do it this way? Just make the sections actually long term GUP
mapped inmutable and not subject to the other page cache things.

This is basically a straight through bypass of the page cache for a file.

HEY! It may be used to map huge pages in the future too!!
