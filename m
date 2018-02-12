Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeBLSxo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:53:44 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44773 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751196AbeBLSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:53:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sy4DNNL_1518461608;
Subject: Re: [PATCH 2/4 v6] lib: debugobjects: add global free list and the
 counter
To: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com, linux-kernel@vger.kernel.org
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
 <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1802121649490.1158@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802121654350.1158@nanos.tec.linutronix.de>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <0ba82b3c-367e-29d3-59ee-6d85ce10037a@linux.alibaba.com>
Date: Mon, 12 Feb 2018 10:53:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802121654350.1158@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/18 7:54 AM, Thomas Gleixner wrote:
> On Mon, 12 Feb 2018, Thomas Gleixner wrote:
>> On Tue, 6 Feb 2018, Yang Shi wrote:
>>> +	/*
>>> +	 * The objs on the pool list might be allocated before the work is
>>> +	 * run, so recheck if pool list it full or not, if not fill pool
>>> +	 * list from the global free list
>>> +	 */
>>> +	while (obj_pool_free < debug_objects_pool_size) {
>>> +		if (obj_nr_tofree <= 0)
>>> +			break;
>>> +
>>> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
>>> +		hlist_del(&obj->node);
>>> +		hlist_add_head(&obj->node, &obj_pool);
>>> +		obj_pool_free++;
>>> +		obj_nr_tofree--;
>>> +	}
>>> +
>>> +	/*
>>> +	 * pool list is already full, and there are still objs on the free list,
>>> +	 * move remaining free objs to a separate list to free the memory later.
>>> +	 */
>>> +	if (obj_nr_tofree > 0) {
>>> +		hlist_move_list(&obj_to_free, &tofree);
>>> +		obj_nr_tofree = 0;
>>> +	}
>>> +
>>>   	while (obj_pool_free >= debug_objects_pool_size + ODEBUG_FREE_BATCH) {
>>>   		for (i = 0; i < ODEBUG_FREE_BATCH; i++) {
>>>   			objs[i] = hlist_entry(obj_pool.first,
>> This whole section is now pointless and can be removed. There is no way
>> that this code path can be entered after this change. Surplus objects are
>> on the obj_to_free list and not on the obj_pool itself.

Yes, it is correct. I think the whole ODEBUG_FREE_BATCH thing can be 
removed too.

Will do it in the next version.

Regards,
Yang

> Actually not in this patch, but in the next one.
>
> Thanks,
>
> 	tglx
