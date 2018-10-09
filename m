Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F569C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52AA2089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52AA2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIMRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:17:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:36291 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbeJIMRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:17:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9951JY7002817;
        Tue, 9 Oct 2018 00:01:21 -0500
Message-ID: <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal
 memory size
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>
Date:   Tue, 09 Oct 2018 16:01:18 +1100
In-Reply-To: <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
References: <20180927223539.28449-1-hch@lst.de>
         <20180927223539.28449-6-hch@lst.de>
         <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
> > -        * Because 32-bit DMA masks are so common we expect every architecture
> > -        * to be able to satisfy them - either by not supporting more physical
> > -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > -        * architecture needs to use an IOMMU instead of the direct mapping.
> > -        */
> > -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > +       u64 min_mask;
> > +
> > +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > +       else
> > +               min_mask = DMA_BIT_MASK(32);
> > +
> > +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> > +
> > +       if (mask >= phys_to_dma(dev, min_mask))
> >                  return 0;
> > -#endif
> >          return 1;
> >   }
> 
> So I believe I have run into the same issue that Guenter reported. On
> an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
> all probe attempts for various devices were failing with -EIO errors.
> 
> I believe the last mask check should be "if (mask < phys_to_dma(dev,
> min_mask))" not a ">=" check.

Right, that test is backwards. I needed to change it here too (powermac
with the rest of the powerpc series).

Cheers,
Ben.


