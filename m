Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A13C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905E426D23
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905E426D23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeFZQs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:48:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752568AbeFZQs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:48:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE63BABEC;
        Tue, 26 Jun 2018 16:48:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6A9521E3515; Tue, 26 Jun 2018 18:48:25 +0200 (CEST)
Date:   Tue, 26 Jun 2018 18:48:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180626164825.fz4m2lv6hydbdrds@quack2.suse.cz>
References: <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca>
 <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
 <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <20180626134757.GY28965@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626134757.GY28965@dhcp22.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-06-18 15:47:57, Michal Hocko wrote:
> On Mon 18-06-18 12:21:46, Dan Williams wrote:
> [...]
> > I do think we should explore a page flag for pages that are "long
> > term" pinned. Michal asked for something along these lines at LSF / MM
> > so that the core-mm can give up on pages that the kernel has lost
> > lifetime control. Michal, did I capture your ask correctly?
> 
> I am sorry to be late. I didn't ask for a page flag exactly. I've asked
> for a way to query for the pin to be temporal or permanent. How that is
> achieved is another question. Maybe we have some more spare room after
> recent struct page reorganization but I dunno, to be honest. Maybe we
> can have an _count offset for these longterm pins. It is not like we are
> using the whole ref count space, right?

Matthew had an interesting idea to pull pinned pages completely out from
any LRU and reuse that space in struct page for pinned refcounts. From some
initial investigation (read on elsewhere in this thread) it looks doable. I
was considering offsetting in refcount as well but on 32-bit architectures
there's not that many bits that I'd be really comfortable with that
solution...
 
> Another thing I was asking for is to actually account those longterm
> pinned pages and apply some control over those. They are basically mlock
> like and so their usage should better not be unbound.

Agreed here but I'd prefer to keep this discussion separate from 'how to
identify pinned pages'.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
