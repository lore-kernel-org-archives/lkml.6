Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC39C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B71320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B71320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeHBAXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:23:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbeHBAXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:23:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70DDE7262C;
        Wed,  1 Aug 2018 22:35:31 +0000 (UTC)
Received: from redhat.com (ovpn-121-8.rdu2.redhat.com [10.10.121.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id D600A1C679;
        Wed,  1 Aug 2018 22:35:27 +0000 (UTC)
Date:   Thu, 2 Aug 2018 01:35:27 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Message-ID: <20180802013230-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
 <20180801083639.GF26378@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801083639.GF26378@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 22:35:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 01 Aug 2018 22:35:31 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 01:36:39AM -0700, Christoph Hellwig wrote:
> On Wed, Aug 01, 2018 at 09:16:38AM +0100, Will Deacon wrote:
> > On arm/arm64, the problem we have is that legacy virtio devices on the MMIO
> > transport (so definitely not PCI) have historically been advertised by qemu
> > as not being cache coherent, but because the virtio core has bypassed DMA
> > ops then everything has happened to work. If we blindly enable the arch DMA
> > ops,
> 
> No one is suggesting that as far as I can tell.
> 
> > we'll plumb in the non-coherent ops and start getting data corruption,
> > so we do need a way to quirk virtio as being "always coherent" if we want to
> > use the DMA ops (which we do, because our emulation platforms have an IOMMU
> > for all virtio devices).
> 
> >From all that I've gather so far: no you do not want that.  We really
> need to figure out virtio "dma" interacts with the host / device.
> 
> If you look at the current iommu spec it does talk of physical address
> with a little careveout for VIRTIO_F_IOMMU_PLATFORM.
> 
> So between that and our discussion in this thread and its previous
> iterations I think we need to stick to the current always physical,
> bypass system dma ops mode of virtio operation as the default.
> 
> We just need to figure out how to deal with devices that deviate
> from the default.  One things is that VIRTIO_F_IOMMU_PLATFORM really
> should become VIRTIO_F_PLATFORM_DMA to cover the cases of non-iommu
> dma tweaks (offsets, cache flushing), which seems well in spirit of
> the original design.

Well I wouldn't say that. VIRTIO_F_IOMMU_PLATFORM is for guest
programmable protection which is designed for things like userspace
drivers but still very much which a CPU doing the accesses. I think
VIRTIO_F_IO_BARRIER needs to be extended to VIRTIO_F_PLATFORM_DMA.

>  The other issue is VIRTIO_F_IO_BARRIER
> which is very vaguely defined, and which needs a better definition.
> And last but not least we'll need some text explaining the challenges
> of hardware devices - I think VIRTIO_F_PLATFORM_DMA + VIRTIO_F_IO_BARRIER
> is what would basically cover them, but a good description including
> an explanation of why these matter.

I think VIRTIO_F_IOMMU_PLATFORM + VIRTIO_F_PLATFORM_DMA but yea.

-- 
MST
