Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeCPGoT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:44:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750814AbeCPGoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:44:18 -0400
Subject: Re: [PATCH RFC 2/2] virtio_ring: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-3-tiwei.bie@intel.com>
 <8f73267a-e20e-de64-d8e0-3fd608dbf368@redhat.com>
 <20180316061047.o2xdyuqhak3mzjyw@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0a0ecf42-8f7f-9387-8ca4-cb65d0835b56@redhat.com>
Date: Fri, 16 Mar 2018 14:44:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316061047.o2xdyuqhak3mzjyw@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月16日 14:10, Tiwei Bie wrote:
> On Fri, Mar 16, 2018 at 12:03:25PM +0800, Jason Wang wrote:
>> On 2018年02月23日 19:18, Tiwei Bie wrote:
>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>> ---
>>>    drivers/virtio/virtio_ring.c | 699 +++++++++++++++++++++++++++++++++++++------
>>>    include/linux/virtio_ring.h  |   8 +-
>>>    2 files changed, 618 insertions(+), 89 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index eb30f3e09a47..393778a2f809 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -58,14 +58,14 @@
>>>    struct vring_desc_state {
>>>    	void *data;			/* Data for callback. */
>>> -	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>>> +	void *indir_desc;		/* Indirect descriptor, if any. */
>>> +	int num;			/* Descriptor list length. */
>>>    };
>>>    struct vring_virtqueue {
>>>    	struct virtqueue vq;
>>> -	/* Actual memory layout for this queue */
>>> -	struct vring vring;
>>> +	bool packed;
>>>    	/* Can we use weak barriers? */
>>>    	bool weak_barriers;
>>> @@ -87,11 +87,28 @@ struct vring_virtqueue {
>>>    	/* Last used index we've seen. */
>>>    	u16 last_used_idx;
>>> -	/* Last written value to avail->flags */
>>> -	u16 avail_flags_shadow;
>>> -
>>> -	/* Last written value to avail->idx in guest byte order */
>>> -	u16 avail_idx_shadow;
>>> +	union {
>>> +		/* Available for split ring */
>>> +		struct {
>>> +			/* Actual memory layout for this queue */
>>> +			struct vring vring;
>>> +
>>> +			/* Last written value to avail->flags */
>>> +			u16 avail_flags_shadow;
>>> +
>>> +			/* Last written value to avail->idx in
>>> +			 * guest byte order */
>>> +			u16 avail_idx_shadow;
>>> +		};
>>> +
>>> +		/* Available for packed ring */
>>> +		struct {
>>> +			/* Actual memory layout for this queue */
>>> +			struct vring_packed vring_packed;
>>> +			u8 wrap_counter : 1;
>>> +			bool chaining;
>>> +		};
>>> +	};
>>>    	/* How to notify other side. FIXME: commonalize hcalls! */
>>>    	bool (*notify)(struct virtqueue *vq);
>>> @@ -201,26 +218,37 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
>>>    			      cpu_addr, size, direction);
>>>    }
>>> -static void vring_unmap_one(const struct vring_virtqueue *vq,
>>> -			    struct vring_desc *desc)
>>> +static void vring_unmap_one(const struct vring_virtqueue *vq, void *_desc)
>>>    {
>> Let's split the helpers to packed/split version like other helpers?
>> (Consider the caller has already known the type of vq).
> Okay.
>

[...]

>>> +				desc[i].flags = flags;
>>> +
>>> +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
>>> +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
>>> +			desc[i].id = cpu_to_virtio32(_vq->vdev, head);
>> If it's a part of chain, we only need to do this for last buffer I think.
> I'm not sure I've got your point about the "last buffer".
> But, yes, id just needs to be set for the last desc.

Right, I think I meant "last descriptor" :)

>
>>> +			prev = i;
>>> +			i++;
>> It looks to me prev is always i - 1?
> No. prev will be (vq->vring_packed.num - 1) when i becomes 0.

Right, so prev = i ? i - 1 : vq->vring_packed.num - 1.

