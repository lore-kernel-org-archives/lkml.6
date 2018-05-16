Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeEPM6E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:58:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:30347 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752414AbeEPM6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:58:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="224698142"
Date: Wed, 16 May 2018 20:58:25 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v4 4/5] virtio_ring: add event idx support in packed ring
Message-ID: <20180516125825.GA4171@debian>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-5-tiwei.bie@intel.com>
 <64f5085b-4b62-d545-36e0-0951c11b29a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64f5085b-4b62-d545-36e0-0951c11b29a8@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 08:17:21PM +0800, Jason Wang wrote:
> On 2018年05月16日 16:37, Tiwei Bie wrote:
[...]
> > @@ -1160,15 +1186,27 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> >   static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> >   {
> >   	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	u16 wrap_counter;
> >   	START_USE(vq);
> >   	/* We optimistically turn back on interrupts, then check if there was
> >   	 * more to do. */
> > +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> > +	 * either clear the flags bit or point the event index at the next
> > +	 * entry. Always update the event index to keep code simple. */
> > +
> > +	wrap_counter = vq->wrap_counter;
> > +	if (vq->last_used_idx > vq->next_avail_idx)
> 
> Should this be ">=" consider rx refill may try to completely fill the ring?

It seems that there are two cases that last_used_idx
equals to next_avail_idx. The first one is that the
ring is empty. And the second one is that the ring
is full. Although in the first case, most probably,
the driver won't enable the interrupt.

Maybe I really should track the used_wrap_counter
instead of calculating it each time I need it.. I'll
give it a try..

> 
> > +		wrap_counter ^= 1;
> > +
> > +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > +			vq->last_used_idx | (wrap_counter << 15));
> >   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> >   		virtio_wmb(vq->weak_barriers);
> > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > +						     VRING_EVENT_F_ENABLE;
> >   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> >   							vq->event_flags_shadow);
> >   	}
> > @@ -1194,15 +1232,40 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
> >   static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >   {
> >   	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	u16 bufs, used_idx, wrap_counter;
> >   	START_USE(vq);
> >   	/* We optimistically turn back on interrupts, then check if there was
> >   	 * more to do. */
> > +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> > +	 * either clear the flags bit or point the event index at the next
> > +	 * entry. Always update the event index to keep code simple. */
> > +
> > +	/* TODO: tune this threshold */
> > +	if (vq->next_avail_idx < vq->last_used_idx)
> > +		bufs = (vq->vring_packed.num + vq->next_avail_idx -
> > +				vq->last_used_idx) * 3 / 4;
> > +	else
> > +		bufs = (vq->next_avail_idx - vq->last_used_idx) * 3 / 4;
> > +
> > +	wrap_counter = vq->wrap_counter;
> > +	if (vq->last_used_idx > vq->next_avail_idx)
> > +		wrap_counter ^= 1;
> > +
> > +	used_idx = vq->last_used_idx + bufs;
> > +	if (used_idx >= vq->vring_packed.num) {
> > +		used_idx -= vq->vring_packed.num;
> > +		wrap_counter ^= 1;
> > +	}
> 
> Looks correct but maybe it's better to add some comments for such logic.

Make sense.

> 
> > +
> > +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > +			used_idx | (wrap_counter << 15));
> >   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> >   		virtio_wmb(vq->weak_barriers);
> > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > +						     VRING_EVENT_F_ENABLE;
> >   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> >   							vq->event_flags_shadow);
> >   	}
> > @@ -1869,8 +1932,10 @@ void vring_transport_features(struct virtio_device *vdev)
> >   		switch (i) {
> >   		case VIRTIO_RING_F_INDIRECT_DESC:
> >   			break;
> > +#if 0
> >   		case VIRTIO_RING_F_EVENT_IDX:
> >   			break;
> > +#endif
> 
> Maybe it's time to remove this #if 0.

Will do it.

Thanks for the review!

Best regards,
Tiwei Bie
