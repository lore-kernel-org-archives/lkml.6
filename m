Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeBKCqk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 21:46:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751087AbeBKCqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 21:46:38 -0500
Subject: Re: [PATCH V4 1/2] ptr_ring: fail early if queue occupies more than
 KMALLOC_MAX_SIZE
To: Eric Biggers <ebiggers3@gmail.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
 <20180210193201.GB23737@zzz.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <322ed04e-2bc2-0453-cd10-8d7784a8eb38@redhat.com>
Date: Sun, 11 Feb 2018 10:46:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180210193201.GB23737@zzz.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月11日 03:32, Eric Biggers wrote:
> Hi Jason,
>
> On Fri, Feb 09, 2018 at 05:45:49PM +0800, Jason Wang wrote:
>> To avoid slab to warn about exceeded size, fail early if queue
>> occupies more than KMALLOC_MAX_SIZE.
>>
>> Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
>> Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   include/linux/ptr_ring.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
>> index 1883d61..6051a5f 100644
>> --- a/include/linux/ptr_ring.h
>> +++ b/include/linux/ptr_ring.h
>> @@ -466,6 +466,8 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>>   
>>   static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
>>   {
>> +	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
>> +		return NULL;
> Are you sure that size can't be over 0x40000000?  The proper way to write this
> (safe from integer overflow) would be:
>
> 	if (size > KMALLOC_MAX_SIZE / sizeof(void *))
> 		return NULL;
>
> - Eric

Good catch.

Will post a fix.

Thanks
