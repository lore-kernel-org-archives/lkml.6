Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeEBPnC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:43:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751246AbeEBPm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:42:59 -0400
Date: Wed, 2 May 2018 18:42:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
Message-ID: <20180502184015-mutt-send-email-mst@kernel.org>
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <20180425051550.24342-5-tiwei.bie@intel.com>
 <34781052-df9f-e505-cd3f-08e460b34dcc@redhat.com>
 <20180502072819.mf5l3dypk6dwx2s7@debian>
 <20180502164828-mutt-send-email-mst@kernel.org>
 <20180502151255.h3x6rhszxa3euinl@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502151255.h3x6rhszxa3euinl@debian>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 11:12:55PM +0800, Tiwei Bie wrote:
> On Wed, May 02, 2018 at 04:51:01PM +0300, Michael S. Tsirkin wrote:
> > On Wed, May 02, 2018 at 03:28:19PM +0800, Tiwei Bie wrote:
> > > On Wed, May 02, 2018 at 10:51:06AM +0800, Jason Wang wrote:
> > > > On 2018年04月25日 13:15, Tiwei Bie wrote:
> > > > > This commit introduces the event idx support in packed
> > > > > ring. This feature is temporarily disabled, because the
> > > > > implementation in this patch may not work as expected,
> > > > > and some further discussions on the implementation are
> > > > > needed, e.g. do we have to check the wrap counter when
> > > > > checking whether a kick is needed?
> > > > > 
> > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > ---
> > > > >   drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++++++++++++----
> > > > >   1 file changed, 49 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 0181e93897be..b1039c2985b9 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -986,7 +986,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > > >   static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> > > > >   {
> > > > >   	struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > -	u16 flags;
> > > > > +	u16 new, old, off_wrap, flags;
> > > > >   	bool needs_kick;
> > > > >   	u32 snapshot;
> > > > > @@ -995,7 +995,12 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> > > > >   	 * suppressions. */
> > > > >   	virtio_mb(vq->weak_barriers);
> > > > > +	old = vq->next_avail_idx - vq->num_added;
> > > > > +	new = vq->next_avail_idx;
> > > > > +	vq->num_added = 0;
> > > > > +
> > > > >   	snapshot = *(u32 *)vq->vring_packed.device;
> > > > > +	off_wrap = virtio16_to_cpu(_vq->vdev, snapshot & 0xffff);
> > > > >   	flags = cpu_to_virtio16(_vq->vdev, snapshot >> 16) & 0x3;
> > > > >   #ifdef DEBUG
> > > > > @@ -1006,7 +1011,10 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> > > > >   	vq->last_add_time_valid = false;
> > > > >   #endif
> > > > > -	needs_kick = (flags != VRING_EVENT_F_DISABLE);
> > > > > +	if (flags == VRING_EVENT_F_DESC)
> > > > > +		needs_kick = vring_need_event(off_wrap & ~(1<<15), new, old);
> > > > 
> > > > I wonder whether or not the math is correct. Both new and event are in the
> > > > unit of descriptor ring size, but old looks not.
> > > 
> > > What vring_need_event() cares is the distance between
> > > `new` and `old`, i.e. vq->num_added. So I think there
> > > is nothing wrong with `old`. But the calculation of the
> > > distance between `new` and `event_idx` isn't right when
> > > `new` wraps. How do you think about the below code:
> > > 
> > > 	wrap_counter = off_wrap >> 15;
> > > 	event_idx = off_wrap & ~(1<<15);
> > > 	if (wrap_counter != vq->wrap_counter)
> > > 		event_idx -= vq->vring_packed.num;
> > > 	
> > > 	needs_kick = vring_need_event(event_idx, new, old);
> > 
> > I suspect this hack won't work for non power of 2 ring.
> 
> Above code doesn't require the ring size to be a power of 2.
> 
> For (__u16)(new_idx - old), what we want to get is vq->num_added.
> 
> old = vq->next_avail_idx - vq->num_added;
> new = vq->next_avail_idx;
> 
> When vq->next_avail_idx >= vq->num_added, it's obvious that,
> (__u16)(new_idx - old) is vq->num_added.
> 
> And when vq->next_avail_idx < vq->num_added, new will be smaller
> than old (old will be a big unsigned number), but (__u16)(new_idx
> - old) is still vq->num_added.
> 
> For (__u16)(new_idx - event_idx - 1), when new wraps and event_idx
> doesn't wrap, the most straightforward way to calculate it is:
> (new + vq->vring_packed.num) - event_idx - 1.

So how about we use the straightforward way then?

> But we can also calculate it in this way:
> 
> event_idx -= vq->vring_packed.num;
> (event_idx will be a big unsigned number)
> 
> Then (__u16)(new_idx - event_idx - 1) will be the value we want.
> 
> Best regards,
> Tiwei Bie


> > 
> > 
> > > Best regards,
> > > Tiwei Bie
> > > 
> > > 
> > > > 
> > > > Thanks
> > > > 
> > > > > +	else
> > > > > +		needs_kick = (flags != VRING_EVENT_F_DISABLE);
> > > > >   	END_USE(vq);
> > > > >   	return needs_kick;
> > > > >   }
> > > > > @@ -1116,6 +1124,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > > >   	if (vq->last_used_idx >= vq->vring_packed.num)
> > > > >   		vq->last_used_idx -= vq->vring_packed.num;
> > > > > +	/* If we expect an interrupt for the next entry, tell host
> > > > > +	 * by writing event index and flush out the write before
> > > > > +	 * the read in the next get_buf call. */
> > > > > +	if (vq->event_flags_shadow == VRING_EVENT_F_DESC)
> > > > > +		virtio_store_mb(vq->weak_barriers,
> > > > > +				&vq->vring_packed.driver->off_wrap,
> > > > > +				cpu_to_virtio16(_vq->vdev, vq->last_used_idx |
> > > > > +						(vq->wrap_counter << 15)));
> > > > > +
> > > > >   #ifdef DEBUG
> > > > >   	vq->last_add_time_valid = false;
> > > > >   #endif
> > > > > @@ -1143,10 +1160,17 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> > > > >   	/* We optimistically turn back on interrupts, then check if there was
> > > > >   	 * more to do. */
> > > > > +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> > > > > +	 * either clear the flags bit or point the event index at the next
> > > > > +	 * entry. Always update the event index to keep code simple. */
> > > > > +
> > > > > +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > > > > +			vq->last_used_idx | (vq->wrap_counter << 15));
> > > > >   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> > > > >   		virtio_wmb(vq->weak_barriers);
> > > > > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > > > > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > > > > +						     VRING_EVENT_F_ENABLE;
> > > > >   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> > > > >   							vq->event_flags_shadow);
> > > > >   	}
> > > > > @@ -1172,15 +1196,34 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
> > > > >   static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> > > > >   {
> > > > >   	struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > +	u16 bufs, used_idx, wrap_counter;
> > > > >   	START_USE(vq);
> > > > >   	/* We optimistically turn back on interrupts, then check if there was
> > > > >   	 * more to do. */
> > > > > +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> > > > > +	 * either clear the flags bit or point the event index at the next
> > > > > +	 * entry. Always update the event index to keep code simple. */
> > > > > +
> > > > > +	/* TODO: tune this threshold */
> > > > > +	bufs = (u16)(vq->next_avail_idx - vq->last_used_idx) * 3 / 4;
> > > > > +
> > > > > +	used_idx = vq->last_used_idx + bufs;
> > > > > +	wrap_counter = vq->wrap_counter;
> > > > > +
> > > > > +	if (used_idx >= vq->vring_packed.num) {
> > > > > +		used_idx -= vq->vring_packed.num;
> > > > > +		wrap_counter ^= 1;
> > > > > +	}
> > > > > +
> > > > > +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > > > > +			used_idx | (wrap_counter << 15));
> > > > >   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> > > > >   		virtio_wmb(vq->weak_barriers);
> > > > > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > > > > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > > > > +						     VRING_EVENT_F_ENABLE;
> > > > >   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> > > > >   							vq->event_flags_shadow);
> > > > >   	}
> > > > > @@ -1822,8 +1865,10 @@ void vring_transport_features(struct virtio_device *vdev)
> > > > >   		switch (i) {
> > > > >   		case VIRTIO_RING_F_INDIRECT_DESC:
> > > > >   			break;
> > > > > +#if 0
> > > > >   		case VIRTIO_RING_F_EVENT_IDX:
> > > > >   			break;
> > > > > +#endif
> > > > >   		case VIRTIO_F_VERSION_1:
> > > > >   			break;
> > > > >   		case VIRTIO_F_IOMMU_PLATFORM:
> > > > 
