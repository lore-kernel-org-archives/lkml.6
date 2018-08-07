Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED64A2170D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED64A2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHGWue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:50:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:43327 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbeHGWue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:50:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w77KWkm5019849;
        Tue, 7 Aug 2018 15:32:51 -0500
Message-ID: <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date:   Wed, 08 Aug 2018 06:32:45 +1000
In-Reply-To: <20180807135505.GA29034@infradead.org>
References: <20180803160246.GA13794@infradead.org>
         <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
         <20180804082120.GB4421@infradead.org>
         <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
         <20180805072930.GB23288@infradead.org>
         <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
         <20180806094243.GA16032@infradead.org>
         <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
         <20180807062117.GD32709@infradead.org>
         <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
         <20180807135505.GA29034@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 06:55 -0700, Christoph Hellwig wrote:
> On Tue, Aug 07, 2018 at 04:42:44PM +1000, Benjamin Herrenschmidt wrote:
> > Note that I can make it so that the same DMA ops (basically standard
> > swiotlb ops without arch hacks) work for both "direct virtio" and
> > "normal PCI" devices.
> > 
> > The trick is simply in the arch to setup the iommu to map the swiotlb
> > bounce buffer pool 1:1 in the iommu, so the iommu essentially can be
> > ignored without affecting the physical addresses.
> > 
> > If I do that, *all* I need is a way, from the guest itself (again, the
> > other side dosn't know anything about it), to force virtio to use the
> > DMA ops as if there was an iommu, that is, use whatever dma ops were
> > setup by the platform for the pci device.
> 
> In that case just setting VIRTIO_F_IOMMU_PLATFORM in the flags should
> do the work (even if that isn't strictly what the current definition
> of the flag actually means).  On the qemu side you'll need to make
> sure you have a way to set VIRTIO_F_IOMMU_PLATFORM without emulating
> an iommu, but with code to take dma offsets into account if your
> plaform has any (various power plaforms seem to have them, not sure
> if it affects your config).

Something like that yes. I prefer a slightly different way, see below,
any but in both cases, it should alleviate your concerns since it means
there would be no particular mucking around with DMA ops at all, virtio
would just use whatever "normal" ops we establish for all PCI devices
on that platform, which will be standard ones.

(swiotlb ones today and the new "integrates" ones you're cooking
tomorrow).

As for the flag itself, while we could set it from qemu when we get
notified that the guest is going secure, both Michael and I think it's
rather gross, it requires qemu to go iterate all virtio devices and
"poke" something into them.

It also means qemu will need some other internal nasty flag that says
"set that bit but don't do iommu".

It's nicer if we have a way in the guest virtio driver to do something
along the lines of

	if ((flags & VIRTIO_F_IOMMU_PLATFORM) || arch_virtio_wants_dma_ops())

Which would have the same effect and means the issue is entirely
contained in the guest.

Cheers,
Ben.


