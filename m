Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeDPWPK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:15:10 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46066 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeDPWPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 18:15:08 -0400
X-Google-Smtp-Source: AIpwx486tx5rdAPAexdYAAn1ALKfekHLU11EDz2NRT4qPe4tMdAcs9ywmUiVyalPvHsXyraVEUt5pA==
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
References: <20180412215501.GA16406@roeck-us.net>
 <CAMJBoFMq8DoWdcrajB_xyMrGXsUsbMjos_U60mOvf01MpK_9Kw@mail.gmail.com>
 <20180413173555.GA30587@roeck-us.net>
 <CAMJBoFPXObpXyQWz-zPJ7JnC-Z5FqqrLfr5BFWKdh+szZrPZ7A@mail.gmail.com>
 <20180413175615.GA30242@roeck-us.net>
 <b241e25a-50a3-fefb-0443-ad6c0a200898@gmail.com>
 <20180416155832.GB12015@roeck-us.net>
From: Vitaly Wool <vitalywool@gmail.com>
Message-ID: <b5158eef-2fbd-ce8c-1c8c-6c38ec837f1d@gmail.com>
Date: Tue, 17 Apr 2018 00:14:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416155832.GB12015@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/18 5:58 PM, Guenter Roeck wrote:

> On Mon, Apr 16, 2018 at 02:43:01PM +0200, Vitaly Wool wrote:
>> Hey Guenter,
>>
>> On 04/13/2018 07:56 PM, Guenter Roeck wrote:
>>
>>> On Fri, Apr 13, 2018 at 05:40:18PM +0000, Vitaly Wool wrote:
>>>> On Fri, Apr 13, 2018, 7:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>>> On Fri, Apr 13, 2018 at 05:21:02AM +0000, Vitaly Wool wrote:
>>>>>> Hi Guenter,
>>>>>>
>>>>>>
>>>>>> Den fre 13 apr. 2018 kl 00:01 skrev Guenter Roeck <linux@roeck-us.net>:
>>>>>>
>>>>>>> Hi all,
>>>>>>> we are observing crashes with z3pool under memory pressure. The kernel
>>>>>> version
>>>>>>> used to reproduce the problem is v4.16-11827-g5d1365940a68, but the
>>>>>> problem was
>>>>>>> also seen with v4.14 based kernels.
>>>>>> just before I dig into this, could you please try reproducing the errors
>>>>>> you see with https://patchwork.kernel.org/patch/10210459/ applied?
>>>>>>
>>>>> As mentioned above, I tested with v4.16-11827-g5d1365940a68, which already
>>>>> includes this patch.
>>>>>
>>>> Bah. Sorry. Expect an update after the weekend.
>>>>
>>> NP; easy to miss. Thanks a lot for looking into it.
>>>
>> I wonder if the following patch would make a difference:
>>
>> diff --git a/mm/z3fold.c b/mm/z3fold.c
>> index c0bca6153b95..5e547c2d5832 100644
>> --- a/mm/z3fold.c
>> +++ b/mm/z3fold.c
>> @@ -887,19 +887,21 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>>   				goto next;
>>   		}
>>   next:
>> -		spin_lock(&pool->lock);
>>   		if (test_bit(PAGE_HEADLESS, &page->private)) {
>>   			if (ret == 0) {
>> -				spin_unlock(&pool->lock);
>>   				free_z3fold_page(page);
>>   				return 0;
>>   			}
>> -		} else if (kref_put(&zhdr->refcount, release_z3fold_page)) {
>> -			atomic64_dec(&pool->pages_nr);
>> -			spin_unlock(&pool->lock);
>> -			return 0;
>> +		} else {
>> +			spin_lock(&zhdr->page_lock);
>> +			if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
>> +				atomic64_dec(&pool->pages_nr);
>> +				return 0;
>> +			}
>> +			spin_unlock(&zhdr->page_lock);
>>   		}
>> +		spin_lock(&pool->lock);
>>   		/*
>>   		 * Add to the beginning of LRU.
>>   		 * Pool lock has to be kept here to ensure the page has
>>
> No, it doesn't. Same crash.
>
> BUG: MAX_LOCK_DEPTH too low!
> turning off the locking correctness validator.
> depth: 48  max: 48!
> 48 locks held by kswapd0/51:
>   #0: 000000004d7a35a9 (&(&pool->lock)->rlock#3){+.+.}, at: z3fold_zpool_shrink+0x47/0x3e0
>   #1: 000000007739f49e (&(&zhdr->page_lock)->rlock){+.+.}, at: z3fold_zpool_shrink+0xb7/0x3e0
>   #2: 00000000ff6cd4c8 (&(&zhdr->page_lock)->rlock){+.+.}, at: z3fold_zpool_shrink+0xb7/0x3e0
>   #3: 000000004cffc6cb (&(&zhdr->page_lock)->rlock){+.+.}, at: z3fold_zpool_shrink+0xb7/0x3e0
> ...
> PU: 0 PID: 51 Comm: kswapd0 Not tainted 4.17.0-rc1-yocto-standard+ #11
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>   dump_stack+0x67/0x9b
>   __lock_acquire+0x429/0x18f0
>   ? __lock_acquire+0x2af/0x18f0
>   ? __lock_acquire+0x2af/0x18f0
>   ? lock_acquire+0x93/0x230
>   lock_acquire+0x93/0x230
>   ? z3fold_zpool_shrink+0xb7/0x3e0
>   _raw_spin_trylock+0x65/0x80
>   ? z3fold_zpool_shrink+0xb7/0x3e0
>   ? z3fold_zpool_shrink+0x47/0x3e0
>   z3fold_zpool_shrink+0xb7/0x3e0
>   zswap_frontswap_store+0x180/0x7c0
> ...
> BUG: sleeping function called from invalid context at mm/page_alloc.c:4320
> in_atomic(): 1, irqs_disabled(): 0, pid: 51, name: kswapd0
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<0000000000000000>]           (null)
> CPU: 0 PID: 51 Comm: kswapd0 Not tainted 4.17.0-rc1-yocto-standard+ #11
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>   dump_stack+0x67/0x9b
>   ___might_sleep+0x16c/0x250
>   __alloc_pages_nodemask+0x1e7/0x1490
>   ? lock_acquire+0x93/0x230
>   ? lock_acquire+0x93/0x230
>   __read_swap_cache_async+0x14d/0x260
>   zswap_writeback_entry+0xdb/0x340
>   z3fold_zpool_shrink+0x2b1/0x3e0
>   zswap_frontswap_store+0x180/0x7c0
>   ? page_vma_mapped_walk+0x22/0x230
>   __frontswap_store+0x6e/0xf0
>   swap_writepage+0x49/0x70
> ...
>
> This is with your patch applied on top of v4.17-rc1.
>
> Guenter
>
Ugh. Could you please keep that patch and apply this on top:

diff --git a/mm/z3fold.c b/mm/z3fold.c
index c0bca6153b95..e8a80d044d9e 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -840,6 +840,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
  			kref_get(&zhdr->refcount);
  			list_del_init(&zhdr->buddy);
  			zhdr->cpu = -1;
+			break;
  		}
  
  		list_del_init(&page->lru);

Thanks,
    Vitaly
