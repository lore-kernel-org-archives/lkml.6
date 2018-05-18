Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeERNRS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:17:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751496AbeERNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:17:17 -0400
Subject: Re: [RFC v4 3/5] virtio_ring: add packed ring support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-4-tiwei.bie@intel.com>
 <2000f635-bc34-71ff-ff51-a711c2e9726d@redhat.com>
 <20180516123909.GB986@debian>
 <ecb50c84-b412-ff0b-6c52-fd789b6c8a86@redhat.com>
 <20180516134550.GB4171@debian>
 <eaf946f1-abab-c4e5-1ab5-ba7912986d58@redhat.com>
 <20180516143332.GA1957@debian>
 <bc38e5a1-e920-7055-dc22-49ac98455257@redhat.com>
 <20180518112950.GA28224@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e247b46a-183f-3959-859b-aebb0bf81c07@redhat.com>
Date: Fri, 18 May 2018 21:17:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518112950.GA28224@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月18日 19:29, Tiwei Bie wrote:
> On Thu, May 17, 2018 at 08:01:52PM +0800, Jason Wang wrote:
>> On 2018年05月16日 22:33, Tiwei Bie wrote:
>>> On Wed, May 16, 2018 at 10:05:44PM +0800, Jason Wang wrote:
>>>> On 2018年05月16日 21:45, Tiwei Bie wrote:
>>>>> On Wed, May 16, 2018 at 08:51:43PM +0800, Jason Wang wrote:
>>>>>> On 2018年05月16日 20:39, Tiwei Bie wrote:
>>>>>>> On Wed, May 16, 2018 at 07:50:16PM +0800, Jason Wang wrote:
>>>>>>>> On 2018年05月16日 16:37, Tiwei Bie wrote:
>>> [...]
>>>>>>>>> +static void detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
>>>>>>>>> +			      unsigned int id, void **ctx)
>>>>>>>>> +{
>>>>>>>>> +	struct vring_packed_desc *desc;
>>>>>>>>> +	unsigned int i, j;
>>>>>>>>> +
>>>>>>>>> +	/* Clear data ptr. */
>>>>>>>>> +	vq->desc_state[id].data = NULL;
>>>>>>>>> +
>>>>>>>>> +	i = head;
>>>>>>>>> +
>>>>>>>>> +	for (j = 0; j < vq->desc_state[id].num; j++) {
>>>>>>>>> +		desc = &vq->vring_packed.desc[i];
>>>>>>>>> +		vring_unmap_one_packed(vq, desc);
>>>>>>>> As mentioned in previous discussion, this probably won't work for the case
>>>>>>>> of out of order completion since it depends on the information in the
>>>>>>>> descriptor ring. We probably need to extend ctx to record such information.
>>>>>>> Above code doesn't depend on the information in the descriptor
>>>>>>> ring. The vq->desc_state[] is the extended ctx.
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Tiwei Bie
>>>>>> Yes, but desc is a pointer to descriptor ring I think so
>>>>>> vring_unmap_one_packed() still depends on the content of descriptor ring?
>>>>>>
>>>>> I got your point now. I think it makes sense to reserve
>>>>> the bits of the addr field. Driver shouldn't try to get
>>>>> addrs from the descriptors when cleanup the descriptors
>>>>> no matter whether we support out-of-order or not.
>>>> Maybe I was wrong, but I remember spec mentioned something like this.
>>> You're right. Spec mentioned this. I was just repeating
>>> the spec to emphasize that it does make sense. :)
>>>
>>>>> But combining it with the out-of-order support, it will
>>>>> mean that the driver still needs to maintain a desc/ctx
>>>>> list that is very similar to the desc ring in the split
>>>>> ring. I'm not quite sure whether it's something we want.
>>>>> If it is true, I'll do it. So do you think we also want
>>>>> to maintain such a desc/ctx list for packed ring?
>>>> To make it work for OOO backends I think we need something like this
>>>> (hardware NIC drivers are usually have something like this).
>>> Which hardware NIC drivers have this?
>> It's quite common I think, e.g driver track e.g dma addr and page frag
>> somewhere. e.g the ring->rx_info in mlx4 driver.
> It seems that I had a misunderstanding on your
> previous comments. I know it's quite common for
> drivers to track e.g. DMA addrs somewhere (and
> I think one reason behind this is that they want
> to reuse the bits of addr field).

Yes, we may want this for virtio-net as well in the future.

>   But tracking
> addrs somewhere doesn't means supporting OOO.
> I thought you were saying it's quite common for
> hardware NIC drivers to support OOO (i.e. NICs
> will return the descriptors OOO):
>
> I'm not familiar with mlx4, maybe I'm wrong.
> I just had a quick glance. And I found below
> comments in mlx4_en_process_rx_cq():
>
> ```
> /* We assume a 1:1 mapping between CQEs and Rx descriptors, so Rx
>   * descriptor offset can be deduced from the CQE index instead of
>   * reading 'cqe->index' */
> index = cq->mcq.cons_index & ring->size_mask;
> cqe = mlx4_en_get_cqe(cq->buf, index, priv->cqe_size) + factor;
> ```
>
> It seems that although they have a completion
> queue, they are still using the ring in order.

I guess so (at least from the above bits). Git grep -i "out of order" in 
drivers/net gives some hints. Looks like there're few deivces do this.

> I guess maybe storage device may want OOO.

Right, some iSCSI did.

But tracking them elsewhere is not only for OOO.

Spec said:

for element address

"
In a used descriptor, Element Address is unused.
"

for Next flag:

"
For example, if descriptors are used in the same order in which they are 
made available, this will result in
the used descriptor overwriting the first available descriptor in the 
list, the used descriptor for the next list
overwriting the first available descriptor in the next list, etc.
"

for in order completion:

"
This will result in the used descriptor overwriting the first available 
descriptor in the batch, the used descriptor
for the next batch overwriting the first available descriptor in the 
next batch, etc.
"

So:

- It's an alignment to the spec
- device may (or should) overwrite the descriptor make also make address 
field useless.

Thanks

>
> Best regards,
> Tiwei Bie
>
>> Thanks
>>
>>>> Not for the patch, but it looks like having a OUT_OF_ORDER feature bit is
>>>> much more simpler to be started with.
>>> +1
>>>
>>> Best regards,
>>> Tiwei Bie
