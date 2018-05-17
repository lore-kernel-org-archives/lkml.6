Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeEQMCB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:02:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeEQMCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:02:00 -0400
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bc38e5a1-e920-7055-dc22-49ac98455257@redhat.com>
Date: Thu, 17 May 2018 20:01:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516143332.GA1957@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月16日 22:33, Tiwei Bie wrote:
> On Wed, May 16, 2018 at 10:05:44PM +0800, Jason Wang wrote:
>> On 2018年05月16日 21:45, Tiwei Bie wrote:
>>> On Wed, May 16, 2018 at 08:51:43PM +0800, Jason Wang wrote:
>>>> On 2018年05月16日 20:39, Tiwei Bie wrote:
>>>>> On Wed, May 16, 2018 at 07:50:16PM +0800, Jason Wang wrote:
>>>>>> On 2018年05月16日 16:37, Tiwei Bie wrote:
> [...]
>>>>>>> +static void detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
>>>>>>> +			      unsigned int id, void **ctx)
>>>>>>> +{
>>>>>>> +	struct vring_packed_desc *desc;
>>>>>>> +	unsigned int i, j;
>>>>>>> +
>>>>>>> +	/* Clear data ptr. */
>>>>>>> +	vq->desc_state[id].data = NULL;
>>>>>>> +
>>>>>>> +	i = head;
>>>>>>> +
>>>>>>> +	for (j = 0; j < vq->desc_state[id].num; j++) {
>>>>>>> +		desc = &vq->vring_packed.desc[i];
>>>>>>> +		vring_unmap_one_packed(vq, desc);
>>>>>> As mentioned in previous discussion, this probably won't work for the case
>>>>>> of out of order completion since it depends on the information in the
>>>>>> descriptor ring. We probably need to extend ctx to record such information.
>>>>> Above code doesn't depend on the information in the descriptor
>>>>> ring. The vq->desc_state[] is the extended ctx.
>>>>>
>>>>> Best regards,
>>>>> Tiwei Bie
>>>> Yes, but desc is a pointer to descriptor ring I think so
>>>> vring_unmap_one_packed() still depends on the content of descriptor ring?
>>>>
>>> I got your point now. I think it makes sense to reserve
>>> the bits of the addr field. Driver shouldn't try to get
>>> addrs from the descriptors when cleanup the descriptors
>>> no matter whether we support out-of-order or not.
>> Maybe I was wrong, but I remember spec mentioned something like this.
> You're right. Spec mentioned this. I was just repeating
> the spec to emphasize that it does make sense. :)
>
>>> But combining it with the out-of-order support, it will
>>> mean that the driver still needs to maintain a desc/ctx
>>> list that is very similar to the desc ring in the split
>>> ring. I'm not quite sure whether it's something we want.
>>> If it is true, I'll do it. So do you think we also want
>>> to maintain such a desc/ctx list for packed ring?
>> To make it work for OOO backends I think we need something like this
>> (hardware NIC drivers are usually have something like this).
> Which hardware NIC drivers have this?

It's quite common I think, e.g driver track e.g dma addr and page frag 
somewhere. e.g the ring->rx_info in mlx4 driver.

Thanks

>
>> Not for the patch, but it looks like having a OUT_OF_ORDER feature bit is
>> much more simpler to be started with.
> +1
>
> Best regards,
> Tiwei Bie
