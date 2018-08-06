Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF74C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F3921A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F3921A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbeHGB5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:57:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730888AbeHGB5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38E938780F;
        Mon,  6 Aug 2018 23:45:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.7])
        by smtp.corp.redhat.com (Postfix) with SMTP id C4E8E101307D;
        Mon,  6 Aug 2018 23:45:26 +0000 (UTC)
Date:   Tue, 7 Aug 2018 02:45:25 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180807024503-mutt-send-email-mst@kernel.org>
References: <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
 <20180807002857-mutt-send-email-mst@kernel.org>
 <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 06 Aug 2018 23:45:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 06 Aug 2018 23:45:32 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:13:56AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-08-07 at 00:46 +0300, Michael S. Tsirkin wrote:
> > On Tue, Aug 07, 2018 at 07:26:35AM +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2018-08-06 at 23:35 +0300, Michael S. Tsirkin wrote:
> > > > > As I said replying to Christoph, we are "leaking" into the interface
> > > > > something here that is really what's the VM is doing to itself, which
> > > > > is to stash its memory away in an inaccessible place.
> > > > > 
> > > > > Cheers,
> > > > > Ben.
> > > > 
> > > > I think Christoph merely objects to the specific implementation.  If
> > > > instead you do something like tweak dev->bus_dma_mask for the virtio
> > > > device I think he won't object.
> > > 
> > > Well, we don't have "bus_dma_mask" yet ..or you mean dma_mask ?
> > > 
> > > So, something like that would be a possibility, but the problem is that
> > > the current virtio (guest side) implementation doesn't honor this when
> > > not using dma ops and will not use dma ops if not using iommu, so back
> > > to square one.
> > 
> > Well we have the RFC for that - the switch to using DMA ops unconditionally isn't
> > problematic itself IMHO, for now that RFC is blocked
> > by its perfromance overhead for now but Christoph says
> > he's trying to remove that for direct mappings,
> > so we should hopefully be able to get there in X weeks.
> 
> That would be good yes.
> 
>  ../..
> 
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -155,7 +155,7 @@ static bool vring_use_dma_api(struct virtio_device
> > > *vdev)
> > >          * the DMA API if we're a Xen guest, which at least allows
> > >          * all of the sensible Xen configurations to work correctly.
> > >          */
> > > -       if (xen_domain())
> > > +       if (xen_domain() || arch_virtio_direct_dma_ops(&vdev->dev))
> > >                 return true;
> > >  
> > >         return false;
> > 
> > Right but can't we fix the retpoline overhead such that
> > vring_use_dma_api will not be called on data path any longer, making
> > this a setup time check?
> 
> Yes it needs to be a setup time check regardless actually !
> 
> The above is broken, sorry I was a bit quick here (too early in the
> morning... ugh). We don't want the arch to go override the dma ops
> every time that is callled.
> 
> But yes, if we can fix the overhead, it becomes just a matter of
> setting up the "right" ops automatically.
> 
> > > (Passing the dev allows the arch to know this is a virtio device in
> > > "direct" mode or whatever we want to call the !iommu case, and
> > > construct appropriate DMA ops for it, which aren't the same as the DMA
> > > ops of any other PCI device who *do* use the iommu).
> > 
> > I think that's where Christoph might have specific ideas about it.
> 
> OK well, assuming Christoph can solve the direct case in a way that
> also work for the virtio !iommu case, we still want some bit of logic
> somewhere that will "switch" to swiotlb based ops if the DMA mask is
> limited.
> 
> You mentioned an RFC for that ? Do you happen to have a link ?

No but Christoph did I think.

> It would be indeed ideal if all we had to do was setup some kind of
> bus_dma_mask on all PCI devices and have virtio automagically insert
> swiotlb when necessary.
> 
> Cheers,
> Ben.
> 
