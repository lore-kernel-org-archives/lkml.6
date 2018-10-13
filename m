Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA9AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297A92077C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fnb73Eo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297A92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJNAZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:25:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeJNAZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5JTAhWThjAfobE+w/amOQSt4mRL4A8wfY378mriehps=; b=Fnb73Eo1jtSEVWcBDa3on5oAe
        XuBE0osk8cPwu1N0cGXHBb4fKGxnOhoyg+VqH1oijuIR9x3+qK5xDUHBcaOdLotOiznzP+xvVXprK
        HWkwtbaK6SNsiC/XGLPcDb7V3BZ+rw4xKtMPXV81MQWK7w/MJTpfD0MhPwk8lSa43cA1+XqO1Qbcd
        LZOiPA51JxoHxtM129XQuSzNjgsBlXUJ02nWiWR2j1ictuUYQEMUch1NG4Y/vAScrFcLqJIa8EGOf
        Gwt+gai4Z2ouhBGsJ9+od4JhaLJ3USzKpY8/9VlGr26NLaq5i9m1xla7G8+v7x7C/G1LdXpTAR90/
        dCD1W4TSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBN4n-0001qf-Cd; Sat, 13 Oct 2018 16:47:41 +0000
Date:   Sat, 13 Oct 2018 09:47:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
Message-ID: <20181013164740.GA6593@infradead.org>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-5-jhubbard@nvidia.com>
 <20181013035516.GA18822@dastard>
 <7c2e3b54-0b1d-6726-a508-804ef8620cfd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2e3b54-0b1d-6726-a508-804ef8620cfd@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 12:34:12AM -0700, John Hubbard wrote:
> In patch 6/6, pin_page_for_dma(), which is called at the end of get_user_pages(),
> unceremoniously rips the pages out of the LRU, as a prerequisite to using
> either of the page->dma_pinned_* fields. 
> 
> The idea is that LRU is not especially useful for this situation anyway,
> so we'll just make it one or the other: either a page is dma-pinned, and
> just hanging out doing RDMA most likely (and LRU is less meaningful during that
> time), or it's possibly on an LRU list.

Have you done any benchmarking what this does to direct I/O performance,
especially for small I/O directly to a (fast) block device?
