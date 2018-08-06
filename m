Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26ABC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C7F21A34
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C7F21A34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeHFQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:14:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39522 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeHFQOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:14:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F3D7A9;
        Mon,  6 Aug 2018 07:05:04 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 678323F2EA;
        Mon,  6 Aug 2018 07:05:04 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 35E111AE2D8E; Mon,  6 Aug 2018 15:05:08 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:05:08 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20180806140507.GB15078@arm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
 <20180805032504-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805032504-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sun, Aug 05, 2018 at 03:27:42AM +0300, Michael S. Tsirkin wrote:
> On Wed, Aug 01, 2018 at 09:16:38AM +0100, Will Deacon wrote:
> > On Tue, Jul 31, 2018 at 03:36:22PM -0500, Benjamin Herrenschmidt wrote:
> > > On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > > > > However the question people raise is that DMA API is already full of
> > > > > arch-specific tricks the likes of which are outlined in your post linked
> > > > > above. How is this one much worse?
> > > > 
> > > > None of these warts is visible to the driver, they are all handled in
> > > > the architecture (possibly on a per-bus basis).
> > > > 
> > > > So for virtio we really need to decide if it has one set of behavior
> > > > as specified in the virtio spec, or if it behaves exactly as if it
> > > > was on a PCI bus, or in fact probably both as you lined up.  But no
> > > > magic arch specific behavior inbetween.
> > > 
> > > The only arch specific behaviour is needed in the case where it doesn't
> > > behave like PCI. In this case, the PCI DMA ops are not suitable, but in
> > > our secure VMs, we still need to make it use swiotlb in order to bounce
> > > through non-secure pages.
> > 
> > On arm/arm64, the problem we have is that legacy virtio devices on the MMIO
> > transport (so definitely not PCI) have historically been advertised by qemu
> > as not being cache coherent, but because the virtio core has bypassed DMA
> > ops then everything has happened to work. If we blindly enable the arch DMA
> > ops, we'll plumb in the non-coherent ops and start getting data corruption,
> > so we do need a way to quirk virtio as being "always coherent" if we want to
> > use the DMA ops (which we do, because our emulation platforms have an IOMMU
> > for all virtio devices).
> > 
> > Will
> 
> Right that's not very different from placing the device within the IOMMU
> domain but in fact bypassing the IOMMU

Hmm, I'm not sure I follow you here -- the IOMMU bypassing is handled
inside the IOMMU driver, so we'd still end up with non-coherent DMA ops
for the guest accesses. The presence of an IOMMU doesn't imply coherency for
us. Or am I missing your point here?

> I wonder whether anyone ever needs a non coherent virtio-mmio. If yes we
> can extend PLATFORM_IOMMU to cover that or add another bit.

I think that's probably the right way around: assume that legacy virtio-mmio
devices are coherent by default.

> What exactly do the non-coherent ops do that causes the corruption?

The non-coherent ops mean that the guest ends up allocating the vring queues
using non-cacheable mappings, whereas qemu/hypervisor uses a cacheable
mapping despite not advertising the devices as being cache-coherent.

This hits something in the architecture known as "mismatched aliases", which
means that coherency is lost between the guest and the hypervisor,
consequently resulting in data not being visible and ordering not being
guaranteed. The usual symptom is that the device appears to lock up iirc,
because the guest and the hypervisor are unable to communicate with each
other.

Does that help to clarify things?

Thanks,

Will
