Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeEPFBR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 01:01:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750992AbeEPFBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 01:01:16 -0400
Subject: Re: [RFC v3 4/5] virtio_ring: add event idx support in packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <20180425051550.24342-5-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <915efeaa-4e47-9004-a722-54b0c40ebcbb@redhat.com>
Date: Wed, 16 May 2018 13:01:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425051550.24342-5-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月25日 13:15, Tiwei Bie wrote:
> This commit introduces the event idx support in packed
> ring. This feature is temporarily disabled, because the
> implementation in this patch may not work as expected,
> and some further discussions on the implementation are
> needed, e.g. do we have to check the wrap counter when
> checking whether a kick is needed?
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 0181e93897be..b1039c2985b9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -986,7 +986,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>   static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>   {
>   	struct vring_virtqueue *vq = to_vvq(_vq);
> -	u16 flags;
> +	u16 new, old, off_wrap, flags;
>   	bool needs_kick;
>   	u32 snapshot;
>   
> @@ -995,7 +995,12 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>   	 * suppressions. */
>   	virtio_mb(vq->weak_barriers);
>   
> +	old = vq->next_avail_idx - vq->num_added;
> +	new = vq->next_avail_idx;
> +	vq->num_added = 0;
> +
>   	snapshot = *(u32 *)vq->vring_packed.device;
> +	off_wrap = virtio16_to_cpu(_vq->vdev, snapshot & 0xffff);
>   	flags = cpu_to_virtio16(_vq->vdev, snapshot >> 16) & 0x3;
>   
>   #ifdef DEBUG
> @@ -1006,7 +1011,10 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>   	vq->last_add_time_valid = false;
>   #endif
>   
> -	needs_kick = (flags != VRING_EVENT_F_DISABLE);
> +	if (flags == VRING_EVENT_F_DESC)
> +		needs_kick = vring_need_event(off_wrap & ~(1<<15), new, old);
> +	else
> +		needs_kick = (flags != VRING_EVENT_F_DISABLE);
>   	END_USE(vq);
>   	return needs_kick;
>   }
> @@ -1116,6 +1124,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>   	if (vq->last_used_idx >= vq->vring_packed.num)
>   		vq->last_used_idx -= vq->vring_packed.num;
>   
> +	/* If we expect an interrupt for the next entry, tell host
> +	 * by writing event index and flush out the write before
> +	 * the read in the next get_buf call. */
> +	if (vq->event_flags_shadow == VRING_EVENT_F_DESC)
> +		virtio_store_mb(vq->weak_barriers,
> +				&vq->vring_packed.driver->off_wrap,
> +				cpu_to_virtio16(_vq->vdev, vq->last_used_idx |
> +						(vq->wrap_counter << 15)));
> +
>   #ifdef DEBUG
>   	vq->last_add_time_valid = false;
>   #endif
> @@ -1143,10 +1160,17 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>   
>   	/* We optimistically turn back on interrupts, then check if there was
>   	 * more to do. */
> +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> +	 * either clear the flags bit or point the event index at the next
> +	 * entry. Always update the event index to keep code simple. */
> +
> +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> +			vq->last_used_idx | (vq->wrap_counter << 15));


Using vq->wrap_counter seems not correct, what we need is the warp 
counter for the last_used_idx not next_avail_idx.

And I think there's even no need to bother with event idx here, how 
about just set VRING_EVENT_F_ENABLE?

>   
>   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
>   		virtio_wmb(vq->weak_barriers);
> -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> +						     VRING_EVENT_F_ENABLE;
>   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
>   							vq->event_flags_shadow);
>   	}
> @@ -1172,15 +1196,34 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
>   static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>   {
>   	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 bufs, used_idx, wrap_counter;
>   
>   	START_USE(vq);
>   
>   	/* We optimistically turn back on interrupts, then check if there was
>   	 * more to do. */
> +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> +	 * either clear the flags bit or point the event index at the next
> +	 * entry. Always update the event index to keep code simple. */
> +
> +	/* TODO: tune this threshold */
> +	bufs = (u16)(vq->next_avail_idx - vq->last_used_idx) * 3 / 4;

bufs could be more than vq->num here, is this intended?

> +
> +	used_idx = vq->last_used_idx + bufs;
> +	wrap_counter = vq->wrap_counter;
> +
> +	if (used_idx >= vq->vring_packed.num) {
> +		used_idx -= vq->vring_packed.num;
> +		wrap_counter ^= 1;

When used_idx is greater or equal vq->num, there's no need to flip 
warp_counter bit since it should match next_avail_idx.

And we need also care about the case when next_avail wraps but used_idx 
not. so we probaly need:

else if (vq->next_avail_idx < used_idx) {
     wrap_counter ^= 1;
}

I think maybe it's time to add some sample codes in the spec to avoid 
duplicating the efforts(bugs).

Thanks
> +	}
> +
> +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> +			used_idx | (wrap_counter << 15));
>   
>   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
>   		virtio_wmb(vq->weak_barriers);
> -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> +						     VRING_EVENT_F_ENABLE;
>   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
>   							vq->event_flags_shadow);
>   	}
> @@ -1822,8 +1865,10 @@ void vring_transport_features(struct virtio_device *vdev)
>   		switch (i) {
>   		case VIRTIO_RING_F_INDIRECT_DESC:
>   			break;
> +#if 0
>   		case VIRTIO_RING_F_EVENT_IDX:
>   			break;
> +#endif
>   		case VIRTIO_F_VERSION_1:
>   			break;
>   		case VIRTIO_F_IOMMU_PLATFORM:
