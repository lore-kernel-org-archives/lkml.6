Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbeE2GQK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:16:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754501AbeE2GQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:16:08 -0400
Subject: Re: [RFC v5 3/5] virtio_ring: add packed ring support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180522081648.14768-1-tiwei.bie@intel.com>
 <20180522081648.14768-4-tiwei.bie@intel.com>
 <30bd7505-0ded-8584-e9ab-152756a667d6@redhat.com>
 <20180529051125.GA2976@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b1b6cd6d-3e46-4f0f-794f-c857dc49919c@redhat.com>
Date: Tue, 29 May 2018 14:16:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529051125.GA2976@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月29日 13:11, Tiwei Bie wrote:
> On Tue, May 29, 2018 at 11:18:57AM +0800, Jason Wang wrote:
>> On 2018年05月22日 16:16, Tiwei Bie wrote:
> [...]
>>> +static void detach_buf_packed(struct vring_virtqueue *vq,
>>> +			      unsigned int id, void **ctx)
>>> +{
>>> +	struct vring_desc_state_packed *state;
>>> +	struct vring_packed_desc *desc;
>>> +	unsigned int i;
>>> +	int *next;
>>> +
>>> +	/* Clear data ptr. */
>>> +	vq->desc_state_packed[id].data = NULL;
>>> +
>>> +	next = &id;
>>> +	for (i = 0; i < vq->desc_state_packed[id].num; i++) {
>>> +		state = &vq->desc_state_packed[*next];
>>> +		vring_unmap_state_packed(vq, state);
>>> +		next = &vq->desc_state_packed[*next].next;
>> Have a short discussion with Michael. It looks like the only thing we care
>> is DMA address and length here.
> The length tracked by desc_state_packed[] is also necessary
> when INDIRECT is used and the buffers are writable.
>
>> So a thought is to avoid using desc_state_packed() is vring_use_dma_api() is
>> false? Probably need another id allocator or just use desc_state_packed for
>> free id list.
> I think it's a good suggestion. Thanks!
>
> I won't track the addr/len/flags for non-indirect descs
> when vring_use_dma_api() returns false.
>
>>> +	}
>>> +
>>> +	vq->vq.num_free += vq->desc_state_packed[id].num;
>>> +	*next = vq->free_head;
>> Using pointer seems not elegant and unnecessary here. You can just track
>> next in integer I think?
> It's possible to use integer, but will need one more var
> to track `prev` (desc_state_packed[prev].next == next in
> this case).

Yes, please do this.

>
>>> +	vq->free_head = id;
>>> +
>>> +	if (vq->indirect) {
>>> +		u32 len;
>>> +
>>> +		/* Free the indirect table, if any, now that it's unmapped. */
>>> +		desc = vq->desc_state_packed[id].indir_desc;
>>> +		if (!desc)
>>> +			return;
>>> +
>>> +		len = vq->desc_state_packed[id].len;
>>> +		for (i = 0; i < len / sizeof(struct vring_packed_desc); i++)
>>> +			vring_unmap_desc_packed(vq, &desc[i]);
>>> +
>>> +		kfree(desc);
>>> +		vq->desc_state_packed[id].indir_desc = NULL;
>>> +	} else if (ctx) {
>>> +		*ctx = vq->desc_state_packed[id].indir_desc;
>>> +	}
>>>    }
>>>    static inline bool more_used_packed(const struct vring_virtqueue *vq)
>>>    {
>>> -	return false;
>>> +	u16 last_used, flags;
>>> +	u8 avail, used;
>>> +
>>> +	last_used = vq->last_used_idx;
>>> +	flags = virtio16_to_cpu(vq->vq.vdev,
>>> +				vq->vring_packed.desc[last_used].flags);
>>> +	avail = !!(flags & VRING_DESC_F_AVAIL(1));
>>> +	used = !!(flags & VRING_DESC_F_USED(1));
>>> +
>>> +	return avail == used && used == vq->used_wrap_counter;
>> Spec does not check avail == used? So there's probably a bug in either of
>> the two places.
>>
>> In what condition that avail != used but used == vq_used_wrap_counter? A
>> buggy device or device set the two bits in two writes?
> Currently, spec doesn't forbid devices to set the status
> bits as: avail != used but used == vq_used_wrap_counter.
> So I think driver cannot assume this won't happen.

Right, but I could not find a situation that device need to something 
like this. We should either forbid this in the spec or change the 
example code in the spec.

Let's see how Michael think about this.

Thanks
