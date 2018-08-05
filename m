Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64450C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CF2217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CF2217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeHECaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:30:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeHECaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:30:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20707819700D;
        Sun,  5 Aug 2018 00:27:48 +0000 (UTC)
Received: from redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with SMTP id 99DA72026D66;
        Sun,  5 Aug 2018 00:27:43 +0000 (UTC)
Date:   Sun, 5 Aug 2018 03:27:42 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Will Deacon <will.deacon@arm.com>
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
Message-ID: <20180805032504-mutt-send-email-mst@kernel.org>
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
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 05 Aug 2018 00:27:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 05 Aug 2018 00:27:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:16:38AM +0100, Will Deacon wrote:
> On Tue, Jul 31, 2018 at 03:36:22PM -0500, Benjamin Herrenschmidt wrote:
> > On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > > > However the question people raise is that DMA API is already full of
> > > > arch-specific tricks the likes of which are outlined in your post linked
> > > > above. How is this one much worse?
> > > 
> > > None of these warts is visible to the driver, they are all handled in
> > > the architecture (possibly on a per-bus basis).
> > > 
> > > So for virtio we really need to decide if it has one set of behavior
> > > as specified in the virtio spec, or if it behaves exactly as if it
> > > was on a PCI bus, or in fact probably both as you lined up.  But no
> > > magic arch specific behavior inbetween.
> > 
> > The only arch specific behaviour is needed in the case where it doesn't
> > behave like PCI. In this case, the PCI DMA ops are not suitable, but in
> > our secure VMs, we still need to make it use swiotlb in order to bounce
> > through non-secure pages.
> 
> On arm/arm64, the problem we have is that legacy virtio devices on the MMIO
> transport (so definitely not PCI) have historically been advertised by qemu
> as not being cache coherent, but because the virtio core has bypassed DMA
> ops then everything has happened to work. If we blindly enable the arch DMA
> ops, we'll plumb in the non-coherent ops and start getting data corruption,
> so we do need a way to quirk virtio as being "always coherent" if we want to
> use the DMA ops (which we do, because our emulation platforms have an IOMMU
> for all virtio devices).
> 
> Will

Right that's not very different from placing the device within the IOMMU
domain but in fact bypassing the IOMMU. I wonder whether anyone ever
needs a non coherent virtio-mmio. If yes we can extend
PLATFORM_IOMMU to cover that or add another bit.

What exactly do the non-coherent ops do that causes the corruption?

-- 
MST
