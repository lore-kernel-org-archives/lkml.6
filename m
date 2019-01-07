Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C355CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFEC2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+em7OJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfAGThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:37:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfAGThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oBwxdkBoPjitlvZ+kpbf+JgC70DdqyjJHrpIjXiuLZo=; b=X+em7OJvfj2YOtn9AcE0RDxDb
        X/Edl5CektMfgyQT7yWGlSPVcRw2pKkiwnr5npyN8mx22VSeeQy0bAyNLGwo7eZxVo6NTiFUl2k2b
        VO/ISUwyVORTdy4nVh8q9kEMuPCPBvc3gpu7wN/jgn2jrn230gnw8n7xMeZEkXvpCwPQ6heGszdSw
        dUeYdLoSNai+JVGAUl4RB6eS/ZUqMHVEhHM5zmbfPu+9TYDQ3S6zmZuY5TwxXN5lX3lkUwse5Zz10
        gXxPfbUtKkyAYusJUfKVTv+IirkcZSCHzQY735j+kxe+SmTud2Qv+RMfxSoIe9+N+S2HDUm/O8YQT
        5NnSBuP7g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggai6-0002vv-Qv; Mon, 07 Jan 2019 19:37:18 +0000
Date:   Mon, 7 Jan 2019 11:37:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] drop_caches: Allow unmapping pages
Message-ID: <20190107193718.GB6310@bombadil.infradead.org>
References: <20190107130239.3417-1-vincent.whitchurch@axis.com>
 <20190107141545.GX6310@bombadil.infradead.org>
 <67dac226-00ca-dd0a-800e-0867e12d3ad5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dac226-00ca-dd0a-800e-0867e12d3ad5@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:25:16AM -0800, Dave Hansen wrote:
> On 1/7/19 6:15 AM, Matthew Wilcox wrote:
> > You're going to get data corruption doing this.  try_to_unmap_one()
> > does:
> > 
> >          /* Move the dirty bit to the page. Now the pte is gone. */
> >          if (pte_dirty(pteval))
> >                  set_page_dirty(page);
> > 
> > so PageDirty() can be false above, but made true by calling
> > try_to_unmap().
> 
> I don't think that PageDirty() check is _required_ for correctness.  You
> can always safely try_to_unmap() no matter the state of the PTE.  We
> can't lock out the hardware from setting the Dirty bit, ever.
> 
> It's also just fine to unmap PageDirty() pages, as long as when the PTE
> is created, we move the dirty bit from the PTE into the 'struct page'
> (which try_to_unmap() does, as you noticed).

Right, but the very next thing the patch does is call
invalidate_complete_page(), which calls __remove_mapping() which ... oh,
re-checks PageDirty() and refuses to drop the page.  So this isn't the
data corruptor that I had thought it was.

> > I also think the way you've done this is expedient at the cost of
> > efficiency and layering violations.  I think you should first tear
> > down the mappings of userspace processes (which will reclaim a lot
> > of pages allocated to page tables), then you won't need to touch the
> > invalidate_inode_pages paths at all.
> 
> By "tear down the mappings", do you mean something analogous to munmap()
> where the VMA goes away?  Or madvise(MADV_DONTNEED) where the PTE is
> destroyed but the VMA remains?
> 
> Last time I checked, we only did free_pgtables() when tearing down VMAs,
> but not for pure unmappings like reclaim or MADV_DONTNEED.  I've thought
> it might be fun to make a shrinker that scanned page tables looking for
> zero'd pages, but I've never run into a system where empty page table
> pages were actually causing a noticeable problem.

A few hours ago when I thought this patch had the ordering of checking
PageDirty() the wrong way round, I had the madvise analogy in mind so
that the PTEs would get destroyed and the dirty information transferred
to the struct page first before trying to drop pages.
