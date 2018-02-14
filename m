Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeBNFdd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 00:33:33 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52692 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751375AbeBNFdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 00:33:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Sy7s58s_1518586406;
Subject: Re: [PATCH 2/4 v6] lib: debugobjects: add global free list and the
 counter
To: Thomas Gleixner <tglx@linutronix.de>
Cc: longman@redhat.com, linux-kernel@vger.kernel.org
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com>
 <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1802121718270.1158@nanos.tec.linutronix.de>
 <73222ea2-3d8b-e84d-6042-3f92fcd9bc08@linux.alibaba.com>
 <alpine.DEB.2.21.1802131100470.1130@nanos.tec.linutronix.de>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b86f2dcb-a61e-a582-3538-5ecce34f9afb@linux.alibaba.com>
Date: Tue, 13 Feb 2018 21:33:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802131100470.1130@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/18 2:02 AM, Thomas Gleixner wrote:
> On Mon, 12 Feb 2018, Yang Shi wrote:
>> On 2/12/18 8:25 AM, Thomas Gleixner wrote:
>>> On Tue, 6 Feb 2018, Yang Shi wrote:
>>>> +	/*
>>>> +	 * Reuse objs from the global free list, they will be reinitialized
>>>> +	 * when allocating
>>>> +	 */
>>>> +	while (obj_nr_tofree > 0 && (obj_pool_free < obj_pool_min_free)) {
>>>> +		raw_spin_lock_irqsave(&pool_lock, flags);
>>>> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
>>> This is racy vs. the worker thread. Assume obj_nr_tofree = 1:
>>>
>>> CPU0					CPU1
>>> worker
>>>      lock(&pool_lock);			while (obj_nr_tofree > 0 && ...) {
>>>        obj = hlist_entry(obj_to_free);	  lock(&pool_lock);
>>>        hlist_del(obj);			
>>>        obj_nr_tofree--;
>>>        ...
>>>      unlock(&pool_lock);
>>> 					  obj = hlist_entry(obj_to_free);
>>> 					  hlist_del(obj); <------- NULL
>>> pointer dereference
>>>
>>> Not what you want, right? The counter or the list head need to be rechecked
>>> after the lock is acquired.
>> Yes, you are right. Will fix the race in newer version.
> I fixed up all the minor issues with this series and applied it to:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects
>
> Please double check the result.

Thanks a lot. It looks good.

Regards,
Yang

>
> Thanks,
>
> 	tglx
