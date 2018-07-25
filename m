Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0411DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33DE20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AAb9EKxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33DE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeGYTf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:35:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/S5ejpMAAkqC4fVDVBPmPsEVFj2IIPrI03iVRacCVSM=; b=AAb9EKxu2a17ri8iHDuUg8yUI
        93hQxaOE8+032rIsimITfljtKwEVRlJRK5OuXxdqXACwNSzO+8o02iMhqc2esJLz5qKIlWC4gvR+9
        8b71JqIdI+Lffm4MCop3t/kES+ElAQ6BlnG/4yPD8bPvXHhGnhsHMDs6gwOiUnqcwjK7U4SbYFTxz
        gAfRvkS3Du10rtKvNaQeuzNWOrjZSDt+peTBeYQ4dTSUAVfSYyPQnSBb9CqjKMiE5KKz9ql//e7zS
        u++JpphUj68V9qJ73ymrX5Ddl81r0lYAqMB7Bsrf19+Q/G+oImdCCciqBBimwVcOP/Lt9xvyMB8IE
        ZM3xAM4EQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiORD-0006yV-PV; Wed, 25 Jul 2018 18:23:03 +0000
Date:   Wed, 25 Jul 2018 11:23:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     elliott@hpe.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>, sqazi@google.com,
        Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>, nullptr@google.com
Subject: Re: [PATCH v2] RFC: clear 1G pages with streaming stores on x86
Message-ID: <20180725182303.GA1366@bombadil.infradead.org>
References: <20180724210923.GA20168@bombadil.infradead.org>
 <20180725023728.44630-1-cannonmatthews@google.com>
 <DF4PR8401MB11806B9D2A7FE04B1F5ECBF8AB540@DF4PR8401MB1180.NAMPRD84.PROD.OUTLOOK.COM>
 <CAJfu=Uf98_FBNkULq5RD6dapY5K6gL=Xm7DOSJJVscDfKkwq0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfu=Uf98_FBNkULq5RD6dapY5K6gL=Xm7DOSJJVscDfKkwq0Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:30:40AM -0700, Cannon Matthews wrote:
> On Tue, Jul 24, 2018 at 10:02 PM Elliott, Robert (Persistent Memory)
> > > +     BUG_ON(pages_per_huge_page % PAGES_BETWEEN_RESCHED != 0);
> > > +     BUG_ON(!dest);
> >
> > Are those really possible conditions?  Is there a safer fallback
> > than crashing the whole kernel?
> 
> Perhaps not, I hope not anyhow,  this was something of a first pass
> with paranoid
> invariant checking, and initially I wrote this outside of the x86
> specific directory.
> 
> I suppose that would depend on:
> 
> Is page_to_virt() always available and guaranteed to return something valid?
> Will `page_per_huge_page` ever be anything other than 262144, and if so
> anything besides 512 or 1?

page_to_virt() can only return NULL for HIGHMEM, which we already know
isn't going to be supported.  pages_per_huge_page might vary in the
future, but is always going to be a power of two.  You can turn that into
a build-time assert, or just leave it for the person who tries to change
gigantic pages from being anything other than 1GB.

> It seems like on x86 these conditions will always be true, but I don't know
> enough to say for 100% certain.

They're true based on the current manuals.  If Intel want to change them,
it's fair that they should have to change this code too.

> Before I started this I experimented with all of those variants, and
> interestingly found that I could equally saturate the memory bandwidth with
> 64,128, or 256bit wide instructions on a broadwell CPU ( I did not have a
> skylake/AVX-512 machine available to run the tests on, would be a curious
> thing to see it it holds for that as well).
> 
> >From userspace I did a mmap(MAP_POPULATE), then measured the time
>  to zero a 100GiB region:
> 
> mmap(MAP_POPULATE):     27.740127291
> memset [libc, AVX]:     19.318307069
> rep stosb:              19.301119348
> movntq:                 5.874515236
> movnti:                 5.786089655
> movtndq:                5.837171599
> vmovntdq:               5.798766718
> 
> It was interesting also that both the libc memset using AVX
> instructions
> (confirmed with gdb, though maybe it's more dynamic/tricksy than I know) was
> almost identical to the `rep stosb` implementation.
> 
> I had some conversations with some platforms engineers who thought this made
> sense, but that it is likely to be highly CPU dependent, and some CPUs might be
> able to do larger bursts of transfers in parallel and get better
> performance from
> the wider instructions, but this got way over my head into hardware SDRAM
> controller design. More benchmarking would tell however.
> 
> Another thing to consider about AVX instructions is that they affect core
> frequency and power/thermals, though I can't really speak to specifics but I
> understand that using 512/256 bit instructions and zmm registers can use more
> power and limit the  frequency of other cores or something along those
> lines.
> Anyone with expertise feel free to correct me on this though. I assume this is
> also highly CPU dependent.

There's a difference between using AVX{256,512} load/store and arithmetic
instructions in terms of power draw; at least that's my recollection
from reading threads on realworldtech.  But I think it's not worth
going further than you have.  You've got a really nice speedup and it's
guaranteed to be faster on basically every microarch.  If somebody wants
to do something super-specialised for their microarch, they can submit
a patch on top of yours.
