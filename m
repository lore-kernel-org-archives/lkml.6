Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DAEC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C33320857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfBBBwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:52:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfBBBwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:52:24 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5017A256708B2959A15E;
        Sat,  2 Feb 2019 09:52:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Sat, 2 Feb 2019
 09:52:15 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Lock its device list during find and
 create its device
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>
References: <20190126061624.5260-1-zhengxiang9@huawei.com>
 <86bm438x8n.wl-marc.zyngier@arm.com>
 <27e0b952-111f-f221-bcd7-1a7ceb2840b5@huawei.com>
 <0dc03914-4c8a-4fa1-fb67-f51936c54836@arm.com>
 <505e3257-3ef6-69d4-b996-5a1e200e1246@huawei.com>
 <32354a2a-b1b3-e03b-c486-c17aee1bed8d@huawei.com>
 <6c44c2d4-d507-e01a-eef5-894ae71209ef@arm.com>
 <f19624cb-b55d-ae30-f479-3079d818887e@huawei.com>
 <23664397-eb28-4362-b292-091ba190be5e@arm.com>
From:   Zheng Xiang <zhengxiang9@huawei.com>
Message-ID: <e3608521-db59-6047-695a-514528a0a2a9@huawei.com>
Date:   Sat, 2 Feb 2019 09:51:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <23664397-eb28-4362-b292-091ba190be5e@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/2/1 17:28, Marc Zyngier wrote:
> On 01/02/2019 06:41, Zheng Xiang wrote:
>>
>> On 2019/1/31 23:12, Marc Zyngier wrote:
>>> Hi Zeng,
>>>
>>> On 31/01/2019 14:47, Zheng Xiang wrote:
>>>> Hi Marc,
>>>>
>>>> On 2019/1/29 13:42, Zheng Xiang wrote:
>>>>> On 2019/1/28 21:51, Marc Zyngier wrote:
>>>>>> On 28/01/2019 07:13, Zheng Xiang wrote:
>>>>>>> Hi Marc,
>>>>>>>
>>>>>>> Thanks for your review.
>>>>>>>
>>>>>>> On 2019/1/26 19:38, Marc Zyngier wrote:
>>>>>>>> Hi Zheng,
>>>>>>>>
>>>>>>>> On Sat, 26 Jan 2019 06:16:24 +0000,
>>>>>>>> Zheng Xiang <zhengxiang9@huawei.com> wrote:
>>>>>>>>>
>>>>>>>>> Currently each PCI device under a PCI Bridge shares the same device id
>>>>>>>>> and ITS device. Assume there are two PCI devices call its_msi_prepare
>>>>>>>>> concurrently and they are both going to find and create their ITS
>>>>>>>>> device. There is a chance that the later one couldn't find ITS device
>>>>>>>>> before the other one creating the ITS device. It will cause the later
>>>>>>>>> one to create a different ITS device even if they have the same
>>>>>>>>> device_id.
>>>>>>>>
>>>>>>>> Interesting finding. Is this something you've actually seen in practice
>>>>>>>> with two devices being probed in parallel? Or something that you found
>>>>>>>> by inspection?
>>>>>>>
>>>>>>> Yes, I find this problem after analyzing the reason of VM hung. At last, I
>>>>>>> find that the virtio-gpu cannot receive the MSI interrupts due to sharing
>>>>>>> a same event_id as virtio-serial.
>>>>>>>
>>>>>>> See https://lkml.org/lkml/2019/1/10/299 for the bug report.
>>>>>>>
>>>>>>> This problem can be reproducted with high probability by booting a Qemu/KVM
>>>>>>> VM with a virtio-serial controller and a virtio-gpu adding to a PCI Bridge
>>>>>>> and also adding some delay before creating ITS device.
>>>>>>
>>>>>> Fair enough. Do you mind sharing your QEMU command line? It'd be useful
>>>>>> if I could reproduce it here (and would give me a way to check that it
>>>>>> doesn't regress).
>>>>>
>>>>
>>>> Have you reproduced it with my QEMU command line?
>>>>
>>>> If so, should I send a V2 patch with your suggestion?
>>>
>>> I've queued the following, much more complete patch:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=9791ec7df0e7b4d80706ccea8f24b6542f6059e9
>>>
>>> Can you check that it works for you? I didn't manage to get the right
>>> timing conditions, but I also had issues getting virtio-gpu running on
>>> my TX2, so one might explain the other.
>>>
>>
>> It works for my case, but I worried about the below lines which may
>> cause memory leak.
>>
>> @@ -2627,8 +2640,14 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>>  		irq_domain_reset_irq_data(data);
>>  	}
>>
>> -	/* If all interrupts have been freed, start mopping the floor */
>> -	if (bitmap_empty(its_dev->event_map.lpi_map,
>> +	mutex_lock(&its->dev_alloc_lock);
>> +
>> +	/*
>> +	 * If all interrupts have been freed, start mopping the
>> +	 * floor. This is conditionned on the device not being shared.
>> +	 */
>> +	if (!its_dev->shared &&
>> +	    bitmap_empty(its_dev->event_map.lpi_map,
>>  			 its_dev->event_map.nr_lpis)) {
>>  		its_lpi_free(its_dev->event_map.lpi_map,
>>  			     its_dev->event_map.lpi_base,
>>
>> It seems that the shared its_dev would never be freed since the value of
>> its_dev->shared is always *true*.
> 
> Yes, and that is on purpose. As we don't refcount the number of
> interrupts that have been requested in the prepare phase, there is a
> race between free and alloc. We can have the following situation:
> 
> CPU0:               CPU1:
> 
> msi_prepare:
> mutex_lock()
> find device()
>   -> found
> store its_dev
> mutex_unlock()
> 
>                     its_irq_domain_free:
>                     mutex_lock()
>                     free_device()
>                     mutex_unlock()
> 
> its_irq_domain_alloc:
> use its_dev -> boom.
> 
> 
> So the trick is not to free the its_dev structure if it shares a devid.
> It is not really a leak, as the next device sharing the same devid will
> pick up the same structure.
> 
> Does it make sense?

Yes, Thanks a lot!


-- 

Thanks,
Xiang