>
>>> +			if (!indirect && i >= vq->vring_packed.num) {
>>> +				i = 0;
>>> +				vq->wrap_counter ^= 1;
>>> +			}
>>> +		}
>>> +	}
>>> +	for (; n < (out_sgs + in_sgs); n++) {
>>> +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>>> +			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
>>> +			if (vring_mapping_error(vq, addr))
>>> +				goto unmap_release;
>>> +
>>> +			flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT |
>>> +					VRING_DESC_F_WRITE |
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
>>> +			prev = i;
>>> +			i++;
>>> +			if (!indirect && i >= vq->vring_packed.num) {
>>> +				i = 0;
>>> +				vq->wrap_counter ^= 1;
>>> +			}
>>> +		}
>>> +	}
>>> +	/* Last one doesn't continue. */
>>> +	if (!indirect && (head + 1) % vq->vring_packed.num == i)
>>> +		head_flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>> I can't get the why we need this here.
> If only one desc is used, we will need to clear the
> VRING_DESC_F_NEXT flag from the head_flags.

Yes, I meant why following desc[prev].flags won't work for this?

>
>>> +	else
>>> +		desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>>> +
>>> +	if (indirect) {
>>> +		/* FIXME: to be implemented */
>>> +
>>> +		/* Now that the indirect table is filled in, map it. */
>>> +		dma_addr_t addr = vring_map_single(
>>> +			vq, desc, total_sg * sizeof(struct vring_packed_desc),
>>> +			DMA_TO_DEVICE);
>>> +		if (vring_mapping_error(vq, addr))
>>> +			goto unmap_release;
>>> +
>>> +		head_flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT |
>>> +					     VRING_DESC_F_AVAIL(wrap_counter) |
>>> +					     VRING_DESC_F_USED(!wrap_counter));
>>> +		vq->vring_packed.desc[head].addr = cpu_to_virtio64(_vq->vdev, addr);
>>> +		vq->vring_packed.desc[head].len = cpu_to_virtio32(_vq->vdev,
>>> +				total_sg * sizeof(struct vring_packed_desc));
>>> +		vq->vring_packed.desc[head].id = cpu_to_virtio32(_vq->vdev, head);
>>> +	}
>>> +
>>> +	/* We're using some buffers from the free list. */
>>> +	vq->vq.num_free -= descs_used;
>>> +
>>> +	/* Update free pointer */
>>> +	if (indirect) {
>>> +		n = head + 1;
>>> +		if (n >= vq->vring_packed.num) {
>>> +			n = 0;
>>> +			vq->wrap_counter ^= 1;
>>> +		}
>>> +		vq->free_head = n;
>> detach_buf_packed() does not even touch free_head here, so need to explain
>> its meaning for packed ring.
> Above code is for indirect support which isn't really
> implemented in this patch yet.
>
> For your question, free_head stores the index of the
> next avail desc. I'll add a comment for it or move it
> to union and give it a better name in next version.

Yes, something like avail_idx might be better.

>
>>> +	} else
>>> +		vq->free_head = i;
>> ID is only valid in the last descriptor in the list, so head + 1 should be
>> ok too?
> I don't really get your point. The vq->free_head stores
> the index of the next avail desc.

I think I get your idea now, free_head has two meanings:

- next avail index
- buffer id

If I'm correct, let's better add a comment for this.

