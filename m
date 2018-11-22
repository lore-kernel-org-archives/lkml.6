Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461BFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBA020645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wzf+T71I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBA020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406194AbeKWDrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:47:45 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37834 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbeKWDro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N5JqTIVcQxGnW3jhvc7PN2ZvPmWZ9oBpMwqexak7ISE=; b=Wzf+T71IEkeCzeUTkYk1lPY8t
        HJXb3dWQZtwasdmlXPBojH0MC77ybisq3Z+9lb7O4d7vnqLhjgkHYgrQvN2NUcQGPZoDnMX3ez7Fq
        mLQEw1Rh7xawfBuf+6CPIXCc//KPIvho+rteUEuRVkpoWF5/ira6hAFZgRyvGufEiSixs=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:53612)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPsRl-000374-HP; Thu, 22 Nov 2018 17:07:21 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPsRh-0003le-CI; Thu, 22 Nov 2018 17:07:17 +0000
Date:   Thu, 22 Nov 2018 17:07:15 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        xen-devel@lists.xenproject.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181122170715.GI30658@n2100.armlinux.org.uk>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 08:50:47AM -0800, Linus Torvalds wrote:
> On Thu, Nov 22, 2018 at 6:03 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The 0 return doesn't work for direct mappings that have ram at address
> > zero and a lot of IOMMUs that start allocating bus space from address
> > zero, so we can't consolidate on that, but I think we can move everyone
> > to all-Fs, which the patch here does.
> 
> Hmm. Maybe not limit it to just all ones, but actually use the
> (standard, for the kernel) IS_ERR_VALUE()?
> 
> That basically reserves the last 4095 values in an unsigned long for
> error values.
> 
> Then those functions could actually return *what* error they
> encountered, using just plain
> 
>         return -ENOMEM;
> 
> or whatever?

Linus,

I'm afraid that won't work very well - 32 bit platforms with 64-bit
addresses (LPAE) would have dma_addr_t as a 64-bit value, which
wouldn't fit into an unsigned long.

IS_ERR_VALUE() would cast a 64-bit DMA address down to a 32-bit
pointer (effectively masking with 0xffffffff).  It would have the
effect of making (eg) 0xXXXXXXXX_fffffVVV an error, where XXXXXXXX
are any of the top 32-bits of a 64-bit bus address, and VVV is the
error code value.

That could be a problem if you hit it in several places throughout
your available RAM... we'd have to mark every top page of RAM in
a naturally aligned 4GB as unusable, as well as block the top page
in natually aligned 4GB blocks from IOMMUs... and then what about
buses that have weird offsets...

So, I don't think the IS_ERR_VALUE() would work very well.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
