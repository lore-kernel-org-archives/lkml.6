Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F57C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93602206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gzraGNzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93602206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeK2FLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:11:23 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52842 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeK2FLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pYJza61sLJFdlvldn49lYBrtO2jjWdq4lJ2R7xdUYFg=; b=gzraGNzvLo/pQut2clQbWptl/
        CCoEFxn4FZkGXl2i5kb+MsfjsXZxbDz03Mx9bdLb9BQOspE9Pxrg5KjGFouybj/cRMcO4G7rvGVCo
        nKDj3+d+Y3LQWLtQbV9cQG+ZnnLrq4nyOf649l1lhvJ7Re+A1N63TI5L1xNh2iPUA8xsI=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:56644)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gS4GU-0006GK-RU; Wed, 28 Nov 2018 18:08:47 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gS4GR-00061u-Bo; Wed, 28 Nov 2018 18:08:43 +0000
Date:   Wed, 28 Nov 2018 18:08:41 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        robin.murphy@arm.com, the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181128180841.GM30658@n2100.armlinux.org.uk>
References: <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de>
 <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk>
 <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:00:06AM -0800, Linus Torvalds wrote:
> On Wed, Nov 28, 2018 at 9:45 AM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > > I don't think this is a huge deal, but ERR_PTR() has been hugely
> > > successful elsewhere. And I'm not hugely convinced about all these
> > > "any address can be valid" arguments. How the hell do you generate a
> > > random dma address in the last page that isn't even page-aligned?
> >
> > kmalloc() a 64-byte buffer, dma_map_single() that buffer.
> 
> No.
> 
> You already cannot do that kmalloc(), exactly because of ERR_PTR().

I'm very sorry, but I think you are confused.

kmalloc() returns a _virtual_ address, which quite rightly must not be
in the top 4K of 4GB, exactly due to ERR_PTR().  That is fine.

However, that is a completely different kettle of fish from a physical
or DMA address - neither of which are virtual addresses.

Now, say we have 1GB of RAM which starts at 0xc0000000 _physical_.
The kernel is configured with a 2GB/2GB user/kernel split, which means
all 1GB of RAM is mapped as lowmem from 0x80000000 to 0xbfffffff
inclusive.  This means kmalloc() can return any address in that range.

ERR_PTR() will work correctly on any of those pointers, meaning that
none of them will be seen as an error.

However, map any virtual address in the range of 0xbffff000 to
0xbfffffff into DMA space, and the resulting DMA address could well
be in the range of 0xfffff000 to 0xffffffff - precisely the range
of addresses that you are advocating to be used for error codes.

> The whole argument of "every possible piece of memory is DMA'able" is
> just wrong.

I'm very sorry, but I do not buy your argument - you are conflating
virtual addresses which ERR_PTR() deals in with physical and bus
addresses - and if you persist down this route, you will cause
regressions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
