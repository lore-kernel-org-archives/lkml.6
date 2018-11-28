Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9707C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770012081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ofRs3GaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770012081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeK2EsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:48:24 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52406 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeK2EsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k4Z7OkTNJk0fXnQq6JzVB6Wb0tgecubNwuvpU5g+JU4=; b=ofRs3GaYZUxqpRLXyEVm2IEbW
        ByvhoKepbttsLZZo35S209BgCvznZBD4F1VgxWoyWWm7MeEuCCSxamKnd6K+eRxhcItBZAX7+d6rR
        5N/psCmqjjY40Akd71ik3xQr8Hdex9vRSxBOYTN6j1PiULrInbsX/W0peT7SRcNifwjrQ=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:51193)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gS3uJ-00063i-NN; Wed, 28 Nov 2018 17:45:51 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gS3uF-0005YN-SF; Wed, 28 Nov 2018 17:45:48 +0000
Date:   Wed, 28 Nov 2018 17:45:45 +0000
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
Message-ID: <20181128174545.GJ30658@n2100.armlinux.org.uk>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de>
 <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:47:05AM -0800, Linus Torvalds wrote:
> On Tue, Nov 27, 2018 at 11:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Fri, Nov 23, 2018 at 07:55:11AM +0100, Christoph Hellwig wrote:
> > > Well, I can tweak the last patch to return -EINVAL from dma_mapping_error
> > > instead of the old 1 is as bool true.  The callers should all be fine,
> > > although I'd have to audit them.  Still wouldn't help with being able to
> > > return different errors.
> >
> > Any opinions?  I'd really like to make some forward progress on this
> > series.
> 
> So I do think that yes, dma_mapping_error() should return an error
> code, not 0/1.
> 
> But I was really hoping that the individual drivers themselves could
> return error codes. Right now the patch-series has code like this:
> 
>       ret = needs_bounce(dev, dma_addr, size);
>       if (ret < 0)
> -         return ARM_MAPPING_ERROR;
> +         return DMA_MAPPING_ERROR;
> 
> which while it all makes sense in the context of this patch-series, I
> *really* think it would have been so much nicer to return the error
> code 'ret' instead (which in this case is -E2BIG).
> 
> I don't think this is a huge deal, but ERR_PTR() has been hugely
> successful elsewhere. And I'm not hugely convinced about all these
> "any address can be valid" arguments. How the hell do you generate a
> random dma address in the last page that isn't even page-aligned?

kmalloc() a 64-byte buffer, dma_map_single() that buffer.  If you
have RAM that maps to a _bus_ address in the top page of 4GB of a
32-bit bus address, then you lose.  Simples.

Subsystems like I2C, SPI, USB etc all deal with small kmalloc'd
buffers and their drivers make use of DMA.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
