Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeDQCYt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 22:24:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751193AbeDQCYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 22:24:47 -0400
Subject: Re: [RFC v2] virtio: support packed ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
References: <20180401141216.8969-1-tiwei.bie@intel.com>
 <ebfbfc3e-9e52-9331-61b6-258e131f822d@redhat.com>
 <20180413071529.f4esh654dakodf4f@debian>
 <8dee7d62-ac0b-54ba-6bec-4bc4a6fb34e9@redhat.com>
 <20180417051343-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <665c828e-6699-7688-cfea-b23b2b0f5fe3@redhat.com>
Date: Tue, 17 Apr 2018 10:24:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417051343-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月17日 10:17, Michael S. Tsirkin wrote:
> On Tue, Apr 17, 2018 at 10:11:58AM +0800, Jason Wang wrote:
>>
>> On 2018年04月13日 15:15, Tiwei Bie wrote:
>>> On Fri, Apr 13, 2018 at 12:30:24PM +0800, Jason Wang wrote:
>>>> On 2018年04月01日 22:12, Tiwei Bie wrote:
>>>>> Hello everyone,
>>>>>
>>>>> This RFC implements packed ring support for virtio driver.
>>>>>
>>>>> The code was tested with DPDK vhost (testpmd/vhost-PMD) implemented
>>>>> by Jens at http://dpdk.org/ml/archives/dev/2018-January/089417.html
>>>>> Minor changes are needed for the vhost code, e.g. to kick the guest.
>>>>>
>>>>> TODO:
>>>>> - Refinements and bug fixes;
>>>>> - Split into small patches;
>>>>> - Test indirect descriptor support;
>>>>> - Test/fix event suppression support;
>>>>> - Test devices other than net;
>>>>>
>>>>> RFC v1 -> RFC v2:
>>>>> - Add indirect descriptor support - compile test only;
>>>>> - Add event suppression supprt - compile test only;
>>>>> - Move vring_packed_init() out of uapi (Jason, MST);
>>>>> - Merge two loops into one in virtqueue_add_packed() (Jason);
>>>>> - Split vring_unmap_one() for packed ring and split ring (Jason);
>>>>> - Avoid using '%' operator (Jason);
>>>>> - Rename free_head -> next_avail_idx (Jason);
>>>>> - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
>>>>> - Some other refinements and bug fixes;
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>>>> ---
>>>>>     drivers/virtio/virtio_ring.c       | 1094 +++++++++++++++++++++++++++++-------
>>>>>     include/linux/virtio_ring.h        |    8 +-
>>>>>     include/uapi/linux/virtio_config.h |   12 +-
>>>>>     include/uapi/linux/virtio_ring.h   |   61 ++
>>>>>     4 files changed, 980 insertions(+), 195 deletions(-)
>>> [...]

[...]

