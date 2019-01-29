Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396D72087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfA2RYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:24:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfA2RYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:24:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 46A599D47DA7C7DC36C6;
        Wed, 30 Jan 2019 01:24:08 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 01:23:59 +0800
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     Thomas Gleixner <tglx@linutronix.de>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
 <5bff8227-16fd-6bca-c16e-3992ef6bec5a@suse.com>
 <alpine.DEB.2.21.1901291257590.1513@nanos.tec.linutronix.de>
 <bdd457db-6898-a085-bfaf-99d29d81467d@huawei.com>
 <alpine.DEB.2.21.1901291717370.1513@nanos.tec.linutronix.de>
CC:     Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Keith Busch" <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "SCSI Mailing List" <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ab22a6bb-a51f-b938-a84c-9cefdb2e92b5@huawei.com>
Date:   Tue, 29 Jan 2019 17:23:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901291717370.1513@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2019 16:27, Thomas Gleixner wrote:
> On Tue, 29 Jan 2019, John Garry wrote:
>> On 29/01/2019 12:01, Thomas Gleixner wrote:
>>> If the last CPU which is associated to a queue (and the corresponding
>>> interrupt) goes offline, then the subsytem/driver code has to make sure
>>> that:
>>>
>>>    1) No more requests can be queued on that queue
>>>
>>>    2) All outstanding of that queue have been completed or redirected
>>>       (don't know if that's possible at all) to some other queue.
>>
>> This may not be possible. For the HW I deal with, we have symmetrical delivery
>> and completion queues, and a command delivered on DQx will always complete on
>> CQx. Each completion queue has a dedicated IRQ.
>
> So you can stop queueing on DQx and wait for all outstanding ones to come
> in on CQx, right?

Right, and this sounds like what Keith Busch mentioned in his reply.

>
>>> That has to be done in that order obviously. Whether any of the
>>> subsystems/drivers actually implements this, I can't tell.
>>
>> Going back to c5cb83bb337c25, it seems to me that the change was made with the
>> idea that we can maintain the affinity for the IRQ as we're shutting it down
>> as no interrupts should occur.
>>
>> However I don't see why we can't instead keep the IRQ up and set the affinity
>> to all online CPUs in offline path, and restore the original affinity in
>> online path. The reason we set the queue affinity to specific CPUs is for
>> performance, but I would not say that this matters for handling residual IRQs.
>
> Oh yes it does. The problem is especially on x86, that if you have a large
> number of queues and you take a large number of CPUs offline, then you run
> into vector space exhaustion on the remaining online CPUs.
>
> In the worst case a single CPU on x86 has only 186 vectors available for
> device interrupts. So just take a quad socket machine with 144 CPUs and two
> multiqueue devices with a queue per cpu. ---> FAIL
>
> It probably fails already with one device because there are lots of other
> devices which have regular interrupt which cannot be shut down.

OK, understood.

Thanks,
John

>
> Thanks,
>
> 	tglx
>
>
> .
>


