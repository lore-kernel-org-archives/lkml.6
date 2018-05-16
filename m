Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeEPFy5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 01:54:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:50075 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbeEPFyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 01:54:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="224603698"
Date: Wed, 16 May 2018 13:55:20 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
Message-ID: <20180516055520.GA21116@debian>
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <20180425051550.24342-5-tiwei.bie@intel.com>
 <915efeaa-4e47-9004-a722-54b0c40ebcbb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <915efeaa-4e47-9004-a722-54b0c40ebcbb@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 01:01:04PM +0800, Jason Wang wrote:
> On 2018年04月25日 13:15, Tiwei Bie wrote:
[...]
> > @@ -1143,10 +1160,17 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> >   	/* We optimistically turn back on interrupts, then check if there was
> >   	 * more to do. */
> > +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> > +	 * either clear the flags bit or point the event index at the next
> > +	 * entry. Always update the event index to keep code simple. */
> > +
> > +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > +			vq->last_used_idx | (vq->wrap_counter << 15));
> 
> 
> Using vq->wrap_counter seems not correct, what we need is the warp counter
> for the last_used_idx not next_avail_idx.

Yes, you're right. I have fixed it in my local repo,
but haven't sent out a new version yet.

I'll try to send out a new RFC today.

> 
> And I think there's even no need to bother with event idx here, how about
> just set VRING_EVENT_F_ENABLE?

We had a similar discussion before. Michael prefers
to use VRING_EVENT_F_DESC when possible to avoid
extra interrupts if host is fast:

https://lkml.org/lkml/2018/4/16/1085
"""
I suspect this will lead to extra interrupts if host is fast.
So I think for now we should always use VRING_EVENT_F_DESC
if EVENT_IDX is negotiated.
"""

> 
> >   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> >   		virtio_wmb(vq->weak_barriers);
> > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > +						     VRING_EVENT_F_ENABLE;
> >   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> >   							vq->event_flags_shadow);
> >   	}
> > @@ -1172,15 +1196,34 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
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
> > +	bufs = (u16)(vq->next_avail_idx - vq->last_used_idx) * 3 / 4;
> 
> bufs could be more than vq->num here, is this intended?

Yes, you're right. Like the above one -- I have fixed
it in my local repo, but haven't sent out a new version
yet. Thanks for spotting this!

> 
> > +
> > +	used_idx = vq->last_used_idx + bufs;
> > +	wrap_counter = vq->wrap_counter;
> > +
> > +	if (used_idx >= vq->vring_packed.num) {
> > +		used_idx -= vq->vring_packed.num;
> > +		wrap_counter ^= 1;
> 
> When used_idx is greater or equal vq->num, there's no need to flip
> warp_counter bit since it should match next_avail_idx.
> 
> And we need also care about the case when next_avail wraps but used_idx not.
> so we probaly need:
> 
> else if (vq->next_avail_idx < used_idx) {
>     wrap_counter ^= 1;
> }
> 
> I think maybe it's time to add some sample codes in the spec to avoid
> duplicating the efforts(bugs).

+1

Best regards,
Tiwei Bie
