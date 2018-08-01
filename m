Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E610620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dsVHbpYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E610620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbeHAKVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:21:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbeHAKVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mf3XNY3mBtK6dbzk/xdtOh4J+lkXum6gACUqD3Xo5c8=; b=dsVHbpYjgTVYdwkMz1PcRCeJp
        0uW12N1Prb7J5Mi2Yzq7GT9bPoYeguMw/f8QWvjW3rzJxp9x4pRp257Sc5XTBHdDFBcPhd8UXJw8f
        EkNAtyCiMGnUrsBciP7rEUtQsRfSzFZ5lB2VqSord+fz6bj1+CRvC/f/q0SGbmK9d0zCMe8oFMYXm
        jWC2BizMEd2ABHxOXmBpq0U9GA+//GIDxaiEAUsxGKHoip/MIezqdunIVqq7yEkQ4sObSVBoRJ7qC
        J2/R7mnNNEoboUvjYu+oaQloMIhGXchjC463dXtba9/nnZ7WOMHpQeW0F55wozLEV31dEi/DGUwWn
        j3MOAOfQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkmca-0007Mm-3d; Wed, 01 Aug 2018 08:36:40 +0000
Date:   Wed, 1 Aug 2018 01:36:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180801083639.GF26378@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801081637.GA14438@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:16:38AM +0100, Will Deacon wrote:
> On arm/arm64, the problem we have is that legacy virtio devices on the MMIO
> transport (so definitely not PCI) have historically been advertised by qemu
> as not being cache coherent, but because the virtio core has bypassed DMA
> ops then everything has happened to work. If we blindly enable the arch DMA
> ops,

No one is suggesting that as far as I can tell.

> we'll plumb in the non-coherent ops and start getting data corruption,
> so we do need a way to quirk virtio as being "always coherent" if we want to
> use the DMA ops (which we do, because our emulation platforms have an IOMMU
> for all virtio devices).

From all that I've gather so far: no you do not want that.  We really
need to figure out virtio "dma" interacts with the host / device.

If you look at the current iommu spec it does talk of physical address
with a little careveout for VIRTIO_F_IOMMU_PLATFORM.

So between that and our discussion in this thread and its previous
iterations I think we need to stick to the current always physical,
bypass system dma ops mode of virtio operation as the default.

We just need to figure out how to deal with devices that deviate
from the default.  One things is that VIRTIO_F_IOMMU_PLATFORM really
should become VIRTIO_F_PLATFORM_DMA to cover the cases of non-iommu
dma tweaks (offsets, cache flushing), which seems well in spirit of
the original design.  The other issue is VIRTIO_F_IO_BARRIER
which is very vaguely defined, and which needs a better definition.
And last but not least we'll need some text explaining the challenges
of hardware devices - I think VIRTIO_F_PLATFORM_DMA + VIRTIO_F_IO_BARRIER
is what would basically cover them, but a good description including
an explanation of why these matter.
