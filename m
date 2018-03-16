Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeCPIen (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:34:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750748AbeCPIek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:34:40 -0400
Subject: Re: [PATCH RFC 2/2] virtio_ring: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-3-tiwei.bie@intel.com>
 <8f73267a-e20e-de64-d8e0-3fd608dbf368@redhat.com>
 <20180316061047.o2xdyuqhak3mzjyw@debian>
 <0a0ecf42-8f7f-9387-8ca4-cb65d0835b56@redhat.com>
 <20180316074028.lun2jy45qqnfeymw@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <02a3da02-8226-ba4e-1b47-d25755b2c429@redhat.com>
Date: Fri, 16 Mar 2018 16:34:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316074028.lun2jy45qqnfeymw@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月16日 15:40, Tiwei Bie wrote:
> On Fri, Mar 16, 2018 at 02:44:12PM +0800, Jason Wang wrote:
>> On 2018年03月16日 14:10, Tiwei Bie wrote:
>>> On Fri, Mar 16, 2018 at 12:03:25PM +0800, Jason Wang wrote:
>>>> On 2018年02月23日 19:18, Tiwei Bie wrote:
>>>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>>>> ---
>>>>>     drivers/virtio/virtio_ring.c | 699 +++++++++++++++++++++++++++++++++++++------
>>>>>     include/linux/virtio_ring.h  |   8 +-
>>>>>     2 files changed, 618 insertions(+), 89 deletions(-)
> [...]
>>>>>     			      cpu_addr, size, direction);
>>>>>     }
>>>>> -static void vring_unmap_one(const struct vring_virtqueue *vq,
>>>>> -			    struct vring_desc *desc)
>>>>> +static void vring_unmap_one(const struct vring_virtqueue *vq, void *_desc)
>>>>>     {
>>>> Let's split the helpers to packed/split version like other helpers?
>>>> (Consider the caller has already known the type of vq).
>>> Okay.
>>>
>> [...]
>>
>>>>> +				desc[i].flags = flags;
>>>>> +
>>>>> +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
>>>>> +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
>>>>> +			desc[i].id = cpu_to_virtio32(_vq->vdev, head);
>>>> If it's a part of chain, we only need to do this for last buffer I think.
>>> I'm not sure I've got your point about the "last buffer".
>>> But, yes, id just needs to be set for the last desc.
>> Right, I think I meant "last descriptor" :)
>>
>>>>> +			prev = i;
>>>>> +			i++;
>>>> It looks to me prev is always i - 1?
>>> No. prev will be (vq->vring_packed.num - 1) when i becomes 0.
>> Right, so prev = i ? i - 1 : vq->vring_packed.num - 1.
> Yes, i wraps together with vq->wrap_counter in following code:
>
>>>>> +			if (!indirect && i >= vq->vring_packed.num) {
>>>>> +				i = 0;
>>>>> +				vq->wrap_counter ^= 1;
>>>>> +			}
>
>>>>> +		}
>>>>> +	}
>>>>> +	for (; n < (out_sgs + in_sgs); n++) {
>>>>> +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>>>>> +			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
>>>>> +			if (vring_mapping_error(vq, addr))
>>>>> +				goto unmap_release;
>>>>> +
>>>>> +			flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT |
>>>>> +					VRING_DESC_F_WRITE |
>>>>> +					VRING_DESC_F_AVAIL(vq->wrap_counter) |
>>>>> +					VRING_DESC_F_USED(!vq->wrap_counter));
>>>>> +			if (!indirect && i == head)
>>>>> +				head_flags = flags;
>>>>> +			else
>>>>> +				desc[i].flags = flags;
>>>>> +
>>>>> +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
>>>>> +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
>>>>> +			desc[i].id = cpu_to_virtio32(_vq->vdev, head);
>>>>> +			prev = i;
>>>>> +			i++;
>>>>> +			if (!indirect && i >= vq->vring_packed.num) {
>>>>> +				i = 0;
>>>>> +				vq->wrap_counter ^= 1;
>>>>> +			}
>>>>> +		}
>>>>> +	}
>>>>> +	/* Last one doesn't continue. */
>>>>> +	if (!indirect && (head + 1) % vq->vring_packed.num == i)
>>>>> +		head_flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>>>> I can't get the why we need this here.
>>> If only one desc is used, we will need to clear the
>>> VRING_DESC_F_NEXT flag from the head_flags.
>> Yes, I meant why following desc[prev].flags won't work for this?
> Because the update of desc[head].flags (in above case,
> prev == head) has been delayed. The flags is saved in
> head_flags.

Ok, but let's try to avoid modular here e.g tracking the number of sgs 
in a counter.

And I see lots of duplication in the above two loops, I believe we can 
unify them with a a single loop. the only difference is dma direction 
and write flag.

