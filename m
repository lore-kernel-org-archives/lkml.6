Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA335C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A45206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A45206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409494AbeKWVdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:33:06 -0500
Received: from 8bytes.org ([81.169.241.247]:49232 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387655AbeKWVdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:33:06 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7EE16322; Fri, 23 Nov 2018 11:49:18 +0100 (CET)
Date:   Fri, 23 Nov 2018 11:49:18 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux@armlinux.org.uk, Christoph Hellwig <hch@lst.de>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181123104918.GE1586@8bytes.org>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 05:52:15PM +0000, Robin Murphy wrote:
> Unfortunately, with things like the top-down IOVA allocator, and 32-bit
> systems in general, "the top 4095" values may well still be valid addresses
> - we're relying on a 1-byte mapping of the very top byte of memory/IOVA
> space being sufficiently ridiculous that no real code would ever do that,
> but even a 4-byte mapping of the top 4 bytes is within the realms of the
> plausible (I've definitely seen the USB layer make 8-byte mappings from any
> old offset within a page, for example).

But we can easily work around that by reserving the top 4k of the first
4GB of IOVA address space in the allocator, no? Then these values are
never returned as valid DMA handles.


Regards,

	Joerg

