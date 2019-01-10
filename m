Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF57FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7FB2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 01:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfAJBzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 20:55:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfAJBzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 20:55:24 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08B4D5A91EE07DC43A21;
        Thu, 10 Jan 2019 09:55:22 +0800 (CST)
Received: from [127.0.0.1] (10.57.71.8) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 09:55:15 +0800
Subject: Re: [PATCH] nvme: fix out of bounds access in nvme_cqe_pending
To:     Christoph Hellwig <hch@lst.de>
CC:     <wangxiongfeng2@huawei.com>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>, <thunder.leizhen@huawei.com>,
        <tanxiaojun@huawei.com>, <xiexiuqi@huawei.com>,
        <yangyingliang@huawei.com>, <cj.chengjian@huawei.com>,
        <wxf.wang@hisilicon.com>, <keith.busch@intel.com>, <axboe@fb.com>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
 <20190109183920.GA22070@lst.de>
From:   Yao HongBo <yaohongbo@huawei.com>
Message-ID: <991b5090-adf7-78e1-ae19-0df94566c212@huawei.com>
Date:   Thu, 10 Jan 2019 09:54:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190109183920.GA22070@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.71.8]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/2019 2:39 AM, Christoph Hellwig wrote:
> On Mon, Jan 07, 2019 at 10:22:07AM +0800, Hongbo Yao wrote:
>> There is an out of bounds array access in nvme_cqe_peding().
>>
>> When enable irq_thread for nvme interrupt, there is racing between the
>> nvmeq->cq_head updating and reading.
> 
> Just curious: why did you enable this option?  Do you have a workload
> where it matters?

Yes, there were a lot of hard interrupts reported when reading the nvme disk,
the OS can not schedule and result in the soft lockup.so i enabled the irq_thread.

>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index d668682..68375d4 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -908,9 +908,11 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
>>  
>>  static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>>  {
>> -	if (++nvmeq->cq_head == nvmeq->q_depth) {
>> +	if (nvmeq->cq_head == (nvmeq->q_depth - 1)) {
>>  		nvmeq->cq_head = 0;
>>  		nvmeq->cq_phase = !nvmeq->cq_phase;
>> +	} else {
>> +		++nvmeq->cq_head;
> 
> No need for the braces above, but otherwise this looks fine.  I'll apply
> it to nvme-4.21.
> 
> .
> 
 Need i send a v2 version?

