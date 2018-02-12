Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbeBLStF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:49:05 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60839 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932322AbeBLStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:49:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sy4FZYp_1518461328;
Subject: Re: [PATCH 2/4 v6] lib: debugobjects: add global free list and the
 counter
To: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com, linux-kernel@vger.kernel.org
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
 <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1802121718270.1158@nanos.tec.linutronix.de>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <73222ea2-3d8b-e84d-6042-3f92fcd9bc08@linux.alibaba.com>
Date: Mon, 12 Feb 2018 10:48:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802121718270.1158@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/18 8:25 AM, Thomas Gleixner wrote:
> On Tue, 6 Feb 2018, Yang Shi wrote:
>> +	/*
>> +	 * Reuse objs from the global free list, they will be reinitialized
>> +	 * when allocating
>> +	 */
>> +	while (obj_nr_tofree > 0 && (obj_pool_free < obj_pool_min_free)) {
>> +		raw_spin_lock_irqsave(&pool_lock, flags);
>> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
> This is racy vs. the worker thread. Assume obj_nr_tofree = 1:
>
> CPU0					CPU1
> worker
>     lock(&pool_lock);			while (obj_nr_tofree > 0 && ...) {
>       obj = hlist_entry(obj_to_free);	  lock(&pool_lock);
>       hlist_del(obj);			
>       obj_nr_tofree--;
>       ...
>     unlock(&pool_lock);
> 					  obj = hlist_entry(obj_to_free);
> 					  hlist_del(obj); <------- NULL pointer dereference
>
> Not what you want, right? The counter or the list head need to be rechecked
> after the lock is acquired.

Yes, you are right. Will fix the race in newer version.

Regards,
Yang

>
>> +		hlist_del(&obj->node);
>> +		obj_nr_tofree--;
>> +		hlist_add_head(&obj->node, &obj_pool);
>> +		obj_pool_free++;
>> +		raw_spin_unlock_irqrestore(&pool_lock, flags);
>> +	}
> Thanks,
>
> 	tglx
