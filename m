Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934641AbeEJHe6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 03:34:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933589AbeEJHe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 03:34:57 -0400
Subject: Re: [RFC v3 3/5] virtio_ring: add packed ring support
From: Jason Wang <jasowang@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <20180425051550.24342-4-tiwei.bie@intel.com>
 <927f4478-5a81-31d4-ac69-f9ec26248591@redhat.com>
Message-ID: <5885acac-e9e3-3abf-b6a2-7347f4d55be2@redhat.com>
Date: Thu, 10 May 2018 15:34:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <927f4478-5a81-31d4-ac69-f9ec26248591@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月10日 15:32, Jason Wang wrote:
>
>
> On 2018年04月25日 13:15, Tiwei Bie wrote:
>> +    /* We're using some buffers from the free list. */
>> +    vq->vq.num_free -= descs_used;
>> +
>> +    /* Update free pointer */
>> +    if (indirect) {
>> +        n = head + 1;
>> +        if (n >= vq->vring_packed.num) {
>> +            n = 0;
>> +            vq->wrap_counter ^= 1;
>> +        }
>> +        vq->next_avail_idx = n;
>> +    } else
>> +        vq->next_avail_idx = i;
>
> During testing zerocopy (out of order completion), I found driver may 
> submit two identical buffer id to vhost. So the above code may not 
> work well.
>
> Consider the case that driver adds 3 buffer and virtqueue size is 8.
>
> a) id = 0,count = 2,next_avail = 2
>
> b) id = 2,count = 4,next_avail = 2

next_avail should be 6 here.

>
> c) id = 4,count = 2,next_avail = 0
>

id should be 6 here.

Thanks

> if packet b is done before packet a, driver may think buffer id 0 is 
> available and try to use it if even if the real buffer 0 was not done.
>
> Thanks
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
