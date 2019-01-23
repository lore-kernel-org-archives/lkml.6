Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67792C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD1020855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfAWNtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:49:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAWNtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:49:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC759D2EEA;
        Wed, 23 Jan 2019 13:49:06 +0000 (UTC)
Received: from redhat.com (ovpn-123-123.rdu2.redhat.com [10.10.123.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 108E75D6A9;
        Wed, 23 Jan 2019 13:49:05 +0000 (UTC)
Date:   Wed, 23 Jan 2019 08:49:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] [PATCH] virtio: support VIRTIO_F_ORDER_PLATFORM
Message-ID: <20190123084308-mutt-send-email-mst@kernel.org>
References: <20190122170346.6279-1-tiwei.bie@intel.com>
 <ecf89b02-57ba-478f-1e28-4286888a4b26@redhat.com>
 <20190122224203-mutt-send-email-mst@kernel.org>
 <7f07c837-d3d0-b5c0-9ecb-29b545b377c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f07c837-d3d0-b5c0-9ecb-29b545b377c3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 23 Jan 2019 13:49:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:56:00PM +0800, Jason Wang wrote:
> 
> On 2019/1/23 上午11:49, Michael S. Tsirkin wrote:
> > On Wed, Jan 23, 2019 at 11:08:04AM +0800, Jason Wang wrote:
> > > On 2019/1/23 上午1:03, Tiwei Bie wrote:
> > > > This patch introduces the support for VIRTIO_F_ORDER_PLATFORM.
> > > > When this feature is negotiated, driver will use the barriers
> > > > suitable for hardware devices.
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > ---
> > > >    drivers/virtio/virtio_ring.c       | 8 ++++++++
> > > >    include/uapi/linux/virtio_config.h | 6 ++++++
> > > >    2 files changed, 14 insertions(+)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index cd7e755484e3..27d3f057493e 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -1609,6 +1609,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > >    		!context;
> > > >    	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > > > +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> > > > +		vq->weak_barriers = false;
> > > > +
> > > >    	vq->packed.ring_dma_addr = ring_dma_addr;
> > > >    	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
> > > >    	vq->packed.device_event_dma_addr = device_event_dma_addr;
> > > > @@ -2079,6 +2082,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > >    		!context;
> > > >    	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > > > +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> > > > +		vq->weak_barriers = false;
> > > > +
> > > >    	vq->split.queue_dma_addr = 0;
> > > >    	vq->split.queue_size_in_bytes = 0;
> > > > @@ -2213,6 +2219,8 @@ void vring_transport_features(struct virtio_device *vdev)
> > > >    			break;
> > > >    		case VIRTIO_F_RING_PACKED:
> > > >    			break;
> > > > +		case VIRTIO_F_ORDER_PLATFORM:
> > > > +			break;
> > > >    		default:
> > > >    			/* We don't understand this bit. */
> > > >    			__virtio_clear_bit(vdev, i);
> > > > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > > > index 1196e1c1d4f6..ff8e7dc9d4dd 100644
> > > > --- a/include/uapi/linux/virtio_config.h
> > > > +++ b/include/uapi/linux/virtio_config.h
> > > > @@ -78,6 +78,12 @@
> > > >    /* This feature indicates support for the packed virtqueue layout. */
> > > >    #define VIRTIO_F_RING_PACKED		34
> > > > +/*
> > > > + * This feature indicates that memory accesses by the driver and the
> > > > + * device are ordered in a way described by the platform.
> > > > + */
> > > > +#define VIRTIO_F_ORDER_PLATFORM		36
> > > > +
> > > >    /*
> > > >     * Does the device support Single Root I/O Virtualization?
> > > >     */
> > > 
> > > I wonder whether or not this is sufficient. Is dma barrier implies a mmio
> > > barrier? Looks not.
> > IIUC we don't need an mmio barrier because we are using a
> > serializing API: Documentation/memory-barriers.txt says:
> > 
> > 	Note that, when using writel(), a prior
> >       wmb() is not needed to guarantee that the cache coherent memory writes
> >       have completed before writing to the MMIO region.
> 
> 
> Ah, I get this.
> 
> 
> > 
> > 
> > > See ia64/include/asm/barrier.h:
> > > 
> > >   * Note: "mb()" and its variants cannot be used as a fence to order
> > >   * accesses to memory mapped I/O registers.  For that, mf.a needs to
> > >   * be used.  However, we don't want to always use mf.a because (a)
> > >   * it's (presumably) much slower than mf and (b) mf.a is supported for
> > >   * sequential memory pages only.
> > >   */
> > > #define mb()            ia64_mf()
> > > #define rmb()           mb()
> > > #define wmb()           mb()
> > > 
> > > #define dma_rmb()       mb()
> > > =>efine dma_wmb()       mb()
> > > 
> > > Thanks
> > Frankly no idea about ia64.
> 
> 
> Neither did me.
> 
> 
> >   Sorry. Are any less esoteric platforms
> > affected?
> > 
> 
> E.g ppc64?

So

void iowrite32(u32 val, void __iomem *addr)
{
        writel(val, addr);
}

and that eventually gets to this one:


#define DEF_MMIO_OUT_D(name, size, insn)                                \
static inline void name(volatile u##size __iomem *addr, u##size val)    \
{                                                                       \
        __asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"                 \
                : "=m" (*addr) : "r" (val) : "memory");                 \
        IO_SET_SYNC_FLAG();                                             \
}

and

#ifdef CONFIG_PPC64
#define IO_SET_SYNC_FLAG()      do { local_paca->io_sync = 1; } while(0)
#else
#define IO_SET_SYNC_FLAG()
#endif





> define dma_wmb()       __asm__ __volatile__ (stringify_in_c(SMPWMB) : :
> :"memo\
> ry")
> 
> /*
>  * Enforce synchronisation of stores vs. spin_unlock
>  * (this does it explicitly, though our implementation of spin_unlock

I don't know which spin_unlock does it refer to here.

>  * does it implicitely too)
>  */
> static inline void mmiowb(void)
> {
>         unsigned long tmp;
> 
>         __asm__ __volatile__("sync; li %0,0; stb %0,%1(13)"
>         : "=&r" (tmp) : "i" (offsetof(struct paca_struct, io_sync))
>         : "memory");
> }

So sync+set io_sync here and sync+io_sync above.

> dma_wmb() is lwsync which is more lightweight than sync I guess?
> 
> Thanks
> 

Sounds about right.


-- 
MST
