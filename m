Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754581AbeE2GNn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:13:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751800AbeE2GNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:13:40 -0400
Subject: Re: [RFC v5 2/5] virtio_ring: support creating packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com, Cornelia Huck <cohuck@redhat.com>
References: <20180522081648.14768-1-tiwei.bie@intel.com>
 <20180522081648.14768-3-tiwei.bie@intel.com>
 <654feee2-3414-e304-0aec-2bb19a7e0c87@redhat.com>
 <20180529052418.GB2976@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <df36b345-38f9-5474-4be1-6792e2e25efb@redhat.com>
Date: Tue, 29 May 2018 14:13:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529052418.GB2976@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月29日 13:24, Tiwei Bie wrote:
> On Tue, May 29, 2018 at 10:49:11AM +0800, Jason Wang wrote:
>> On 2018年05月22日 16:16, Tiwei Bie wrote:
>>> This commit introduces the support for creating packed ring.
>>> All split ring specific functions are added _split suffix.
>>> Some necessary stubs for packed ring are also added.
>>>
>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>> ---
>>>    drivers/virtio/virtio_ring.c | 801 +++++++++++++++++++++++------------
>>>    include/linux/virtio_ring.h  |   8 +-
>>>    2 files changed, 546 insertions(+), 263 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index 71458f493cf8..f5ef5f42a7cf 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -61,11 +61,15 @@ struct vring_desc_state {
>>>    	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>>>    };
>>> +struct vring_desc_state_packed {
>>> +	int next;			/* The next desc state. */
>>> +};
>>> +
>>>    struct vring_virtqueue {
>>>    	struct virtqueue vq;
>>> -	/* Actual memory layout for this queue */
>>> -	struct vring vring;
>>> +	/* Is this a packed ring? */
>>> +	bool packed;
>>>    	/* Can we use weak barriers? */
>>>    	bool weak_barriers;
>>> @@ -87,11 +91,39 @@ struct vring_virtqueue {
>>>    	/* Last used index we've seen. */
>>>    	u16 last_used_idx;
>>> -	/* Last written value to avail->flags */
>>> -	u16 avail_flags_shadow;
>>> +	union {
>>> +		/* Available for split ring */
>>> +		struct {
>>> +			/* Actual memory layout for this queue. */
>>> +			struct vring vring;
>>> -	/* Last written value to avail->idx in guest byte order */
>>> -	u16 avail_idx_shadow;
>>> +			/* Last written value to avail->flags */
>>> +			u16 avail_flags_shadow;
>>> +
>>> +			/* Last written value to avail->idx in
>>> +			 * guest byte order. */
>>> +			u16 avail_idx_shadow;
>>> +		};
>>> +
>>> +		/* Available for packed ring */
>>> +		struct {
>>> +			/* Actual memory layout for this queue. */
>>> +			struct vring_packed vring_packed;
>>> +
>>> +			/* Driver ring wrap counter. */
>>> +			u8 avail_wrap_counter;
>>> +
>>> +			/* Device ring wrap counter. */
>>> +			u8 used_wrap_counter;
>> How about just use boolean?
> I can change it to bool if you want.

Yes, please.

>
> [...]
>>> -static int vring_mapping_error(const struct vring_virtqueue *vq,
>>> -			       dma_addr_t addr)
>>> -{
>>> -	if (!vring_use_dma_api(vq->vq.vdev))
>>> -		return 0;
>>> -
>>> -	return dma_mapping_error(vring_dma_dev(vq), addr);
>>> -}
>> It looks to me if you keep vring_mapping_error behind
>> vring_unmap_one_split(), lots of changes were unncessary.
>>
> [...]
>>> +	}
>>> +	/* That should have freed everything. */
>>> +	BUG_ON(vq->vq.num_free != vq->vring.num);
>>> +
>>> +	END_USE(vq);
>>> +	return NULL;
>>> +}
>> I think the those copy-and-paste hunks could be avoided and the diff should
>> only contains renaming of the function. If yes, it would be very welcomed
>> since it requires to compare the changes verbatim otherwise.
> Michael suggested to lay out the code as:
>
> XXX_split
>
> XXX_packed
>
> XXX wrappers
>
> https://lkml.org/lkml/2018/4/13/410
>
> That's why I moved some code.

I see, then no need to change but it still looks unnecessary.

>
>>> +
>>> +/*
>>> + * The layout for the packed ring is a continuous chunk of memory
>>> + * which looks like this.
>>> + *
>>> + * struct vring_packed {
>>> + *	// The actual descriptors (16 bytes each)
>>> + *	struct vring_packed_desc desc[num];
>>> + *
>>> + *	// Padding to the next align boundary.
>>> + *	char pad[];
>>> + *
>>> + *	// Driver Event Suppression
>>> + *	struct vring_packed_desc_event driver;
>>> + *
>>> + *	// Device Event Suppression
>>> + *	struct vring_packed_desc_event device;
>>> + * };
>>> + */
>>> +static inline void vring_init_packed(struct vring_packed *vr, unsigned int num,
>>> +				     void *p, unsigned long align)
>>> +{
>>> +	vr->num = num;
>>> +	vr->desc = p;
>>> +	vr->driver = (void *)(((uintptr_t)p + sizeof(struct vring_packed_desc)
>>> +		* num + align - 1) & ~(align - 1));
>> If we choose not to go uapi, maybe we can use ALIGN() macro here?
> Okay.
>
>>> +	vr->device = vr->driver + 1;
>>> +}
> [...]
>>> +/* Only available for split ring */
>>>    const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>>>    {
>> A possible issue with this is:
>>
>> After commit d4674240f31f8c4289abba07d64291c6ddce51bc ("KVM: s390:
>> virtio-ccw revision 1 SET_VQ"). CCW tries to use
>> virtqueue_get_avail()/virtqueue_get_used(). Looks like a bug either here or
>> ccw code.
> Do we still need to support:
>
> include/linux/virtio.h
> /*
>   * Legacy accessors -- in almost all cases, these are the wrong functions
>   * to use.
>   */
> static inline void *virtqueue_get_desc(struct virtqueue *vq)
> {
>          return virtqueue_get_vring(vq)->desc;
> }
> static inline void *virtqueue_get_avail(struct virtqueue *vq)
> {
>          return virtqueue_get_vring(vq)->avail;
> }
> static inline void *virtqueue_get_used(struct virtqueue *vq)
> {
>          return virtqueue_get_vring(vq)->used;
> }
>
> in packed ring?

I think it was probably a bug in ccw, they should use e.g 
virtqueue_get_desc_addr() instead.

Thanks

>
> If so, I think maybe it's better to expose them as
> symbols and implement them in virtio_ring.c.
>
> Best regards,
> Tiwei Bie
