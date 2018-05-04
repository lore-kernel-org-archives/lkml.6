Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEDBOK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:14:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:24194 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeEDBOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:14:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="39140612"
Date: Fri, 4 May 2018 09:14:51 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [RFC] virtio: support VIRTIO_F_IO_BARRIER
Message-ID: <20180504011451.qf4po3s76adxxulf@debian>
References: <20180503025955.28816-1-tiwei.bie@intel.com>
 <20180503203108-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503203108-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:57:20PM +0300, Michael S. Tsirkin wrote:
> On Thu, May 03, 2018 at 10:59:55AM +0800, Tiwei Bie wrote:
> > This patch introduces the support for VIRTIO_F_IO_BARRIER.
> > When this feature is negotiated, driver will use the barriers
> > suitable for hardware devices.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> Thanks!
> 
> > ---
> >  drivers/virtio/virtio_ring.c       | 5 +++++
> >  include/uapi/linux/virtio_config.h | 8 +++++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 21d464a29cf8..edb565643bf4 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -996,6 +996,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  		!context;
> >  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> >  
> > +	if (virtio_has_feature(vdev, VIRTIO_F_IO_BARRIER))
> > +		vq->weak_barriers = false;
> > +
> >  	/* No callback?  Tell other side not to bother us. */
> >  	if (!callback) {
> >  		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> 
> One issue worth looking at is that at least on Intel strong barriers are
> actually typically overkill.  We should probably switch weak_barriers ==
> false case over to dma barriers.

Jason suggested me to add a reference or some notes in this
patch about your patch:

"[PATCH] virtio_ring: switch to dma_XX barriers for rpmsg"

> 
> > @@ -1164,6 +1167,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >  			break;
> >  		case VIRTIO_F_IOMMU_PLATFORM:
> >  			break;
> > +		case VIRTIO_F_IO_BARRIER:
> > +			break;
> >  		default:
> >  			/* We don't understand this bit. */
> >  			__virtio_clear_bit(vdev, i);
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 308e2096291f..6ca8d24bf468 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> 
> Any virtio UAPI changes must be CC'd to one of the virtio TC mailing lists
> (subscriber-only, sorry about that).

Got it! I'll send a new version and Cc virtio-dev.

> 
> > @@ -49,7 +49,7 @@
> >   * transport being used (eg. virtio_ring), the rest are per-device feature
> >   * bits. */
> >  #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		34
> > +#define VIRTIO_TRANSPORT_F_END		38
> >  
> >  #ifndef VIRTIO_CONFIG_NO_LEGACY
> >  /* Do we get callbacks when the ring is completely used, even if we've
> > @@ -71,4 +71,10 @@
> >   * this is for compatibility with legacy systems.
> >   */
> >  #define VIRTIO_F_IOMMU_PLATFORM		33
> > +
> > +/*
> > + * If clear - driver may use barriers suitable for CPU cores.
> > + * If set - driver must use barriers suitable for hardware devices.
> > + */
> > +#define VIRTIO_F_IO_BARRIER		37
> >  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> 
> Why 37? I'd use 34 I think.

In the latest virtio spec draft, 34 and 35 have been taken
by VIRTIO_F_RING_PACKED and VIRTIO_F_IN_ORDER. And 36 had
been taken by VIRTIO_F_NOTIFICATION_DATA previously when I
sent below proposal:

https://lists.oasis-open.org/archives/virtio-dev/201804/msg00310.html

But I just noticed that NOTIFICATION_DATA has been reverted
from the repo, which means 36 is the next available bit. So
I'll use it. Thanks for the reminder!

Best regards,
Tiwei Bie

> 
> > -- 
> > 2.11.0
