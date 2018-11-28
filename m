Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E687C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7148208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NcfNGhye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7148208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeK2GuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:50:14 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54056 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2GuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KBvtpmJNoUWUAhsCVnKaCKgB3XrFxh+KAh2HMOdDpKo=; b=NcfNGhyeiRIIeK0HlIIEVX68A
        GSYhCWehsmBrLW4QAdMBuVwRPmpbIDwdLWCuI3thggvt0abSSzOtNsZFZ47SSHKxFKU9BCP7wreeU
        WoagLP32OQ5Eo8fjeJqPRxOfBz7jyH1PLujRGudwsxZsMeuQ73eJRhrupkNI0P69DYtjE=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:42491)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gS5nr-0006eo-Q6; Wed, 28 Nov 2018 19:47:19 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gS5nm-00074y-5C; Wed, 28 Nov 2018 19:47:14 +0000
Date:   Wed, 28 Nov 2018 19:47:09 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, robin.murphy@arm.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-alpha@vger.kernel.org, xen-devel@lists.xenproject.org,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181128194708.GP30658@n2100.armlinux.org.uk>
References: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk>
 <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128.112717.149234960284639699.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128.112717.149234960284639699.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:27:17AM -0800, David Miller wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Wed, 28 Nov 2018 10:00:06 -0800
> 
> > Not all memory is accessible even to the kernel. If you have memory
> > that shows up in the last page of phys_addr_t, you just mark it
> > reserved at boot-time.
> 
> It's not the physical memory at the end that needs to be reserved.
> 
> It's the IOMMU mapping arena.

True, if and only if you have an IOMMU.

Where there isn't an IOMMU, then we'd have to reserve every page that
that translates to a bus address in the top 4K of dma_addr_t on any
bus in the system - that means knowing early in the kernel
initialisation about all buses in the system so we can detect and
reserve these pages.

I don't think that's trivial to do.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
