Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757055AbeEJJt3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:49:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756697AbeEJJt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:49:27 -0400
Subject: Re: [RFC v3 3/5] virtio_ring: add packed ring support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <20180425051550.24342-4-tiwei.bie@intel.com>
 <927f4478-5a81-31d4-ac69-f9ec26248591@redhat.com>
 <5885acac-e9e3-3abf-b6a2-7347f4d55be2@redhat.com>
 <20180510085601.6mpxf3yvwxnqnk5q@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2fc35cd5-9dbd-7743-497f-b6637d92f528@redhat.com>
Date: Thu, 10 May 2018 17:49:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510085601.6mpxf3yvwxnqnk5q@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月10日 16:56, Tiwei Bie wrote:
> On Thu, May 10, 2018 at 03:34:50PM +0800, Jason Wang wrote:
>> On 2018年05月10日 15:32, Jason Wang wrote:
>>> On 2018年04月25日 13:15, Tiwei Bie wrote:
>>>> +    /* We're using some buffers from the free list. */
>>>> +    vq->vq.num_free -= descs_used;
>>>> +
>>>> +    /* Update free pointer */
>>>> +    if (indirect) {
>>>> +        n = head + 1;
>>>> +        if (n >= vq->vring_packed.num) {
>>>> +            n = 0;
>>>> +            vq->wrap_counter ^= 1;
>>>> +        }
>>>> +        vq->next_avail_idx = n;
>>>> +    } else
>>>> +        vq->next_avail_idx = i;
>>> During testing zerocopy (out of order completion), I found driver may
>>> submit two identical buffer id to vhost. So the above code may not work
>>> well.
>>>
>>> Consider the case that driver adds 3 buffer and virtqueue size is 8.
>>>
>>> a) id = 0,count = 2,next_avail = 2
>>>
>>> b) id = 2,count = 4,next_avail = 2
>> next_avail should be 6 here.
>>
>>> c) id = 4,count = 2,next_avail = 0
>>>
>> id should be 6 here.
>>
>> Thanks
>>
>>> if packet b is done before packet a, driver may think buffer id 0 is
>>> available and try to use it if even if the real buffer 0 was not done.
>>>
>>> Thanks
> Nice catch! Thanks a lot!
> I'll implement an ID allocator.
>
> Best regards,
> Tiwei Bie

Sounds good.

Another similar issue is detac_buf_packed(). It did:

         for (j = 0; j < vq->desc_state[head].num; j++) {
                 desc = &vq->vring_packed.desc[i];
                 vring_unmap_one_packed(vq, desc);
                 i++;
                 if (i >= vq->vring_packed.num)
                         i = 0;
         }

This probably won't work for out of order too and according to the spec:

"""
Driver needs to keep track of the size of the list corresponding to each
buffer ID, to be able to skip to where the next used descriptor is 
written by the device.
"""

Looks like we should not depend on the descriptor ring.

Thanks
