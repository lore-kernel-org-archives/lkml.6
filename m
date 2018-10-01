Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FE9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D11A20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o1AXa+Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D11A20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeJAWaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:30:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJAWaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YvJu2YggMvLwkf+KcRSyKAyF/gQXmYEtqQKuIvF8MVQ=; b=o1AXa+UpcBHCFCF48zZwDNYcl
        poCpiYC0zqM2gkfynrpsd7wUQZNPaJva0aKgj779cnLo/Pl3CSEL1BIwMP+KgP2GfRjFHP9/GpPkV
        GTLXSxCa5MomMMJSRYl2BIZXw6h1DUjzk44aBreyQguT5fCmMHlB/lqzSNQJh5HHm6aGvSHxH0w2r
        4HQzNm6vQOPbf/XnmQScnh58ERowipCJWt8Ftpz1djvhWybmaVIXRo/kabEqkPQ2FxGjGJg/F6gcH
        vge+12a4WD1zkA+VBjVPmr+jUY+XvEmCO0WGZIeQ9JDj2OSU/Hrsmy8oW8269qH0VovuTUXYbiu8G
        EpHGrSEqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g70U6-0001Hw-Be; Mon, 01 Oct 2018 15:51:46 +0000
Date:   Mon, 1 Oct 2018 08:51:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, john.hubbard@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
Message-ID: <20181001155146.GA30236@infradead.org>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com>
 <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
 <20180929162117.GA31216@bombadil.infradead.org>
 <20181001125013.GA6357@infradead.org>
 <20181001152929.GA21881@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001152929.GA21881@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 08:29:29AM -0700, Matthew Wilcox wrote:
> I don't understand the dislike of the sg list.  Other than for special
> cases which we should't be optimising for (ramfs, brd, loopback
> filesystems), when we get a page to do I/O, we're going to want a dma
> mapping for them.  It makes sense to already allocate space to store
> the mapping at the outset.

We don't actually need the space - the scatterlist forces it on us,
otherwise we could translate directly in the on-disk format and
save that duplicate space.  I have prototypes for NVMe and RDMA that do
away with the scatterlist entirely.

And even if we are still using the scatterlist as we do right now we'd
need a second scatterlist at least for block / file system based I/O
as we can't plug the scatterlist into the I/O stack (nevermind that
due to splitting merging the lower one might not map 1:1 to the upper
one).

> [1] Can we ever admit that the bio_vec and the skb_frag_t are actually
> the same thing?

When I brought this up years ago the networking folks insisted that
their use of u16 offset/size fields was important for performance,
while for bio_vecs we needed the larger ones for some cases.  Since
then networking switched to 32-bit fields for what is now the fast
path, so it might be worth to give it another spin.

Than should also help with using my new bio_vec based dma-mapping
helpers to batch iommu mappings in networking, which Jesper had on
his todo list as all the indirect calls are causing performance
issues.
