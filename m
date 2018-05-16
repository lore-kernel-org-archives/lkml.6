Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeEPNbg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:31:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752309AbeEPNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:31:34 -0400
Subject: Re: [RFC v4 4/5] virtio_ring: add event idx support in packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-5-tiwei.bie@intel.com>
 <64f5085b-4b62-d545-36e0-0951c11b29a8@redhat.com>
 <20180516125825.GA4171@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cfaa4e06-1f00-fd6c-5b4c-60eaafa63445@redhat.com>
Date: Wed, 16 May 2018 21:31:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516125825.GA4171@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月16日 20:58, Tiwei Bie wrote:
> On Wed, May 16, 2018 at 08:17:21PM +0800, Jason Wang wrote:
>> On 2018年05月16日 16:37, Tiwei Bie wrote:
> [...]
>>> @@ -1160,15 +1186,27 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>>>    static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>>>    {
>>>    	struct vring_virtqueue *vq = to_vvq(_vq);
>>> +	u16 wrap_counter;
>>>    	START_USE(vq);
>>>    	/* We optimistically turn back on interrupts, then check if there was
>>>    	 * more to do. */
>>> +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
>>> +	 * either clear the flags bit or point the event index at the next
>>> +	 * entry. Always update the event index to keep code simple. */
>>> +
>>> +	wrap_counter = vq->wrap_counter;
>>> +	if (vq->last_used_idx > vq->next_avail_idx)
>> Should this be ">=" consider rx refill may try to completely fill the ring?
> It seems that there are two cases that last_used_idx
> equals to next_avail_idx. The first one is that the
> ring is empty. And the second one is that the ring
> is full. Although in the first case, most probably,
> the driver won't enable the interrupt.
>
> Maybe I really should track the used_wrap_counter
> instead of calculating it each time I need it.. I'll
> give it a try..
>

Right, good to know and this will match spec sample code.

Thanks
