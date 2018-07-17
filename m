Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7065EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2851A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2851A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeGQUgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:36:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54558 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbeGQUgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:36:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 27AB1207AB; Tue, 17 Jul 2018 22:02:19 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6628B2091A;
        Tue, 17 Jul 2018 22:01:36 +0200 (CEST)
Date:   Tue, 17 Jul 2018 22:01:36 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nand: ranw: qcom_nand: stop using phys_to_dma()
Message-ID: <20180717220136.2782fc5d@bbrezillon>
In-Reply-To: <CAK8P3a1M4v1hMduAX3y39DEjBiT=70xm-+qJ8CPLZHQwKOzJ1g@mail.gmail.com>
References: <20180711122709.358159-1-arnd@arndb.de>
        <20180711150449.4152333c@bbrezillon>
        <CAK8P3a1M4v1hMduAX3y39DEjBiT=70xm-+qJ8CPLZHQwKOzJ1g@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 11 Jul 2018 16:26:31 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Jul 11, 2018 at 3:04 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Wed, 11 Jul 2018 14:26:58 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> >> Compile-testing this driver on x86 caused a link error:
> >>
> >> ERROR: "__phys_to_dma" [drivers/mtd/nand/raw/qcom_nandc.ko] undefined!
> >>
> >> The problem here is that the driver attempts to convert the physical
> >> address into the DMA controller as a dma_addr_t and calls phys_to_dma()
> >> to do the conversion.
> >>
> >> However, there is no generic way to convert a phys_addr_t into a dma_addr_t
> >> for anything other than RAM (which should use the dma-mapping API instead).
> >> The only correct use of phys_to_dma() instead is inside of the dma-mapping
> >> implementation.  
> >
> > Should we use dma_map_resource() to do the phys_addr_t to dma_addr_t
> > conversion?  
> 
> I had not seen that interface before, but yes, that does seem like the best
> way to do it here.

Do you plan to send a new version using dma_map_resource()? BTW,
there's typo in the subject prefix (s/ranw/rawnand/).

Regards,

Boris
