Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE99C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A222820862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A222820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbeG1WoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:44:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730551AbeG1WoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:44:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A196540216E4;
        Sat, 28 Jul 2018 21:16:25 +0000 (UTC)
Received: from redhat.com (ovpn-116-41.ams2.redhat.com [10.36.116.41])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5066F111AF24;
        Sat, 28 Jul 2018 21:16:20 +0000 (UTC)
Date:   Sun, 29 Jul 2018 00:16:19 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        hch@infradead.org, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
Message-ID: <20180729001344-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 28 Jul 2018 21:16:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 28 Jul 2018 21:16:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 02:26:24PM +0530, Anshuman Khandual wrote:
> On 07/20/2018 09:29 AM, Anshuman Khandual wrote:
> > Now that virtio core always needs all virtio devices to have DMA OPS, we
> > need to make sure that the structure it points is the right one. In the
> > absence of VIRTIO_F_IOMMU_PLATFORM flag QEMU expects GPA from guest kernel.
> > In such case, virtio device must use default virtio_direct_dma_ops DMA OPS
> > structure which transforms scatter gather buffer addresses as GPA. This
> > DMA OPS override must happen as early as possible during virtio device
> > initializatin sequence before virtio core starts using given device's DMA
> > OPS callbacks for I/O transactions. This change detects device's IOMMU flag
> > and does the override in case the flag is cleared.
> > 
> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> > ---
> >  drivers/virtio/virtio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 7907ad3..6b13987 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_add_status);
> > 
> > +const struct dma_map_ops virtio_direct_dma_ops;
> > +
> >  int virtio_finalize_features(struct virtio_device *dev)
> >  {
> >  	int ret = dev->config->finalize_features(dev);
> > @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
> >  	if (ret)
> >  		return ret;
> 
> 
> The previous patch removed the code block for XEN guests which forced
> the use of DMA API all the time irrespective of VIRTIO_F_IOMMU_PLATFORM
> flag on the device. Here is what I have removed with patch 2/4 which
> breaks the existing semantics on XEN guests.
> 
> -static bool vring_use_dma_api(struct virtio_device *vdev)
> -{
> -	if (!virtio_has_iommu_quirk(vdev))
> -		return true;
> -
> -	/* Otherwise, we are left to guess. */
> -	/*
> -	 * In theory, it's possible to have a buggy QEMU-supposed
> -	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
> -	 * such a configuration, virtio has never worked and will
> -	 * not work without an even larger kludge.  Instead, enable
> -	 * the DMA API if we're a Xen guest, which at least allows
> -	 * all of the sensible Xen configurations to work correctly.
> -	 */
> -	if (xen_domain())
> -		return true;
> -
> -	return false;
> -}
> 
> XEN guests would not like override with virtio_direct_dma_ops in any
> case irrespective of the flag VIRTIO_F_IOMMU_PLATFORM. So the existing
> semantics can be preserved with something like this. It just assumes
> that dev->dma_ops is non-NULL and a valid one set by the architecture.
> If required we can add those tests here before skipping the override.
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 7907ad3..6b13987 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -166,6 +166,8 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
> 
> +const struct dma_map_ops virtio_direct_dma_ops;
> +
>  int virtio_finalize_features(struct virtio_device *dev)
>  {
>  	int ret = dev->config->finalize_features(dev);
> @@ -174,6 +176,9 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret)
>  		return ret;
> +
> +	if (xen_domain())
> +		goto skip_override;
> +
> +	if (virtio_has_iommu_quirk(dev))
> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> +
> + skip_override:
> +

I prefer normal if scoping as opposed to goto spaghetti pls.
Better yet move vring_use_dma_api here and use it.
Less of a chance something will break.

>  	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>  		return 0
> 
> Will incorporate these changes in the next version.
