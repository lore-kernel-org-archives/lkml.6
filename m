Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeEPMvy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:51:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752991AbeEPMvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:51:50 -0400
Subject: Re: [RFC v4 3/5] virtio_ring: add packed ring support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-4-tiwei.bie@intel.com>
 <2000f635-bc34-71ff-ff51-a711c2e9726d@redhat.com>
 <20180516123909.GB986@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ecb50c84-b412-ff0b-6c52-fd789b6c8a86@redhat.com>
Date: Wed, 16 May 2018 20:51:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516123909.GB986@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月16日 20:39, Tiwei Bie wrote:
> On Wed, May 16, 2018 at 07:50:16PM +0800, Jason Wang wrote:
>> On 2018年05月16日 16:37, Tiwei Bie wrote:
> [...]
>>>    struct vring_virtqueue {
>>> @@ -116,6 +117,9 @@ struct vring_virtqueue {
>>>    			/* Last written value to driver->flags in
>>>    			 * guest byte order. */
>>>    			u16 event_flags_shadow;
>>> +
>>> +			/* ID allocation. */
>>> +			struct idr buffer_id;
>> I'm not sure idr is fit for the performance critical case here. Need to
>> measure its performance impact, especially if we have few unused slots.
> I'm also not sure.. But fortunately, it should be quite easy
> to replace it with something else without changing other code.
> If it will really hurt the performance, I'll change it.

We may want to do some benchmarking/profiling to see.

>
>>>    		};
>>>    	};
> [...]
>>> +static void detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
>>> +			      unsigned int id, void **ctx)
>>> +{
>>> +	struct vring_packed_desc *desc;
>>> +	unsigned int i, j;
>>> +
>>> +	/* Clear data ptr. */
>>> +	vq->desc_state[id].data = NULL;
>>> +
>>> +	i = head;
>>> +
>>> +	for (j = 0; j < vq->desc_state[id].num; j++) {
>>> +		desc = &vq->vring_packed.desc[i];
>>> +		vring_unmap_one_packed(vq, desc);
>> As mentioned in previous discussion, this probably won't work for the case
>> of out of order completion since it depends on the information in the
>> descriptor ring. We probably need to extend ctx to record such information.
> Above code doesn't depend on the information in the descriptor
> ring. The vq->desc_state[] is the extended ctx.
>
> Best regards,
> Tiwei Bie

Yes, but desc is a pointer to descriptor ring I think so 
vring_unmap_one_packed() still depends on the content of descriptor ring?

Thanks
