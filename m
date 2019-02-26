Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AA9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F126B217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D7sWvUea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBZNQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:16:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/0Yfqvt2fTZP8q8jxlYBFshRU+XHsJv+JQimDtiuzTQ=; b=D7sWvUea+gs67NCuS5heXPu2Q
        oFl3rP7mlRN3+UIubV0pnwh7VIR1TKzkFc4fJbIWm2NyWZ7U/cqAKDWov9sTN5mteThwKi0kDeuuB
        jcR4PgcKwYMflwdVTa7fb+YcWSRiWXTWhSdU9To9fjRpBNU07H9+Dp7L8pUYzQiXg30IMtA9Tm1mK
        QfQ5GtzK2ZyngUcWQQTBw6+aYlxSoTaZjTRRSVEZOd9piop58N824Po9FVVpgWiGjhs4HK45zMpkT
        ZKXeiMaIPkh0Lk1r6PsuFJ3kggQ31c1igzwgnQGIIJ9RQHq3ZezY0sdMSYiWB2ZoST0QW+fQ3DUzZ
        DEW5JyQvw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gycbK-0007gX-Ue; Tue, 26 Feb 2019 13:16:50 +0000
Date:   Tue, 26 Feb 2019 05:16:50 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Balcer, Piotr" <piotr.balcer@intel.com>
Subject: Re: find_get_entries_tag regression bisected
Message-ID: <20190226131650.GE11592@bombadil.infradead.org>
References: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
 <20190216153511.GM12668@bombadil.infradead.org>
 <20190216172948.GN12668@bombadil.infradead.org>
 <20190216211105.GO12668@bombadil.infradead.org>
 <CAPcyv4j8G0S4Z2ngzrz_OhFjp8+4tqCtpRRE6Eq33uczh0QBRA@mail.gmail.com>
 <20190226120820.GB11592@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226120820.GB11592@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 04:08:21AM -0800, Matthew Wilcox wrote:
> On Mon, Feb 25, 2019 at 09:03:00PM -0800, Dan Williams wrote:
> > On Sat, Feb 16, 2019 at 1:11 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sat, Feb 16, 2019 at 09:29:48AM -0800, Matthew Wilcox wrote:
> > > > On Sat, Feb 16, 2019 at 07:35:11AM -0800, Matthew Wilcox wrote:
> > > > > Another way to fix this would be to mask the address in dax_entry_mkclean(),
> > > > > but I think this is cleaner.
> > > >
> > > > That's clearly rubbish, dax_entry_mkclean() can't possibly mask the
> > > > address.  It might be mis-aligned in another process.  But ... if it's
> > > > misaligned in another process, dax_entry_mkclean() will only clean the first
> > > > PTE associated with the PMD; it won't clean the whole thing.  I think we need
> > > > something like this:
> > >
> > > Nope, this isn't enough.  It's _necessary_ to find the processes that
> > > have part of this PMD page mapped, but not the start of it.  But it's
> > > not _sufficient_ because it'll still only mkclean the first PTE.  So we
> > > need a loop.  I'm feeling a bit over my head here.  I may have a go at
> > > a fuller fix, but if someone else wants to have a go at it, be my guest!
> > 
> > Nothing comes to mind outside of pseudo-reverting this conversion by
> > introducing a way to get back to the old semantics. If you don't see a
> > path forward, us mere Xarray-mortals stand no chance.
> 
> This is a pre-existing bug.  Fixing the regression is easy.

To be clear; I sent the regression fix a week ago in
20190216153511.GM12668@bombadil.infradead.org

I haven't tested it; I don't have a suitable setup right now.

The pre-existing bug is that if you have two tasks with the same
address range mapped, but one has it mapped with a PMD and the
other has it mapped with PTEs (maybe due to mapping only a subset
of the addresses), dax_entry_mkclean() won't clean the PTEs because
vma_interval_tree_foreach() won't find the VMA.
