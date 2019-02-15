Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A808B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N6vgbDuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbfBOSIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:08:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387853AbfBOSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ekIKuh6zBnupKG9gxO673zuIE5kCUp3UX8vSRNljvIk=; b=N6vgbDuAO0pFZp1PJU1ZeiFyA
        ytwPOqX5TusjyRZIce5OHcQYYs3JVVuTD5LuzVjB4CxjutjoKS4NZs9QFgUcKdXLB7gtJ1URorkMb
        TNstdGaGILxTXQmo0Qr0PM6yGl/H/UEiXQxcDH+CVG23ZcxIbzqjiNePIi44h8UtgBQ188zYyyTSV
        eFkDmiks78XQrfwzlTAk8egXMa9LlLeD9OzBkE5gSLkbtTTuPKq5G4cuAiWId9oCv28UJWxRVMkFQ
        C+2kwPtXa2mhF1XtTTcUxzUY1N0PthxEuqk6mq99jR2F3ASJNSYoge3Y5zgoFsHyC+XCkvgPfRZEr
        and9h+huQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guhuu-0003J4-NB; Fri, 15 Feb 2019 18:08:52 +0000
Date:   Fri, 15 Feb 2019 10:08:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Dave Chinner <david@fromorbit.com>,
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
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190215180852.GJ12668@bombadil.infradead.org>
References: <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190214202622.GB3420@redhat.com>
 <20190214205049.GC12668@bombadil.infradead.org>
 <20190214213922.GD3420@redhat.com>
 <20190215011921.GS20493@dastard>
 <01000168f1d25e3a-2857236c-a7cc-44b8-a5f3-f51c2cfe6ce4-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168f1d25e3a-2857236c-a7cc-44b8-a5f3-f51c2cfe6ce4-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 03:42:02PM +0000, Christopher Lameter wrote:
> On Fri, 15 Feb 2019, Dave Chinner wrote:
> 
> > Which tells us filesystem people that the applications are doing
> > something that _will_ cause data corruption and hence not to spend
> > any time triaging data corruption reports because it's not a
> > filesystem bug that caused it.
> >
> > See open(2):
> >
> > 	Applications should avoid mixing O_DIRECT and normal I/O to
> > 	the same file, and especially to overlapping byte regions in
> > 	the same file.  Even when the filesystem correctly handles
> > 	the coherency issues in this situation, overall I/O
> > 	throughput is likely to be slower than using either mode
> > 	alone.  Likewise, applications should avoid mixing mmap(2)
> > 	of files with direct I/O to the same files.
> 
> Since RDMA is something similar: Can we say that a file that is used for
> RDMA should not use the page cache?

That makes no sense.  The page cache is the standard synchronisation point
for filesystems and processes.  The only problems come in for the things
which bypass the page cache like O_DIRECT and DAX.

