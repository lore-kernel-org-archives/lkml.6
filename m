Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649EBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01583217BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01583217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeHFKgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:36:08 -0400
Received: from verein.lst.de ([213.95.11.211]:54656 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeHFKgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:36:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8B3A468D52; Mon,  6 Aug 2018 10:33:22 +0200 (CEST)
Date:   Mon, 6 Aug 2018 10:33:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
Message-ID: <20180806083322.GA31637@lst.de>
References: <Pine.LNX.4.44L0.1808051424440.29532-100000@netrider.rowland.org> <55fffb30-1388-af6a-70a6-cb738dab062f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fffb30-1388-af6a-70a6-cb738dab062f@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 02:38:22PM -0700, Guenter Roeck wrote:
> AFAICS it used to be interrupt tolerant for all but x86 up to commit
> 6894258eda ("dma-mapping: consolidate dma_{alloc,free}_{attrs,coherent}").
> A quick test shows that the warning is indeed not seen if I run my test
> on v3.18.y.
>
> You would have to ask Christoph why it is now interrupt-intolerant for all
> architectures.

interrupt-tolerant actually is a very odd wording.  x86 itself (at least
unless using an iommu) actually is fine with calling dma_free_* with
interrupts disabled, but many other architectures are not.  For many
architectures that are not cache coherent we'll have to manipulale
the kernel page tables when freeing coherent memory, which we absolutely
can't do from irq context.  And as usual in the kernel we try to enforce
the same rules on everyone to allow for portable code.

Also except for the odd USB use cases that abuses dma_alloc_coherent
for the bounce buffers in device local memory you are doing something
wrong if you call dma_alloc*/dma_free* anywhere but during device
initialization and removal.  These are slow path interfaces for
allocating memory for things like descriptors and similar.  Your fast
path should be using dma_map*/dma_unmap*.
