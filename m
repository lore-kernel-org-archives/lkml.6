Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA9C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34DF2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFjpHN01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBGRYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:24:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KaCACouyWcP3AHn7c7rvYHXFAgfIP9iLxHVqu/otoeA=; b=uFjpHN01utFKoX5XohZKeYMVc
        dy3QXKNe+IGOmuHAt7tMQhY29FNWyN1wCCP7aB09vF7xxiK+W/3f5jDFt/TsnOx5hrOEVHD79bqJg
        oRpfGDj14NXeY2ZFeJ8HUn/Le2lCmWCMfiOB+ISwJKuv2+cexAax5pwwGsn61TQe7bWf9fzmdNFji
        0116U/IZY1pvA6mg2+Y2jvBLyeoBdBphTe3n4cEYzwMC9/mR4UmV+EXC0bKMpys+HvtvcgKLSbCJ4
        xdwbOotNdPfbXC7joW4xQCquZpeRBXTVD/AXGacSx54m6M/ncB7wKq0yMenS9s9hm7yw/iFCeCTEd
        l6r802ZNw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grnPC-0001CL-1M; Thu, 07 Feb 2019 17:24:06 +0000
Date:   Thu, 7 Feb 2019 09:24:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190207172405.GY21860@bombadil.infradead.org>
References: <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 11:25:35AM -0500, Doug Ledford wrote:
> * Really though, as I said in my email to Tom Talpey, this entire
> situation is simply screaming that we are doing DAX networking wrong. 
> We shouldn't be writing the networking code once in every single
> application that wants to do this.  If we had a memory segment that we
> shared from server to client(s), and in that memory segment we
> implemented a clustered filesystem, then applications would simply mmap
> local files and be done with it.  If the file needed to move, the kernel
> would update the mmap in the application, done.  If you ask me, it is
> the attempt to do this the wrong way that is resulting in all this
> heartache.  That said, for today, my recommendation would be to require
> ODP hardware for XFS filesystem with the DAX option, but allow ext2
> filesystems to mount DAX filesystems on non-ODP hardware, and go in and
> modify the ext2 filesystem so that on DAX mounts, it disables hole punch
> and ftrunctate any time they would result in the forced removal of an
> established mmap.

I agree that something's wrong, but I think the fundamental problem is
that there's no concept in RDMA of having an STag for storage rather
than for memory.

Imagine if we could associate an STag with a file descriptor on the
server.  The client could then perform an RDMA to that STag.  On the
server, we'd need lots of smarts in the card and in the OS to know how
to treat that packet on arrival -- depending on what the file descriptor
referred to, it might only have to write into the page cache, or it
might set up an NVMe DMA, or it might resolve the underlying physical
address and DMA directly to an NV-DIMM.
