Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D16EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066A520864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AmXu96LJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066A520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeK2Ge4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:34:56 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53870 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2Gez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0F9M2ky248AzTDbBYp0kd4XRh3zqAPomiVVLBP6TO3M=; b=AmXu96LJerk3c6K/104JPow7L
        9WD2UKhBd9dxwUaXkhvvQyElWZUdPhbwemZ1X2uamK9llswWHoMAu/OmY7phprNyZMepIdih9Dlzj
        D1qqMzsIBRMuDx8yentxbFcIkI4a8kTv9wifWHCO5f7/o3qFgBIddKh8ocCJWLg2gamlU=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:57653)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gS5Z9-0006bI-I0; Wed, 28 Nov 2018 19:32:07 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gS5Z1-0006w5-NX; Wed, 28 Nov 2018 19:31:59 +0000
Date:   Wed, 28 Nov 2018 19:31:57 +0000
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
Message-ID: <20181128193157.GO30658@n2100.armlinux.org.uk>
References: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de>
 <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk>
 <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128180841.GM30658@n2100.armlinux.org.uk>
 <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:19:15AM -0800, Linus Torvalds wrote:
> On Wed, Nov 28, 2018, 10:08 Russell King - ARM Linux <linux@armlinux.org.uk
> wrote:
> 
> > >
> > > You already cannot do that kmalloc(), exactly because of ERR_PTR().
> >
> > I'm very sorry, but I think you are confused.
> >
> > kmalloc() returns a _virtual_ address, which quite rightly must not be
> > in the top 4K of 4GB, exactly due to ERR_PTR().  That is fine.
> >
> > However, that is a completely different kettle of fish from a physical
> > or DMA address - neither of which are virtual addresses.
> >
> 
> You cut away the part that showed that I'm not in the least confused.
> 
> Let me just paste it back in here:
> 
>   "Which is what we ALREADY do for these exact reasons. If the DMA
> mappings means that you'd need to add one more page to that list of
> reserved pages, then so be it."

We're not talking about just one more page.  We're talking about
_every_ page that _may_ map to a bus address in the range of 4GB - 4K
(a point I've already made earlier in this discussion.)

It's not just about physical addresses, it's about bus addresses,
and there are buses out there that have a translation between physical
address and bus address without IOMMUs and the like.

Can we know ahead of time about all these translations?  It means
moving that information out of various bus drivers into core
architecture code (yuck, when you have multiple different platforms)
or into DT (which means effectively breaking every damn platform
that's using older DT files) - something that we don't have to do
today.

I remain 100% opposed to your idea.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
