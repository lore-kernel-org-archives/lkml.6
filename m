Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD23ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683E8214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683E8214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbeGMAsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:48:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387781AbeGMAsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:48:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8C304072CC7;
        Fri, 13 Jul 2018 00:36:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-30.rdu2.redhat.com [10.10.112.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6B1822156889;
        Fri, 13 Jul 2018 00:36:13 +0000 (UTC)
Date:   Fri, 13 Jul 2018 03:36:12 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        cdall@kernel.org, marc.zyngier@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, ard.biesheuvel@linaro.org,
        peter.maydell@linaro.org, kristina.martsenko@arm.com,
        mark.rutland@arm.com, Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 02/17] virtio: pci-legacy: Validate queue pfn
Message-ID: <20180713004545-mutt-send-email-mst@kernel.org>
References: <1522156531-28348-1-git-send-email-suzuki.poulose@arm.com>
 <1522156531-28348-3-git-send-email-suzuki.poulose@arm.com>
 <20180327170823-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327170823-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 00:36:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 00:36:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 05:11:04PM +0300, Michael S. Tsirkin wrote:
> On Tue, Mar 27, 2018 at 02:15:12PM +0100, Suzuki K Poulose wrote:
> > Legacy PCI over virtio uses a 32bit PFN for the queue. If the
> > queue pfn is too large to fit in 32bits, which we could hit on
> > arm64 systems with 52bit physical addresses (even with 64K page
> > size), we simply miss out a proper link to the other side of
> > the queue.
> > 
> > Add a check to validate the PFN, rather than silently breaking
> > the devices.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Christoffer Dall <cdall@kernel.org>
> > Cc: Peter Maydel <peter.maydell@linaro.org>
> > Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  drivers/virtio/virtio_pci_legacy.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > index 2780886..4b84a75 100644
> > --- a/drivers/virtio/virtio_pci_legacy.c
> > +++ b/drivers/virtio/virtio_pci_legacy.c
> > @@ -122,6 +122,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >  	struct virtqueue *vq;
> >  	u16 num;
> >  	int err;
> > +	u64 q_pfn;
> >  
> >  	/* Select the queue we're interested in */
> >  	iowrite16(index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> > @@ -141,9 +142,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >  	if (!vq)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > +	q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
> > +	if (q_pfn >> 32) {
> > +		dev_err(&vp_dev->pci_dev->dev, "virtio-pci queue PFN too large\n");
> > +		err = -ENOMEM;
> 
> ENOMEM seems wrong here. E2BIG?
> 
> > +		goto out_del_vq;
> > +	}
> > +
> >  	/* activate the queue */
> > -	iowrite32(virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
> > -		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> > +	iowrite32((u32)q_pfn, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> 
> Is the cast really necessary here?
> 
> >  
> >  	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
> >  
> > @@ -160,6 +167,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >  
> >  out_deactivate:
> >  	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> > +out_del_vq:
> >  	vring_del_virtqueue(vq);
> >  	return ERR_PTR(err);
> >  }
> > -- 
> > 2.7.4

Ping are you going to address and repost, or should I drop this?

-- 
MST
