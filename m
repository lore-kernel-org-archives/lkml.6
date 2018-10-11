Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8365C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDAC2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDAC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJKUjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:39:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38469 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbeJKUjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:39:36 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A3AE6083A1F1;
        Thu, 11 Oct 2018 21:12:24 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Thu, 11 Oct 2018
 21:12:16 +0800
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
To:     Christoph Hellwig <hch@infradead.org>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com> <20181011063603.GA3456@infradead.org>
 <118d01db-05f4-a85b-850c-c4e5a5616a16@huawei.com>
 <20181011101534.GA31802@infradead.org>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e2f35903-e28f-0fb5-7c61-47aa7f1a6926@huawei.com>
Date:   Thu, 11 Oct 2018 14:12:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181011101534.GA31802@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 11:15, Christoph Hellwig wrote:
> On Thu, Oct 11, 2018 at 10:59:11AM +0100, John Garry wrote:
>>
>>> blk-mq tags are always per-host (which has actually caused problems for
>>> ATA, which is now using its own per-device tags).
>>>
>>
>> So, for example, if Scsi_host.can_queue = 2048 and Scsi_host.nr_hw_queues =
>> 16, then rq tags are still in range [0, 2048) for that HBA, i.e. invariant
>> on queue count?
>
> Yes, if can_queue is 2048 you will gets tags from 0..2047.
>

I should be clear about some things before discussing this further. Our 
device has 16 hw queues. And each command we send to any queue in the 
device must have a unique tag across all hw queues for that device, and 
should be in the range [0, 2048) - it's called an IPTT. So 
Scsi_host.can_queue = 2048.

However today we only expose a single queue to upper layer (for 
unrelated LLDD error handling restriction). We hope to expose all 16 
queues in future, which is what I meant by "enabling SCSI MQ in the 
driver". However, with 6/7, this creates a problem, below.

> IFF you device needs different tags for different queues it can use
> the blk_mq_unique_tag heper to generate unique global tag.

So this helper can't help, as fundamentially the issue is "the tag field 
in struct request is unique per hardware queue but not all all hw 
queues". Indeed blk_mq_unique_tag() does give a unique global tag, but 
cannot be used for the IPTT.

OTOH, We could expose 16 queues to upper layer, and drop 6/7, but we 
found it performs worse.

>
> But unless you actuall have multiple hardware queues that latter part
> is rather irrelevant to start with.
>
> .
>

Thanks,
John

