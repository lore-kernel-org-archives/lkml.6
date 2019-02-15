Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A80A2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Unvl08o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfBOPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:42:03 -0500
Received: from a9-31.smtp-out.amazonses.com ([54.240.9.31]:45698 "EHLO
        a9-31.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfBOPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1550245322;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=ieoA9G/W7FjMw2f/8b6ijric5X7WLHj4SWCwlIfIT3E=;
        b=Unvl08o3EUDCs5oYoOtJ8OdPcFc3nBgaouZGWhaSGZlU9kTY9eNGTON+3/0G29W6
        6pXPvYuHZZIEeICI7KLo9AEm2ZplYtKkKF+PsXj0PEPeb2H8EbZirMGy+OxsrEYPu3i
        2bZjBAUyQ6w+UfRWab+O9lfJretpOK2oDiEyOQPY=
Date:   Fri, 15 Feb 2019 15:42:02 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Dave Chinner <david@fromorbit.com>
cc:     Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
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
In-Reply-To: <20190215011921.GS20493@dastard>
Message-ID: <01000168f1d25e3a-2857236c-a7cc-44b8-a5f3-f51c2cfe6ce4-000000@email.amazonses.com>
References: <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com> <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz> <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com> <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com> <20190211180654.GB24692@ziepe.ca> <20190214202622.GB3420@redhat.com> <20190214205049.GC12668@bombadil.infradead.org> <20190214213922.GD3420@redhat.com> <20190215011921.GS20493@dastard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.15-54.240.9.31
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019, Dave Chinner wrote:

> Which tells us filesystem people that the applications are doing
> something that _will_ cause data corruption and hence not to spend
> any time triaging data corruption reports because it's not a
> filesystem bug that caused it.
>
> See open(2):
>
> 	Applications should avoid mixing O_DIRECT and normal I/O to
> 	the same file, and especially to overlapping byte regions in
> 	the same file.  Even when the filesystem correctly handles
> 	the coherency issues in this situation, overall I/O
> 	throughput is likely to be slower than using either mode
> 	alone.  Likewise, applications should avoid mixing mmap(2)
> 	of files with direct I/O to the same files.

Since RDMA is something similar: Can we say that a file that is used for
RDMA should not use the page cache?

And can we enforce this in the future? I.e. have some file state that says
that this file is direct/RDMA or contains long term pinning and thus
allows only a certain type of operations to ensure data consistency?

If we cannot enforce it then we may want to spit out some warning?

