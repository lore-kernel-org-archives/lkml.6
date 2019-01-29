Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021AFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D88214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfA2RNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:13:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728379AbfA2RNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:13:02 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3951922AE9A7DD864459;
        Wed, 30 Jan 2019 01:12:58 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 01:12:47 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     Keith Busch <keith.busch@intel.com>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
 <20190129154433.GF15302@localhost.localdomain>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Message-ID: <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
Date:   Tue, 29 Jan 2019 17:12:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190129154433.GF15302@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2019 15:44, Keith Busch wrote:
> On Tue, Jan 29, 2019 at 03:25:48AM -0800, John Garry wrote:
>> Hi,
>>
>> I have a question on $subject which I hope you can shed some light on.
>>
>> According to commit c5cb83bb337c25 ("genirq/cpuhotplug: Handle managed
>> IRQs on CPU hotplug"), if we offline the last CPU in a managed IRQ
>> affinity mask, the IRQ is shutdown.
>>
>> The reasoning is that this IRQ is thought to be associated with a
>> specific queue on a MQ device, and the CPUs in the IRQ affinity mask are
>> the same CPUs associated with the queue. So, if no CPU is using the
>> queue, then no need for the IRQ.
>>
>> However how does this handle scenario of last CPU in IRQ affinity mask
>> being offlined while IO associated with queue is still in flight?
>>
>> Or if we make the decision to use queue associated with the current CPU,
>> and then that CPU (being the last CPU online in the queue's IRQ
>> afffinity mask) goes offline and we finish the delivery with another CPU?
>>
>> In these cases, when the IO completes, it would not be serviced and timeout.
>>
>> I have actually tried this on my arm64 system and I see IO timeouts.
>
> Hm, we used to freeze the queues with CPUHP_BLK_MQ_PREPARE callback,
> which would reap all outstanding commands before the CPU and IRQ are
> taken offline. That was removed with commit 4b855ad37194f ("blk-mq:
> Create hctx for each present CPU"). It sounds like we should bring
> something like that back, but make more fine grain to the per-cpu context.
>

Seems reasonable. But we would need it to deal with drivers where they 
only expose a single queue to BLK MQ, but use many queues internally. I 
think megaraid sas does this, for example.

I would also be slightly concerned with commands being issued from the 
driver unknown to blk mq, like SCSI TMF.

Thanks,
John

> .
>


