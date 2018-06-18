Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5241AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F352720874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYhfLd06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F352720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeFRIKJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:10:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932918AbeFRIKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x2dJnZekaDdeDwD7hQgNuSNkI/1aHMsETvW1BOmt+Oo=; b=XYhfLd06BixRLxQkFTCa/k4gN
        71MrJ9OymIMWh5REZIYwAoFR6khRiSqZRMacbTvNzNaCShGKsf3H2dx8KDk3821+2OCQxAPf11H1v
        aSmuV5YRhPDwkBco6dvb4z5zOOZ83nGkr5i9N/xQ4pgldFshPCirWIaq5uw6gl//5p3GiSMkTSN4C
        jn7l9MoqWIYLerbYjznoBjC29UUfC1s9U7Errg1K+ZZyH1yTi0cHyE+Dqy19o9IxyyWgXW+u54+HD
        wufYckbfWwlSiCXfMgN3roLujHHOvErLWtE4O0se1FS6lyTWGpALY0JM7j/KFd0CnFNP6k/nGDlXs
        Yn9nbTIzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUpEi-0005cB-2G; Mon, 18 Jun 2018 08:10:04 +0000
Date:   Mon, 18 Jun 2018 01:10:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/2] mm: gup: don't unmap or drop filesystem buffers
Message-ID: <20180618081003.GA20927@infradead.org>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <010001640fbe0dd8-f999e7f6-7b6e-4deb-b073-0c572006727d-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001640fbe0dd8-f999e7f6-7b6e-4deb-b073-0c572006727d-000000@email.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 09:54:31PM +0000, Christopher Lameter wrote:
> On Sat, 16 Jun 2018, john.hubbard@gmail.com wrote:
> 
> > I've come up with what I claim is a simple, robust fix, but...I'm
> > presuming to burn a struct page flag, and limit it to 64-bit arches, in
> > order to get there. Given that the problem is old (Jason Gunthorpe noted
> > that RDMA has been living with this problem since 2005), I think it's
> > worth it.
> >
> > Leaving the new page flag set "nearly forever" is not great, but on the
> > other hand, once the page is actually freed, the flag does get cleared.
> > It seems like an acceptable tradeoff, given that we only get one bit
> > (and are lucky to even have that).
> 
> This is not robust. Multiple processes may register a page with the RDMA
> subsystem. How do you decide when to clear the flag? I think you would
> need an additional refcount for the number of times the page was
> registered.

And it's not just RDMA that is using get_user_pages.  We have tons of
users that do short, spurious get_user_pages do do zero copy operations.

We can't leave the page in a wrecked state after that.

> I still think the cleanest solution here is to require mmu notifier
> callbacks and to not pin the page in the first place. If a NIC does not
> support a hardware mmu then it can still simulate it in software by
> holding off the ummapping the mmu notifier callback until any pending
> operation is complete and then invalidate the mapping so that future
> operations require a remapping (or refaulting).

Sounds ok for RDMA, not going to help for most other users.
