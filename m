Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeBAXB4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:01:56 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50368 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751450AbeBAXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:01:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0SxXVQ7X_1517526092;
Subject: Re: [PATCH 2/2 v5] lib: debugobjects: handle objects free in a batch
 outside the loop
To: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com, linux-kernel@vger.kernel.org
References: <1517508959-63958-1-git-send-email-yang.shi@linux.alibaba.com>
 <1517508959-63958-2-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1802012203210.1472@nanos.tec.linutronix.de>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <62f30929-47b0-87d6-f9cf-c85d9abf69df@linux.alibaba.com>
Date: Thu, 1 Feb 2018 15:01:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802012203210.1472@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/18 1:36 PM, Thomas Gleixner wrote:
> On Fri, 2 Feb 2018, Yang Shi wrote:
>
>>   /*
>> - * Allocate a new object. If the pool is empty, switch off the debugger.
>> + * Allocate a new object. Retrieve from global freelist first. If the pool is
>> + * empty, switch off the debugger.
>>    * Must be called with interrupts disabled.
>>    */
>>   static struct debug_obj *
>> @@ -150,6 +154,13 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
>>   	struct debug_obj *obj = NULL;
>>   
>>   	raw_spin_lock(&pool_lock);
> Why in alloc_object() and not in fill_pool()?
>
>> +	if (obj_nr_tofree > 0 && (obj_pool_free < obj_pool_min_free)) {
>> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
>> +		obj_nr_tofree--;
>> +		hlist_del(&obj->node);
>> +		goto out;
>> +	}
> Errm. This is wrong. It does not reinitialize the object. Please do that
> shuffling in fill_pool().

OK, will move the reuse logic into fill_pool().

>
>>   	if (obj_pool.first) {
>>   		obj	    = hlist_entry(obj_pool.first, typeof(*obj), node);
> ....
>
>> +	/* When pool list is not full move free objs to pool list */
>> +	while (obj_pool_free < debug_objects_pool_size) {
>> +		if (obj_nr_tofree <= 0)
>> +			break;
>> +
>> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
>> +		hlist_del(&obj->node);
>> +		hlist_add_head(&obj->node, &obj_pool);
>> +		obj_pool_free++;
>> +		obj_pool_used--;
>> +		obj_nr_tofree--;
>> +	}
>> +
>> +	/*
>> +	 * pool list is already full, and there are still objs on the free list,
>> +	 * move remaining free objs to a separate list to free the memory later.
>> +	 */
>> +	if (obj_nr_tofree > 0) {
>> +		hlist_move_list(&obj_to_free, &tofree);
>> +		obj_nr_tofree = 0;
>> +	}
> The accounting is inconsistent. You leak obj_pool_used. But that's wrong
> anyway because an object should not be accounted for in two places. It's
> only on _ONE_ list....

So I should move the accounting to where the obj is deleted from the 
list? It should look like:

if (obj_nr_tofree > 0)
         hlist_move_list(&obj_to_free, &tofree);

...

if (!hlist_empty(&tofree)) {
                 hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
                         hlist_del(&obj->node);
                         obj_nr_tofree--;
                         kmem_cache_free(obj_cache, obj);
                 }
         }

>
>> @@ -716,7 +762,6 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
>>   {
>>   	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
>>   	struct hlist_node *tmp;
>> -	HLIST_HEAD(freelist);
>>   	struct debug_obj_descr *descr;
>>   	enum debug_obj_state state;
>>   	struct debug_bucket *db;
>> @@ -752,18 +797,17 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
>>   				goto repeat;
>>   			default:
>>   				hlist_del(&obj->node);
>> -				hlist_add_head(&obj->node, &freelist);
>> +				/* Put obj on the global free list */
>> +				raw_spin_lock(&pool_lock);
>> +				hlist_add_head(&obj->node, &obj_to_free);
>> +				/* Update the counter of objs on the global freelist */
>> +				obj_nr_tofree++;
>> +				raw_spin_unlock(&pool_lock);
> As we have to take pool_lock anyway, we simply can change free_object() to:
>
> static bool __free_object(obj)
> {
> 	bool work;
>
> 	lock(pool);
> 	work = obj_pool_free > debug_objects_pool_size && obj_cache;
> 	obj_pool_used++;
> 	if (work) {
> 		obj_nr_tofree++;
> 		hlist_add_head(&obj->node, &obj_to_free);
> 	] else {
> 		obj_pool_free++;
> 		hlist_add_head(&obj->node, &obj_pool);
> 	}
> 	unlock(pool);
> 	return work;
> }
>
> static void free_object(obj)
> {
> 	if (__free_object(obj))
> 		schedule_work(&debug_obj_work);
> }
>
> and then use __free_object() in __debug_check_no_obj_freed()
>
>      	 bool work = false;
>
> 	 ...
>   	    	 work |= __free_object(obj);
> 	 ...
>
> 	 if (work)
> 		schedule_work(&debug_obj_work);
>
> That makes the whole thing simpler and the accounting is matching the place
> where the object is:
>
>        obj_pool_free counts the number of objects enqueued in obj_pool
>        obj_nr_tofree counts the number of objects enqueued in obj_to_free
>        obr_pool_used counts the number of objects enqueued in the hash lists
>
> Ideally you split that patch into pieces:
>
> 1) Introduce obj_to_free/obj_nr_tofree and add the removing/freeing from it
>     in fill_pool() and free_obj_work(). Nothing adds an object at this point
>     to obj_to_free.
>
> 2) Change free_object() to use obj_to_free and split it apart
>
> 3) Change __debug_check_no_obj_freed() to use __free_object()
>
> That makes it simpler to review and to follow.
>
> Hmm?

Sure, will refactor free_object() and split the patches in newer version.

Thanks,
Yang

>
> Thanks,
>
> 	tglx