>>>> It looks to me we should examine RING_EVENT_FLAGS_DESC in desc_event_flags
>>>> instead of vq->event here. Spec does not forces to use evenf_off and
>>>> event_wrap if event index is enabled.
>>>>
>>>>> +		// FIXME: fix this!
>>>>> +		needs_kick = ((off_wrap >> 15) == vq->wrap_counter) &&
>>>>> +			     vring_need_event(off_wrap & ~(1<<15), new, old);
>>>> Why need a & here?
>>> Because wrap_counter (the most significant bit in off_wrap)
>>> isn't part of the index.
>>>
>>>>> +	} else {
>>>> Need a smp_rmb() to make sure desc_event_flags was checked before flags.
>>> I don't get your point, if my understanding is correct,
>>> desc_event_flags is vq->vring_packed.device->flags. So
>>> what's the "flags"?
>> Sorry, I mean we need check device.flags before off_warp. So it needs an
>> smp_rmb() in the middle.
> It's best to just read all flags atomically as u32.

Yes it is.

>
>> It looks to me there's no guarantee that
>> VRING_EVENT_F_DESC is set if event index is supported.
>>
>>>>> +		needs_kick = (vq->vring_packed.device->flags !=
>>>>> +			      cpu_to_virtio16(_vq->vdev, VRING_EVENT_F_DISABLE));
>>>>> +	}
>>>>> +	END_USE(vq);
>>>>> +	return needs_kick;
>>>>> +}
>>> [...]
>>>>> +static int detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
>>>>> +			      void **ctx)
>>>>> +{
>>>>> +	struct vring_packed_desc *desc;
>>>>> +	unsigned int i, j;
>>>>> +
>>>>> +	/* Clear data ptr. */
>>>>> +	vq->desc_state[head].data = NULL;
>>>>> +
>>>>> +	i = head;
>>>>> +
>>>>> +	for (j = 0; j < vq->desc_state[head].num; j++) {
>>>>> +		desc = &vq->vring_packed.desc[i];
>>>>> +		vring_unmap_one_packed(vq, desc);
>>>>> +		desc->flags = 0x0;
>>>> Looks like this is unnecessary.
>>> It's safer to zero it. If we don't zero it, after we
>>> call virtqueue_detach_unused_buf_packed() which calls
>>> this function, the desc is still available to the
>>> device.
>> Well detach_unused_buf_packed() should be called after device is stopped,
>> otherwise even if you try to clear, there will still be a window that device
>> may use it.
>>
>>>>> +		i++;
>>>>> +		if (i >= vq->vring_packed.num)
>>>>> +			i = 0;
>>>>> +	}
>>> [...]
>>>>> +static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>>>>> +{
>>>>> +	struct vring_virtqueue *vq = to_vvq(_vq);
>>>>> +	u16 last_used_idx, wrap_counter, off_wrap;
>>>>> +
>>>>> +	START_USE(vq);
>>>>> +
>>>>> +	last_used_idx = vq->last_used_idx;
>>>>> +	wrap_counter = vq->wrap_counter;
>>>>> +
>>>>> +	if (last_used_idx > vq->next_avail_idx)
>>>>> +		wrap_counter ^= 1;
>>>>> +
>>>>> +	off_wrap = last_used_idx | (wrap_counter << 15);
>>>>> +
>>>>> +	/* We optimistically turn back on interrupts, then check if there was
>>>>> +	 * more to do. */
>>>>> +	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
>>>>> +	 * either clear the flags bit or point the event index at the next
>>>>> +	 * entry. Always do both to keep code simple. */
>>>>> +	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
>>>>> +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC:
>>>>> +						     VRING_EVENT_F_ENABLE;
>>>>> +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
>>>>> +							vq->event_flags_shadow);
>>>>> +	}
>>>> A smp_wmb() is missed here?
>>>>
>>>>> +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev, off_wrap);
>>>> And according to the spec, it looks to me write a VRING_EVENT_F_ENABLE is
>>>> sufficient here.
>>> I didn't think much when implementing the event suppression
>>> for packed ring previously. After I saw your comments, I found
>>> something new. Indeed, unlike the split ring, for the packed
>>> ring, spec doesn't say we must use VRING_EVENT_F_DESC when
>>> EVENT_IDX is negotiated. So do you think below thought is
>>> right or makes sense?
>>>
>>> - For virtqueue_enable_cb_prepare(), we just need to enable
>>>     the ring by setting flags to VRING_EVENT_F_ENABLE in any
>>>     case.
>>>
>>> - We will try to use VRING_EVENT_F_DESC (if EVENT_IDX is
>>>     negotiated) only when we want to delay the interrupts
>>>     virtqueue_enable_cb_delayed().
>> This looks good to me.
> I suspect this will lead to extra interrupts if host is fast.
> So I think for now we should always use VRING_EVENT_F_DESC
> if EVENT_IDX is negotiated.

Right, so if this is true, maybe we'd better force this in the spec?

Thanks

>
> VRING_EVENT_F_DISABLE makes more sense to me.
>

[...]
