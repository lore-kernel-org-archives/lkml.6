Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeDQCMR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:12:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752058AbeDQCMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:12:13 -0400
Subject: Re: [RFC v2] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
References: <20180401141216.8969-1-tiwei.bie@intel.com>
 <ebfbfc3e-9e52-9331-61b6-258e131f822d@redhat.com>
 <20180413071529.f4esh654dakodf4f@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8dee7d62-ac0b-54ba-6bec-4bc4a6fb34e9@redhat.com>
Date: Tue, 17 Apr 2018 10:11:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413071529.f4esh654dakodf4f@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月13日 15:15, Tiwei Bie wrote:
> On Fri, Apr 13, 2018 at 12:30:24PM +0800, Jason Wang wrote:
>> On 2018年04月01日 22:12, Tiwei Bie wrote:
>>> Hello everyone,
>>>
>>> This RFC implements packed ring support for virtio driver.
>>>
>>> The code was tested with DPDK vhost (testpmd/vhost-PMD) implemented
>>> by Jens at http://dpdk.org/ml/archives/dev/2018-January/089417.html
>>> Minor changes are needed for the vhost code, e.g. to kick the guest.
>>>
>>> TODO:
>>> - Refinements and bug fixes;
>>> - Split into small patches;
>>> - Test indirect descriptor support;
>>> - Test/fix event suppression support;
>>> - Test devices other than net;
>>>
>>> RFC v1 -> RFC v2:
>>> - Add indirect descriptor support - compile test only;
>>> - Add event suppression supprt - compile test only;
>>> - Move vring_packed_init() out of uapi (Jason, MST);
>>> - Merge two loops into one in virtqueue_add_packed() (Jason);
>>> - Split vring_unmap_one() for packed ring and split ring (Jason);
>>> - Avoid using '%' operator (Jason);
>>> - Rename free_head -> next_avail_idx (Jason);
>>> - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
>>> - Some other refinements and bug fixes;
>>>
>>> Thanks!
>>>
>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>> ---
>>>    drivers/virtio/virtio_ring.c       | 1094 +++++++++++++++++++++++++++++-------
>>>    include/linux/virtio_ring.h        |    8 +-
>>>    include/uapi/linux/virtio_config.h |   12 +-
>>>    include/uapi/linux/virtio_ring.h   |   61 ++
>>>    4 files changed, 980 insertions(+), 195 deletions(-)
> [...]
>>> +static struct vring_packed_desc *alloc_indirect_packed(struct virtqueue *_vq,
>>> +						       unsigned int total_sg,
>>> +						       gfp_t gfp)
>>> +{
>>> +	struct vring_packed_desc *desc;
>>> +
>>> +	/*
>>> +	 * We require lowmem mappings for the descriptors because
>>> +	 * otherwise virt_to_phys will give us bogus addresses in the
>>> +	 * virtqueue.
>>> +	 */
>>> +	gfp &= ~__GFP_HIGHMEM;
>>> +
>>> +	desc = kmalloc(total_sg * sizeof(struct vring_packed_desc), gfp);
>> Can we simply check vq->packed here to avoid duplicating helpers?
> Then it would be something like this:
>
> static void *alloc_indirect(struct virtqueue *_vq, unsigned int total_sg,
> 			    gfp_t gfp)
> {
> 	struct vring_virtqueue *vq = to_vvq(_vq);
> 	void *data;
>
> 	/*
> 	 * We require lowmem mappings for the descriptors because
> 	 * otherwise virt_to_phys will give us bogus addresses in the
> 	 * virtqueue.
> 	 */
> 	gfp &= ~__GFP_HIGHMEM;
>
> 	if (vq->packed) {
> 		data = kmalloc(total_sg * sizeof(struct vring_packed_desc),
> 				gfp);
> 		if (!data)
> 			return NULL;
> 	} else {
> 		struct vring_desc *desc;
> 		unsigned int i;
>
> 		desc = kmalloc(total_sg * sizeof(struct vring_desc), gfp);
> 		if (!desc)
> 			return NULL;
>
> 		for (i = 0; i < total_sg; i++)
> 			desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
>
> 		data = desc;
> 	}
>
> 	return data;
> }
>
> I would prefer to have two simpler helpers (and to the callers,
> it's already very clear about which one they should call), i.e.
> the current implementation:
>
> static struct vring_packed_desc *alloc_indirect_packed(struct virtqueue *_vq,
> 						       unsigned int total_sg,
> 						       gfp_t gfp)
> {
> 	struct vring_packed_desc *desc;
>
> 	/*
> 	 * We require lowmem mappings for the descriptors because
> 	 * otherwise virt_to_phys will give us bogus addresses in the
> 	 * virtqueue.
> 	 */
> 	gfp &= ~__GFP_HIGHMEM;
>
> 	desc = kmalloc(total_sg * sizeof(struct vring_packed_desc), gfp);
>
> 	return desc;
> }
>
> static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> 					       unsigned int total_sg,
> 					       gfp_t gfp)
> {
> 	struct vring_desc *desc;
> 	unsigned int i;
>
> 	/*
> 	 * We require lowmem mappings for the descriptors because
> 	 * otherwise virt_to_phys will give us bogus addresses in the
> 	 * virtqueue.
> 	 */
> 	gfp &= ~__GFP_HIGHMEM;
>
> 	desc = kmalloc(total_sg * sizeof(struct vring_desc), gfp);
> 	if (!desc)
> 		return NULL;
>
> 	for (i = 0; i < total_sg; i++)
> 		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
> 	return desc;
> }

Yeah, I miss that split version needs a desc list.

>
>>> +
>>> +	return desc;
>>> +}
> [...]
>>> +static inline int virtqueue_add_packed(struct virtqueue *_vq,
>>> +				       struct scatterlist *sgs[],
>>> +				       unsigned int total_sg,
>>> +				       unsigned int out_sgs,
>>> +				       unsigned int in_sgs,
>>> +				       void *data,
>>> +				       void *ctx,
>>> +				       gfp_t gfp)
>>> +{
>>> +	struct vring_virtqueue *vq = to_vvq(_vq);
>>> +	struct vring_packed_desc *desc;
>>> +	struct scatterlist *sg;
>>> +	unsigned int i, n, descs_used, uninitialized_var(prev), err_idx;
>>> +	__virtio16 uninitialized_var(head_flags), flags;
>>> +	int head, wrap_counter;
>>> +	bool indirect;
>>> +
>>> +	START_USE(vq);
>>> +
>>> +	BUG_ON(data == NULL);
>>> +	BUG_ON(ctx && vq->indirect);
>>> +
>>> +	if (unlikely(vq->broken)) {
>>> +		END_USE(vq);
>>> +		return -EIO;
>>> +	}
>>> +
>>> +#ifdef DEBUG
>>> +	{
>>> +		ktime_t now = ktime_get();
>>> +
>>> +		/* No kick or get, with .1 second between?  Warn. */
>>> +		if (vq->last_add_time_valid)
>>> +			WARN_ON(ktime_to_ms(ktime_sub(now, vq->last_add_time))
>>> +					    > 100);
>>> +		vq->last_add_time = now;
>>> +		vq->last_add_time_valid = true;
>>> +	}
>>> +#endif
>>> +
>>> +	BUG_ON(total_sg == 0);
>>> +
>>> +	head = vq->next_avail_idx;
>>> +	wrap_counter = vq->wrap_counter;
>>> +
>>> +	/* If the host supports indirect descriptor tables, and we have multiple
>>> +	 * buffers, then go indirect. FIXME: tune this threshold */
>>> +	if (vq->indirect && total_sg > 1 && vq->vq.num_free)
>> Let's introduce a helper like virtqueue_need_indirect() to avoid duplicating
>> codes and FIXME.
> Okay.
>
>>> +		desc = alloc_indirect_packed(_vq, total_sg, gfp);
>>> +	else {
>>> +		desc = NULL;
>>> +		WARN_ON_ONCE(total_sg > vq->vring_packed.num && !vq->indirect);
>>> +	}
>>> +
>>> +	if (desc) {
>>> +		/* Use a single buffer which doesn't continue */
>>> +		indirect = true;
>>> +		/* Set up rest to use this indirect table. */
>>> +		i = 0;
>>> +		descs_used = 1;
>>> +	} else {
>>> +		indirect = false;
>>> +		desc = vq->vring_packed.desc;
>>> +		i = head;
>>> +		descs_used = total_sg;
>>> +	}
>>> +
>>> +	if (vq->vq.num_free < descs_used) {
>>> +		pr_debug("Can't add buf len %i - avail = %i\n",
>>> +			 descs_used, vq->vq.num_free);
>>> +		/* FIXME: for historical reasons, we force a notify here if
>>> +		 * there are outgoing parts to the buffer.  Presumably the
>>> +		 * host should service the ring ASAP. */
>>> +		if (out_sgs)
>>> +			vq->notify(&vq->vq);
>>> +		if (indirect)
>>> +			kfree(desc);
>>> +		END_USE(vq);
>>> +		return -ENOSPC;
>>> +	}
>>> +
>>> +	for (n = 0; n < out_sgs + in_sgs; n++) {
>>> +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>>> +			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
>>> +						DMA_TO_DEVICE : DMA_FROM_DEVICE);
>>> +			if (vring_mapping_error(vq, addr))
>>> +				goto unmap_release;
>>> +
>>> +			flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT |
>>> +					(n < out_sgs ? 0 : VRING_DESC_F_WRITE) |
>>> +					VRING_DESC_F_AVAIL(vq->wrap_counter) |
>>> +					VRING_DESC_F_USED(!vq->wrap_counter));
>>> +			if (!indirect && i == head)
>>> +				head_flags = flags;
>>> +			else
>>> +				desc[i].flags = flags;
>>> +
>>> +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
>>> +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
>>> +			desc[i].id = cpu_to_virtio32(_vq->vdev, head);
>> Similar to V1, we only need this for the last descriptor.
> Okay, will just set it for the last desc.
>
>>> +			prev = i;
>> It looks to me there's no need to track prev inside the loop here.
>>
>>> +			i++;
>>> +			if (!indirect && i >= vq->vring_packed.num) {
>>> +				i = 0;
>>> +				vq->wrap_counter ^= 1;
>>> +			}
>>> +		}
>>> +	}
>>> +	/* Last one doesn't continue. */
>>> +	if (total_sg == 1)
>>> +		head_flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>>> +	else
>>> +		desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>> The only case when prev != i - 1 is i == 0, we can add a if here.
> It's just a mirror of the existing implementation in split ring.
> It seems that split ring implementation needs this just because
> it's much harder for it to find the prev, which is not true for
> packed ring. So I'll take your suggestion. Thanks!
>
> [...]
>>> +static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>>> +{
>>> +	struct vring_virtqueue *vq = to_vvq(_vq);
>>> +	u16 new, old, off_wrap;
>>> +	bool needs_kick;
>>> +
>>> +	START_USE(vq);
>>> +	/* We need to expose the new flags value before checking notification
>>> +	 * suppressions. */
>>> +	virtio_mb(vq->weak_barriers);
>>> +
>>> +	old = vq->next_avail_idx - vq->num_added;
>>> +	new = vq->next_avail_idx;
>>> +	vq->num_added = 0;
>>> +
>>> +#ifdef DEBUG
>>> +	if (vq->last_add_time_valid) {
>>> +		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
>>> +					      vq->last_add_time)) > 100);
>>> +	}
>>> +	vq->last_add_time_valid = false;
>>> +#endif
>>> +
>>> +	off_wrap = virtio16_to_cpu(_vq->vdev, vq->vring_packed.device->off_wrap);
>>> +
>>> +	if (vq->event) {
>> It looks to me we should examine RING_EVENT_FLAGS_DESC in desc_event_flags
>> instead of vq->event here. Spec does not forces to use evenf_off and
>> event_wrap if event index is enabled.
>>
>>> +		// FIXME: fix this!
>>> +		needs_kick = ((off_wrap >> 15) == vq->wrap_counter) &&
>>> +			     vring_need_event(off_wrap & ~(1<<15), new, old);
>> Why need a & here?
> Because wrap_counter (the most significant bit in off_wrap)
> isn't part of the index.
>
>>> +	} else {
>> Need a smp_rmb() to make sure desc_event_flags was checked before flags.
> I don't get your point, if my understanding is correct,
> desc_event_flags is vq->vring_packed.device->flags. So
> what's the "flags"?

Sorry, I mean we need check device.flags before off_warp. So it needs an 
smp_rmb() in the middle. It looks to me there's no guarantee that 
VRING_EVENT_F_DESC is set if event index is supported.

>
>>> +		needs_kick = (vq->vring_packed.device->flags !=
>>> +			      cpu_to_virtio16(_vq->vdev, VRING_EVENT_F_DISABLE));
>>> +	}
>>> +	END_USE(vq);
>>> +	return needs_kick;
>>> +}
> [...]
>>> +static int detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
>>> +			      void **ctx)
>>> +{
>>> +	struct vring_packed_desc *desc;
>>> +	unsigned int i, j;
>>> +
>>> +	/* Clear data ptr. */
>>> +	vq->desc_state[head].data = NULL;
>>> +
>>> +	i = head;
>>> +
>>> +	for (j = 0; j < vq->desc_state[head].num; j++) {
>>> +		desc = &vq->vring_packed.desc[i];
>>> +		vring_unmap_one_packed(vq, desc);
>>> +		desc->flags = 0x0;
>> Looks like this is unnecessary.
> It's safer to zero it. If we don't zero it, after we
> call virtqueue_detach_unused_buf_packed() which calls
> this function, the desc is still available to the
> device.

Well detach_unused_buf_packed() should be called after device is 
stopped, otherwise even if you try to clear, there will still be a 
window that device may use it.

>
>>> +		i++;
>>> +		if (i >= vq->vring_packed.num)
>>> +			i = 0;
>>> +	}
> [...]
>>> +static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>>> +{
>>> +	struct vring_virtqueue *vq = to_vvq(_vq);
>>> +	u16 last_used_idx, wrap_counter, off_wrap;
>>> +
>>> +	START_USE(vq);
>>> +
>>> +	last_used_idx = vq->last_used_idx;
>>> +	wrap_counter = vq->wrap_counter;
>>> +
>>> +	if (last_used_idx > vq->next_avail_idx)
>>> +		wrap_counter ^= 1;
>>> +
>>> +	off_wrap = last_used_idx | (wrap_counter << 15);
>>> +
>>> +	/* We optimistically turn back on interrupts, then check if there was
>>> +	 * more to do. */
>>> +	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
>>> +	 * either clear the flags bit or point the event index at the next
>>> +	 * entry. Always do both to keep code simple. */
>>> +	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
>>> +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC:
>>> +						     VRING_EVENT_F_ENABLE;
>>> +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
>>> +							vq->event_flags_shadow);
>>> +	}
>> A smp_wmb() is missed here?
>>
>>> +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev, off_wrap);
>> And according to the spec, it looks to me write a VRING_EVENT_F_ENABLE is
>> sufficient here.
> I didn't think much when implementing the event suppression
> for packed ring previously. After I saw your comments, I found
> something new. Indeed, unlike the split ring, for the packed
> ring, spec doesn't say we must use VRING_EVENT_F_DESC when
> EVENT_IDX is negotiated. So do you think below thought is
> right or makes sense?
>
> - For virtqueue_enable_cb_prepare(), we just need to enable
>    the ring by setting flags to VRING_EVENT_F_ENABLE in any
>    case.
>
> - We will try to use VRING_EVENT_F_DESC (if EVENT_IDX is
>    negotiated) only when we want to delay the interrupts
>    virtqueue_enable_cb_delayed().

This looks good to me.

>
>>> +	END_USE(vq);
>>> +	return last_used_idx;
>>> +}
>>> +
> [...]
>>> @@ -1157,14 +1852,18 @@ void vring_transport_features(struct virtio_device *vdev)
>>>    	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++) {
>>>    		switch (i) {
>>> -		case VIRTIO_RING_F_INDIRECT_DESC:
>>> +#if 0
>>> +		case VIRTIO_RING_F_INDIRECT_DESC: // FIXME not tested yet.
>>>    			break;
>>> -		case VIRTIO_RING_F_EVENT_IDX:
>>> +		case VIRTIO_RING_F_EVENT_IDX: // FIXME probably not work.
>>>    			break;
>>> +#endif
>> It would be better if you can split EVENT_IDX and INDIRECT_DESC into
>> separate patches too.
> Sure. Will do it in the next version.
>
> Thanks for the review!

Thanks.

>> Thanks
>>