>
>>> +
>>> +	/* Store token and indirect buffer state. */
>>> +	vq->desc_state[head].num = descs_used;
>>> +	vq->desc_state[head].data = data;
>>> +	if (indirect)
>>> +		vq->desc_state[head].indir_desc = desc;
>>> +	else
>>> +		vq->desc_state[head].indir_desc = ctx;
>>> +
>>> +	virtio_wmb(vq->weak_barriers);
>> Let's add a comment to explain the barrier here.
> Okay.
>
>>> +	vq->vring_packed.desc[head].flags = head_flags;
>>> +	vq->num_added++;
>>> +
>>> +	pr_debug("Added buffer head %i to %p\n", head, vq);
>>> +	END_USE(vq);
>>> +
>>> +	return 0;
>>> +
>>> +unmap_release:
>>> +	err_idx = i;
>>> +	i = head;
>>> +
>>> +	for (n = 0; n < total_sg; n++) {
>>> +		if (i == err_idx)
>>> +			break;
>>> +		vring_unmap_one(vq, &desc[i]);
>>> +		i++;
>>> +		if (!indirect && i >= vq->vring_packed.num)
>>> +			i = 0;
>>> +	}
>>> +
>>> +	vq->wrap_counter = wrap_counter;
>>> +
>>> +	if (indirect)
>>> +		kfree(desc);
>>> +
>>> +	END_USE(vq);
>>> +	return -EIO;
>>> +}
>>> +
>>> +static inline int virtqueue_add(struct virtqueue *_vq,
>>> +				struct scatterlist *sgs[],
>>> +				unsigned int total_sg,
>>> +				unsigned int out_sgs,
>>> +				unsigned int in_sgs,
>>> +				void *data,
>>> +				void *ctx,
>>> +				gfp_t gfp)
>>> +{
>>> +	struct vring_virtqueue *vq = to_vvq(_vq);
>>> +
>>> +	return vq->packed ? virtqueue_add_packed(_vq, sgs, total_sg, out_sgs,
>>> +						 in_sgs, data, ctx, gfp) :
>>> +			    virtqueue_add_split(_vq, sgs, total_sg, out_sgs,
>>> +						in_sgs, data, ctx, gfp);
>>> +}
>>> +
>>>    /**
>>>     * virtqueue_add_sgs - expose buffers to other end
>>>     * @vq: the struct virtqueue we're talking about.
>>> @@ -561,6 +845,12 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>>>    	 * event. */
>>>    	virtio_mb(vq->weak_barriers);
>>> +	if (vq->packed) {
>>> +		/* FIXME: to be implemented */
>>> +		needs_kick = true;
>>> +		goto out;
>>> +	}
>>> +
>>>    	old = vq->avail_idx_shadow - vq->num_added;
>>>    	new = vq->avail_idx_shadow;
>>>    	vq->num_added = 0;
>>> @@ -579,6 +869,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>>>    	} else {
>>>    		needs_kick = !(vq->vring.used->flags & cpu_to_virtio16(_vq->vdev, VRING_USED_F_NO_NOTIFY));
>>>    	}
>>> +
>>> +out:
>>>    	END_USE(vq);
>>>    	return needs_kick;
>>>    }
>>> @@ -628,8 +920,8 @@ bool virtqueue_kick(struct virtqueue *vq)
>>>    }
>>>    EXPORT_SYMBOL_GPL(virtqueue_kick);
>>> -static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
>>> -		       void **ctx)
>>> +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>>> +			     void **ctx)
>>>    {
>>>    	unsigned int i, j;
>>>    	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>>> @@ -677,29 +969,81 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
>>>    	}
>>>    }
>>> -static inline bool more_used(const struct vring_virtqueue *vq)
>>> +static void detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
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
>>> +		vring_unmap_one(vq, desc);
>>> +		i++;
>>> +		if (i >= vq->vring_packed.num)
>>> +			i = 0;
>>> +	}
>>> +
>>> +	vq->vq.num_free += vq->desc_state[head].num;
>> It looks to me vq->free_head grows always, how can we make sure it does not
>> exceeds vq.num here?
> The vq->free_head stores the index of the next avail
> desc. You can find it wraps together with vq->wrap_counter
> in virtqueue_add_packed().
>

I see, thanks.


[...]

>>> +
>>> +	/* detach_buf_packed clears data, so grab it now. */
>>> +	ret = vq->desc_state[i].data;
>>> +	detach_buf_packed(vq, i, ctx);
>>> +
>>> +	vq->last_used_idx += vq->desc_state[i].num;
>>> +	if (vq->last_used_idx >= vq->vring_packed.num)
>>> +		vq->last_used_idx %= vq->vring_packed.num;
>> '-=' should be sufficient here?
> Good suggestion. I think so.
>
>>> +
>>> +	// FIXME: implement the desc event support
>>> +
>>> +#ifdef DEBUG
>>> +	vq->last_add_time_valid = false;
>>> +#endif
>>> +
>>> +	END_USE(vq);
>>> +	return ret;
>>> +}
>>> +

[...]

