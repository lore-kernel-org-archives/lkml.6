Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F09C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D6821AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D6821AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbeHIAgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:36:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:42185 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeHIAgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:36:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w78MDWJc009603;
        Wed, 8 Aug 2018 17:13:34 -0500
Message-ID: <98eb367ce322ad84baa31e3c7beffc4a42be8458.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Date:   Thu, 09 Aug 2018 08:13:32 +1000
In-Reply-To: <20180808232210-mutt-send-email-mst@kernel.org>
References: <20180806094243.GA16032@infradead.org>
         <6c707d6d33ac25a42265c2e9b521c2416d72c739.camel@kernel.crashing.org>
         <20180807062117.GD32709@infradead.org>
         <aa59c7f8556bd4b332394a1dcf2d4a8faf3dc4a2.camel@kernel.crashing.org>
         <20180807135505.GA29034@infradead.org>
         <2103ecfe52d23cec03f185d08a87bfad9c9d82b5.camel@kernel.crashing.org>
         <20180808063158.GA2474@infradead.org>
         <4b596883892b5cb5560bef26fcd249e7107173ac.camel@kernel.crashing.org>
         <20180808123036.GA2525@infradead.org>
         <b8b9150a747453c070ad3b0e4c92d2b1b052ad06.camel@kernel.crashing.org>
         <20180808232210-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 23:31 +0300, Michael S. Tsirkin wrote:
> On Wed, Aug 08, 2018 at 11:18:13PM +1000, Benjamin Herrenschmidt wrote:
> > Sure, but all of this is just the configuration of the iommu. But I
> > think we agree here, and your point remains valid, indeed my proposed
> > hack:
> > 
> > >       if ((flags & VIRTIO_F_IOMMU_PLATFORM) || arch_virtio_wants_dma_ops())
> > 
> > Will only work if the IOMMU and non-IOMMU path are completely equivalent.
> > 
> > We can provide that guarantee for our secure VM case, but not generally so if
> > we were to go down the route of a quirk in virtio, it might be better to
> > make it painfully obvious that it's specific to that one case with a different
> > kind of turd:
> > 
> > -	if (xen_domain())
> > +	if (xen_domain() || pseries_secure_vm())
> > 		return true;
> 
> I don't think it's pseries specific actually. E.g. I suspect AMD SEV
> might benefit from the same kind of hack.

As long as they can provide the same guarantee that the DMA ops are
completely equivalent between virtio and other PCI devices, at least on
the same bus, ie, we don't have to go hack special DMA ops.

I think the latter is really what Christoph wants to avoid for good
reasons.

> > So to summarize, and make sure I'm not missing something, the two approaches
> > at hand are either:
> > 
> >  1- The above, which is a one liner and contained in the guest, so that's nice, but
> > also means another turd in virtio which isn't ...
> > 
> >  2- We force pseries to always set VIRTIO_F_IOMMU_PLATFORM, but with the current
> > architecture on our side that will force virtio to always go through an emulated
> > iommu, as pseries doesn't have the concept of a real bypass window, and thus will
> > impact performance for both secure and non-secure VMs.
> > 
> >  3- Invent a property that can be put in selected PCI device tree nodes that
> > indicates that for that device specifically, the iommu can be bypassed, along with
> > a hypercall to turn that bypass on/off. Virtio would then use VIRTIO_F_IOMMU_PLATFORM
> > but its DT nodes would also have that property and Linux would notice it and turn
> > bypass on.
> 
> For completeness, virtio could also have its own bounce buffer
> outside of DMA API one. I don't see lots of benefits to this
> though.

Not fan of that either...

> > The resulting properties of those options are:
> > 
> > 1- Is what I want because it's the simplest, provides the best performance now,
> >    and works without code changes to qemu or non-secure Linux. However it does
> >    add a tiny turd to virtio which is annoying.
> > 
> > 2- This works but it puts the iommu in the way always, thus reducing virtio performance
> >    accross the board for pseries unless we only do that for secure VMs but that is
> >    difficult (as discussed earlier).
> > 
> > 3- This would recover the performance lost in -2-, however it requires qemu *and*
> >    guest changes. Specifically, existing guests (RHEL 7 etc...) would get the
> >    performance hit of -2- unless modified to call that 'enable bypass' call, which
> >    isn't great.
> > 
> > So imho we have to chose one of 3 not-great solutions here... Unless I missed
> > something in your ideas of course.
> > 

