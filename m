Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6943C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C6020811
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfA3Kit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:38:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbfA3Kit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:38:49 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5688DAD717B61B5EF2AF;
        Wed, 30 Jan 2019 18:38:47 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 18:38:38 +0800
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     Keith Busch <keith.busch@intel.com>
References: <f6f6e031-8b79-439d-c2af-8d3e76f30710@huawei.com>
 <20190129154433.GF15302@localhost.localdomain>
 <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
 <20190129172059.GC17132@localhost.localdomain>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
Date:   Wed, 30 Jan 2019 10:38:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190129172059.GC17132@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2019 17:20, Keith Busch wrote:
> On Tue, Jan 29, 2019 at 05:12:40PM +0000, John Garry wrote:
>> On 29/01/2019 15:44, Keith Busch wrote:
>>>
>>> Hm, we used to freeze the queues with CPUHP_BLK_MQ_PREPARE callback,
>>> which would reap all outstanding commands before the CPU and IRQ are
>>> taken offline. That was removed with commit 4b855ad37194f ("blk-mq:
>>> Create hctx for each present CPU"). It sounds like we should bring
>>> something like that back, but make more fine grain to the per-cpu context.
>>>
>>
>> Seems reasonable. But we would need it to deal with drivers where they only
>> expose a single queue to BLK MQ, but use many queues internally. I think
>> megaraid sas does this, for example.
>>
>> I would also be slightly concerned with commands being issued from the
>> driver unknown to blk mq, like SCSI TMF.
>
> I don't think either of those descriptions sound like good candidates
> for using managed IRQ affinities.

I wouldn't say that this behaviour is obvious to the developer. I can't 
see anything in Documentation/PCI/MSI-HOWTO.txt

It also seems that this policy to rely on upper layer to flush+freeze 
queues would cause issues if managed IRQs are used by drivers in other 
subsystems. Networks controllers may have multiple queues and 
unsoliciated interrupts.

Thanks,
John

>
> .
>