>
>>>>> +	else
>>>>> +		desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>>>>> +
>>>>> +	if (indirect) {
>>>>> +		/* FIXME: to be implemented */
>>>>> +
>>>>> +		/* Now that the indirect table is filled in, map it. */
>>>>> +		dma_addr_t addr = vring_map_single(
>>>>> +			vq, desc, total_sg * sizeof(struct vring_packed_desc),
>>>>> +			DMA_TO_DEVICE);
>>>>> +		if (vring_mapping_error(vq, addr))
>>>>> +			goto unmap_release;
>>>>> +
>>>>> +		head_flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT |
>>>>> +					     VRING_DESC_F_AVAIL(wrap_counter) |
>>>>> +					     VRING_DESC_F_USED(!wrap_counter));
>>>>> +		vq->vring_packed.desc[head].addr = cpu_to_virtio64(_vq->vdev, addr);
>>>>> +		vq->vring_packed.desc[head].len = cpu_to_virtio32(_vq->vdev,
>>>>> +				total_sg * sizeof(struct vring_packed_desc));
>>>>> +		vq->vring_packed.desc[head].id = cpu_to_virtio32(_vq->vdev, head);
>>>>> +	}
>>>>> +
>>>>> +	/* We're using some buffers from the free list. */
>>>>> +	vq->vq.num_free -= descs_used;
>>>>> +
>>>>> +	/* Update free pointer */
>>>>> +	if (indirect) {
>>>>> +		n = head + 1;
>>>>> +		if (n >= vq->vring_packed.num) {
>>>>> +			n = 0;
>>>>> +			vq->wrap_counter ^= 1;
>>>>> +		}
>>>>> +		vq->free_head = n;
>>>> detach_buf_packed() does not even touch free_head here, so need to explain
>>>> its meaning for packed ring.
>>> Above code is for indirect support which isn't really
>>> implemented in this patch yet.
>>>
>>> For your question, free_head stores the index of the
>>> next avail desc. I'll add a comment for it or move it
>>> to union and give it a better name in next version.
>> Yes, something like avail_idx might be better.
>>
>>>>> +	} else
>>>>> +		vq->free_head = i;
>>>> ID is only valid in the last descriptor in the list, so head + 1 should be
>>>> ok too?
>>> I don't really get your point. The vq->free_head stores
>>> the index of the next avail desc.
>> I think I get your idea now, free_head has two meanings:
>>
>> - next avail index
>> - buffer id
> In my design, free_head is just the index of the next
> avail desc.
>
> Driver can set anything to buffer ID.

Then you need another method to track id to context e.g hashing.

>   And in my design,
> I save desc index in buffer ID.
>
> I'll add comments for them.
>
>> If I'm correct, let's better add a comment for this.
>>
>>>>> +
>>>>> +	/* Store token and indirect buffer state. */
>>>>> +	vq->desc_state[head].num = descs_used;
>>>>> +	vq->desc_state[head].data = data;
>>>>> +	if (indirect)
>>>>> +		vq->desc_state[head].indir_desc = desc;
>>>>> +	else
>>>>> +		vq->desc_state[head].indir_desc = ctx;
>>>>> +
>>>>> +	virtio_wmb(vq->weak_barriers);
>>>> Let's add a comment to explain the barrier here.
>>> Okay.
>>>
>>>>> +	vq->vring_packed.desc[head].flags = head_flags;
>>>>> +	vq->num_added++;
>>>>> +
>>>>> +	pr_debug("Added buffer head %i to %p\n", head, vq);
>>>>> +	END_USE(vq);
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +unmap_release:
>>>>> +	err_idx = i;
>>>>> +	i = head;
>>>>> +
>>>>> +	for (n = 0; n < total_sg; n++) {
>>>>> +		if (i == err_idx)
>>>>> +			break;
>>>>> +		vring_unmap_one(vq, &desc[i]);
>>>>> +		i++;
>>>>> +		if (!indirect && i >= vq->vring_packed.num)
>>>>> +			i = 0;
>>>>> +	}
>>>>> +
>>>>> +	vq->wrap_counter = wrap_counter;
>>>>> +
>>>>> +	if (indirect)
>>>>> +		kfree(desc);
>>>>> +
>>>>> +	END_USE(vq);
>>>>> +	return -EIO;
>>>>> +}
> [...]
>>>>> @@ -1096,17 +1599,21 @@ struct virtqueue *vring_create_virtqueue(
>>>>>     	if (!queue) {
>>>>>     		/* Try to get a single page. You are my only hope! */
>>>>> -		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
>>>>> +		queue = vring_alloc_queue(vdev, __vring_size(num, vring_align,
>>>>> +							     packed),
>>>>>     					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
>>>>>     	}
>>>>>     	if (!queue)
>>>>>     		return NULL;
>>>>> -	queue_size_in_bytes = vring_size(num, vring_align);
>>>>> -	vring_init(&vring, num, queue, vring_align);
>>>>> +	queue_size_in_bytes = __vring_size(num, vring_align, packed);
>>>>> +	if (packed)
>>>>> +		vring_packed_init(&vring.vring_packed, num, queue, vring_align);
>>>>> +	else
>>>>> +		vring_init(&vring.vring_split, num, queue, vring_align);
>>>> Let's rename vring_init to vring_init_split() like other helpers?
>>> The vring_init() is a public API in include/uapi/linux/virtio_ring.h.
>>> I don't think we can rename it.
>> I see, then this need more thoughts to unify the API.
> My thought is to keep the old API as is, and introduce
> new types and helpers for packed ring.

I admit it's not a fault of this patch. But we'd better think of this in 
the future, consider we may have new kinds of ring.

>
> More details can be found in this patch:
> https://lkml.org/lkml/2018/2/23/243
> (PS. The type which has bit fields is just for reference,
>   and will be changed in next version.)
>
> Do you have any other suggestions?

No.

Thanks

>
> Best regards,
> Tiwei Bie
>
>>>>> -	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
>>>>> -				   notify, callback, name);
>>>>> +	vq = __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
>>>>> +				   context, notify, callback, name);
>>>>>     	if (!vq) {
>>>>>     		vring_free_queue(vdev, queue_size_in_bytes, queue,
>>>>>     				 dma_addr);
> [...]
