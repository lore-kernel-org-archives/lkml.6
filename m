Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF767C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DDF20865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DDF20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeKXXt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 18:49:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbeKXXt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 18:49:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4CB6B7F75C46A;
        Sat, 24 Nov 2018 21:01:30 +0800 (CST)
Received: from [127.0.0.1] (10.57.115.182) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Sat, 24 Nov 2018
 21:01:20 +0800
Subject: Re: [PATCH rdma-next 3/3] RDMA/hns: Modify hns RoCE device's name
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
 <1542986065-44265-4-git-send-email-xavier.huwei@huawei.com>
 <20181123203958.GJ3395@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <charles.chenxin@huawei.com>, <liuyixian@huawei.com>,
        <zhangxiping3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5BF94B9F.5030409@huawei.com>
Date:   Sat, 24 Nov 2018 21:01:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181123203958.GJ3395@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/24 4:39, Jason Gunthorpe wrote:
> On Fri, Nov 23, 2018 at 11:14:25PM +0800, Wei Hu (Xavier) wrote:
>> This patch modifies the name of hns RoCE device's name in order
>> to ensure that the name is consistent before and after reset.
>>
>> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 4 +++-
>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 259977b..a8cfe76 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -954,6 +954,7 @@ struct hns_roce_dev {
>>  	struct pci_dev		*pci_dev;
>>  	struct device		*dev;
>>  	struct hns_roce_uar     priv_uar;
>> +	char			name[IB_DEVICE_NAME_MAX];
>>  	const char		*irq_names[HNS_ROCE_MAX_IRQ_NUM];
>>  	spinlock_t		sm_lock;
>>  	spinlock_t		bt_cmd_lock;
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index 1d639a0..678c7ec 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -6110,6 +6110,9 @@ static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>>  		hr_dev->irq[i] = pci_irq_vector(handle->pdev,
>>  						i + handle->rinfo.base_vector);
>>  
>> +	snprintf(hr_dev->name, IB_DEVICE_NAME_MAX, "hns%s",
>> +		 handle->rinfo.netdev->name);
> Why is this making up its own driver name? How is this avoiding
> colliding with an existing name?
>
> This is very dangerous since we now have device renaming, the driver
> could fail to load with no recovery.
Hi, Jason
       
    The NIC driver notifies the RoCE driver to perform reset related
processing by calling the .reset_notify() interface registered by the
RoCE driver. If the RoCE reset processing fails, .reset_notify()
returns non-zero, and then hns NIC driver will reschedule the
reset task again.
   
    The current hardware version in hip08 SoC cannot support
after reset process the application still communicates with the
resources like QP requested before reset. In RoCE reset process,
we will release the resources through ib_unregister_device, after
the hardware reset is completed, driver will re-execute
ib_register_device.
   
    Currently, we find that the ib_device's name after reset
and the one before reset may be different. We can specify the
device name to solve this problem.

    Best Regards
Xavier
> Jason
>
> .
>


