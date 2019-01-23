Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF6C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DC6217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfAWEEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 23:04:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfAWEEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 23:04:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6848F58E3E;
        Wed, 23 Jan 2019 04:04:30 +0000 (UTC)
Received: from redhat.com (ovpn-122-113.rdu2.redhat.com [10.10.122.113])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD144600C6;
        Wed, 23 Jan 2019 04:04:29 +0000 (UTC)
Date:   Tue, 22 Jan 2019 23:04:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH] virtio: support VIRTIO_F_ORDER_PLATFORM
Message-ID: <20190122230247-mutt-send-email-mst@kernel.org>
References: <20190122170346.6279-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122170346.6279-1-tiwei.bie@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 23 Jan 2019 04:04:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:03:46AM +0800, Tiwei Bie wrote:
> This patch introduces the support for VIRTIO_F_ORDER_PLATFORM.
> When this feature is negotiated, driver will use the barriers
> suitable for hardware devices.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

Could you pls add a bit more explanation in the commit log?
E.g. which configurations are broken without this patch?
How severe is the problem?

I'm trying to decide whether this belongs in 5.0 or 5.1.

> ---
>  drivers/virtio/virtio_ring.c       | 8 ++++++++
>  include/uapi/linux/virtio_config.h | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..27d3f057493e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1609,6 +1609,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>  
> +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> +		vq->weak_barriers = false;
> +
>  	vq->packed.ring_dma_addr = ring_dma_addr;
>  	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
>  	vq->packed.device_event_dma_addr = device_event_dma_addr;
> @@ -2079,6 +2082,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>  
> +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> +		vq->weak_barriers = false;
> +
>  	vq->split.queue_dma_addr = 0;
>  	vq->split.queue_size_in_bytes = 0;
>  
> @@ -2213,6 +2219,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_RING_PACKED:
>  			break;
> +		case VIRTIO_F_ORDER_PLATFORM:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 1196e1c1d4f6..ff8e7dc9d4dd 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -78,6 +78,12 @@
>  /* This feature indicates support for the packed virtqueue layout. */
>  #define VIRTIO_F_RING_PACKED		34
>  
> +/*
> + * This feature indicates that memory accesses by the driver and the
> + * device are ordered in a way described by the platform.
> + */
> +#define VIRTIO_F_ORDER_PLATFORM		36
> +
>  /*
>   * Does the device support Single Root I/O Virtualization?
>   */
> -- 
> 2.17.1