>>> +
>>> +#if 0
>>> +		vq->chaining = virtio_has_feature(vdev,
>>> +						  VIRTIO_RING_F_LIST_DESC);
>>> +#else
>>> +		vq->chaining = true;
>> Looks like in V10 there's no F_LIST_DESC.
> Yes. I kept this in this patch just because the
> desc chaining is optional in the old spec draft
> when sending out this patch set. I'll remove it
> in next version.
>
>>> +#endif
>>> +	} else {
>>> +		vq->vring = vring.vring_split;
>>> +		vq->avail_flags_shadow = 0;
>>> +		vq->avail_idx_shadow = 0;
>>> +
>>> +		/* Put everything in free lists. */
>>> +		vq->free_head = 0;
>>> +		for (i = 0; i < num-1; i++)
>>> +			vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
>>> +	}
>>> +
>>>    	/* No callback?  Tell other side not to bother us. */
>>>    	if (!callback) {
>>> -		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
>>> -		if (!vq->event)
>>> -			vq->vring.avail->flags = cpu_to_virtio16(vdev, vq->avail_flags_shadow);
>>> +		if (packed) {
>>> +			// FIXME: to be implemented
>>> +		} else {
>>> +			vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
>>> +			if (!vq->event)
>>> +				vq->vring.avail->flags = cpu_to_virtio16(vdev,
>>> +						vq->avail_flags_shadow);
>>> +		}
>>>    	}
>>> -	/* Put everything in free lists. */
>>> -	vq->free_head = 0;
>>> -	for (i = 0; i < vring.num-1; i++)
>>> -		vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
>>> -	memset(vq->desc_state, 0, vring.num * sizeof(struct vring_desc_state));
>>> +	memset(vq->desc_state, 0, num * sizeof(struct vring_desc_state));
>>>    	return &vq->vq;
>>>    }
>>> @@ -1058,6 +1548,14 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
>>>    	}
>>>    }
>>> +static inline int
>>> +__vring_size(unsigned int num, unsigned long align, bool packed)
>>> +{
>>> +	if (packed)
>>> +		return vring_packed_size(num, align);
>>> +	return vring_size(num, align);
>>> +}
>>> +
>>>    struct virtqueue *vring_create_virtqueue(
>>>    	unsigned int index,
>>>    	unsigned int num,
>>> @@ -1074,7 +1572,8 @@ struct virtqueue *vring_create_virtqueue(
>>>    	void *queue = NULL;
>>>    	dma_addr_t dma_addr;
>>>    	size_t queue_size_in_bytes;
>>> -	struct vring vring;
>>> +	union vring_union vring;
>>> +	bool packed;
>>>    	/* We assume num is a power of 2. */
>>>    	if (num & (num - 1)) {
>>> @@ -1082,9 +1581,13 @@ struct virtqueue *vring_create_virtqueue(
>>>    		return NULL;
>>>    	}
>>> +	packed = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED);
>>> +
>>>    	/* TODO: allocate each queue chunk individually */
>>> -	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
>>> -		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
>>> +	for (; num && __vring_size(num, vring_align, packed) > PAGE_SIZE;
>>> +			num /= 2) {
>>> +		queue = vring_alloc_queue(vdev, __vring_size(num, vring_align,
>>> +							     packed),
>>>    					  &dma_addr,
>>>    					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>>>    		if (queue)
>>> @@ -1096,17 +1599,21 @@ struct virtqueue *vring_create_virtqueue(
>>>    	if (!queue) {
>>>    		/* Try to get a single page. You are my only hope! */
>>> -		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
>>> +		queue = vring_alloc_queue(vdev, __vring_size(num, vring_align,
>>> +							     packed),
>>>    					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
>>>    	}
>>>    	if (!queue)
>>>    		return NULL;
>>> -	queue_size_in_bytes = vring_size(num, vring_align);
>>> -	vring_init(&vring, num, queue, vring_align);
>>> +	queue_size_in_bytes = __vring_size(num, vring_align, packed);
>>> +	if (packed)
>>> +		vring_packed_init(&vring.vring_packed, num, queue, vring_align);
>>> +	else
>>> +		vring_init(&vring.vring_split, num, queue, vring_align);
>> Let's rename vring_init to vring_init_split() like other helpers?
> The vring_init() is a public API in include/uapi/linux/virtio_ring.h.
> I don't think we can rename it.

I see, then this need more thoughts to unify the API.

>
>>> -	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
>>> -				   notify, callback, name);
>>> +	vq = __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
>>> +				   context, notify, callback, name);
>>>    	if (!vq) {
>>>    		vring_free_queue(vdev, queue_size_in_bytes, queue,
>>>    				 dma_addr);
>>> @@ -1132,10 +1639,17 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>>>    				      void (*callback)(struct virtqueue *vq),
>>>    				      const char *name)
>>>    {
>>> -	struct vring vring;
>>> -	vring_init(&vring, num, pages, vring_align);
>>> -	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
>>> -				     notify, callback, name);
>>> +	union vring_union vring;
>>> +	bool packed;
>>> +
>>> +	packed = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED);
>>> +	if (packed)
>>> +		vring_packed_init(&vring.vring_packed, num, pages, vring_align);
>>> +	else
>>> +		vring_init(&vring.vring_split, num, pages, vring_align);
>>> +
>>> +	return __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
>>> +				     context, notify, callback, name);
>>>    }
>>>    EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>>> @@ -1145,7 +1659,9 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>>>    	if (vq->we_own_ring) {
>>>    		vring_free_queue(vq->vq.vdev, vq->queue_size_in_bytes,
>>> -				 vq->vring.desc, vq->queue_dma_addr);
>>> +				 vq->packed ? (void *)vq->vring_packed.desc :
>>> +					      (void *)vq->vring.desc,
>>> +				 vq->queue_dma_addr);
>>>    	}
>>>    	list_del(&_vq->list);
>>>    	kfree(vq);
>>> @@ -1159,14 +1675,18 @@ void vring_transport_features(struct virtio_device *vdev)
>>>    	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++) {
>>>    		switch (i) {
>>> +#if 0 // FIXME: to be implemented
>>>    		case VIRTIO_RING_F_INDIRECT_DESC:
>>>    			break;
>>> +#endif
>>>    		case VIRTIO_RING_F_EVENT_IDX:
>>>    			break;
>>>    		case VIRTIO_F_VERSION_1:
>>>    			break;
>>>    		case VIRTIO_F_IOMMU_PLATFORM:
>>>    			break;
>>> +		case VIRTIO_F_RING_PACKED:
>>> +			break;
>>>    		default:
>>>    			/* We don't understand this bit. */
>>>    			__virtio_clear_bit(vdev, i);
>>> @@ -1187,7 +1707,7 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>>>    	struct vring_virtqueue *vq = to_vvq(_vq);
>>> -	return vq->vring.num;
>>> +	return vq->packed ? vq->vring_packed.num : vq->vring.num;
>>>    }
>>>    EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>>> @@ -1224,6 +1744,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>>>    }
>>>    EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
>>> +/* Only available for split ring */
>> Interesting, I think we need this for correctly configure pci. e.g in
>> setup_vq()?
> Yes. The setup_vq() should be updated. But it requires
> QEMU change, so I just kept it as is in this RFC patch.

