Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F29C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E6C21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAWIEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:04:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:18341 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfAWIEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:04:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 00:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,510,1539673200"; 
   d="scan'208";a="116707982"
Received: from unknown (HELO dpdk-tbie) ([10.67.104.173])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2019 00:04:49 -0800
Date:   Wed, 23 Jan 2019 16:02:27 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH] virtio: support VIRTIO_F_ORDER_PLATFORM
Message-ID: <20190123080227.GA23394@dpdk-tbie>
References: <20190122170346.6279-1-tiwei.bie@intel.com>
 <20190122230247-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122230247-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:04:29PM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 23, 2019 at 01:03:46AM +0800, Tiwei Bie wrote:
> > This patch introduces the support for VIRTIO_F_ORDER_PLATFORM.
> > When this feature is negotiated, driver will use the barriers
> > suitable for hardware devices.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> Could you pls add a bit more explanation in the commit log?
> E.g. which configurations are broken without this patch?
> How severe is the problem?

Sure. Will do that.

Thanks

> 
> I'm trying to decide whether this belongs in 5.0 or 5.1.
> 
> > ---
> >  drivers/virtio/virtio_ring.c       | 8 ++++++++
> >  include/uapi/linux/virtio_config.h | 6 ++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd7e755484e3..27d3f057493e 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1609,6 +1609,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  		!context;
> >  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> >  
> > +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> > +		vq->weak_barriers = false;
> > +
> >  	vq->packed.ring_dma_addr = ring_dma_addr;
> >  	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
> >  	vq->packed.device_event_dma_addr = device_event_dma_addr;
> > @@ -2079,6 +2082,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  		!context;
> >  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> >  
> > +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> > +		vq->weak_barriers = false;
> > +
> >  	vq->split.queue_dma_addr = 0;
> >  	vq->split.queue_size_in_bytes = 0;
> >  
> > @@ -2213,6 +2219,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >  			break;
> >  		case VIRTIO_F_RING_PACKED:
> >  			break;
> > +		case VIRTIO_F_ORDER_PLATFORM:
> > +			break;
> >  		default:
> >  			/* We don't understand this bit. */
> >  			__virtio_clear_bit(vdev, i);
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 1196e1c1d4f6..ff8e7dc9d4dd 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -78,6 +78,12 @@
> >  /* This feature indicates support for the packed virtqueue layout. */
> >  #define VIRTIO_F_RING_PACKED		34
> >  
> > +/*
> > + * This feature indicates that memory accesses by the driver and the
> > + * device are ordered in a way described by the platform.
> > + */
> > +#define VIRTIO_F_ORDER_PLATFORM		36
> > +
> >  /*
> >   * Does the device support Single Root I/O Virtualization?
> >   */
> > -- 
> > 2.17.1
