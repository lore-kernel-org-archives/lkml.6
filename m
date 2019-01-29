Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FB320844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfA2TCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:02:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfA2TCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:02:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0177CA0484;
        Tue, 29 Jan 2019 19:02:41 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id DA0CC5C893;
        Tue, 29 Jan 2019 19:02:37 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:02:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190129134750-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87womn8inf.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 29 Jan 2019 19:02:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
> 
> Fixing address of powerpc mailing list.
> 
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> 
> > Hello,
> >
> > With Christoph's rework of the DMA API that recently landed, the patch
> > below is the only change needed in virtio to make it work in a POWER
> > secure guest under the ultravisor.
> >
> > The other change we need (making sure the device's dma_map_ops is NULL
> > so that the dma-direct/swiotlb code is used) can be made in
> > powerpc-specific code.
> >
> > Of course, I also have patches (soon to be posted as RFC) which hook up
> > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> >
> > What do you think?
> >
> > From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> >
> > The host can't access the guest memory when it's encrypted, so using
> > regular memory pages for the ring isn't an option. Go through the DMA API.
> >
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Well I think this will come back to bite us (witness xen which is now
reworking precisely this path - but at least they aren't to blame, xen
came before ACCESS_PLATFORM).

I also still think the right thing would have been to set
ACCESS_PLATFORM for all systems where device can't access all memory.

But I also think I don't have the energy to argue about power secure
guest anymore.  So be it for power secure guest since the involved
engineers disagree with me.  Hey I've been wrong in the past ;).

But the name "sev_active" makes me scared because at least AMD guys who
were doing the sensible thing and setting ACCESS_PLATFORM (unless I'm
wrong? I reemember distinctly that's so) will likely be affected too.
We don't want that.

So let's find a way to make sure it's just power secure guest for now
pls.

I also think we should add a dma_api near features under virtio_device
such that these hacks can move off data path.

By the way could you please respond about virtio-iommu and
why there's no support for ACCESS_PLATFORM on power?

I have Cc'd you on these discussions.


Thanks!


> > ---
> >  drivers/virtio/virtio_ring.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd7e755484e3..321a27075380 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * not work without an even larger kludge.  Instead, enable
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> > +	 *
> > +	 * Also, if guest memory is encrypted the host can't access
> > +	 * it directly. In this case, we'll need to use the DMA API.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() || sev_active())
> >  		return true;
> >
> >  	return false;
> 
> 
> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center
