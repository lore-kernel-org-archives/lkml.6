Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeDXBOs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:14:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932633AbeDXBOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:14:47 -0400
Subject: Re: [RFC v2] virtio: support packed ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
References: <20180401141216.8969-1-tiwei.bie@intel.com>
 <515e635b-bc80-9b8d-72f9-b390ae5103ec@redhat.com>
 <20180423092908.77rii3gi7dcaf7o6@debian>
 <e08c55df-6ea2-cf7f-d7c9-91e55913ab16@redhat.com>
 <20180424040258-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <820a9720-0a02-684b-3957-319b5b2a5370@redhat.com>
Date: Tue, 24 Apr 2018 09:14:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424040258-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月24日 09:05, Michael S. Tsirkin wrote:
>>>>> +	if (vq->indirect) {
>>>>> +		u32 len;
>>>>> +
>>>>> +		desc = vq->desc_state[head].indir_desc;
>>>>> +		/* Free the indirect table, if any, now that it's unmapped. */
>>>>> +		if (!desc)
>>>>> +			goto out;
>>>>> +
>>>>> +		len = virtio32_to_cpu(vq->vq.vdev,
>>>>> +				      vq->vring_packed.desc[head].len);
>>>>> +
>>>>> +		BUG_ON(!(vq->vring_packed.desc[head].flags &
>>>>> +			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
>>>> It looks to me spec does not force to keep VRING_DESC_F_INDIRECT here. So we
>>>> can safely remove this BUG_ON() here.
>>>>
>>>>> +		BUG_ON(len == 0 || len % sizeof(struct vring_packed_desc));
>>>> Len could be ignored for used descriptor according to the spec, so we need
>>>> remove this BUG_ON() too.
>>> Yeah, you're right! The BUG_ON() isn't right. I'll remove it.
>>> And I think something related to this in the spec isn't very
>>> clear currently.
>>>
>>> In the spec, there are below words:
>>>
>>> https://github.com/oasis-tcs/virtio-spec/blob/d4fec517dfcf/packed-ring.tex#L272
>>> """
>>> In descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
>>> is reserved and is ignored by the device.
>>> """
>>>
>>> So when device writes back an used descriptor in this case,
>>> device may not set the VIRTQ_DESC_F_WRITE flag as the flag
>>> is reserved and should be ignored.
>>>
>>> https://github.com/oasis-tcs/virtio-spec/blob/d4fec517dfcf/packed-ring.tex#L170
>>> """
>>> Element Length is reserved for used descriptors without the
>>> VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
>>> """
>>>
>>> And this is the way how driver ignores the `len` in an used
>>> descriptor.
>>>
>>> https://github.com/oasis-tcs/virtio-spec/blob/d4fec517dfcf/packed-ring.tex#L241
>>> """
>>> To increase ring capacity the driver can store a (read-only
>>> by the device) table of indirect descriptors anywhere in memory,
>>> and insert a descriptor in the main virtqueue (with \field{Flags}
>>> bit VIRTQ_DESC_F_INDIRECT on) that refers to a buffer element
>>> containing this indirect descriptor table;
>>> """
>>>
>>> So the indirect descriptors in the table are read-only by
>>> the device. And the only descriptor which is writeable by
>>> the device is the descriptor in the main virtqueue (with
>>> Flags bit VIRTQ_DESC_F_INDIRECT on). So if we ignore the
>>> `len` in this descriptor, we won't be able to get the
>>> length of the data written by the device.
>>>
>>> So I think the `len` in this descriptor will carry the
>>> length of the data written by the device (if the buffers
>>> are writable to the device) even if the VIRTQ_DESC_F_WRITE
>>> isn't set by the device. How do you think?
>> Yes I think so. But we'd better need clarification from Michael.
> I think if you use a descriptor, and you want to supply len
> to guest, you set VIRTQ_DESC_F_WRITE in the used descriptor.
> Spec also says you must not set VIRTQ_DESC_F_INDIRECT then.
> If that's a problem we could look at relaxing that last requirement -
> does driver want INDIRECT in used descriptor to match
> the value in the avail descriptor for some reason?
>

Looks not, so what I get it:

- device and set VIRTQ_DESC_F_WRITE flag for used descriptor when needed
- there no need to keep INDIRECT flag in used descriptor

So for the above case, we can just have a used descriptor with _F_WRITE 
but without INDIRECT flag.

Thanks
