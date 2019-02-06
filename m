Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1006C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDD6218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VJLzZzDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBFTQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:16:25 -0500
Received: from a9-35.smtp-out.amazonses.com ([54.240.9.35]:52356 "EHLO
        a9-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfBFTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549480581;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=znIZuWNF4X3qMOcXoMBkQ62oatbaP8owCgJHWHXID7U=;
        b=VJLzZzDJARHqbWqB+oPbQUvfBw3ad4uMs5V9EZ6Sxrql4TaUUv54mEAg6vkqb2wp
        hJ+8gmBbIEEET+f2gIwCeApJpoU8ID418zMmx4PlsqnaxKp/hhvS5vfXcdC5L/9tWVT
        lH1yxIoaaol35eryN2nGrJnPhI272qHM6o7zat1A=
Date:   Wed, 6 Feb 2019 19:16:21 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Doug Ledford <dledford@redhat.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
Message-ID: <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com> <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.06-54.240.9.35
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019, Doug Ledford wrote:

> > Most of the cases we want revoke for are things like truncate().
> > Shouldn't happen with a sane system, but we're trying to avoid users
> > doing awful things like being able to DMA to pages that are now part of
> > a different file.
>
> Why is the solution revoke then?  Is there something besides truncate
> that we have to worry about?  I ask because EBUSY is not currently
> listed as a return value of truncate, so extending the API to include
> EBUSY to mean "this file has pinned pages that can not be freed" is not
> (or should not be) totally out of the question.
>
> Admittedly, I'm coming in late to this conversation, but did I miss the
> portion where that alternative was ruled out?

Coming in late here too but isnt the only DAX case that we are concerned
about where there was an mmap with the O_DAX option to do direct write
though? If we only allow this use case then we may not have to worry about
long term GUP because DAX mapped files will stay in the physical location
regardless.

Maybe we can solve the long term GUP problem through the requirement that
user space acquires some sort of means to pin the pages? In the DAX case
this is given by the filesystem and the hardware will basically take care
of writeback.

In case of anonymous memory this can be guaranteed otherwise and is less
critical since these pages are not part of the pagecache and are not
subject to writeback.


