Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D3C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF77021A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KdWcAkY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfBPVLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 16:11:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfBPVLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 16:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y4Td9saIQpNV657WyZ1dogmBLd950iUjowfeEEtlTrM=; b=KdWcAkY/itLWoFbxVYudrtNEH
        nktD6OPRCWWlEcXwopuxsfFqVFszlY7QCAEugwNzwXt8TV7/iK5s5esRSmZUyF5C7WSn/W55g5yKL
        HDXC8/YdB1HPvwwA9XozZ07BtD5e9fHrAgyFTFQH1CjDOQZh8rZN2Zwkku4cgPBvXe29UM+hSUT8c
        MjaQM8jIEGnp+ULwjNG6J5y3lQ54zn/CNAiEm1h36VFtzdTfyr2j0YGIg55wdpkSi0yKkYTg/f8LL
        NDBGkuzG9OOfduzgQTHQNnhN/JlwttL+DcGjceqkp1dIlc9MmWperoOkBidt314n2DehqHX+6r6Lj
        0fMtni0kg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gv7En-0006i9-Pt; Sat, 16 Feb 2019 21:11:05 +0000
Date:   Sat, 16 Feb 2019 13:11:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Balcer, Piotr" <piotr.balcer@intel.com>
Subject: Re: find_get_entries_tag regression bisected
Message-ID: <20190216211105.GO12668@bombadil.infradead.org>
References: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
 <20190216153511.GM12668@bombadil.infradead.org>
 <20190216172948.GN12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216172948.GN12668@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 09:29:48AM -0800, Matthew Wilcox wrote:
> On Sat, Feb 16, 2019 at 07:35:11AM -0800, Matthew Wilcox wrote:
> > Another way to fix this would be to mask the address in dax_entry_mkclean(),
> > but I think this is cleaner.
> 
> That's clearly rubbish, dax_entry_mkclean() can't possibly mask the
> address.  It might be mis-aligned in another process.  But ... if it's
> misaligned in another process, dax_entry_mkclean() will only clean the first
> PTE associated with the PMD; it won't clean the whole thing.  I think we need
> something like this:

Nope, this isn't enough.  It's _necessary_ to find the processes that
have part of this PMD page mapped, but not the start of it.  But it's
not _sufficient_ because it'll still only mkclean the first PTE.  So we
need a loop.  I'm feeling a bit over my head here.  I may have a go at
a fuller fix, but if someone else wants to have a go at it, be my guest!

(feeling massively unqualified for the task at hand ;-)