Ok.

>
>>>    dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>>>    {
>>>    	struct vring_virtqueue *vq = to_vvq(_vq);
>>> @@ -1235,6 +1756,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>>>    }
>>>    EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
>>> +/* Only available for split ring */
>>>    dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>> Maybe it's better to rename this to get_device_addr().
> It's a kernel API which has been exported by EXPORT_SYMBOL_GPL(),
> I'm not sure whether it's a good idea to rename it.

If it's not a part of uapi, I think we can.

Thanks

>
> Best regards,
> Tiwei Bie
>
>> Thanks
>>
>>>    {
>>>    	struct vring_virtqueue *vq = to_vvq(_vq);
>>> @@ -1246,6 +1768,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>>>    }
>>>    EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
>>> +/* Only available for split ring */
>>>    const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>>>    {
>>>    	return &to_vvq(vq)->vring;
>>> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
>>> index bbf32524ab27..a0075894ad16 100644
>>> --- a/include/linux/virtio_ring.h
>>> +++ b/include/linux/virtio_ring.h
>>> @@ -60,6 +60,11 @@ static inline void virtio_store_mb(bool weak_barriers,
>>>    struct virtio_device;
>>>    struct virtqueue;
>>> +union vring_union {
>>> +	struct vring vring_split;
>>> +	struct vring_packed vring_packed;
>>> +};
>>> +
>>>    /*
>>>     * Creates a virtqueue and allocates the descriptor ring.  If
>>>     * may_reduce_num is set, then this may allocate a smaller ring than
>>> @@ -79,7 +84,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
>>>    /* Creates a virtqueue with a custom layout. */
>>>    struct virtqueue *__vring_new_virtqueue(unsigned int index,
>>> -					struct vring vring,
>>> +					union vring_union vring,
>>> +					bool packed,
>>>    					struct virtio_device *vdev,
>>>    					bool weak_barriers,
>>>    					bool ctx,
