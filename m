Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4264C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0992083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fDhEtHJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfBFUYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:24:18 -0500
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:46676 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfBFUYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549484657;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=IKQJI6P5KcnC2eHGyyi/rgikGuil/xT/2O0jHHw10a0=;
        b=fDhEtHJ779ZPKC8QBWbnCFtyLqOeIlaDQN/k8z1KTzhCp5BQk+dZKBet4B90Tzyc
        yeBtEEaYgRGcTEZ3DxRl/n5v9qjNl6N4jsH5rTebfAfQkj/+8ZwEgz90nynwe0zI2+E
        UhrOAlWNgtMfKAm66GB0jaGbrePsyVanR4Sv9zWA=
Date:   Wed, 6 Feb 2019 20:24:17 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <20190206194055.GP21860@bombadil.infradead.org>
Message-ID: <01000168c47b8b6a-ba1b2cd5-0a53-4367-a296-aa0b0ba26359-000000@email.amazonses.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com> <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com> <20190206194055.GP21860@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.06-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019, Matthew Wilcox wrote:

> >
> > Coming in late here too but isnt the only DAX case that we are concerned
> > about where there was an mmap with the O_DAX option to do direct write
>
> There is no O_DAX option.  There's mount -o dax, but there's nothing that
> a program does to say "Use DAX".

Hmmm... I thought that a file handle must have a special open mode to
actually to a dax map. Looks like that is not the case.

> > though? If we only allow this use case then we may not have to worry about
> > long term GUP because DAX mapped files will stay in the physical location
> > regardless.
>
> ... except for truncate.  And now that I think about it, there was a
> desire to support hot-unplug which also needed revoke.

Well but that requires that the application unmaps the file.

> > Maybe we can solve the long term GUP problem through the requirement that
> > user space acquires some sort of means to pin the pages? In the DAX case
> > this is given by the filesystem and the hardware will basically take care
> > of writeback.
>
> It's not given by the filesystem.

DAX provides a mapping to physical persistent memory that
does not go away. Or its a block device.

>
> > In case of anonymous memory this can be guaranteed otherwise and is less
> > critical since these pages are not part of the pagecache and are not
> > subject to writeback.
>
> but are subject to being swapped out?

Well that is controlled by mlock and could also involve other means like
disabling swap.

