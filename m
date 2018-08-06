Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF44C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C336B21A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C336B21A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbeHFX5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:57:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728671AbeHFX5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:57:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3E2C81663CC;
        Mon,  6 Aug 2018 21:46:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.7])
        by smtp.corp.redhat.com (Postfix) with SMTP id 25A5B101043F;
        Mon,  6 Aug 2018 21:46:34 +0000 (UTC)
Date:   Tue, 7 Aug 2018 00:46:34 +0300
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
Message-ID: <20180807002857-mutt-send-email-mst@kernel.org>
References: <20180803070507.GA1344@infradead.org>
 <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
 <20180803220443-mutt-send-email-mst@kernel.org>
 <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
 <20180805031046-mutt-send-email-mst@kernel.org>
 <fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
 <20180806164106-mutt-send-email-mst@kernel.org>
 <ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
 <20180806233024-mutt-send-email-mst@kernel.org>
 <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 21:46:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 21:46:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 07:26:35AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-08-06 at 23:35 +0300, Michael S. Tsirkin wrote:
> > > As I said replying to Christoph, we are "leaking" into the interface
> > > something here that is really what's the VM is doing to itself, which
> > > is to stash its memory away in an inaccessible place.
> > > 
> > > Cheers,
> > > Ben.
> > 
> > I think Christoph merely objects to the specific implementation.  If
> > instead you do something like tweak dev->bus_dma_mask for the virtio
> > device I think he won't object.
> 
> Well, we don't have "bus_dma_mask" yet ..or you mean dma_mask ?
> 
> So, something like that would be a possibility, but the problem is that
> the current virtio (guest side) implementation doesn't honor this when
> not using dma ops and will not use dma ops if not using iommu, so back
> to square one.

Well we have the RFC for that - the switch to using DMA ops unconditionally isn't
problematic itself IMHO, for now that RFC is blocked
by its perfromance overhead for now but Christoph says
he's trying to remove that for direct mappings,
so we should hopefully be able to get there in X weeks.

> Christoph seems to be wanting to use a flag in the interface to make
> the guest use dma_ops which is what I don't understand.
> 
> What would be needed then would be something along the lines of virtio
> noticing that dma_mask isn't big enough to cover all of memory (which
> isn't something generic code can easily do here for various reasons I
> can elaborate if you want, but that specific test more/less has to be
> arch specific), and in that case, force itself to use DMA ops routed to
> swiotlb.
> 
> I'd rather have arch code do the bulk of that work, don't you think ?
> 
> Which brings me back to this option, which may be the simplest and
> avoids the overhead of the proposed series (I found the series to be a
> nice cleanup but retpoline does kick us in the nuts here).
> 
> So what about this ?
> 
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -155,7 +155,7 @@ static bool vring_use_dma_api(struct virtio_device
> *vdev)
>          * the DMA API if we're a Xen guest, which at least allows
>          * all of the sensible Xen configurations to work correctly.
>          */
> -       if (xen_domain())
> +       if (xen_domain() || arch_virtio_direct_dma_ops(&vdev->dev))
>                 return true;
>  
>         return false;

Right but can't we fix the retpoline overhead such that
vring_use_dma_api will not be called on data path any longer, making
this a setup time check?


> (Passing the dev allows the arch to know this is a virtio device in
> "direct" mode or whatever we want to call the !iommu case, and
> construct appropriate DMA ops for it, which aren't the same as the DMA
> ops of any other PCI device who *do* use the iommu).

I think that's where Christoph might have specific ideas about it.

> Otherwise, the harder option would be for us to hack so that
> xen_domain() returns true in our setup (gross), and have the arch code,
> when it sets up PCI device DMA ops, have a gross hack to identify
> virtio PCI devices, checks their F_IOMMU flag itself, and sets up the
> different ops at that point.
> 
> As for those "special" ops, they are of course just normal swiotlb ops,
> there's nothing "special" other that they aren't the ops that other PCI
> device on that bus use.
> 
> Cheers,
> Ben.

-- 
MST
