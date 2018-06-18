Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3B2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD4820874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD4820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeFRIEI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:04:08 -0400
Received: from verein.lst.de ([213.95.11.211]:33943 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932723AbeFRIEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:04:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 72C3568E44; Mon, 18 Jun 2018 10:12:58 +0200 (CEST)
Date:   Mon, 18 Jun 2018 10:12:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180618081258.GB16991@lst.de>
References: <20180617012510.20139-1-jhubbard@nvidia.com> <20180617012510.20139-3-jhubbard@nvidia.com> <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com> <20180617200432.krw36wrcwidb25cj@ziepe.ca> <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com> <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 01:28:18PM -0700, John Hubbard wrote:
> Yes. However, my thinking was: get_user_pages() can become a way to indicate that 
> these pages are going to be treated specially. In particular, the caller
> does not really want or need to support certain file operations, while the
> page is flagged this way.
> 
> If necessary, we could add a new API call.

That API call is called get_user_pages_longterm.

> But either way, I think we could
> reasonably document that "if you pin these pages (either via get_user_pages,
> or some new, similar-looking API call), you can DMA to/from them, and safely
> mark them as dirty when you're done, and the right things will happen. 
> And in the interim, you can expect that the follow file system API calls
> will not behave predictably: fallocate, truncate, ..."

That is not how get_user_pages(_fast) is used.  We use it all over the
kernel, including for direct I/O.  You'd break a lot of existing use
cases very badly.
