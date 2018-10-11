Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF51FC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E14520841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E14520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeJKVf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:35:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbeJKVfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:35:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C36F53970C6AE;
        Thu, 11 Oct 2018 22:07:46 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Thu, 11 Oct 2018
 22:07:38 +0800
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
To:     Ming Lei <ming.lei@redhat.com>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com> <20181011063603.GA3456@infradead.org>
 <118d01db-05f4-a85b-850c-c4e5a5616a16@huawei.com>
 <20181011101534.GA31802@infradead.org>
 <e2f35903-e28f-0fb5-7c61-47aa7f1a6926@huawei.com>
 <20181011133159.GA31355@ming.t460p>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <519812c7-970a-976c-7db5-a035bf4f4e24@huawei.com>
Date:   Thu, 11 Oct 2018 15:07:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181011133159.GA31355@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 14:32, Ming Lei wrote:
> On Thu, Oct 11, 2018 at 02:12:11PM +0100, John Garry wrote:
>> On 11/10/2018 11:15, Christoph Hellwig wrote:
>>> On Thu, Oct 11, 2018 at 10:59:11AM +0100, John Garry wrote:
>>>>
>>>>> blk-mq tags are always per-host (which has actually caused problems for
>>>>> ATA, which is now using its own per-device tags).
>>>>>
>>>>
>>>> So, for example, if Scsi_host.can_queue = 2048 and Scsi_host.nr_hw_queues =
>>>> 16, then rq tags are still in range [0, 2048) for that HBA, i.e. invariant
>>>> on queue count?
>>>
>>> Yes, if can_queue is 2048 you will gets tags from 0..2047.
>>>
>>
>> I should be clear about some things before discussing this further. Our
>> device has 16 hw queues. And each command we send to any queue in the device
>> must have a unique tag across all hw queues for that device, and should be
>> in the range [0, 2048) - it's called an IPTT. So Scsi_host.can_queue = 2048.
>
> Could you describe a bit about IPTT?
>

IPTT is an "Initiator Tag". It is a tag to map to the context of a hw 
queue command. It is related to SAS protocol Initiator Port tag. I think 
that most SAS HBAs have a similar concept.

IPTTs are limited, and must be recycled when an IO completes. Our hw 
supports upto 2048. So we have a limit of 2048 commands issued at any 
point in time.

Previously we had been managing IPTT in LLDD, but found rq tag can be 
used as IPTT (as in 6/7), to gave a good performance boost.

> Looks like the 16 hw queues are like reply queues in other drivers,
> such as megara_sas, but given all the 16 reply queues share one tagset,
> so the hw queue number has to be 1 from blk-mq's view.
>
>>
>> However today we only expose a single queue to upper layer (for unrelated
>> LLDD error handling restriction). We hope to expose all 16 queues in future,
>> which is what I meant by "enabling SCSI MQ in the driver". However, with
>> 6/7, this creates a problem, below.
>
> If the tag of each request from all hw queues has to be unique, you
> can't expose all 16 queues.

Well we can if we generate and manage the IPTT in the LLDD, as we had 
been doing. If we want to use the rq tag - which 6/7 is for - then we can't.

>
>>
>>> IFF you device needs different tags for different queues it can use
>>> the blk_mq_unique_tag heper to generate unique global tag.
>>
>> So this helper can't help, as fundamentially the issue is "the tag field in
>> struct request is unique per hardware queue but not all all hw queues".
>> Indeed blk_mq_unique_tag() does give a unique global tag, but cannot be used
>> for the IPTT.
>>
>> OTOH, We could expose 16 queues to upper layer, and drop 6/7, but we found
>> it performs worse.
>
> We discussed this issue before, but not found a good solution yet for
> exposing multiple hw queues to blk-mq.

I just think that it's unfortunate that enabling blk-mq means that the 
LLDD loses this unique tag across all queues in range [0, 
Scsi_host.can_queue), so much so that we found performance better by not 
exposing multiple queues and continuing to use single rq tag...

>
> However, we still get good performance in case of none scheduler by the
> following patches:
>
> 8824f62246be blk-mq: fail the request in case issue failure
> 6ce3dd6eec11 blk-mq: issue directly if hw queue isn't busy in case of 'none'
>

I think that these patches would have been included in our testing. I 
need to check.

>
> Thanks,
> Ming


Thanks,
John

>
> .
>


